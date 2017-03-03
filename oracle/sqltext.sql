set verify off
--set pages 48
col sql_text for A64
select a.sql_text from v$sqltext a, v$session b
where b.sid='&1' and a.address=b.sql_address and a.hash_value=b.sql_hash_value
order by a.piece
/
