CREATE OR REPLACE VIEW cust_rv_receipt AS 
 SELECT cc.ad_client_id, cc.ad_org_id, cc.isactive, cc.c_cash_id, cc.dateacct, 
    cc.name, cc.c_cashbook_id, cc.description, cc.beginningbalance, 
    cc.endingbalance, cc.statementdifference, cc.processed, cc.ad_orgtrx_id, 
    cc.c_project_id, cc.c_campaign_id, cc.c_activity_id, cc.isapproved, 
    cc.docstatus, cc.c_cash_id AS cust_rv_receipt_id, cc.documentno, 
    cc.c_doctypetarget_id
   FROM c_cash cc;


CREATE OR REPLACE VIEW cust_rv_receiptline AS 
 SELECT ccl.ad_client_id, ccl.ad_org_id, ccl.isactive, ccl.c_cashline_id, 
    ccl.c_cash_id, ccl.line, ccl.description, ccl.cashtype, 
    ccl.c_bankaccount_id, ccl.c_charge_id, ccl.c_currency_id, ccl.amount, 
    ccl.discountamt, ccl.writeoffamt, ccl.isgenerated, ccl.processed, 
    ccl.c_payment_id, ccl.c_bank_id, ccl.c_cash_id AS cust_rv_receipt_id, 
    ccl.c_invoice_id, ccl.c_bpartner_id, ccl.referenceno, cc.documentno, 
    cc.c_doctypetarget_id, ccl.affectsbook, ccl.datedoc, ccl.a_base_amount, 
    i.controlno, 
    COALESCE(ccl.referenceno, ccl.referenceno, i.documentno) AS documentmix, 
    COALESCE(ccl.datedoc, ccl.datedoc, i.dateinvoiced) AS datemix, 
    ccl.c_activity_id
   FROM c_cashline ccl
   JOIN c_cash cc ON ccl.c_cash_id = cc.c_cash_id
   LEFT JOIN c_invoice i ON ccl.c_invoice_id = i.c_invoice_id;