-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_Element SET ColumnName='Exempt', Name='Exempt', PrintName='Exempt',Updated=TO_TIMESTAMP('2013-05-14 14:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3000244
;

-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=3000244
;

-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_Column SET ColumnName='Exempt', Name='Exempt', Description=NULL, Help=NULL WHERE AD_Element_ID=3000244
;

-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_Process_Para SET ColumnName='Exempt', Name='Exempt', Description=NULL, Help=NULL, AD_Element_ID=3000244 WHERE UPPER(ColumnName)='EXEMPT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_Process_Para SET ColumnName='Exempt', Name='Exempt', Description=NULL, Help=NULL WHERE AD_Element_ID=3000244 AND IsCentrallyMaintained='Y'
;

-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_Field SET Name='Exempt', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=3000244) AND IsCentrallyMaintained='Y'
;

-- 14-may-2013 14:53:13 VET
--  LVE Inalsa
UPDATE AD_PrintFormatItem SET PrintName='Exempt', Name='Exempt' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=3000244)
;

-- 14-may-2013 14:53:28 VET
--  LVE Inalsa
UPDATE AD_Element_Trl SET Name='Exento',PrintName='Exento',Updated=TO_TIMESTAMP('2013-05-14 14:53:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3000244 AND AD_Language='es_VE'
;

-- 14-may-2013 14:53:52 VET
--  LVE Inalsa
UPDATE AD_Element SET AD_Reference_ID=12,Updated=TO_TIMESTAMP('2013-05-14 14:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3000244
;

