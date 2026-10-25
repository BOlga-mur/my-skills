-- СветЛамп: напряжение блоков питания — только выходное, простым числом.
-- «12/220» → 12, «24/180-265» → 24, «48V» → 48, «12 В» → 12.
-- Работает со всеми атрибутами, которые называются «Напряжение» (их в магазине может быть несколько),
-- и только для товаров в «Блоках питания» (bloki-pitanija) и их подкатегориях.
-- Значения, которые не начинаются с 5, 12, 24, 36 или 48 вольт, не трогает.
-- Отмена — файл napryazhenie-otmenit.sql.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

-- 1. Сколько атрибутов «Напряжение» в магазине (для понимания, почему прошлый скрипт не сработал)
SELECT attribute_id AS `ID атрибута`, name AS `Название`, COUNT(*) AS `Языков`
FROM oc_attribute_description WHERE name = 'Напряжение' GROUP BY attribute_id, name;

-- Блоки питания: все категории с адресом bloki-pitanija и их подкатегории
DROP TABLE IF EXISTS sl_psu_products;
CREATE TABLE sl_psu_products AS
SELECT DISTINCT p2c.product_id
FROM oc_url_alias ua
JOIN oc_category_path cp ON cp.path_id = CAST(SUBSTRING(ua.`query`, 13) AS UNSIGNED)
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
WHERE ua.`keyword` = 'bloki-pitanija' AND ua.`query` LIKE 'category_id=%';

-- Копия для отмены
DROP TABLE IF EXISTS sl_volt_backup;
CREATE TABLE sl_volt_backup AS
SELECT pa.* FROM oc_product_attribute pa
JOIN sl_psu_products s ON s.product_id = pa.product_id
WHERE pa.attribute_id IN (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение');

-- 2. Исправление
UPDATE oc_product_attribute pa
JOIN sl_psu_products s ON s.product_id = pa.product_id
SET pa.text = REPLACE(REPLACE(REPLACE(UPPER(TRIM(SUBSTRING_INDEX(pa.text, '/', 1))), 'V', ''), 'В', ''), ' ', '')
WHERE pa.attribute_id IN (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение')
  AND REPLACE(REPLACE(REPLACE(UPPER(TRIM(SUBSTRING_INDEX(pa.text, '/', 1))), 'V', ''), 'В', ''), ' ', '') IN ('5', '12', '24', '36', '48')
  AND pa.text <> REPLACE(REPLACE(REPLACE(UPPER(TRIM(SUBSTRING_INDEX(pa.text, '/', 1))), 'V', ''), 'В', ''), ' ', '');

-- 3. Какие значения напряжения у блоков теперь
SELECT pa.text AS `Напряжение`, COUNT(DISTINCT pa.product_id) AS `Блоков`
FROM oc_product_attribute pa
JOIN sl_psu_products s ON s.product_id = pa.product_id
WHERE pa.attribute_id IN (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение')
GROUP BY pa.text
ORDER BY CAST(pa.text AS DECIMAL(10,2)), pa.text;
