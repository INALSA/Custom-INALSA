-- 08-may-2013 14:36:41 VET
-- LVE Retention
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,3000256,0,29,'MaskQtyInternalUse',TO_TIMESTAMP('2013-05-08 14:36:39','YYYY-MM-DD HH24:MI:SS'),100,'Internal Use Quantity removed from Inventory','ERPC',22,'Quantity of product inventory used internally (positive if taken out - negative if returned)','Y','Mask Internal Use Qty','Internal Use',TO_TIMESTAMP('2013-05-08 14:36:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 14:36:41 VET
-- LVE Retention
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=3000256 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- 08-may-2013 14:38:24 VET
-- LVE Retention
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,Callout,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,3000457,3000256,0,29,322,'org.erpca.model.CalloutInventory.qtyInternalUse','Mask QtyInternalUse',TO_TIMESTAMP('2013-05-08 14:38:20','YYYY-MM-DD HH24:MI:SS'),100,'Internal Use Quantity removed from Inventory','ERPC',22,'Quantity of product inventory used internally (positive if taken out - negative if returned)','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','VirtualInternal Use Qty',0,TO_TIMESTAMP('2013-05-08 14:38:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- 08-may-2013 14:38:24 VET
-- LVE Retention
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=3000457 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 08-may-2013 14:43:36 VET
-- LVE Retention
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,3000457,3000443,0,256,TO_TIMESTAMP('2013-05-08 14:43:35','YYYY-MM-DD HH24:MI:SS'),100,'Internal Use Quantity removed from Inventory',22,'ERPC','Quantity of product inventory used internally (positive if taken out - negative if returned)','Y','Y','Y','N','N','N','N','N','Mask Internal Use Qty',TO_TIMESTAMP('2013-05-08 14:43:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 14:43:36 VET
-- LVE Retention
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000443 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08-may-2013 14:43:56 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0,Updated=TO_TIMESTAMP('2013-05-08 14:43:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000443
;

-- 08-may-2013 14:45:37 VET
-- LVE Retention
ALTER TABLE M_InventoryLine ADD COLUMN MaskQtyInternalUse NUMERIC DEFAULT NULL 
;

-- 08-may-2013 15:53:34 VET
-- LVE Retention
UPDATE AD_Table SET PO_Window_ID=341,Updated=TO_TIMESTAMP('2013-05-08 15:53:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=322
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_Element SET ColumnName='MaskQtyInternalUse', Name='Mask Internal Use Qty',Updated=TO_TIMESTAMP('2013-05-08 15:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3000256
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=3000256
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_Column SET ColumnName='MaskQtyInternalUse', Name='Mask Internal Use Qty', Description='Internal Use Quantity removed from Inventory', Help='Quantity of product inventory used internally (positive if taken out - negative if returned)' WHERE AD_Element_ID=3000256
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_Process_Para SET ColumnName='MaskQtyInternalUse', Name='Mask Internal Use Qty', Description='Internal Use Quantity removed from Inventory', Help='Quantity of product inventory used internally (positive if taken out - negative if returned)', AD_Element_ID=3000256 WHERE UPPER(ColumnName)='MASKQTYINTERNALUSE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_Process_Para SET ColumnName='MaskQtyInternalUse', Name='Mask Internal Use Qty', Description='Internal Use Quantity removed from Inventory', Help='Quantity of product inventory used internally (positive if taken out - negative if returned)' WHERE AD_Element_ID=3000256 AND IsCentrallyMaintained='Y'
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_Field SET Name='Mask Internal Use Qty', Description='Internal Use Quantity removed from Inventory', Help='Quantity of product inventory used internally (positive if taken out - negative if returned)' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=3000256) AND IsCentrallyMaintained='Y'
;

-- 08-may-2013 15:55:19 VET
-- LVE Retention
UPDATE AD_PrintFormatItem SET PrintName='Internal Use', Name='Mask Internal Use Qty' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=3000256)
;

-- 08-may-2013 15:56:44 VET
-- LVE Retention
UPDATE AD_Element_Trl SET Name='Cantidad Usada Internamente',PrintName='Cantidad Usada Internamente',Description='Cantidad usada Internamente borrado por inventario',Help='Cantidad de inventario del producto usada internamente (si esta tomado hacia afuera positivo - negativa si está vuelto)',Updated=TO_TIMESTAMP('2013-05-08 15:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=3000256 AND AD_Language='es_VE'
;

-- 08-may-2013 15:57:23 VET
-- LVE Retention
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,3000457,3000444,0,683,TO_TIMESTAMP('2013-05-08 15:57:22','YYYY-MM-DD HH24:MI:SS'),100,'Internal Use Quantity removed from Inventory',22,'ERPC','Quantity of product inventory used internally (positive if taken out - negative if returned)','Y','Y','Y','N','N','N','N','N','Mask Internal Use Qty',TO_TIMESTAMP('2013-05-08 15:57:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 15:57:23 VET
-- LVE Retention
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000444 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08-may-2013 15:57:23 VET
-- LVE Retention
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,52115,3000445,0,683,TO_TIMESTAMP('2013-05-08 15:57:23','YYYY-MM-DD HH24:MI:SS'),100,131089,'D','Y','Y','Y','N','N','N','N','N','QtyCsv',TO_TIMESTAMP('2013-05-08 15:57:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 15:57:23 VET
-- LVE Retention
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000445 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08-may-2013 15:57:24 VET
-- LVE Retention
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,56357,3000446,0,683,TO_TIMESTAMP('2013-05-08 15:57:23','YYYY-MM-DD HH24:MI:SS'),100,'Use to keep the reversal line ID for reversing costing purpose',22,'D','Y','Y','Y','N','N','N','N','N','Reversal Line',TO_TIMESTAMP('2013-05-08 15:57:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 15:57:24 VET
-- LVE Retention
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000446 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08-may-2013 15:57:25 VET
-- LVE Retention
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,14101,3000447,0,683,TO_TIMESTAMP('2013-05-08 15:57:24','YYYY-MM-DD HH24:MI:SS'),100,'Search key for the record in the format required - must be unique',40,'D','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Y','Y','Y','N','N','N','N','N','Search Key',TO_TIMESTAMP('2013-05-08 15:57:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 15:57:25 VET
-- LVE Retention
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000447 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08-may-2013 15:57:25 VET
-- LVE Retention
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,14102,3000448,0,683,TO_TIMESTAMP('2013-05-08 15:57:25','YYYY-MM-DD HH24:MI:SS'),100,'Bar Code (Universal Product Code or its superset European Article Number)',30,'D','Use this field to enter the bar code for the product in any of the bar code symbologies (Codabar, Code 25, Code 39, Code 93, Code 128, UPC (A), UPC (E), EAN-13, EAN-8, ITF, ITF-14, ISBN, ISSN, JAN-13, JAN-8, POSTNET and FIM, MSI/Plessey, and Pharmacode) ','Y','Y','Y','N','N','N','N','N','UPC/EAN',TO_TIMESTAMP('2013-05-08 15:57:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- 08-may-2013 15:57:25 VET
-- LVE Retention
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=3000448 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 08-may-2013 15:57:41 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0,Updated=TO_TIMESTAMP('2013-05-08 15:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10998
;

-- 08-may-2013 15:57:41 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0,Updated=TO_TIMESTAMP('2013-05-08 15:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000445
;

-- 08-may-2013 15:57:41 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0,Updated=TO_TIMESTAMP('2013-05-08 15:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000446
;

-- 08-may-2013 15:57:41 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0,Updated=TO_TIMESTAMP('2013-05-08 15:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000447
;

-- 08-may-2013 15:57:41 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='N', SeqNo=0,Updated=TO_TIMESTAMP('2013-05-08 15:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000448
;

-- 08-may-2013 15:57:42 VET
-- LVE Retention
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90,Updated=TO_TIMESTAMP('2013-05-08 15:57:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3000444
;
