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
 * Copyright (C) 2003-2013 E.R.P. Consultores y Asociados, C.A.               *
 * All Rights Reserved.                                                       *
 * Contributor(s): Yamel Senih www.erpconsultoresyasociados.com               *
 *****************************************************************************/
package org.spin.util;

import java.io.File;
import java.io.FileWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;

import org.compiere.model.MBank;
import org.compiere.model.MBankAccount;
import org.compiere.model.MClient;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPayment;
import org.compiere.model.MPaymentBatch;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.PaymentExport;

/**
 * @author <a href="mailto:jlct.master@gmail.com">Jorge Colmenarez</a>
 * Export class for Banesco Bank
 */
public class B_BanescoPE implements PaymentExport {

	/** Logger								*/
	static private CLogger	s_log = CLogger.getCLogger (B_BanescoPE.class);

	/** BPartner Info Index for Account    		*/
	private static final int     BPA_A_ACCOUNT 		= 0;
	/** BPartner Info Index for Value       	*/
	private static final int     BPA_A_IDENT_SSN 	= 1;
	/** BPartner Info Index for Name        	*/
	private static final int     BPA_A_NAME 		= 2;
	/** BPartner Info Index for Swift Code	    */
	private static final int     BPA_SWIFTCODE 		= 3;
	/** BPartner Info Index for e-mail    		*/
	private static final int     BPA_A_EMAIL 		= 4;
	/**	Type Register */
	private String p_Type_Register					= "";
	
