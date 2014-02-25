package org.erpca.model;

import java.io.IOException;
import java.net.URISyntaxException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.compiere.model.MSysConfig;
import org.w3c.dom.Document;

import org.xml.sax.SAXException;

public class ValidateRifSeniat {

	public ValidateRifSeniat(String p_Rif) {
		m_Rif=p_Rif;
		m_exists = false;
		try {
			readXML(p_Rif);
		} catch (ParserConfigurationException e) {
			m_error=e.getMessage();
		} catch (SAXException e) {
			m_error=e.getMessage();
		} catch (IOException e) {
			m_error= e.getMessage();
		} catch (URISyntaxException e) {
			m_error=e.getMessage();
		}
	}
	
	private boolean readXML(String p_Rif) throws ParserConfigurationException, SAXException, IOException, URISyntaxException
	{
		
		xmlBuilder = xmlParser.newDocumentBuilder();
		String url = MSysConfig.getValue("CUST_URL_SENIAT", "http://localhost/"); 
		Document xml = xmlBuilder.parse(url+p_Rif);
		//Normalizing XML	
		xml.getDocumentElement().normalize();
		m_Rif = xml.getDocumentElement().getAttributes().item(0).getNodeValue();
		m_Name = xml.getDocumentElement().getChildNodes().item(0).getTextContent();
		m_Agent=xml.getDocumentElement().getChildNodes().item(1).getTextContent();
		m_Contributor=xml.getDocumentElement().getChildNodes().item(2).getTextContent();
		m_exists = true;
		return m_exists;
	}
	
	public String getM_Rif() {
		return m_Rif;
	}
	public String getM_Name() {
		return m_Name;
	}
	public String getM_Contributor() {
		return m_Contributor;
	}
	public String getM_Agent() {
		return m_Agent;
	}
	public boolean isM_exists() {
		return m_exists;
	}
	
	public String getM_error() {
		return m_error;
	}

	private DocumentBuilderFactory xmlParser=DocumentBuilderFactory.newInstance();
	private DocumentBuilder xmlBuilder ;
	private String m_Rif;
	private String m_Name;
	private String m_Agent;
	private String m_Contributor;
	private boolean m_exists;
	private String m_error;
	
}
