col "name" for a55
col "Tablespace" for a15
col "Status" for a10
col "Size (M)" for 9G999G999G999
col "Used (M)" for 9G999G999G999
SELECT d.file_name "Name",
         d.tablespace_name "Tablespace",
         v.status "Status",
         TO_CHAR((d.bytes / 1024 / 1024), '99999990.000') "Size (M)",
         NVL(TO_CHAR(((d.bytes - SUM(s.bytes)) / 1024 / 1024), '99999990.000'),
            TO_CHAR((d.bytes / 1024 / 1024), '99999990.000')) "Used (M)"
FROM sys.dba_data_files d,
     sys.dba_free_space s,
     sys.v_$datafile v
WHERE (s.file_id (+)= d.file_id)
      AND (d.file_name = v.name)
      and upper(d.tablespace_name) like upper('%&Tablespace_name%')
   GROUP BY d.file_name, d.tablespace_name, v.status, d.bytes
/