	/**************************************************************************
	 *  Export to File
	 *  @param checks array of checks
	 *  @param file file to export checks
	 *  @return number of lines
	 */
	public int exportToFile (MPaySelectionCheck[] checks, File file, StringBuffer err)
	{
		if (checks == null || checks.length == 0)
			return 0;
		//  delete if exists
		try
		{
			if (file.exists())
				file.delete();
		}
		catch (Exception e)
		{
			s_log.log(Level.WARNING, "Could not delete - " + file.getAbsolutePath(), e);
		}
		
		//	Set Objects
		MPaySelection m_PaySelection = (MPaySelection) checks[0].getC_PaySelection();
		MPayment m_Payment = (MPayment) checks[0].getC_Payment();
		MPaymentBatch m_PaymentBatch = (MPaymentBatch) m_Payment.getC_PaymentBatch();
		MBankAccount m_BankAccount = (MBankAccount) m_PaySelection.getC_BankAccount();
		MOrgInfo m_OrgInfo = MOrgInfo.get(m_PaySelection.getCtx(), m_PaySelection.getAD_Org_ID(), m_PaySelection.get_TrxName());
		MClient m_Client = MClient.get(m_OrgInfo.getCtx(), m_OrgInfo.getAD_Client_ID());
		MBank mBank = MBank.get(m_BankAccount.getCtx(), m_BankAccount.getC_Bank_ID());
				
		//	Format Date Header
		String formatH = "yyyyMMddHHmmss";
		SimpleDateFormat sdfH = new SimpleDateFormat(formatH);
		//	Format Date
		String format = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		// Bank Identification
		String bankIdentification = mBank.getSwiftCode().trim();
		bankIdentification = String.format("%1$-" + 12 + "s", bankIdentification);
		
		//Type of identification		
		//String iden_Type_Org = orgInfo.getTaxID().substring(0,1);

		//	Fields of Control Register (fixed data)
		String p_Commercial_Allocated = String.format("%1$-" + 15 + "s", "BANESCO");
		String p_Standard_EDIFACT = "E";
		String p_Version_Standard_EDIFACT ="D  95B";
		String p_Document_Type = "PAYMUL";
		String p_Production = "P";
		//	End Fields 
		
		//	Fields of Header Register 
		String p_Type_Transaction = "SCV";
		String p_Description_Code = String.format("%1$-" + 32 + "s", "");
		String p_PaymentRequest_Condition = String.format("%1$-" + 3 + "s","9");
		String p_PaymentRequestNo = String.format("%1$-" + 35 + "s", m_PaymentBatch.getDocumentNo());
		String p_PaymentRequestDate = sdfH.format(m_PaymentBatch.getProcessingDate());
		//	End Fields
		
		//	Fields of Debit Register
		String p_DebitReferenceNo = String.format("%0"+ 8 +"d",Integer.parseInt(m_PaymentBatch.getDocumentNo()));
		//	Process Organization Tax ID
		String p_orgTaxID = m_OrgInfo.getTaxID().replace("-", "").trim();
		p_orgTaxID = String.format("%1$-" + 17 + "s", p_orgTaxID);
		String p_clientName = String.format("%1$-"+ 35 +"s", m_Client.getName());
		//	Payment Amount
		String p_totalAmt = String.format("%.2f", m_PaySelection.getTotalAmt().abs()).replace(".", "").replace(",", "");			
		p_totalAmt = String.format("%0" + 15 + "d", Integer.parseInt(p_totalAmt));
		String p_ISO_Code = "VEF";
		String p_Free_Field = String.format("%1$-"+ 1 +"s","");
		//	Account No
		String p_bankAccountNo = m_BankAccount.getAccountNo().trim();
		p_bankAccountNo = p_bankAccountNo.substring(0, (p_bankAccountNo.length() >= 20 ? 20: p_bankAccountNo.length()));
		p_bankAccountNo = p_bankAccountNo.replace(" ", "");
		p_bankAccountNo = String.format("%1$-" + 34 + "s", p_bankAccountNo);
		String p_BankCodeOrder = String.format("%1$-"+ 11 +"s","BANESCO");
		String p_PayDate = sdf.format(m_PaySelection.getPayDate());
		//	End Fields 
		
		
		int noLines = 0;
		StringBuffer line = null;
		try
		{
			FileWriter fw = new FileWriter(file);
			
			// 	Write Control Register
			line = new StringBuffer();
			//	Set Value Type Register for Control Register
			p_Type_Register = "HDR";
			// 	Control Register
			line.append(p_Type_Register)												//	Type Register
				.append(p_Commercial_Allocated)											//	Commercial Allocated
				.append(p_Standard_EDIFACT)												//	Standard EDIFACT
				.append(p_Version_Standard_EDIFACT)										//	Version Standard EDIFACT
				.append(p_Document_Type)												//	Document Type
				.append(p_Production);													//	Production
			
			fw.write(line.toString());
			noLines++;
			
			//  Write Header
			line = new StringBuffer();
			//	Set Value Type Register for Header Register
			p_Type_Register = "01";
			//	Header
			line.append(Env.NL)															//	New Line
				.append(p_Type_Register)												//  Type Register
				.append(p_Type_Transaction)												//	Type Transaction
				.append(p_Description_Code)												//  Description Code
				.append(p_PaymentRequest_Condition)										//  Payment Request Condition
				.append(p_PaymentRequestNo)												//  Payment Request Number
				.append(p_PaymentRequestDate);											//  Payment Request Date
				
			fw.write(line.toString());
			noLines++;
			
			//  Write Debit Note
			line = new StringBuffer();
			//	Set Value Type Register for Debit Note Register
			p_Type_Register = "02";
			
			//	Debit Note
			line.append(Env.NL)															//	New Line
				.append(p_Type_Register)												//  Type Register
				.append(String.format("%1$-"+ 30 +"s",p_DebitReferenceNo))				//	Reference Number
				.append(p_orgTaxID)														//  Organization Tax ID
				.append(p_clientName)													//  Client Name
				.append(p_totalAmt)														//  Total Amt
				.append(p_ISO_Code)														//  ISO Code Currency
				.append(p_Free_Field)													//  Free Field
				.append(p_bankAccountNo)												//  Bank Account Number
				.append(p_BankCodeOrder)												//  Bank Order Code
				.append(p_PayDate);														//  Payment Date 
				
			fw.write(line.toString());
			noLines++;
			int con=0;
			//  Write Credit Note
			for (int i = 0; i < checks.length; i++)
			{
				con++;
				//	Set Objects 
				MPaySelectionCheck mpp = checks[i];
				if (mpp == null)
					continue;
				//  BPartner Info
				String bp[] = getBPartnerInfo(mpp.getC_BPartner_ID());
				
				//	Payment Detail
				m_Payment = (MPayment) mpp.getC_Payment();
				
				//	Credit Register
				p_Type_Register = "03";
				//	Process Document No
				String p_docNo = m_Payment.getDocumentNo();
				p_docNo = p_docNo.substring(0, (p_docNo.length() >= 8? 8: p_docNo.length()));
				p_docNo = String.format("%0"+ 8 +"d",Integer.parseInt(m_Payment.getDocumentNo()));
				//	Payment Amount
				String p_Amt = String.format("%.2f", m_Payment.getPayAmt().abs()).replace(".", "").replace(",", "");
				p_Amt = String.format("%0" + 15 + "d", Integer.parseInt(p_Amt));
				//	Used the variable p_ISO_Code
				String p_BP_BankAccount = String.format("%1$-"+ 30 +"s",bp[BPA_A_ACCOUNT]); 
				String p_BP_SwiftCode = String.format("%1$-"+ 11 +"s", bp[BPA_SWIFTCODE]);
				String p_AgencyCode = String.format("%1$-"+ 3 +"s","");
				String p_BP_TaxID = String.format("%1$-"+ 17 +"s",bp[BPA_A_IDENT_SSN]);
				String p_BP_Name = String.format("%1$-"+ 70 +"s",bp[BPA_A_NAME]);
				String p_BP_Email = String.format("%1$-"+ 70 +"s",bp[BPA_A_EMAIL]);
				String p_BP_Phone = String.format("%1$-"+ 25 +"s","");
				String p_BP_TaxID_Contact = String.format("%1$-"+ 17 +"s","");
				String p_BP_Name_Contact = String.format("%1$-"+ 35 +"s","");
				String p_Settlor_Qualifier = String.format("%1$-"+ 1 +"s","");
				String p_Card_Employee = String.format("%1$-"+ 30 +"s","");
				String p_Type_Payroll = String.format("%1$-"+ 2 +"s","");
				String p_Location = String.format("%1$-"+ 21 +"s","");
				String p_PaymentTerm = String.format("%1$-"+ 3 +"s","42");
				
				//	Write Credit Register
				line = new StringBuffer();
				
				line.append(Env.NL)															//	New Line
					.append(p_Type_Register)												//	Type Register	
					.append(String.format("%1$-"+ 30 +"s",p_docNo))							//	Document Number
					.append(p_Amt)															// 	Payment Amount
					.append(p_ISO_Code)														//	ISO Code Currency
					.append(p_BP_BankAccount)												//  BP Bank Account
					.append(p_BP_SwiftCode)													// 	BP Bank Swift Code
					.append(p_AgencyCode)													// 	Agency Code
					.append(p_BP_TaxID)														// 	BP TaxID
					.append(p_BP_Name)														//	BP Name
					.append(p_BP_Email)														//	BP Email
					.append(p_BP_Phone)														//  BP Phone
					.append(p_BP_TaxID_Contact)												//  BP TaxID Contact
					.append(p_BP_Name_Contact)												// 	BP Name Contact
					.append(p_Settlor_Qualifier)											//	Settlor Qualifier
					.append(p_Card_Employee)												// 	Card Employee
					.append(p_Type_Payroll)													//	Type Payroll
					.append(p_Location)														//	Location						//	Payment Concept
					.append(p_PaymentTerm); 												//	Payment Term
				
				fw.write(line.toString());
				noLines++;
			}   // End Write Credit Note
			
			//	Totals Register
			//	Set Value Type Register for Totals Register
			p_Type_Register = "06";
			String p_CountDebit = String.format("%0"+ 15 +"d",1);
			String p_CountCredit = String.format("%0"+ 15 +"d",con);
			//	Set p_TotalAmt
			
			//	Write Totals
			line = new StringBuffer();
			
			line.append(Env.NL)															//	New Line
				.append(p_Type_Register)												//  Type Register
				.append(p_CountDebit)													//	Count Debit
				.append(p_CountCredit)													//  Count Credit
				.append(p_totalAmt);													//  Total Amount
				
			fw.write(line.toString());
			noLines++;
			//	Close
			 
			fw.flush();
			fw.close();
		}
		catch (Exception e)
		{
			err.append(e.toString());
			s_log.log(Level.SEVERE, "", e);
			return -1;
		}

		return noLines;
	}   //  exportToFile

