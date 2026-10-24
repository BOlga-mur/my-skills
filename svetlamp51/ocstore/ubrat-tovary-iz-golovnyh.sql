-- СветЛамп: убрать товары из головных категорий.
-- Головная категория = категория, у которой есть подкатегории.
-- Товар убирается из головной категории, только если он остаётся
-- хотя бы в одной обычной категории, поэтому из каталога ничего не пропадёт.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

-- 1. Резервная копия связей «товар — категория»
DROP TABLE IF EXISTS sl_backup_product_to_category;
CREATE TABLE sl_backup_product_to_category AS SELECT * FROM oc_product_to_category;

-- 2. Головные категории и товары, которые есть в обычных категориях
DROP TABLE IF EXISTS sl_parents;
CREATE TABLE sl_parents AS SELECT DISTINCT parent_id AS category_id FROM oc_category WHERE parent_id > 0;

DROP TABLE IF EXISTS sl_keep;
CREATE TABLE sl_keep AS
  SELECT DISTINCT product_id FROM oc_product_to_category
  WHERE category_id NOT IN (SELECT category_id FROM sl_parents);

-- 3. Убрать товары из головных категорий
DELETE p2c FROM oc_product_to_category p2c
  JOIN sl_parents p ON p.category_id = p2c.category_id
  JOIN sl_keep k ON k.product_id = p2c.product_id;

-- 4. Если у товара была отмечена головная категория как «главная»,
--    главной становится одна из оставшихся (от неё зависят адрес товара и хлебные крошки)
UPDATE oc_product_to_category p2c
  JOIN (SELECT product_id, MIN(category_id) AS category_id
        FROM oc_product_to_category
        GROUP BY product_id
        HAVING MAX(main_category) = 0) m
    ON m.product_id = p2c.product_id AND m.category_id = p2c.category_id
  SET p2c.main_category = 1;

-- 5. Уборка
DROP TABLE sl_parents;
DROP TABLE sl_keep;
