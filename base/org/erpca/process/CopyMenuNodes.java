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
package org.erpca.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
/**
 * @author <a href="mailto:dixon.22martinez@gmail.com">Dixon Martinez</a>
 * Copy the nodes of a menu.
 */
public class CopyMenuNodes extends SvrProcess {


	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#prepare()
	 */
	@Override
	protected void prepare() {
		for(ProcessInfoParameter para : getParameter()){
			String name = para.getParameterName();
			if(para.getParameter() == null){
				;
			}else if(name.equals("Tree_To_ID"))
				m_AD_Tree_To_ID = para.getParameterAsInt();
			else if(name.equals("AD_Tree_ID"))
				m_AD_Tree_ID = para.getParameterAsInt();			
		}
	}

	/* (non-Javadoc)
	 * @see org.compiere.process.SvrProcess#doIt()
	 */
	@Override
	protected String doIt() throws Exception {		
		loadNode();
		return "";
	}
		
	@SuppressWarnings("deprecation")
	private ResultSet loadNode(){	
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;
		dropNode();
		sql.append("SELECT " +m_AD_Tree_To_ID +
				",	node_id,ad_client_id,ad_org_id,isactive," +
				"	created,createdby,updated,updatedby,parent_id,seqno " +
				"FROM AD_TreeNodeMM " +
				"WHERE AD_Tree_ID = ?");
		try{
			PreparedStatement ps = DB.prepareStatement(sql.toString(),null);
			ps.setInt(1,m_AD_Tree_ID);
			rs = ps.executeQuery();
			while(rs.next()){
				//String sqlInsert = ("Insert into AD_treeNodeMM(ad_tree_id,node_id,ad_client_id,ad_org_id,isactive,created,createdby,updated,updatedby,parent_id,seqno)" +
				String sqlInsert = ("Insert into AD_treeNodeMM(ad_tree_id,node_id,ad_client_id,ad_org_id,isactive,createdby,updatedby,parent_id,seqno)" +
								"Values("+m_AD_Tree_To_ID + ","+
											rs.getInt("Node_ID")+"," +
											rs.getInt("AD_Client_ID")+ ","+
											rs.getInt("AD_Org_ID")+",'"+
											rs.getString("IsActive")+"',"+
											rs.getInt("CreatedBy")+","+
											rs.getInt("UpdatedBy")+","+
											rs.getInt("Parent_ID")+","+
											rs.getInt("SeqNO")+
										"  ) ");
				if(DB.executeUpdate(sqlInsert) != 0)
					copy++;
			}
			addLog(0,null, new BigDecimal(copy),"Nodos Copiados");
		}catch (SQLException e) {
			log.log(Level.SEVERE,e.getMessage().toString());
		}
		return rs;
	}
	
	@SuppressWarnings("deprecation")
	private ResultSet dropNode(){	
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;
		sql.append("SELECT "+
				" node_id,ad_client_id,ad_org_id,isactive," +
				"	created,createdby,updated,updatedby,parent_id,seqno " +
				"FROM AD_TreeNodeMM " +
				"WHERE AD_Tree_ID = ?");
		try{
			PreparedStatement ps = DB.prepareStatement(sql.toString(),null);
			ps.setInt(1,m_AD_Tree_To_ID);
			
			rs = ps.executeQuery();
			while(rs.next()){
				String sqlDelete = "DELETE FROM  AD_TreeNodeMM" +
						"  WHERE  AD_Tree_ID = "+m_AD_Tree_To_ID;
				
				DB.executeUpdate(sqlDelete.toString());				
				//DB.executeUpdate(sqlInsert, get_TrxName());
			}
		}catch (SQLException e) {
			log.log(Level.SEVERE,e.getMessage().toString());
		}
		return rs;
	}

	
	int m_AD_Tree_ID;
	int m_AD_Tree_To_ID;
	int copy ;
	
}
