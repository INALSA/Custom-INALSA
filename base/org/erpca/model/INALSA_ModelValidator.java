package org.erpca.model;

import java.math.BigDecimal;

import org.compiere.model.MCashLine;
import org.compiere.model.MClient;
import org.compiere.model.MCurrency;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPayment;
import org.compiere.model.MTax;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;


/**
 * INALSA Model Validator
 * @author <a href="mailto:yamelsenih@gmail.com">Yamel Senih</a>
 * 
 * Contributor: <a href="mailto:dixon.22martinez@gmail.com">Dixon Martinez</a>
 * 		<li> Calculate the tax amount and the exempt amount
 *  	<li> Modification of code to make translations of the elements.
 */
public class INALSA_ModelValidator implements org.compiere.model.ModelValidator {

	/**
	 * Constructor.
	 */
	public INALSA_ModelValidator() {
		super();
	} // ModelValidator

	/** Logger */
	private static CLogger log = CLogger.getCLogger(INALSA_ModelValidator.class);
	/** Client */
	private int m_AD_Client_ID = -1;
	
	/**
	 * Initialize Validation
	 * 
	 * @param engine
	 *            validation engine
	 * @param client
	 *            client
	 */
	@Override
	public void initialize(ModelValidationEngine engine, MClient client) {
		// client = null for global validator
		if (client != null) {
			m_AD_Client_ID = client.getAD_Client_ID();
			log.info(client.toString());
		} else {
			log.info("Initializing global validator: " + this.toString());
		}
		// We want to be informed when C_BPartner is created/changed
		engine.addModelChange(MCashLine.Table_Name, this);
		//	Add Listener for Payment Doc Validate
		engine.addDocValidate(MPayment.Table_Name, this);

	}

	@Override
	public int getAD_Client_ID() {
		return m_AD_Client_ID;
	}

	@Override
	public String login(int AD_Org_ID, int AD_Role_ID, int AD_User_ID) {
		log.info("AD_User_ID=" + AD_User_ID);
		return null;
	}

	/**
	 * Model Change of a monitored Table. Called after
	 * PO.beforeSave/PO.beforeDelete when you called addModelChange for the
	 * table
	 * 
	 * @param po
	 *            persistent object
	 * @param type
	 *            TYPE_
	 * @return error message or null
	 * @exception Exception
	 *                if the recipient wishes the change to be not accept.
	 */
	public String modelChange(PO po, int type) throws Exception {

		if (po.get_TableName().equals("C_CashLine") 
				&& (type == TYPE_BEFORE_CHANGE 
						|| type == TYPE_BEFORE_NEW)) {
			log.fine(MCashLine.Table_Name + " -- TYPE_BEFORE_NEW || TYPE_BEFORE_CHANGE");
			//	Get Cash Line from PO
			MCashLine m_CashLine = (MCashLine) po;
			//	Verify if the (Base Amount + Tax Amount) > Amount
			if(m_CashLine != null) {
				String str_base_amount  = m_CashLine.get_ValueAsString("A_Base_Amount");				
				BigDecimal base_amt = new BigDecimal((str_base_amount != null && str_base_amount.length() > 0? str_base_amount: "0"));
				BigDecimal amt = m_CashLine.getAmount();
				//Dixon Martinez
				//Calculate the tax amount and the exempt amount
				MTax m_Tax = new MTax(Env.getCtx(), m_CashLine.get_ValueAsInt("C_Tax_ID"), null);
				MCurrency m_Currency = new  MCurrency(Env.getCtx(), Env.getContextAsInt(Env.getCtx(), "@#C_Currency_ID@"), null);
				BigDecimal taxAmt = m_Tax.calculateTax(base_amt, false, m_Currency.getStdPrecision());
				BigDecimal exAmt = amt.subtract(base_amt).subtract(taxAmt);							
				//	Error
				
				//Carlos Parada Add Validation When Amt is Equals To Zero
				if(base_amt.abs()
						.add(taxAmt.abs())
						.add(exAmt.abs())
						.compareTo(amt.abs()) > 0 && amt.abs()!=Env.ZERO)
					//Dixon Martinez
					//Modification of code to make translations of the elements.
					return  "(" + Msg.translate(m_CashLine.getCtx(), "A_Base_Amount") + 
							" + " + Msg.translate(m_CashLine.getCtx(), "TaxAmt") + 
							" + " + Msg.translate(m_CashLine.getCtx(), "Exempt") + 
							") > " + Msg.translate(m_CashLine.getCtx(), "Amount");				
			}
			log.info(po.toString());			
		}
		return null;
	} // modelChange

	@SuppressWarnings("unused")
	@Override
	public String docValidate(PO po, int timing) {
		if(timing == TIMING_AFTER_COMPLETE){
			if(po.get_TableName().equals(MPayment.Table_Name)){
				log.fine(MPayment.Table_Name + " -- TIMING_AFTER_COMPLETE");
				MPayment payment = (MPayment) po;
				//Dixon Martinez
				if(payment.getReversal_ID() != 0)
					return null;
				boolean ok = MPaySelectionCheck.deleteGeneratedDraft(Env.getCtx(), payment.getC_Payment_ID(),payment.get_TrxName());
				//
				int C_PaySelectionCheck_ID = 0;
				MPaySelectionCheck psc = MPaySelectionCheck.getOfPayment(Env.getCtx(), payment.getC_Payment_ID(), payment.get_TrxName());
				
				if (psc != null)
					C_PaySelectionCheck_ID = psc.getC_PaySelectionCheck_ID();
				else
				{
					/*if(payment.getTenderType() != null)
						return null;*/
					psc = MPaySelectionCheck.createForPayment(Env.getCtx(), payment.getC_Payment_ID(), payment.get_TrxName());
					if (psc != null)
						C_PaySelectionCheck_ID = psc.getC_PaySelectionCheck_ID();
				}
				
				log.fine(MPayment.Table_Name + " -- TIMING_AFTER_COMPLETE -----> C_PaySelectionCheck_ID=" + C_PaySelectionCheck_ID);
				
			}
		} else if(timing == TIMING_BEFORE_REVERSECORRECT || timing == TIMING_BEFORE_VOID){
			if(po.get_TableName().equals(MPayment.Table_Name)){
				log.fine(MPayment.Table_Name + " -- TIMING_BEFORE_REVERSECORRECT || TIMING_BEFORE_VOID");
			}
		}
		return null;
	}

}
