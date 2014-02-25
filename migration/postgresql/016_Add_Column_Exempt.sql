-- 14-may-2013 15:08:12 VET
--  LVE Inalsa
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,ColumnSQL,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,3000481,3000244,0,12,410,'Exempt','(C_CashLine.Amount - (C_CashLine.A_Base_Amount + C_CashLine.TaxAmt))',TO_TIMESTAMP('2013-05-14 15:08:12','YYYY-MM-DD HH24:MI:SS'),100,'U',14,'Y','Y','N','N','N','N','N','N','N','N','N','N','N','Exempt',0,TO_TIMESTAMP('2013-05-14 15:08:12','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- 14-may-2013 15:08:12 VET
--  LVE Inalsa
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=3000481 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 14-may-2013 15:08:40 VET
--  LVE Inalsa
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,3000481,3000271,0,339,TO_TIMESTAMP('2013-05-14 15:08:39','YYYY-MM-DD HH24:MI:SS'),100,14,'U','Y','Y','Y','N','N','N','N','N','Exempt',TO_TIMESTAMP('2013-05-14 15:08:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 14-may-2013 15:08:40 VET
--  LVE Inalsa
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000271 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 14-may-2013 15:09:05 VET
--  LVE Inalsa
UPDATE AD_Field SET EntityType='ECA02',Updated=TO_TIMESTAMP('2013-05-14 15:09:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000271
;

-- 14-may-2013 15:09:33 VET
--  LVE Inalsa
UPDATE AD_Column SET EntityType='ECA02',Updated=TO_TIMESTAMP('2013-05-14 15:09:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3000481
;

-- 14-may-2013 15:15:31 VET
--  LVE Inalsa
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2013-05-14 15:15:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3000481
;

-- 14-may-2013 15:16:57 VET
--  LVE Inalsa
UPDATE AD_Column SET IsActive='Y',Updated=TO_TIMESTAMP('2013-05-14 15:16:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3000481
;

-- 14-may-2013 15:17:15 VET
--  LVE Inalsa
UPDATE AD_Column SET ColumnSQL='(C_CashLine.Amount - (C_CashLine.A_Base_Amount + TaxAmt))',Updated=TO_TIMESTAMP('2013-05-14 15:17:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3000481
;

-- 14-may-2013 15:21:46 VET
--  LVE Inalsa
UPDATE AD_Column SET ColumnSQL='(C_CashLine.Amount - (C_CashLine.A_Base_Amount + Case When C_CashLine.C_Tax_ID Is Null Then 0 Else (Select C_CashLine.A_Base_Amount * (C_Tax.Rate / 100)  From C_Tax Where C_Tax.C_Tax_ID=C_CashLine.C_Tax_ID) End))',Updated=TO_TIMESTAMP('2013-05-14 15:21:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3000481
;

