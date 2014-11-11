-- 08-may-2013 22:46:25 VET
-- RETENTION LVE
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,3000458,1308,0,20,234,217,'Posted',TO_TIMESTAMP('2013-05-08 22:46:23','YYYY-MM-DD HH24:MI:SS'),100,'Posting status','ECA02',1,'The Posted field indicates the status of the Generation of General Ledger Accounting Lines ','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Posted',0,TO_TIMESTAMP('2013-05-08 22:46:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- 08-may-2013 22:46:26 VET
-- RETENTION LVE
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=3000458 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 08-may-2013 22:46:36 VET
-- RETENTION LVE
ALTER TABLE C_DocType ADD COLUMN Posted CHAR(1) DEFAULT 'Y' CHECK (Posted IN ('Y','N'))
;

-- 08-may-2013 22:55:22 VET
-- RETENTION LVE
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,3000458,3000449,0,167,TO_TIMESTAMP('2013-05-08 22:55:18','YYYY-MM-DD HH24:MI:SS'),100,'Posting status',1,'ECA02','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ','Y','Y','Y','N','N','N','N','N','Posted',TO_TIMESTAMP('2013-05-08 22:55:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 22:55:22 VET
-- RETENTION LVE
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000449 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

