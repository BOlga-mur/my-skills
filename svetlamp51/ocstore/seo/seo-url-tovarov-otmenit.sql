-- СветЛамп: отменить seo-url-tovarov-zapolnit.sql или seo-url-tovarov-vse.sql.
-- Убирает записанные скриптом ЧПУ; если запускался вариант «все», возвращает старые адреса.
-- Если префикс таблиц не oc_, замените oc_ на свой.
-- После запуска удалите в папке system/storage/cache файлы cache.seo_pro*.

DELETE ua FROM oc_url_alias ua JOIN sl_seo_new n ON ua.query = CONCAT('product_id=', n.product_id) AND ua.keyword = n.keyword;

-- Только после варианта «все»: вернуть старые адреса (таблица sl_seo_old есть только тогда)
CREATE TABLE IF NOT EXISTS sl_seo_old LIKE oc_url_alias;
INSERT INTO oc_url_alias (query, keyword)
SELECT o.query, o.keyword FROM sl_seo_old o
WHERE NOT EXISTS (SELECT 1 FROM oc_url_alias ua WHERE ua.query = o.query);

DROP TABLE sl_seo_new;
DROP TABLE sl_seo_old;
