-- СветЛамп: ЧПУ (SEO URL) для товаров, у которых его нет.
-- Адрес делается из названия товара по правилам SEO: транслитерация латиницей, только строчные буквы,
-- цифры и дефисы, не длиннее 80 знаков. Пример: «Лампа GX53 8W 4000К, Gauss» → lampa-gx53-8w-4000k-gauss
-- Если такой адрес уже занят (другой товар, категория, статья), в конце добавляется номер товара: …-2231.
-- Товары, у которых ЧПУ уже есть, НЕ трогаются: их адреса уже знают поисковики.
-- Отмена — seo-url-tovarov-otmenit.sql. Работает в MySQL 5.7 и новее.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.
-- После запуска удалите в папке system/storage/cache файлы, имя которых начинается на cache.seo_pro
-- (иначе новые адреса заработают только через час).

DROP TABLE IF EXISTS sl_seo_new;
CREATE TABLE sl_seo_new (product_id INT NOT NULL PRIMARY KEY, name VARCHAR(255), keyword VARCHAR(255)) DEFAULT CHARSET=utf8;

INSERT INTO sl_seo_new (product_id, name)
SELECT p.product_id, pd.name
FROM oc_product p
JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 1
WHERE NOT EXISTS (SELECT 1 FROM oc_url_alias ua WHERE ua.query = CONCAT('product_id=', p.product_id) AND TRIM(ua.keyword) <> '');

-- Транслитерация: «Лампа GX53 8W 4000К» → «lampa-gx53-8w-4000k»
UPDATE sl_seo_new SET keyword = LOWER(TRIM(name));
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'щ', 'shch');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ш', 'sh');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ч', 'ch');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ж', 'zh');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ц', 'ts');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ю', 'yu');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'я', 'ya');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ё', 'e');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'й', 'y');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'х', 'h');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'а', 'a');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'б', 'b');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'в', 'v');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'г', 'g');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'д', 'd');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'е', 'e');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'з', 'z');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'и', 'i');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'к', 'k');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'л', 'l');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'м', 'm');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'н', 'n');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'о', 'o');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'п', 'p');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'р', 'r');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'с', 's');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'т', 't');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'у', 'u');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ф', 'f');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ы', 'y');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'э', 'e');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ъ', '');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'ь', '');
-- Пробелы и знаки препинания → дефис
UPDATE sl_seo_new SET keyword = REPLACE(keyword, ' ', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, ',', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '.', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '/', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '\\', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '(', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, ')', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '"', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '''', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '«', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '»', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '„', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '“', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '”', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '+', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '*', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '×', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '%', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '№', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, ':', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, ';', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '!', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '?', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '&', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '#', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '_', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '–', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '—', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '°', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '⌀', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, 'Ø', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '[', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, ']', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '|', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '=', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '~', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '`', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '<', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '>', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '{', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '}', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '@', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '^', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '$', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '’', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '´', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '·', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '²', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '³', '-');
-- Несколько дефисов подряд → один, без дефисов по краям
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '--', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '--', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '--', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '--', '-');
UPDATE sl_seo_new SET keyword = REPLACE(keyword, '--', '-');
UPDATE sl_seo_new SET keyword = TRIM(BOTH '-' FROM keyword);
-- Не длиннее 80 знаков, обрезка по целому слову
UPDATE sl_seo_new SET keyword = LEFT(keyword, 80) WHERE CHAR_LENGTH(keyword) > 80;
UPDATE sl_seo_new SET keyword = LEFT(keyword, CHAR_LENGTH(keyword) - LOCATE('-', REVERSE(keyword))) WHERE CHAR_LENGTH(keyword) = 80 AND LOCATE('-', keyword) > 0;
UPDATE sl_seo_new SET keyword = TRIM(BOTH '-' FROM keyword);
-- Если остались непонятные символы — адрес не делается (товар попадёт в список «не сделано»)
UPDATE sl_seo_new SET keyword = NULL WHERE keyword = '' OR keyword NOT REGEXP '^[a-z0-9]+(-[a-z0-9]+)*$';

-- Занятые адреса: уже есть в магазине или совпали у нескольких товаров → добавляется номер товара
DROP TABLE IF EXISTS sl_seo_taken;
CREATE TABLE sl_seo_taken AS
SELECT n.product_id FROM sl_seo_new n
WHERE n.keyword IS NOT NULL
  AND (EXISTS (SELECT 1 FROM oc_url_alias ua WHERE LOWER(ua.keyword) = n.keyword)
       OR (SELECT COUNT(*) FROM (SELECT keyword FROM sl_seo_new) x WHERE x.keyword = n.keyword) > 1);
UPDATE sl_seo_new n JOIN sl_seo_taken t ON t.product_id = n.product_id
SET n.keyword = CONCAT(LEFT(n.keyword, 70), '-', n.product_id);
DROP TABLE sl_seo_taken;

-- Пустые записи ЧПУ этих товаров (если были) убираются, новые записываются
DELETE ua FROM oc_url_alias ua JOIN sl_seo_new n ON ua.query = CONCAT('product_id=', n.product_id)
WHERE n.keyword IS NOT NULL;
INSERT INTO oc_url_alias (query, keyword)
SELECT CONCAT('product_id=', product_id), keyword FROM sl_seo_new WHERE keyword IS NOT NULL;

-- Что сделано. Внизу — товары, для которых адрес сделать не удалось: их ЧПУ нужно вписать вручную
SELECT product_id AS `ID`, name AS `Товар`, IFNULL(keyword, '— не сделано —') AS `Новый ЧПУ`
FROM sl_seo_new ORDER BY keyword IS NULL, name;
