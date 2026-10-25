-- СветЛамп: заполнить атрибут «Мощность лампы» там, где он пустой, по названию товара.
-- Берётся число перед W / Вт в названии: «Лампа GU5.3 11w 4100K» → 11.
-- Затрагивает только товары в «Лампах» и их подкатегориях, у которых атрибута ещё нет.
-- Товары без мощности в названии (переходники, патроны) не трогаются.
-- Нужен MySQL 8 или MariaDB 10.0.5+ (функция REGEXP_SUBSTR).
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

SET @sl_lampy := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                  WHERE `keyword` = 'lampy' AND `query` LIKE 'category_id=%' LIMIT 1);
SET @sl_power := (SELECT attribute_id FROM oc_attribute_description
                  WHERE name = 'Мощность лампы' LIMIT 1);

-- Лампы без мощности, у которых мощность есть в названии
DROP TABLE IF EXISTS sl_power_filled;
CREATE TABLE sl_power_filled AS
SELECT p.product_id, pd.name,
       REPLACE(REGEXP_SUBSTR(REGEXP_SUBSTR(pd.name, '[0-9]+([.,][0-9]+)? ?([wWвВ]|Вт|вт|ВТ)'), '[0-9]+([.,][0-9]+)?'), ',', '.') AS power
FROM oc_product p
JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 1
WHERE @sl_power IS NOT NULL
  AND p.product_id IN (SELECT p2c.product_id FROM oc_product_to_category p2c
                       JOIN oc_category_path cp ON cp.category_id = p2c.category_id
                       WHERE cp.path_id = @sl_lampy)
  AND p.product_id NOT IN (SELECT pa.product_id FROM oc_product_attribute pa
                           WHERE pa.attribute_id = @sl_power AND TRIM(pa.text) <> '')
  AND REGEXP_SUBSTR(pd.name, '[0-9]+([.,][0-9]+)? ?([wWвВ]|Вт|вт|ВТ)') <> '';

-- Пустые строки атрибута (если были) убираются, чтобы не было дублей
DELETE pa FROM oc_product_attribute pa
JOIN sl_power_filled f ON f.product_id = pa.product_id
WHERE pa.attribute_id = @sl_power;

-- Запись мощности на всех языках магазина
INSERT INTO oc_product_attribute (product_id, attribute_id, language_id, text)
SELECT f.product_id, @sl_power, l.language_id, f.power
FROM sl_power_filled f
CROSS JOIN oc_language l;

-- Что заполнено
SELECT product_id AS `ID`, name AS `Товар`, power AS `Мощность лампы` FROM sl_power_filled ORDER BY name;
