CREATE OR REPLACE VIEW rv_orderdetail AS 
 SELECT l.ad_client_id, l.ad_org_id, l.isactive, l.created, l.createdby, 
    l.updated, l.updatedby, o.c_order_id, o.docstatus, o.docaction, 
    o.c_doctype_id, o.isapproved, o.iscreditapproved, o.salesrep_id, 
    o.bill_bpartner_id, o.bill_location_id, o.bill_user_id, o.isdropship, 
    l.c_bpartner_id, l.c_bpartner_location_id, o.ad_user_id, o.poreference, 
    o.c_currency_id, o.issotrx, l.c_campaign_id, l.c_project_id, 
    l.c_activity_id, l.c_projectphase_id, l.c_projecttask_id, l.c_orderline_id, 
    l.dateordered, l.datepromised, l.m_product_id, l.m_warehouse_id, 
    l.m_attributesetinstance_id, 
    productattribute(l.m_attributesetinstance_id) AS productattribute, 
    pasi.m_attributeset_id, pasi.m_lot_id, pasi.guaranteedate, pasi.lot, 
    pasi.serno, l.c_uom_id, l.qtyentered, l.qtyordered, l.qtyreserved, 
    l.qtydelivered, l.qtyinvoiced, l.priceactual, l.priceentered, 
    l.qtyordered - l.qtydelivered AS qtytodeliver, 
    l.qtyordered - l.qtyinvoiced AS qtytoinvoice, 
    (l.qtyordered - l.qtyinvoiced) * l.priceactual AS netamttoinvoice, 
    l.qtylostsales, l.qtylostsales * l.priceactual AS amtlostsales, 
        CASE
            WHEN l.pricelist = 0::numeric THEN 0::numeric
            ELSE round((l.pricelist - l.priceactual) / l.pricelist * 100::numeric, 2)
        END AS discount, 
        CASE
            WHEN l.pricelimit = 0::numeric THEN 0::numeric
            ELSE round((l.priceactual - l.pricelimit) / l.pricelimit * 100::numeric, 2)
        END AS margin, 
        CASE
            WHEN l.pricelimit = 0::numeric THEN 0::numeric
            ELSE (l.priceactual - l.pricelimit) * l.qtydelivered
        END AS marginamt,
        COALESCE(c.name, (p.Name || productattribute(l.m_attributesetinstance_id)), l.Description) AS name,
        l.Description, l.C_Tax_ID, (l.LineNetAmt * t.Rate * 0.01) TaxAmt, l.LineNetAmt
   FROM c_order o
   JOIN c_orderline l ON o.c_order_id = l.c_order_id
   INNER JOIN C_UOM uo ON(uo.C_UOM_ID = l.C_UOM_ID)
   INNER JOIN C_Tax t ON(t.C_Tax_ID = l.C_Tax_ID)
   LEFT JOIN C_Charge c ON(c.C_Charge_ID = l.C_Charge_ID)
   LEFT JOIN M_Product p ON(p.M_Product_ID = l.M_Product_ID)
   LEFT JOIN m_attributesetinstance pasi ON l.m_attributesetinstance_id = pasi.m_attributesetinstance_id