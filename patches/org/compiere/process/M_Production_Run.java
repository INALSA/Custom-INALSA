/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Copyright (C) 2003-2007 e-Evolution,SC. All Rights Reserved.               *
 * Contributor(s): Victor Perez www.e-evolution.com                           *
 *****************************************************************************/

package org.compiere.process;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MLocator;
import org.compiere.model.MProduct;
import org.compiere.model.MStorage;
import org.compiere.model.MTransaction;
import org.compiere.model.MUOMConversion;
import org.compiere.model.Query;
import org.compiere.model.X_M_Production;
import org.compiere.model.X_M_ProductionLine;
import org.compiere.model.X_M_ProductionPlan;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.ValueNamePair;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;

/**
 * Production of BOMs
 *   1) Creating ProductionLines when IsCreated = 'N'
 *   2) Posting the Lines (optionally only when fully stocked)
 * 
 * @author victor.perez@e-evolution.com
 * @contributor: Carlos Ruiz (globalqss) - review backward compatibility - implement mustBeStocked properly
 * @contributor: Carlos Parada (Mary-Iancarina) - 
 * Separate Process Generate Production And Proces Production, Locator For Components Products, Support for UOM Conversion 
 */
public class M_Production_Run extends SvrProcess {

	/** The Record */
	private int p_Record_ID = 0;
	
	/** Locator to */
	private int p_M_LocatorFrom_ID = 0;
	
	private int m_level = 0;

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_LocatorFrom_ID"))
				p_M_LocatorFrom_ID = para[i].getParameterAsInt();			
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_Record_ID = getRecord_ID();
	} //prepare

	/**
	 * Process
	 * 
	 * @return message
	 * @throws Exception
	 */

	protected String doIt() throws Exception 
	{
		log.info("Search fields in M_Production");
		MPPProductBOM bom = null;
		BigDecimal qtyToProduced = Env.ZERO;
		X_M_Production production = new X_M_Production(getCtx(), p_Record_ID, get_TrxName());
		

		String whereClause = "M_Production_ID=? ";
		List<X_M_ProductionPlan> lines = new Query(getCtx(), X_M_ProductionPlan.Table_Name , whereClause, get_TrxName())
												  .setParameters(p_Record_ID)
												  .setOrderBy("Line, M_Product_ID")
												  .list();
		for (X_M_ProductionPlan pp :lines)
		{			
			int line = 100;
			int no = DB.executeUpdateEx("DELETE M_ProductionLine WHERE M_ProductionPlan_ID = ?", new Object[]{pp.getM_ProductionPlan_ID()},get_TrxName());
			if (no == -1) raiseError("ERROR", "DELETE M_ProductionLine WHERE M_ProductionPlan_ID = "+ pp.getM_ProductionPlan_ID());
			
			MProduct product = MProduct.get(getCtx(), pp.getM_Product_ID());
			if (pp.get_ValueAsInt("PP_Product_BOM_ID") > 0)
				bom = MPPProductBOM.get(getCtx(), pp.get_ValueAsInt("PP_Product_BOM_ID"));
			else
				bom= MPPProductBOM.getDefault(product, get_TrxName());
			
			X_M_ProductionLine pl = new X_M_ProductionLine(getCtx(), 0 , get_TrxName());
			pl.setAD_Org_ID(pp.getAD_Org_ID());
			pl.setLine(line);
			pl.setDescription(pp.getDescription());
			pl.setM_Product_ID(pp.getM_Product_ID());
			pl.setM_Locator_ID(pp.getM_Locator_ID());
			pl.setM_ProductionPlan_ID(pp.getM_ProductionPlan_ID());
			qtyToProduced = MUOMConversion.convertProductFrom (getCtx(), pp.getM_Product_ID(), 
					bom.getC_UOM_ID(), pp.getProductionQty());
			pl.setMovementQty(qtyToProduced);
			pl.saveEx(get_TrxName());

			if (explosion(pp, product, pp.getProductionQty() , line ,bom) == 0 )
				raiseError("No BOM Lines", "");
				
			
		} // Production Plan
		
		if(!production.isCreated())	
		{	
			production.setIsCreated(true);
			production.saveEx();
		}
		return "@OK@";

	} 


	/**
	 * Explosion the Production Plan
	 * @param pp
	 * @param product
	 * @param qty
	 * @throws Exception 
	 */
	private int explosion(X_M_ProductionPlan pp , MProduct product , BigDecimal qty , int line, MPPProductBOM p_Bom ) throws Exception
	{	
		
		MPPProductBOM bom = p_Bom;
		BigDecimal qtyBOM = Env.ZERO;
		if (bom == null)
			bom= MPPProductBOM.getDefault(product, get_TrxName());
		
		if(bom == null )
		{	
			raiseError("Do not exist default BOM for this product :" 
					+ product.getValue() + "-" 
					+ product.getName(),"");
			
		}				
		MPPProductBOMLine[] bom_lines = bom.getLines(new Timestamp (System.currentTimeMillis()));
		m_level += 1;
		int components = 0;
		line = line * m_level;
		for(MPPProductBOMLine bomline : bom_lines)
		{
			MProduct component = MProduct.get(getCtx(), bomline.getM_Product_ID());
			
			if(component.isBOM() && !component.isStocked())
			{	
				explosion(pp, component, bomline.getQtyBOM() , line, null);
			}
			else
			{	
				line += 1;
				X_M_ProductionLine pl = new X_M_ProductionLine(getCtx(), 0 , get_TrxName());
				pl.setAD_Org_ID(pp.getAD_Org_ID());
				pl.setLine(line);
				pl.setDescription(bomline.getDescription());
				pl.setM_Product_ID(bomline.getM_Product_ID());
				pl.setM_Locator_ID((p_M_LocatorFrom_ID == 0 ? pp.getM_Locator_ID() : p_M_LocatorFrom_ID ));				
				pl.setM_ProductionPlan_ID(pp.getM_ProductionPlan_ID());
				qtyBOM = MUOMConversion.convertProductFrom (getCtx(), bomline.getM_Product_ID(), 
						bomline.getC_UOM_ID(), bomline.getQtyBOM());
				pl.setMovementQty(qtyBOM.multiply(qty).negate());
				pl.saveEx();
				components += 1;
				
			}
		
		}
		return  components;
	}	
	
	private void raiseError(String string, String sql) throws Exception {
		String msg = string;
		ValueNamePair pp = CLogger.retrieveError();
		if (pp != null)
			msg = pp.getName() + " - ";
		msg += sql;
		throw new AdempiereUserError (msg);
	}
} // M_Production_Run
