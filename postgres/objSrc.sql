\prompt 'Object name to search? ' objName
select relowner, relname, relkind from pg_class where lower(relname) LIKE lower('%'||:'objName'||'%');