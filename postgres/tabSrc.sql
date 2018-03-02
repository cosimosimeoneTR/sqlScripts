\prompt 'Table name to search? ' tabName
SELECT
    *
FROM
    information_schema.tables
WHERE
    LOWER( table_name ) LIKE LOWER( '%' ||:'tabName' || '%' )
    AND table_schema NOT IN(
        'pg_catalog',
        'information_schema'
    );