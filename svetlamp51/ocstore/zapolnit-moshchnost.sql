-- СветЛамп: заполнить атрибут «Мощность лампы» там, где он пустой, по названию товара.
-- Берётся число перед W / Вт в названии: «Лампа GU5.3 11w 4100K» → 11, «9,5 Вт» → 9.5, «2x18W» → 18.
-- Затрагивает только товары в «Лампах» и их подкатегориях, у которых атрибута ещё нет.
-- Товары без мощности в названии (переходники, патроны) не трогаются.
-- Работает в MySQL 5.7 и новее, а также в MariaDB.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

SET @sl_lampy := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                  WHERE `keyword` = 'lampy' AND `query` LIKE 'category_id=%' LIMIT 1);
SET @sl_power := (SELECT attribute_id FROM oc_attribute_description
                  WHERE name = 'Мощность лампы' LIMIT 1);

DROP TABLE IF EXISTS sl_power_filled;
CREATE TABLE sl_power_filled (product_id INT NOT NULL PRIMARY KEY, name VARCHAR(255), power VARCHAR(16));

-- Название режется на слова; мощность — это слово вида «11w» / «9,5Вт» / «2x18W»
-- или число, за которым идёт отдельное слово «W» / «Вт». Берётся первое такое место в названии.
INSERT IGNORE INTO sl_power_filled (product_id, name, power)
SELECT product_id, name, power FROM (
  SELECT product_id, name, i,
    CASE
      WHEN w LIKE '%вт' AND REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(LEFT(w, CHAR_LENGTH(w) - 2), 'x', -1), 'х', -1), ',', '.') REGEXP '^[0-9]+([.][0-9]+)?$'
        THEN REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(LEFT(w, CHAR_LENGTH(w) - 2), 'x', -1), 'х', -1), ',', '.')
      WHEN w LIKE '%w' AND REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(LEFT(w, CHAR_LENGTH(w) - 1), 'x', -1), 'х', -1), ',', '.') REGEXP '^[0-9]+([.][0-9]+)?$'
        THEN REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(LEFT(w, CHAR_LENGTH(w) - 1), 'x', -1), 'х', -1), ',', '.')
      WHEN (nxt LIKE 'w' OR nxt LIKE 'вт') AND REPLACE(w, ',', '.') REGEXP '^[0-9]+([.][0-9]+)?$'
        THEN REPLACE(w, ',', '.')
    END AS power
  FROM (
    SELECT p.product_id, pd.name, n.i,
           TRIM(BOTH ',' FROM TRIM(BOTH ')' FROM TRIM(BOTH '(' FROM SUBSTRING_INDEX(SUBSTRING_INDEX(pd.name, ' ', n.i), ' ', -1)))) AS w,
           TRIM(BOTH ',' FROM TRIM(BOTH ')' FROM SUBSTRING_INDEX(SUBSTRING_INDEX(pd.name, ' ', n.i + 1), ' ', -1))) AS nxt
    FROM oc_product p
    JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 1
    JOIN (SELECT 1 AS i UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
          UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
          UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18
          UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24) n
      ON n.i <= 1 + CHAR_LENGTH(pd.name) - CHAR_LENGTH(REPLACE(pd.name, ' ', ''))
    WHERE @sl_power IS NOT NULL
      AND p.product_id IN (SELECT p2c.product_id FROM oc_product_to_category p2c
                           JOIN oc_category_path cp ON cp.category_id = p2c.category_id
                           WHERE cp.path_id = @sl_lampy)
      AND p.product_id NOT IN (SELECT pa.product_id FROM oc_product_attribute pa
                               WHERE pa.attribute_id = @sl_power AND TRIM(pa.text) <> '')
  ) words
) found
WHERE power IS NOT NULL
ORDER BY product_id, i;

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
