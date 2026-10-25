-- СветЛамп: отменить bloki-pitaniya-ispravit.sql — вернуть напряжение и мощность блоков питания как было.
-- Если префикс таблиц не oc_, замените oc_ на свой.
SET @sl_volt  := (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение' LIMIT 1);
SET @sl_power := (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Мощность' LIMIT 1);

DELETE pa FROM oc_product_attribute pa JOIN sl_psu_changes c ON c.product_id = pa.product_id
WHERE pa.attribute_id IN (@sl_volt, @sl_power);

INSERT INTO oc_product_attribute SELECT * FROM sl_psu_backup;

DROP TABLE sl_psu_changes;
DROP TABLE sl_psu_backup;
