\prompt 'Table name ? ' tabName
SELECT pg_size_pretty(SUM(pg_total_relation_size(quote_ident(schemaname) || '.' || quote_ident(tablename)))::BIGINT) as tableSize FROM pg_tables WHERE lower(tablename) LIKE lower('%'||:'tabName'||'%');