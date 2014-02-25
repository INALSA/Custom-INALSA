-- 04/05/2013 05:13:55 PM VET
-- LVE Retention
INSERT INTO AD_ReportView (AD_Client_ID,AD_Org_ID,AD_ReportView_ID,AD_Table_ID,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,WhereClause) VALUES (0,0,3000205,1000017,TO_TIMESTAMP('2013-05-04 17:13:52','YYYY-MM-DD HH24:MI:SS'),100,'Movimientos Bancarios Conciliados','ERPC','Y','Movimientos Bancarios Conciliados',TO_TIMESTAMP('2013-05-04 17:13:52','YYYY-MM-DD HH24:MI:SS'),100,'CUST_RV_Reconciled.IsReconciled')
;

-- 04/05/2013 05:14:56 PM VET
-- LVE Retention
INSERT INTO AD_ReportView (AD_Client_ID,AD_Org_ID,AD_ReportView_ID,AD_Table_ID,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,WhereClause) VALUES (0,0,3000206,1000019,TO_TIMESTAMP('2013-05-04 17:14:55','YYYY-MM-DD HH24:MI:SS'),100,'Movimientos Bancarios No Conciliados','ERPC','Y','Movimientos Bancarios No Conciliados',TO_TIMESTAMP('2013-05-04 17:14:55','YYYY-MM-DD HH24:MI:SS'),100,'CUST_RV_UnReconciled.IsReconciled')
;

-- 04/05/2013 05:16:59 PM VET
-- LVE Retention
UPDATE AD_PrintFormat SET AD_ReportView_ID=3000206,Updated=TO_TIMESTAMP('2013-05-04 17:16:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=1000052
;

-- 04/05/2013 05:17:35 PM VET
-- LVE Retention
UPDATE AD_PrintFormat SET AD_ReportView_ID=3000205,Updated=TO_TIMESTAMP('2013-05-04 17:17:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=1000051
;

-- 04/05/2013 05:18:50 PM VET
-- LVE Retention
UPDATE AD_ReportView SET WhereClause='CUST_RV_Reconciled.IsReconciled = ''Y''',Updated=TO_TIMESTAMP('2013-05-04 17:18:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=3000205
;

-- 04/05/2013 05:18:57 PM VET
-- LVE Retention
UPDATE AD_ReportView SET WhereClause='CUST_RV_UnReconciled.IsReconciled = ''N''',Updated=TO_TIMESTAMP('2013-05-04 17:18:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=3000206
;

-- 04/05/2013 05:26:17 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET IsGroupBy='N', IsPageBreak='N', IsPrinted='Y', SeqNo=170, SortNo=0, XPosition=0, YPosition=0,Updated=TO_TIMESTAMP('2013-05-04 17:26:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:27:13 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET AD_PrintFont_ID=129, IsGroupBy='N', IsPageBreak='N', PrintName='Monto Disponible:', SortNo=0, XPosition=0, YPosition=0,Updated=TO_TIMESTAMP('2013-05-04 17:27:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:27:13 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem_Trl SET PrintName='Monto Disponible:',PrintNameSuffix=NULL,IsTranslated='Y' WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:27:34 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET AD_PrintFont_ID=134, IsGroupBy='N', IsNextLine='Y', IsPageBreak='N', SortNo=0, XPosition=0, YPosition=0,Updated=TO_TIMESTAMP('2013-05-04 17:27:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:27:44 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET AD_PrintFont_ID=161, IsGroupBy='N', IsPageBreak='N', SortNo=0, XPosition=0, YPosition=0,Updated=TO_TIMESTAMP('2013-05-04 17:27:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:27:55 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET IsGroupBy='N', IsPageBreak='N', IsRelativePosition='N', SortNo=0, XSpace=0, YSpace=0,Updated=TO_TIMESTAMP('2013-05-04 17:27:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:28:09 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET IsGroupBy='N', IsPageBreak='N', SortNo=0, XPosition=200, XSpace=0, YPosition=300, YSpace=0,Updated=TO_TIMESTAMP('2013-05-04 17:28:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

-- 04/05/2013 05:28:21 PM VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET IsGroupBy='N', IsPageBreak='N', SortNo=0, XPosition=500, XSpace=0, YSpace=0,Updated=TO_TIMESTAMP('2013-05-04 17:28:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=1002163
;

