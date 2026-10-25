-- СветЛамп: товары, которые лежат только в «Уличном освещении» (и ни в какой другой категории),
-- переносятся в подкатегорию «Садовое освещение». Остальные товары не трогаются.
-- Категории находятся по адресам ulichnoe-osveshhenie и sadovoe-osveshchenie.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

SET @sl_parent := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                   WHERE `keyword` = 'ulichnoe-osveshhenie' AND `query` LIKE 'category_id=%' LIMIT 1);
SET @sl_child  := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                   WHERE `keyword` = 'sadovoe-osveshchenie' AND `query` LIKE 'category_id=%' LIMIT 1);

-- Резервная копия связей «товар — категория»
DROP TABLE IF EXISTS sl_backup2_product_to_category;
CREATE TABLE sl_backup2_product_to_category AS SELECT * FROM oc_product_to_category;

-- Перенос: у такого товара одна-единственная связь, она и меняется на «Садовое освещение»
UPDATE oc_product_to_category
SET category_id = @sl_child, main_category = 1
WHERE category_id = @sl_parent
  AND @sl_child IS NOT NULL
  AND product_id IN (SELECT product_id FROM (
        SELECT product_id FROM oc_product_to_category GROUP BY product_id HAVING COUNT(*) = 1
      ) AS sl_only_one);

-- Что получилось: товары, которые теперь лежат в «Садовом освещении»
SELECT p2c.product_id, pd.name
FROM oc_product_to_category p2c
JOIN oc_product_description pd ON pd.product_id = p2c.product_id
WHERE p2c.category_id = @sl_child
GROUP BY p2c.product_id, pd.name;
