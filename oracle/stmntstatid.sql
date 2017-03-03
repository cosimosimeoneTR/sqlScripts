--set pages 500 lines 180
col sql_text for A15
col module for A25
select
   a.sid
   ,c.sql_text
   ,c.module
   ,c.sorts
   ,c.disk_reads
   ,c.buffer_gets
   ,c.rows_processed
   ,'§' X
from
   v$session a
   ,v$sqlarea c
where
   a.sql_hash_value=c.hash_value
   and a.sql_address=c.address
   and a.sid = '&1'
order by
   a.sid
/
