-- 04/05/2013 08:18:42 PM VET
-- LVE Retention
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,3000254,0,18,184,'Tree_To_ID',TO_TIMESTAMP('2013-05-04 20:18:42','YYYY-MM-DD HH24:MI:SS'),100,NULL,'ERPC',22,NULL,'Y','Tree To','Tree To',TO_TIMESTAMP('2013-05-04 20:18:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 04/05/2013 08:18:42 PM VET
-- LVE Retention
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=3000254 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- 04/05/2013 08:19:01 PM VET
-- LVE Retention
UPDATE AD_Element_Trl SET Name='A Arbol',PrintName='A Arbol',Updated=TO_TIMESTAMP('2013-05-04 20:19:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3000254 AND AD_Language='es_VE'
;

-- 04/05/2013 08:19:46 PM VET
-- LVE Retention
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,3000456,3000254,0,18,184,288,'Tree_To_ID',TO_TIMESTAMP('2013-05-04 20:19:45','YYYY-MM-DD HH24:MI:SS'),100,'ERPC',22,'Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Tree To',0,TO_TIMESTAMP('2013-05-04 20:19:45','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- 04/05/2013 08:19:46 PM VET
-- LVE Retention
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=3000456 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 04/05/2013 08:20:14 PM VET
-- LVE Retention
DELETE FROM AD_Process_Para_Trl WHERE AD_Process_Para_ID=3000214
;

-- 04/05/2013 08:20:14 PM VET
-- LVE Retention
DELETE FROM AD_Process_Para WHERE AD_Process_Para_ID=3000214
;

-- 04/05/2013 08:20:31 PM VET
-- LVE Retention
INSERT INTO AD_Process_Para (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,AD_Reference_Value_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy) VALUES (0,3000254,0,3000205,3000215,18,184,'Tree_To_ID',TO_TIMESTAMP('2013-05-04 20:20:30','YYYY-MM-DD HH24:MI:SS'),100,'ERPC',22,'Y','Y','Y','N','Tree To',20,TO_TIMESTAMP('2013-05-04 20:20:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 04/05/2013 08:20:31 PM VET
-- LVE Retention
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=3000215 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

