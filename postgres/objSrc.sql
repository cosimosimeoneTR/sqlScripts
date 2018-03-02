\prompt 'Object name to search? ' objName 
SELECT
    relowner,
    relname,
    relkind
FROM
    pg_class
WHERE
    LOWER( relname ) LIKE LOWER( '%' ||:'objName' || '%' );