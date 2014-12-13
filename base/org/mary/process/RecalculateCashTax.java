package org.mary.process;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MCash;
import org.compiere.model.MCashTax;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import java.util.List;
import org.compiere.model.Query;

/**
 *	Re-Calculated Cash Tax
 *	
 *  @author <a href="mailto:jlct.master@gmail.com">Jorge Colmenarez</a> 2014-12-12, 19:36:57
 */

public class RecalculateCashTax extends SvrProcess {
	
	private int p_C_Cash_ID = 0;

	@Override
	protected void prepare() {
		// TODO Auto-generated method stub
		for(ProcessInfoParameter parameter :getParameter()){
			String name = parameter.getParameterName();
			if(parameter.getParameter() == null){
				;
			}else if(name.equals("C_Cash_ID"))
				p_C_Cash_ID = parameter.getParameterAsInt();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception {
		// TODO Auto-generated method stub
		log.info("C_Cash_ID="+p_C_Cash_ID);
		
		int noCash=0;
		
		ArrayList<Object> params = new ArrayList<Object>();
		//	Add Document Type
		StringBuffer whereClause = new StringBuffer(" DocStatus = 'CO' ");
		if(p_C_Cash_ID!=0){
			whereClause.append("AND C_Cash_ID = ?");
			params.add(p_C_Cash_ID);
		}
		
		List<MCash> list = new Query(getCtx(),MCash.Table_Name, whereClause.toString(), get_TrxName())
						.setParameters(params)
						.list();
		
		for(MCash mCash : list){
			if(MCashTax.calculateTaxTotal(mCash))
				noCash++;
		}
		
		addLog(0, null, new BigDecimal(noCash), "@C_Cash_ID@: @QtyCalculated@");
		
		return "@OK@";
	}

}
