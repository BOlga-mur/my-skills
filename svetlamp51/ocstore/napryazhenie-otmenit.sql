-- СветЛамп: отменить napryazhenie-ispravit.sql — вернуть напряжение блоков питания как было.
-- Если префикс таблиц не oc_, замените oc_ на свой.
DELETE pa FROM oc_product_attribute pa
JOIN sl_volt_backup b ON b.product_id = pa.product_id AND b.attribute_id = pa.attribute_id AND b.language_id = pa.language_id;

INSERT INTO oc_product_attribute SELECT * FROM sl_volt_backup;

DROP TABLE sl_volt_backup;
DROP TABLE sl_psu_products;
