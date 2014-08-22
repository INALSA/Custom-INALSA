/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.mary.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.model.*;
import org.compiere.util.Env;

/** Generated Model for T_Cust_M_Production
 *  @author Adempiere (generated) 
 *  @version Release 3.7.0LTS - $Id$ */
public class X_T_Cust_M_Production extends PO implements I_T_Cust_M_Production, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20140821L;

    /** Standard Constructor */
    public X_T_Cust_M_Production (Properties ctx, int T_Cust_M_Production_ID, String trxName)
    {
      super (ctx, T_Cust_M_Production_ID, trxName);
      /** if (T_Cust_M_Production_ID == 0)
        {
			setAD_PInstance_ID (0);
			setM_Locator_ID (0);
			setM_ProductComponent_ID (0);
			setM_Product_ID (0);
			setPP_Product_BOM_ID (0);
			setQtyAvailable (Env.ZERO);
			setQtyProduced (Env.ZERO);
			setQtyToUse (Env.ZERO);
			setT_Cust_M_Production_ID (0);
        } */
    }

    /** Load Constructor */
    public X_T_Cust_M_Production (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_T_Cust_M_Production[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_PInstance getAD_PInstance() throws RuntimeException
    {
		return (org.compiere.model.I_AD_PInstance)MTable.get(getCtx(), org.compiere.model.I_AD_PInstance.Table_Name)
			.getPO(getAD_PInstance_ID(), get_TrxName());	}

	/** Set Process Instance.
		@param AD_PInstance_ID 
		Instance of the process
	  */
	public void setAD_PInstance_ID (int AD_PInstance_ID)
	{
		if (AD_PInstance_ID < 1) 
			set_Value (COLUMNNAME_AD_PInstance_ID, null);
		else 
			set_Value (COLUMNNAME_AD_PInstance_ID, Integer.valueOf(AD_PInstance_ID));
	}

	/** Get Process Instance.
		@return Instance of the process
	  */
	public int getAD_PInstance_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Locator getM_Locator() throws RuntimeException
    {
		return (org.compiere.model.I_M_Locator)MTable.get(getCtx(), org.compiere.model.I_M_Locator.Table_Name)
			.getPO(getM_Locator_ID(), get_TrxName());	}

	/** Set Locator.
		@param M_Locator_ID 
		Warehouse Locator
	  */
	public void setM_Locator_ID (int M_Locator_ID)
	{
		if (M_Locator_ID < 1) 
			set_Value (COLUMNNAME_M_Locator_ID, null);
		else 
			set_Value (COLUMNNAME_M_Locator_ID, Integer.valueOf(M_Locator_ID));
	}

	/** Get Locator.
		@return Warehouse Locator
	  */
	public int getM_Locator_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Locator_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Product getM_ProductComponent() throws RuntimeException
    {
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_Name)
			.getPO(getM_ProductComponent_ID(), get_TrxName());	}

	/** Set Product Component.
		@param M_ProductComponent_ID 
		This product is a component at an terminated product
	  */
	public void setM_ProductComponent_ID (int M_ProductComponent_ID)
	{
		if (M_ProductComponent_ID < 1) 
			set_Value (COLUMNNAME_M_ProductComponent_ID, null);
		else 
			set_Value (COLUMNNAME_M_ProductComponent_ID, Integer.valueOf(M_ProductComponent_ID));
	}

	/** Get Product Component.
		@return This product is a component at an terminated product
	  */
	public int getM_ProductComponent_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ProductComponent_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException
    {
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_Name)
			.getPO(getM_Product_ID(), get_TrxName());	}

	/** Set Product.
		@param M_Product_ID 
		Product, Service, Item
	  */
	public void setM_Product_ID (int M_Product_ID)
	{
		if (M_Product_ID < 1) 
			set_Value (COLUMNNAME_M_Product_ID, null);
		else 
			set_Value (COLUMNNAME_M_Product_ID, Integer.valueOf(M_Product_ID));
	}

	/** Get Product.
		@return Product, Service, Item
	  */
	public int getM_Product_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Product_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.eevolution.model.I_PP_Product_BOM getPP_Product_BOM() throws RuntimeException
    {
		return (org.eevolution.model.I_PP_Product_BOM)MTable.get(getCtx(), org.eevolution.model.I_PP_Product_BOM.Table_Name)
			.getPO(getPP_Product_BOM_ID(), get_TrxName());	}

	/** Set BOM & Formula.
		@param PP_Product_BOM_ID 
		BOM & Formula
	  */
	public void setPP_Product_BOM_ID (int PP_Product_BOM_ID)
	{
		if (PP_Product_BOM_ID < 1) 
			set_Value (COLUMNNAME_PP_Product_BOM_ID, null);
		else 
			set_Value (COLUMNNAME_PP_Product_BOM_ID, Integer.valueOf(PP_Product_BOM_ID));
	}

	/** Get BOM & Formula.
		@return BOM & Formula
	  */
	public int getPP_Product_BOM_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PP_Product_BOM_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Available Quantity.
		@param QtyAvailable 
		Available Quantity (On Hand - Reserved)
	  */
	public void setQtyAvailable (BigDecimal QtyAvailable)
	{
		set_Value (COLUMNNAME_QtyAvailable, QtyAvailable);
	}

	/** Get Available Quantity.
		@return Available Quantity (On Hand - Reserved)
	  */
	public BigDecimal getQtyAvailable () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_QtyAvailable);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Qty Produced.
		@param QtyProduced 
		Quantity to be produced
	  */
	public void setQtyProduced (BigDecimal QtyProduced)
	{
		set_Value (COLUMNNAME_QtyProduced, QtyProduced);
	}

	/** Get Qty Produced.
		@return Quantity to be produced
	  */
	public BigDecimal getQtyProduced () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_QtyProduced);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Qty to Use.
		@param QtyToUse 
		Quantity to Use
	  */
	public void setQtyToUse (BigDecimal QtyToUse)
	{
		set_Value (COLUMNNAME_QtyToUse, QtyToUse);
	}

	/** Get Qty to Use.
		@return Quantity to Use
	  */
	public BigDecimal getQtyToUse () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_QtyToUse);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Production ID.
		@param T_Cust_M_Production_ID Production ID	  */
	public void setT_Cust_M_Production_ID (int T_Cust_M_Production_ID)
	{
		if (T_Cust_M_Production_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_T_Cust_M_Production_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_T_Cust_M_Production_ID, Integer.valueOf(T_Cust_M_Production_ID));
	}

	/** Get Production ID.
		@return Production ID	  */
	public int getT_Cust_M_Production_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_T_Cust_M_Production_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}