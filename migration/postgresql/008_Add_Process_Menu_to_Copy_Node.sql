-- 04/05/2013 07:56:24 PM VET
-- LVE Retention
INSERT INTO AD_Process (AccessLevel,AD_Client_ID,AD_Org_ID,AD_Process_ID,Classname,CopyFromProcess,Created,CreatedBy,EntityType,IsActive,IsBetaFunctionality,IsDirectPrint,IsReport,IsServerProcess,Name,ShowHelp,Statistic_Count,Statistic_Seconds,Updated,UpdatedBy,Value) VALUES ('3',0,0,3000205,'org.erpcya.process.CopyMenuNodes','N',TO_TIMESTAMP('2013-05-04 19:56:23','YYYY-MM-DD HH24:MI:SS'),100,'ERPC','Y','N','N','N','Y','Copy Menu Nodes','Y',0,0,TO_TIMESTAMP('2013-05-04 19:56:23','YYYY-MM-DD HH24:MI:SS'),100,'prc_CopyMenuNodes')
;

-- 04/05/2013 07:56:24 PM VET
-- LVE Retention
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=3000205 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- 04/05/2013 07:56:53 PM VET
-- LVE Retention
UPDATE AD_Process_Trl SET Name='Copiar nodos de menu',Updated=TO_TIMESTAMP('2013-05-04 19:56:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=3000205 AND AD_Language='es_VE'
;

-- 04/05/2013 07:57:19 PM VET
-- LVE Retention
INSERT INTO AD_Process_Para (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy) VALUES (0,132,0,3000205,3000213,19,'AD_Tree_ID',TO_TIMESTAMP('2013-05-04 19:57:18','YYYY-MM-DD HH24:MI:SS'),100,'Identifies a Tree','ERPC',22,'The Tree field identifies a unique Tree in the system. Trees define roll ups or summary levels of information.  They are used in reports for defining report points and summarization levels.','Y','Y','Y','N','Tree',10,TO_TIMESTAMP('2013-05-04 19:57:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 04/05/2013 07:57:19 PM VET
-- LVE Retention
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=3000213 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- 04/05/2013 07:58:06 PM VET
-- LVE Retention
INSERT INTO AD_Menu ("action",AD_Client_ID,AD_Menu_ID,AD_Org_ID,AD_Process_ID,Created,CreatedBy,EntityType,IsActive,IsCentrallyMaintained,IsReadOnly,IsSOTrx,IsSummary,Name,Updated,UpdatedBy) VALUES ('P',0,3000208,0,3000205,TO_TIMESTAMP('2013-05-04 19:58:06','YYYY-MM-DD HH24:MI:SS'),100,'ERPC','Y','Y','N','N','N','Copy Menu Nodes',TO_TIMESTAMP('2013-05-04 19:58:06','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 04/05/2013 07:58:06 PM VET
-- LVE Retention
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Menu_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=3000208 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- 04/05/2013 07:58:06 PM VET
-- LVE Retention
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID,AD_Tree_ID,Created,CreatedBy,IsActive,Node_ID,Parent_ID,SeqNo,Updated,UpdatedBy) VALUES (0,0,10,TO_TIMESTAMP('2013-05-04 19:58:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',3000208,0,999,TO_TIMESTAMP('2013-05-04 19:58:06','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=3000208
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- 04/05/2013 08:00:09 PM VET
-- LVE Retention
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19,Updated=TO_TIMESTAMP('2013-05-04 20:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=50008
;

-- 04/05/2013 08:03:00 PM VET
-- LVE Retention
UPDATE AD_Menu_Trl SET Name='Copiar nodos de un menu',Updated=TO_TIMESTAMP('2013-05-04 20:03:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=3000208 AND AD_Language='es_VE'
;

-- 04/05/2013 08:03:19 PM VET
-- LVE Retention
UPDATE AD_Menu_Trl SET Name='Copiar nodos de menu',Updated=TO_TIMESTAMP('2013-05-04 20:03:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=3000208 AND AD_Language='es_VE'
;

