-- СветЛамп: блоки питания — напряжение и мощность по названию товара.
-- • «Напряжение»: ставится выходное напряжение из названия (12V, 24 В, DC12V…), а если в названии его нет —
--   часть записанного значения до косой черты («12/220» → 12). Если в атрибуте записано другое
--   (12/220, 220, 12V или пусто), оно заменяется простым числом. Учитываются только 5, 12, 24, 36 и 48 В,
--   поэтому входное «220В» или «AC100-240V» из названия не попадёт.
-- • «Мощность»: заполняется только там, где её нет (60W, 100 Вт, 150Вт…). Заполненную мощность не трогает.
-- Затрагивает только товары в «Блоках питания» (bloki-pitanija) и их подкатегориях.
-- В конце показывает таблицу: что было и что стало. Работает в MySQL 5.7 и новее.
-- Отмена — файл bloki-pitaniya-otmenit.sql.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

SET @sl_psu   := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                  WHERE `keyword` = 'bloki-pitanija' AND `query` LIKE 'category_id=%' LIMIT 1);
SET @sl_volt  := (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Напряжение' LIMIT 1);
SET @sl_power := (SELECT attribute_id FROM oc_attribute_description WHERE name = 'Мощность' LIMIT 1);

-- Слова названий блоков питания (до 30 слов)
DROP TABLE IF EXISTS sl_psu_words;
CREATE TABLE sl_psu_words AS
SELECT p.product_id, pd.name, n.i,
       TRIM(BOTH ',' FROM TRIM(BOTH ')' FROM TRIM(BOTH '(' FROM SUBSTRING_INDEX(SUBSTRING_INDEX(pd.name, ' ', n.i), ' ', -1)))) AS w,
       TRIM(BOTH ',' FROM TRIM(BOTH ')' FROM SUBSTRING_INDEX(SUBSTRING_INDEX(pd.name, ' ', n.i + 1), ' ', -1))) AS nxt
FROM oc_product p
JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 1
JOIN (SELECT 1 AS i UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
      UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
      UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18
      UNION ALL SELECT 19 UNION ALL SELECT 20 UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24
      UNION ALL SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL SELECT 30) n
  ON n.i <= 1 + CHAR_LENGTH(pd.name) - CHAR_LENGTH(REPLACE(pd.name, ' ', ''))
WHERE p.product_id IN (SELECT p2c.product_id FROM oc_product_to_category p2c
                       JOIN oc_category_path cp ON cp.category_id = p2c.category_id
                       WHERE cp.path_id = @sl_psu);

-- Напряжение и мощность из названия (первое подходящее место)
DROP TABLE IF EXISTS sl_psu_found;
CREATE TABLE sl_psu_found (product_id INT NOT NULL PRIMARY KEY, name VARCHAR(255), volt VARCHAR(16), power VARCHAR(16));
INSERT INTO sl_psu_found (product_id, name) SELECT DISTINCT product_id, name FROM sl_psu_words;

UPDATE sl_psu_found f JOIN (
  SELECT product_id, SUBSTRING_INDEX(GROUP_CONCAT(v ORDER BY i), ',', 1) AS v FROM (
    SELECT product_id, i,
      CASE
        WHEN (w LIKE '%v' OR w LIKE '%в') AND REPLACE(UPPER(LEFT(w, CHAR_LENGTH(w) - 1)), 'DC', '') IN ('5', '12', '24', '36', '48')
          THEN REPLACE(UPPER(LEFT(w, CHAR_LENGTH(w) - 1)), 'DC', '')
        WHEN (nxt LIKE 'v' OR nxt LIKE 'в') AND REPLACE(UPPER(w), 'DC', '') IN ('5', '12', '24', '36', '48')
          THEN REPLACE(UPPER(w), 'DC', '')
      END AS v
    FROM sl_psu_words) x
  WHERE v IS NOT NULL GROUP BY product_id
) found ON found.product_id = f.product_id
SET f.volt = found.v;

UPDATE sl_psu_found f JOIN (
  SELECT product_id, SUBSTRING_INDEX(GROUP_CONCAT(v ORDER BY i SEPARATOR '|'), '|', 1) AS v FROM (
    SELECT product_id, i,
      CASE
        WHEN w LIKE '%вт' AND REPLACE(LEFT(w, CHAR_LENGTH(w) - 2), ',', '.') REGEXP '^[0-9]+([.][0-9]+)?$'
          THEN REPLACE(LEFT(w, CHAR_LENGTH(w) - 2), ',', '.')
        WHEN w LIKE '%w' AND REPLACE(LEFT(w, CHAR_LENGTH(w) - 1), ',', '.') REGEXP '^[0-9]+([.][0-9]+)?$'
          THEN REPLACE(LEFT(w, CHAR_LENGTH(w) - 1), ',', '.')
        WHEN (nxt LIKE 'w' OR nxt LIKE 'вт') AND REPLACE(w, ',', '.') REGEXP '^[0-9]+([.][0-9]+)?$'
          THEN REPLACE(w, ',', '.')
      END AS v
    FROM sl_psu_words) x
  WHERE v IS NOT NULL GROUP BY product_id
) found ON found.product_id = f.product_id
SET f.power = found.v;

-- Если в названии напряжения нет, оно берётся из уже записанного значения вида «12/220» или «24V/220V»:
-- выходное напряжение — то, что до косой черты
UPDATE sl_psu_found f
JOIN oc_product_attribute pa ON pa.product_id = f.product_id AND pa.attribute_id = @sl_volt AND pa.language_id = 1
SET f.volt = REPLACE(REPLACE(REPLACE(UPPER(TRIM(SUBSTRING_INDEX(pa.text, '/', 1))), 'V', ''), 'В', ''), ' ', '')
WHERE f.volt IS NULL
  AND REPLACE(REPLACE(REPLACE(UPPER(TRIM(SUBSTRING_INDEX(pa.text, '/', 1))), 'V', ''), 'В', ''), ' ', '') IN ('5', '12', '24', '36', '48');

-- Что было (для отчёта и отмены)
DROP TABLE IF EXISTS sl_psu_backup;
CREATE TABLE sl_psu_backup AS
SELECT pa.* FROM oc_product_attribute pa JOIN sl_psu_found f ON f.product_id = pa.product_id
WHERE pa.attribute_id IN (@sl_volt, @sl_power);

DROP TABLE IF EXISTS sl_psu_changes;
CREATE TABLE sl_psu_changes AS
SELECT f.product_id, f.name,
       (SELECT b.text FROM sl_psu_backup b WHERE b.product_id = f.product_id AND b.attribute_id = @sl_volt AND b.language_id = 1 LIMIT 1) AS volt_old,
       f.volt AS volt_new,
       (SELECT b.text FROM sl_psu_backup b WHERE b.product_id = f.product_id AND b.attribute_id = @sl_power AND b.language_id = 1 LIMIT 1) AS power_old,
       f.power AS power_new
FROM sl_psu_found f;

-- Напряжение: заменить там, где в названии оно есть и отличается от записанного
DELETE pa FROM oc_product_attribute pa JOIN sl_psu_changes c ON c.product_id = pa.product_id
WHERE @sl_volt IS NOT NULL AND pa.attribute_id = @sl_volt AND c.volt_new IS NOT NULL AND NOT (TRIM(IFNULL(c.volt_old, '')) <=> c.volt_new);
INSERT INTO oc_product_attribute (product_id, attribute_id, language_id, text)
SELECT c.product_id, @sl_volt, l.language_id, c.volt_new FROM sl_psu_changes c CROSS JOIN oc_language l
WHERE @sl_volt IS NOT NULL AND c.volt_new IS NOT NULL AND NOT (TRIM(IFNULL(c.volt_old, '')) <=> c.volt_new);

-- Мощность: заполнить только пустую
DELETE pa FROM oc_product_attribute pa JOIN sl_psu_changes c ON c.product_id = pa.product_id
WHERE @sl_power IS NOT NULL AND pa.attribute_id = @sl_power AND c.power_new IS NOT NULL AND TRIM(IFNULL(c.power_old, '')) = '';
INSERT INTO oc_product_attribute (product_id, attribute_id, language_id, text)
SELECT c.product_id, @sl_power, l.language_id, c.power_new FROM sl_psu_changes c CROSS JOIN oc_language l
WHERE @sl_power IS NOT NULL AND c.power_new IS NOT NULL AND TRIM(IFNULL(c.power_old, '')) = '';

DROP TABLE sl_psu_words;
DROP TABLE sl_psu_found;

-- Отчёт: что изменилось. Внизу — блоки, где в названии нет напряжения или мощности: их стоит заполнить вручную
SELECT name AS `Блок питания`,
       IFNULL(volt_old, '—') AS `Напряжение было`,
       CASE WHEN volt_new IS NULL THEN '— не найдено —'
            WHEN TRIM(IFNULL(volt_old, '')) = volt_new THEN volt_new
            ELSE CONCAT(volt_new, '  ← изменено') END AS `Напряжение стало`,
       IFNULL(power_old, '—') AS `Мощность была`,
       CASE WHEN TRIM(IFNULL(power_old, '')) <> '' THEN power_old
            WHEN power_new IS NULL THEN '— нет в названии —'
            ELSE CONCAT(power_new, '  ← заполнено') END AS `Мощность стала`
FROM sl_psu_changes
ORDER BY (volt_new IS NULL OR (TRIM(IFNULL(power_old, '')) = '' AND power_new IS NULL)),
         (TRIM(IFNULL(volt_old, '')) <=> volt_new) AND TRIM(IFNULL(power_old, '')) <> '',
         name;
