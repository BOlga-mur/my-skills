-- СветЛамп: какие характеристики заполнены у блоков питания.
-- Смотрит все товары в разделе «Блоки питания» (bloki-pitanija) и во всех его подкатегориях.
-- Ничего не меняет, только показывает.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.

SET @sl_psu := (SELECT CAST(SUBSTRING(`query`, 13) AS UNSIGNED) FROM oc_url_alias
                WHERE `keyword` = 'bloki-pitanija' AND `query` LIKE 'category_id=%' LIMIT 1);

-- 1. Какие атрибуты есть у блоков питания и у скольких товаров они заполнены
SELECT ad.name AS `Атрибут`, COUNT(DISTINCT pa.product_id) AS `Заполнено у товаров`,
       (SELECT COUNT(DISTINCT p2.product_id) FROM oc_product_to_category p2
        JOIN oc_category_path c2 ON c2.category_id = p2.category_id WHERE c2.path_id = @sl_psu) AS `Всего товаров`
FROM oc_category_path cp
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
JOIN oc_product_attribute pa ON pa.product_id = p2c.product_id AND pa.language_id = 1 AND TRIM(pa.text) <> ''
JOIN oc_attribute_description ad ON ad.attribute_id = pa.attribute_id AND ad.language_id = 1
WHERE cp.path_id = @sl_psu
GROUP BY ad.name
ORDER BY COUNT(DISTINCT pa.product_id) DESC;

-- 2. Значения атрибутов про мощность и напряжение (видно, где «60», а где «60 Вт» или «60W»)
SELECT ad.name AS `Атрибут`, pa.text AS `Значение`, COUNT(DISTINCT pa.product_id) AS `Товаров`
FROM oc_category_path cp
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
JOIN oc_product_attribute pa ON pa.product_id = p2c.product_id AND pa.language_id = 1
JOIN oc_attribute_description ad ON ad.attribute_id = pa.attribute_id AND ad.language_id = 1
WHERE cp.path_id = @sl_psu AND (ad.name LIKE '%мощност%' OR ad.name LIKE '%напряжени%' OR ad.name LIKE '%вольт%')
GROUP BY ad.name, pa.text
ORDER BY ad.name, CAST(pa.text AS DECIMAL(10,2)), pa.text;

-- 3. Блоки питания с названиями: по ним видно, есть ли мощность и напряжение в названии
SELECT cd.name AS `Категория`, pd.name AS `Товар`
FROM oc_category_path cp
JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
JOIN oc_product_description pd ON pd.product_id = p2c.product_id AND pd.language_id = 1
JOIN oc_category_description cd ON cd.category_id = cp.category_id AND cd.language_id = 1
WHERE cp.path_id = @sl_psu
ORDER BY cd.name, pd.name;
