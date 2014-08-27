package org.mary.report;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MLocator;
import org.compiere.model.MProduct;
import org.compiere.model.MUOMConversion;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.ValueNamePair;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.mary.model.X_T_Cust_M_Production;

/**
 * Generated Report Production.
 * @author <a href="mailto:jlct.master@gmail.com">Jorge Colmenarez</a>
 *
 */
public class Production extends SvrProcess {
	
	/** The Product to Produced */
	private int p_M_Product_ID = 0;
	/** The LDM of the Selected Product */
	private int p_PP_Product_BOM_ID = 0;
	/** The Warehouse where to find the Components */
	private int p_M_LocatorFrom_ID = 0;
	/** The Quantity to Produced */
	private BigDecimal p_QtyProduced = BigDecimal.ZERO;
	/** Deployed Components if is true */
	private String p_IsDeployed = "";

	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_Product_ID"))
				p_M_Product_ID = para[i].getParameterAsInt();
			else if (name.equals("PP_Product_BOM_ID"))
				p_PP_Product_BOM_ID = para[i].getParameterAsInt();
			else if (name.equals("M_LocatorFrom_ID"))
				p_M_LocatorFrom_ID = para[i].getParameterAsInt();
			else if (name.equals("QtyProduced"))
				p_QtyProduced = (BigDecimal) para[i].getParameter();
			else if (name.equals("IsDeployed"))
				p_IsDeployed = (String) para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception {
		MPPProductBOM pBom = new MPPProductBOM(getCtx(), p_PP_Product_BOM_ID, get_TrxName());
		MProduct Product = new MProduct(getCtx(), p_M_Product_ID, get_TrxName());
		MLocator Locator = new MLocator(getCtx(), p_M_LocatorFrom_ID, get_TrxName());
		
		if(explosion(Product,pBom,Locator,p_QtyProduced) == 0)
			raiseError("No BOM Lines", "");
		
		return null;
	}
	
	/**
	 * Explosion the Production Plan
	 * @param pp
	 * @param product
	 * @param qty
	 * @throws Exception 
	 */
	private int explosion(MProduct product,MPPProductBOM p_Bom,MLocator locator,BigDecimal qty) throws Exception
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
		//m_level += 1;
		int components = 0;
		//line = line * m_level;
		for(MPPProductBOMLine bomline : bom_lines)
		{
			MProduct component = MProduct.get(getCtx(), bomline.getM_Product_ID());
			if(p_IsDeployed.equals("N") && component.isBOM() && !component.isStocked())
			{	
				explosion(component,null,locator,bomline.getQtyBOM());
				
			}
			else if(p_IsDeployed.equals("Y") && component.isBOM())
			{
				explosion(component,null,locator,bomline.getQtyBOM());
			}
			else
			{	
				//line += 1;
				X_T_Cust_M_Production p = new X_T_Cust_M_Production(getCtx(), 0, get_TrxName());
				p.setAD_PInstance_ID(getAD_PInstance_ID());
				p.set_CustomColumn("M_AttributeSetInstance_ID", bomline.getM_AttributeSetInstance_ID());
				p.setM_Product_ID(p_M_Product_ID);
				p.setPP_Product_BOM_ID(p_PP_Product_BOM_ID);
				p.setM_Locator_ID((p_M_LocatorFrom_ID == 0 ? component.getM_Locator_ID() : p_M_LocatorFrom_ID ));
				p.setQtyProduced(p_QtyProduced);
				p.setM_ProductComponent_ID(bomline.getM_Product_ID());
				p.set_CustomColumn("C_UOM_ID",bomline.getC_UOM_ID());
				qtyBOM = MUOMConversion.convertProductFrom (getCtx(), bomline.getM_Product_ID(), 
						bomline.getC_UOM_ID(), bomline.getQtyBOM());
				p.setQtyToUse(qtyBOM.multiply(qty));
					/**	Search QtyAvailable,QtyOnHand and QtyReserved From Table M_Storage
					 * 	@param p_M_Product_ID
					 * 	@param p_M_LocatorFrom_ID			 
					 **/
					StringBuffer sql = new StringBuffer();
					String p_ClausuleWhere = "WHERE M_Product_ID ="+bomline.getM_Product_ID()+" AND M_Locator_ID ="+(p_M_LocatorFrom_ID == 0 ? component.getM_Locator_ID() : p_M_LocatorFrom_ID );
					sql.append("Select SUM(qtyonhand) AS QtyOnHand,SUM(qtyreserved) AS QtyReserved,SUM(qtyonhand)-SUM(qtyreserved) AS QtyAvailable From M_Storage "+p_ClausuleWhere+" GROUP BY M_Product_ID,M_Locator_ID");
					log.fine("SQL = " + sql.toString());
					try{
						PreparedStatement pstmt = DB.prepareStatement (sql.toString(), get_TrxName());
						//	Evaluation
						ResultSet rs = pstmt.executeQuery();
						if(rs.next()){
							p.setQtyAvailable(rs.getBigDecimal("QtyAvailable"));
							p.set_CustomColumn("QtyOnHand",rs.getBigDecimal("QtyOnHand"));
							p.set_CustomColumn("QtyReserved",rs.getBigDecimal("QtyReserved"));
						}
						
						if (pstmt != null)
							pstmt.close ();
						pstmt = null;
						if (rs != null)
							rs.close ();
						rs = null;
					}catch(Exception e){
						throw new AdempiereException(e);
					}
					/** End Search QtyAvailable,QtyOnHand and QtyReserved */
					
				p.saveEx();
			}
			components += 1;
		
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

}
