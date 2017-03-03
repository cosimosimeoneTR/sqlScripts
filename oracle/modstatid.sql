--set pages 500 lines 180
col sql_text for A20
col module for A25
col username for A10
select
   a.username
   ,c.module
   ,sum(c.sorts) sorts
   ,sum(c.disk_reads) disk_reads
   ,sum(c.buffer_gets) buffer_gets
   ,sum(c.rows_processed) rows_processed
   ,sum( sorts+disk_reads+buffer_gets+rows_processed ) isalive
   ,'§' X
from
   v$session a
   ,v$sqlarea c
where
   a.sql_hash_value=c.hash_value
   and a.sql_address=c.address
   and a.sid is not null
   and c.module is not null
   and a.sid = '&1'
group by c.module,a.username
order by
   c.module
/