	/**
	 * Get Business Partner Information
	 * @author <a href="mailto:yamelsenih@gmail.com">Yamel Senih</a> 16/04/2013, 20:14:38
	 * @param C_BPartner_ID
	 * @return
	 * @return String[]
	 */
	private String[] getBPartnerInfo (int C_BPartner_ID)
	{
		String[] bp = new String[5];
		//	Sql
		String sql = "SELECT MAX(bpa.AccountNo) AccountNo, bpa.A_Ident_SSN, bpa.A_Name, bpb.SwiftCode, bpa.A_Email " +
				"FROM C_BP_BankAccount bpa " +
				"INNER JOIN C_Bank bpb ON(bpb.C_Bank_ID = bpa.C_Bank_ID) " +
				"WHERE bpa.C_BPartner_ID = ? " +
				"AND bpa.IsActive = 'Y' " +
				"AND bpa.IsACH = 'Y' " +
				"GROUP BY bpa.C_BPartner_ID, bpa.A_Ident_SSN, bpa.A_Name, bpb.SwiftCode, bpa.A_Email";
		
		s_log.fine("SQL=" + sql);
		
		try
		{
			PreparedStatement pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, C_BPartner_ID);
			ResultSet rs = pstmt.executeQuery();
			//
			if (rs.next())
			{
				bp[BPA_A_ACCOUNT] = rs.getString(1);
				if (bp[BPA_A_ACCOUNT] == null)
					bp[BPA_A_ACCOUNT] = "NO CUENTA";
				bp[BPA_A_IDENT_SSN] = rs.getString(2);
				if (bp[BPA_A_IDENT_SSN] == null)
					bp[BPA_A_IDENT_SSN] = "NO RIF/CI";
				bp[BPA_A_NAME] = rs.getString(3);
				if (bp[BPA_A_NAME] == null)
					bp[BPA_A_NAME] = "NO NOMBRE";
				bp[BPA_SWIFTCODE] = rs.getString(4);
				if (bp[BPA_SWIFTCODE] == null)
					bp[BPA_SWIFTCODE] = "NO SWIFT";
				bp[BPA_A_EMAIL] = rs.getString(5);
				if (bp[BPA_A_EMAIL] == null)
					bp[BPA_A_EMAIL] = "";
			} else {
				bp[BPA_A_ACCOUNT] 	= "NO CUENTA";
				bp[BPA_A_IDENT_SSN] = "NO RIF/CI";
				bp[BPA_A_NAME] 		= "NO NOMBRE";
				bp[BPA_SWIFTCODE] 	= "NO SWIFT";
				bp[BPA_A_EMAIL] 	= "";
			}
			rs.close();
			pstmt.close();
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		return processBPartnerInfo(bp);
	}   //  getBPartnerInfo
	
	
	/**
	 * Process Business Partner Information
	 * @author <a href="mailto:yamelsenih@gmail.com">Yamel Senih</a> 16/04/2013, 20:14:49
	 * @param bp
	 * @return
	 * @return String[]
	 */
	private String [] processBPartnerInfo(String [] bp){
		//	Process Business Partner Account No
		String bpaAccount = bp[BPA_A_ACCOUNT];
		bpaAccount = bpaAccount.substring(0, bpaAccount.length() >= 20? 20: bpaAccount.length());
		bpaAccount = String.format("%1$-" + 20 + "s", bpaAccount).replace(" ","0");
		bp[BPA_A_ACCOUNT] = bpaAccount;
		//	Process Tax ID
		String bpaTaxID = bp[BPA_A_IDENT_SSN];
		bpaTaxID = bpaTaxID.replace("-", "").trim();
		bpaTaxID = bpaTaxID.substring(0, bpaTaxID.length() >= 15? 15: bpaTaxID.length());
		//bpaTaxID = String.format("%1$-" + 15 + "s", bpaTaxID);
		bp[BPA_A_IDENT_SSN] = bpaTaxID;
		//	Process Account Name
		String bpaName = bp[BPA_A_NAME];
		bpaName = bpaName.substring(0, bpaName.length() >= 60? 60: bpaName.length());
		bpaName = String.format("%1$-" + 60 + "s", bpaName);
		bp[BPA_A_NAME] = bpaName;
		//	Process Swift Code
		String bpaSwiftCode = bp[BPA_SWIFTCODE];
		bpaSwiftCode = bpaSwiftCode.substring(0, bpaSwiftCode.length() >= 12? 12: bpaSwiftCode.length());
		
		bp[BPA_SWIFTCODE] = bpaSwiftCode;
		//	Process e-mail
		String bpaEmail = bp[BPA_A_EMAIL];
		bpaName = bpaEmail.substring(0, bpaEmail.length() >= 60? 60: bpaEmail.length());
		bpaEmail = String.format("%1$-" + 50 + "s", bpaEmail);
		bp[BPA_A_EMAIL] = bpaEmail;
		return bp;
	}	//	processBPartnerInfo

	
}
