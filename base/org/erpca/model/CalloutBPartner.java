/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.erpca.model;


import java.util.Properties;
import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *	CalloutBPartner 
 *
 *  @author carlos Parada
 *  @version  1.0
 */
public class CalloutBPartner extends CalloutEngine
{

	/**
	 * Validate SENIAT
	 * @author <a href="mailto:yamelsenih@gmail.com">Yamel Senih</a> 15/05/2013, 11:25:07
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @param oldValue
	 * @return
	 * @return String
	 * 
	 * Contributor: <a href="mailto:dixon.22martinez@gmail.com">Dixon Martinez</a>
	 * 		<li> Add the business partner name without brackets
	 *  	<li> Use the fields to Name2 for storing the name of the business partner
	 */
	public String validateSeniat(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue)
	{
		String m_Value = mTab.get_ValueAsString("Value");
		if (m_Value == null || m_Value.equals("")) {
			return "";
		}	
		
		//	Valid SENIAT
		ValidateRifSeniat l_ValidateSeniat = new ValidateRifSeniat(m_Value);
		if(l_ValidateSeniat.isM_exists())
		{
			
			//Dixon Martinez 2013-05-24
			//Variables to store the information of the name retrieved from the SENIAT
			String name1 = "";
			String name2 = "";
			String name = "";
			
			//I keep the name returned by the validator
			name = l_ValidateSeniat.getM_Name();
			
			//Locate the index of the first parenthesis of the name
			int initParen = name.indexOf("(");
			
			if(initParen != -1){
				//Save the name returned without what was inside the parentheses
				name = name.substring(0,(initParen - 1 ));
			}else{
				name = name.substring(0,name.length());
			}
					
			//Conditional to initialize the variables name1 and name2 in as if the name is greater than 60
			if(name.length() > 60){
				//Split the name into two
				int nam = name.length() / 2;
				name1 = name.substring(0,nam);
				name2 = name.substring(nam, name.length()); 
			}else {
				name1 = name;
				name2 = ""; 
			}
			//Set name
			if(mTab.get_ValueAsString("Name").equals("") && mTab.get_ValueAsString("Name2").equals("")){
				mTab.setValue("Name", name1);
				mTab.setValue("Name2", name2);
			}
			
			return Msg.translate(ctx, "Value")+": "+l_ValidateSeniat.getM_Rif()+"  "+
					 Msg.translate(ctx, "Name")+": "+l_ValidateSeniat.getM_Name()+"  "+
					 Msg.getMsg(Env.getCtx(), "RetentionAgent")+": "+l_ValidateSeniat.getM_Agent()+"  "+
					 Msg.getMsg(Env.getCtx(), "IVATaxpayer")+": "+ l_ValidateSeniat.getM_Contributor()+"  ";
		}
		else
			return l_ValidateSeniat.getM_error();		
	}
}	//	CalloutBPartner
