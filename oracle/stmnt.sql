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
order by
	    a.piece
/