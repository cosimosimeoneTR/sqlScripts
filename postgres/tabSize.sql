\prompt 'Table name ? ' tabName
SELECT schemaname, tablename, tableSize FROM (
  SELECT
      schemaname,
      tablename,
      pg_size_pretty(
          SUM( pg_total_relation_size( quote_ident( schemaname )|| '.' || quote_ident( tablename )))::BIGINT
      ) AS tableSize
      ,SUM( pg_total_relation_size( quote_ident( schemaname )|| '.' || quote_ident( tablename )))::BIGINT as tableSizeRow
  FROM
      pg_tables
  WHERE
      LOWER( tablename ) LIKE LOWER( '%' ||:'tabName' || '%' )
  GROUP BY schemaname, tablename
) X
ORDER BY tableSizeRow;