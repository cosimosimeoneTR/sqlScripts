\prompt 'Table name to search? ' tabName
select * from information_schema.tables where lower(table_name) LIKE lower('%'||:'tabName'||'%')
and table_schema not in ('pg_catalog', 'information_schema')
;