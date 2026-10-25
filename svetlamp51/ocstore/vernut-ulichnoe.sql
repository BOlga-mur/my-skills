-- СветЛамп: вернуть связи «товар — категория» как было до perenos-ulichnoe-v-sadovoe.sql
-- Если префикс таблиц не oc_, замените oc_ на свой.
DELETE FROM oc_product_to_category;
INSERT INTO oc_product_to_category SELECT * FROM sl_backup2_product_to_category;
