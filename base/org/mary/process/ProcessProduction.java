package org.mary.process;

import java.math.BigDecimal;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MLocator;
import org.compiere.model.MStorage;
import org.compiere.model.MTransaction;
import org.compiere.model.Query;
import org.compiere.model.X_M_Production;
import org.compiere.model.X_M_ProductionLine;
import org.compiere.model.X_M_ProductionPlan;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.Env;

public class ProcessProduction extends SvrProcess{

	/** The Record */
	private int p_Record_ID = 0;
	
	/** Validation Inventory*/
	private boolean mustBeStocked = false;
	
	@Override
	protected void prepare() {
		// TODO Auto-generated method stub
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("MustBeStocked"))
				mustBeStocked = ((String) para[i].getParameter()).equals("Y");
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_Record_ID = getRecord_ID();

	}

	@Override
	protected String doIt() throws Exception {
		// TODO Auto-generated method stub
		X_M_Production production = new X_M_Production(getCtx(), p_Record_ID, get_TrxName());
		
		String whereClause = "M_Production_ID=? ";
		List<X_M_ProductionPlan> lines = new Query(getCtx(), X_M_ProductionPlan.Table_Name , whereClause, get_TrxName())
												  .setParameters(p_Record_ID)
												  .setOrderBy("Line, M_Product_ID")
												  .list();
		for (X_M_ProductionPlan pp :lines)
		{
			whereClause = "M_ProductionPlan_ID= ? ";
			List<X_M_ProductionLine> production_lines = new Query(getCtx(), X_M_ProductionLine.Table_Name , whereClause, get_TrxName())
													  .setParameters(pp.getM_ProductionPlan_ID())
													  .setOrderBy("Line")
												  .list();
		
			for (X_M_ProductionLine pline : production_lines)
			{
				if (production.isCreated()) 
				{
					MLocator locator = MLocator.get(getCtx(), pline.getM_Locator_ID());
					
					String MovementType = MTransaction.MOVEMENTTYPE_ProductionPlus;					
					BigDecimal MovementQty = pline.getMovementQty();						
					if (MovementQty.signum() == 0)
						continue ;
					else if(MovementQty.signum() < 0)
					{
						BigDecimal QtyAvailable = MStorage.getQtyAvailable(
								locator.getM_Warehouse_ID(), 
								locator.getM_Locator_ID(), 
								pline.getM_Product_ID(), 
								pline.getM_AttributeSetInstance_ID(),
								get_TrxName());
						
						if(mustBeStocked && QtyAvailable.add(MovementQty).signum() < 0)
						{	
							throw new AdempiereUserError ("@NotEnoughStocked@: " + pline.getM_Product().getName(), "");
						}
						
						MovementType = MTransaction.MOVEMENTTYPE_Production_;
					}
				
					if (!MStorage.add(getCtx(), locator.getM_Warehouse_ID(),
						locator.getM_Locator_ID(),
						pline.getM_Product_ID(), 
						pline.getM_AttributeSetInstance_ID(), 0 , 
						MovementQty,
						Env.ZERO,
						Env.ZERO,
						get_TrxName()))
					{
						throw new AdempiereUserError ("Cannot correct Inventory", "");
					}
					
					//Create Transaction
					MTransaction mtrx = new MTransaction (getCtx(), pline.getAD_Org_ID(), 
						MovementType, locator.getM_Locator_ID(),
						pline.getM_Product_ID(), pline.getM_AttributeSetInstance_ID(), 
						MovementQty, production.getMovementDate(), get_TrxName());
					mtrx.setM_ProductionLine_ID(pline.getM_ProductionLine_ID());
					mtrx.saveEx();
					
					pline.setProcessed(true);
					pline.saveEx();
				}
				
			} // Production Line
			pp.setProcessed(true);
			pp.saveEx();
		} // Production Plan
		
		if(production.isCreated())	
		{
			 production.setProcessed(true);
			 production.saveEx();	
			 
			 // Immediate accounting 
			 if (MClient.isClientAccountingImmediate()) {
				 @SuppressWarnings("unused")
				String ignoreError = DocumentEngine.postImmediate(getCtx(), getAD_Client_ID(), production.get_Table_ID(), production.get_ID(), true, get_TrxName());						
			 }
			 
		}
		return "@Processed@";
	}

}
