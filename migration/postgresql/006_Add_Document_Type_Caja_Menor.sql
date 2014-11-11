-- 29/04/2013 10:42:10 AM VET
-- LVE Retention
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,Created,CreatedBy,CurrentNext,CurrentNextSys,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,Prefix,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (1000002,0,1000534,TO_TIMESTAMP('2013-04-29 10:42:09','YYYY-MM-DD HH24:MI:SS'),100,1000000,100,1,'Y','N','Y','N','Caja','CH-','N',1000000,TO_TIMESTAMP('2013-04-29 10:42:09','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 29/04/2013 10:43:01 AM VET
-- LVE Retention
INSERT INTO C_DocType (AD_Client_ID,AD_Org_ID,AffectsBook,Affects_Book,C_DocType_ID,Created,CreatedBy,DocBaseType,DocNoSequence_ID,DocumentCopies,GL_Category_ID,HasCharges,HasProforma,IsActive,IsCreateCounter,IsDefault,IsDefaultCounterDoc,IsDocNoControlled,IsIndexed,IsInTransit,IsOverwriteDateOnComplete,IsOverwriteSeqOnComplete,IsPickQAConfirm,IsPrepareSplitDocument,IsShipConfirm,IsSOTrx,IsSplitWhenDifference,Name,PrintName,Updated,UpdatedBy) VALUES (1000002,0,'N','N',1000048,TO_TIMESTAMP('2013-04-29 10:43:00','YYYY-MM-DD HH24:MI:SS'),100,'CMC',1000534,1,1000000,'N','N','Y','Y','N','N','Y','N','N','N','N','N','Y','N','N','N','Caja Menor','Caja Menor',TO_TIMESTAMP('2013-04-29 10:43:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 29/04/2013 10:43:01 AM VET
-- LVE Retention
INSERT INTO C_DocType_Trl (AD_Language,C_DocType_ID, DocumentNote,Name,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.C_DocType_ID, t.DocumentNote,t.Name,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, C_DocType t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.C_DocType_ID=1000048 AND NOT EXISTS (SELECT * FROM C_DocType_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.C_DocType_ID=t.C_DocType_ID)
;

-- 29/04/2013 10:43:01 AM VET
-- LVE Retention
INSERT INTO AD_Document_Action_Access (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,C_DocType_ID , AD_Ref_List_ID, AD_Role_ID) (SELECT 1000002,0,'Y', CURRENT_TIMESTAMP,100, CURRENT_TIMESTAMP,100, doctype.C_DocType_ID, "action".AD_Ref_List_ID, rol.AD_Role_ID FROM AD_Client client INNER JOIN C_DocType doctype ON (doctype.AD_Client_ID=client.AD_Client_ID) INNER JOIN AD_Ref_List "action" ON ("action".AD_Reference_ID=135) INNER JOIN AD_Role rol ON (rol.AD_Client_ID=client.AD_Client_ID) WHERE client.AD_Client_ID=1000002 AND doctype.C_DocType_ID=1000048 AND rol.IsManual='N')
;

