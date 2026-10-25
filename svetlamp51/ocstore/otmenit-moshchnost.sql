-- СветЛамп: отменить zapolnit-moshchnost.sql — убрать мощность, которую он записал.
-- Если префикс таблиц не oc_, замените oc_ на свой.
SET @sl_power := (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Мощность лампы' LIMIT 1);

DELETE pa FROM oc_product_attribute pa
JOIN sl_power_filled f ON f.product_id = pa.product_id
WHERE pa.attribute_id = @sl_power;

DROP TABLE sl_power_filled;
