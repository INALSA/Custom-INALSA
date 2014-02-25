package org.erpca.model;


import org.compiere.model.MCash;
import org.compiere.model.MCashTax;
import org.compiere.model.MClient;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.PO;
import org.compiere.util.CLogger;


/**
 * ERP Model Validator
 * @author <a href="mailto:carlosaparadam@gmail.com">Carlos Parada</a>
 */
public class ERPModelValidator implements org.compiere.model.ModelValidator {

	/**
	 * Constructor.
	 */
	public ERPModelValidator() {
		super();
	} // ModelValidator

	/** Logger */
	private static CLogger log = CLogger.getCLogger(ERPModelValidator.class);
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
		//	Add Listener for Cash Doc Validate
		engine.addDocValidate(MCash.Table_Name, this);

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

	@Override
	public String docValidate(PO po, int timing) {
		//Carlos Parada Add Tax in Cash 
		if (timing==TIMING_BEFORE_PREPARE){
			  if(po.get_TableName().equals(MCash.Table_Name)){
				  log.fine(MCash.Table_Name + " -- TIMING_BEFORE_PREPARE");
				  MCash cash = (MCash) po;
				  
				  if (!MCashTax.calculateTaxTotal(cash)) // setTotals
						return "TaxCalculatingError";
			  }
		}
		
		return null;
	}

	@Override
	public String modelChange(PO po, int type) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
