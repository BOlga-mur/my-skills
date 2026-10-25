-- СветЛамп: отменить napryazhenie-tolko-cifry.sql — вернуть В / V в значения напряжения.
-- Если префикс таблиц не oc_, замените oc_ на свой.
DELETE pa FROM oc_product_attribute pa
JOIN sl_volt_units_backup b ON b.product_id = pa.product_id AND b.attribute_id = pa.attribute_id AND b.language_id = pa.language_id;

INSERT INTO oc_product_attribute SELECT * FROM sl_volt_units_backup;

DROP TABLE sl_volt_units_backup;
