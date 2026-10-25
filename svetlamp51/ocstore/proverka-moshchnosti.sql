-- СветЛамп: у каких ламп заполнена мощность.
-- Смотрит все товары в разделе «Лампы» и во всех его подкатегориях (cokol-gx53, cokol-gx70 и т. д.)
-- и ищет у них атрибут, название которого начинается на «Мощност» («Мощность», «Мощность, Вт»…).
-- Ничего не меняет, только показывает.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

SET @sl_lampy := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                  WHERE `keyword` = 'lampy' AND `query` LIKE 'category_id=%' LIMIT 1);

-- 1. Сводка по каждой категории: сколько ламп всего и у скольких мощность не заполнена
SELECT cd.name AS `Категория`,
       COUNT(DISTINCT p2c.product_id) AS `Всего ламп`,
       COUNT(DISTINCT p2c.product_id) - COUNT(DISTINCT pa.product_id) AS `Без мощности`
FROM oc_category_path cp
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
JOIN oc_category_description cd ON cd.category_id = cp.category_id AND cd.language_id = 1
LEFT JOIN (oc_product_attribute pa
           JOIN oc_attribute_description ad ON ad.attribute_id = pa.attribute_id AND ad.language_id = 1 AND ad.name LIKE 'Мощност%')
       ON pa.product_id = p2c.product_id AND pa.language_id = 1 AND TRIM(pa.text) <> ''
WHERE cp.path_id = @sl_lampy
GROUP BY cp.category_id, cd.name
ORDER BY cd.name;

-- 2. Каждая лампа и её мощность. Сначала те, у кого мощность не заполнена
SELECT cd.name AS `Категория`, pd.name AS `Товар`, p.model AS `Модель`,
       COALESCE(GROUP_CONCAT(DISTINCT CONCAT(ad.name, ': ', pa.text) SEPARATOR '; '), '— НЕ ЗАПОЛНЕНО —') AS `Мощность`
FROM oc_category_path cp
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
JOIN oc_product p ON p.product_id = p2c.product_id
JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 1
JOIN oc_category_description cd ON cd.category_id = cp.category_id AND cd.language_id = 1
LEFT JOIN (oc_product_attribute pa
           JOIN oc_attribute_description ad ON ad.attribute_id = pa.attribute_id AND ad.language_id = 1 AND ad.name LIKE 'Мощност%')
       ON pa.product_id = p.product_id AND pa.language_id = 1 AND TRIM(pa.text) <> ''
WHERE cp.path_id = @sl_lampy
GROUP BY cp.category_id, cd.name, p.product_id, pd.name, p.model
ORDER BY COUNT(ad.attribute_id) > 0, cd.name, pd.name;

-- 3. Как записаны значения мощности (видно, где «10», а где «10 Вт» или «10W»)
SELECT ad.name AS `Атрибут`, pa.text AS `Значение`, COUNT(DISTINCT pa.product_id) AS `Ламп`
FROM oc_category_path cp
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
JOIN oc_product_attribute pa ON pa.product_id = p2c.product_id AND pa.language_id = 1
JOIN oc_attribute_description ad ON ad.attribute_id = pa.attribute_id AND ad.language_id = 1 AND ad.name LIKE 'Мощност%'
WHERE cp.path_id = @sl_lampy
GROUP BY ad.name, pa.text
ORDER BY ad.name, CAST(pa.text AS DECIMAL(10,2)), pa.text;
