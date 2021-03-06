SELECT table_name
      ,table_schema
      ,MIN(MYpg_stat_file.creation) AS creation
      ,MIN(MYpg_stat_file.change) AS change
  FROM information_schema.tables
      ,pg_ls_dir('./base')
      ,pg_class
      ,pg_stat_file('./base/' || (pg_ls_dir) || '/' || (relfilenode), TRUE) MYpg_stat_file
 WHERE 1 = 1
       AND (table_type = 'BASE TABLE' AND table_schema not in ('pg_catalog','information_schema') )
       AND (pg_ls_dir <> 'pgsql_tmp' AND pg_ls_dir::INT <= (SELECT relfilenode FROM pg_class WHERE relname ILIKE table_name))
       AND (relname ILIKE table_name)
 GROUP BY table_name,table_schema
 ORDER BY table_schema,table_name
;
