set verify off
--set pages 32000
col sql_text for A132
select
	a.sql_text
from
	 v$sqltext a
	,v$session b
where
	    b.sid='&1'
	and a.address=b.sql_address
	and a.hash_value=b.sql_hash_value
	and (instr(UPPER(a.sql_text),' INTO ') > 0 or instr(UPPER(a.sql_text),' FROM ') > 0 or instr(UPPER(a.sql_text),'DELETE ') > 0 or instr(UPPER(a.sql_text),'UPDATE ') > 0)
order by
	    a.piece
/