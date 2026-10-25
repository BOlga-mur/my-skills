-- СветЛамп: в атрибутах «Напряжение» оставить только число — убрать В / V.
-- «220В» → 220, «220 V» → 220, «12v» → 12, «100-240V» → 100-240. Для всех товаров.
-- Значения, где кроме числа и В/V есть что-то ещё (буквы, слова), не трогает.
-- Работает со всеми атрибутами, которые называются «Напряжение».
-- Отмена — файл napryazhenie-tolko-cifry-otmenit.sql.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

-- Копия для отмены
DROP TABLE IF EXISTS sl_volt_units_backup;
CREATE TABLE sl_volt_units_backup AS
SELECT pa.* FROM oc_product_attribute pa
WHERE pa.attribute_id IN (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение')
  AND pa.text <> REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(pa.text), 'V', ''), 'v', ''), 'В', ''), 'в', ''), ' ', '');

-- Исправление: только если после удаления В/V осталось число или диапазон чисел
UPDATE oc_product_attribute pa
SET pa.text = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(pa.text), 'V', ''), 'v', ''), 'В', ''), 'в', ''), ' ', '')
WHERE pa.attribute_id IN (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение')
  AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(pa.text), 'V', ''), 'v', ''), 'В', ''), 'в', ''), ' ', '') REGEXP '^[0-9]+([.,][0-9]+)?(-[0-9]+([.,][0-9]+)?)?$'
  AND pa.text <> REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(pa.text), 'V', ''), 'v', ''), 'В', ''), 'в', ''), ' ', '');

-- Какие значения напряжения теперь есть в магазине
SELECT pa.text AS `Напряжение`, COUNT(DISTINCT pa.product_id) AS `Товаров`
FROM oc_product_attribute pa
WHERE pa.attribute_id IN (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение')
GROUP BY pa.text
ORDER BY CAST(pa.text AS DECIMAL(10,2)), pa.text;
