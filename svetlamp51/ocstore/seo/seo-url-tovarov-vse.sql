-- СветЛамп: ЧПУ (SEO URL) ВСЕХ товаров заново, из названия товара.
-- ВНИМАНИЕ: у товаров, у которых ЧПУ уже был, адрес ПОМЕНЯЕТСЯ. Старые адреса, которые знают
-- Яндекс и Google и на которые могут вести ссылки, начнут открывать «Страница не найдена»,
-- пока поисковики не переобойдут сайт (обычно несколько недель), и позиции могут временно просесть.
-- Если нужно только дозаполнить пустые ЧПУ — используйте seo-url-tovarov-zapolnit.sql.
-- Правила: транслитерация латиницей, строчные буквы, цифры и дефисы, не длиннее 80 знаков;
-- занятый адрес получает в конце номер товара.
-- Отмена — seo-url-tovarov-otmenit.sql (вернёт и старые адреса). Работает в MySQL 5.7 и новее.
-- Если префикс таблиц не oc_, замените oc_ на свой во всём файле.
-- После запуска удалите в папке system/storage/cache файлы, имя которых начинается на cache.seo_pro.

-- Копия всех старых ЧПУ товаров для отмены
DROP TABLE IF EXISTS sl_seo_old;
CREATE TABLE sl_seo_old AS SELECT * FROM oc_url_alias WHERE query LIKE 'product_id=%';

DROP TABLE IF EXISTS sl_seo_new;
CREATE TABLE sl_seo_new (product_id INT NOT NULL PRIMARY KEY, name VARCHAR(255), keyword VARCHAR(255)) DEFAULT CHARSET=utf8;

INSERT INTO sl_seo_new (product_id, name)
SELECT p.product_id, pd.name
FROM oc_product p
JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = 1;

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

-- Занятые адреса: у категорий/статей или совпали у нескольких товаров → добавляется номер товара
DROP TABLE IF EXISTS sl_seo_taken;
CREATE TABLE sl_seo_taken AS
SELECT n.product_id FROM sl_seo_new n
WHERE n.keyword IS NOT NULL
  AND (EXISTS (SELECT 1 FROM oc_url_alias ua WHERE LOWER(ua.keyword) = n.keyword AND ua.query NOT LIKE 'product_id=%')
       OR (SELECT COUNT(*) FROM (SELECT keyword FROM sl_seo_new) x WHERE x.keyword = n.keyword) > 1);
UPDATE sl_seo_new n JOIN sl_seo_taken t ON t.product_id = n.product_id
SET n.keyword = CONCAT(LEFT(n.keyword, 70), '-', n.product_id);
DROP TABLE sl_seo_taken;

-- Старые ЧПУ товаров заменяются новыми (у товаров, для которых новый адрес не получился, остаётся старый)
DELETE ua FROM oc_url_alias ua JOIN sl_seo_new n ON ua.query = CONCAT('product_id=', n.product_id)
WHERE n.keyword IS NOT NULL;
INSERT INTO oc_url_alias (query, keyword)
SELECT CONCAT('product_id=', product_id), keyword FROM sl_seo_new WHERE keyword IS NOT NULL;

-- Что было и что стало
SELECT n.product_id AS `ID`, n.name AS `Товар`,
       IFNULL((SELECT o.keyword FROM sl_seo_old o WHERE o.query = CONCAT('product_id=', n.product_id) LIMIT 1), '—') AS `Был ЧПУ`,
       IFNULL(n.keyword, '— не сделано, остался старый —') AS `Стал ЧПУ`
FROM sl_seo_new n ORDER BY n.keyword IS NULL, n.name;
