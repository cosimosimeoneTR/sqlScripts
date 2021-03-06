\prompt 'Schama name? ' schName
SELECT
    pg_size_pretty(
        SUM( pg_total_relation_size( quote_ident( schemaname )|| '.' || quote_ident( tablename )))::BIGINT
    ) AS schemaSize
FROM
    pg_tables
WHERE
    schemaname =:'schName';