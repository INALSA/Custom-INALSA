-- 09/04/2013 03:16:52 PM VET
-- LVE Retention
UPDATE CUST_RetentionType SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11;
-- 09/04/2013 03:16:52 PM VET
-- LVE Retention
UPDATE CUST_ConceptRetention SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11;
-- 09/04/2013 03:16:52 PM VET
-- LVE Retention
UPDATE CUST_CR_PT_Combination SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11;
-- 09/04/2013 03:16:52 PM VET
-- LVE Retention
UPDATE CUST_PersonType SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11;
-- 09/04/2013 03:16:52 PM VET
-- LVE Retention
UPDATE CUST_RetentionConfig SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11;
-- 09/04/2013 03:16:52 PM VET
-- LVE Retention
UPDATE CUST_RetentionRelation SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11;

UPDATE C_PaymentTerm SET AD_Client_ID = 1000002, AD_Org_ID = 0 WHERE AD_Client_ID = 11 AND AD_Org_ID = 11;

UPDATE C_PaysChedule SET AD_Client_ID = 1000002, AD_Org_ID =1000002;

SELECT * FROM AD_PrintFormat WHERE AD_PrintFormat_ID = 3000201 OR AD_PrintFormat_ID = 3000202;
UPDATE AD_PrintFormat SET AD_Client_ID = 1000002, AD_Org_ID = 1000002 WHERE AD_PrintFormat_ID = 3000201 OR AD_PrintFormat_ID = 3000202;

SELECT * FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID = 3000201 OR AD_PrintFormat_ID = 3000202;
UPDATE AD_PrintFormatItem SET AD_Client_ID = 1000002, AD_Org_ID = 1000002 WHERE AD_PrintFormat_ID = 3000201 OR AD_PrintFormat_ID = 3000202;
