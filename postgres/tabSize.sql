\prompt 'Table name ? ' tabName
SELECT
    pg_size_pretty(
        SUM( pg_total_relation_size( quote_ident( schemaname )|| '.' || quote_ident( tablename )))::BIGINT
    ) AS tableSize
FROM
    pg_tables
WHERE
    LOWER( tablename ) LIKE LOWER( '%' ||:'tabName' || '%' );