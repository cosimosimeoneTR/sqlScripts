set echo off
--set pages 500 lines 180
col QCSID for 9999
col SID for 9999
col COMANDO for A7
col AVANZAMENTO for 9,999,999,999
col MB for 999,999,999
col osuser for a18
col EXEC_TIME for A11
col schemaname for A8
break on QCSID skip 2
compute sum label TOT of AVANZAMENTO on QCSID
compute count label CNT of SID on QCSID
select
   a.qcsid
	,a.sid
	,decode(b.osuser,'16006414','--- IO ---',b.osuser) osuser
	,qualecomando(b.command) COMANDO
	,substr(module,1,25) MODULE
	,(h.block_gets+h.physical_reads+h.block_changes+h.consistent_changes) AVANZAMENTO
	,to_char(b.logon_time,'DD-MM HH24:MI') LOGON_TIME
	,diffdate(b.logon_time,sysdate) EXEC_TIME
	,b.schemaname
	,'§' X
from
	v$px_session a
	,v$session b
	,v$sesstat c
	,v$sesstat d
	,v$sesstat f
	,v$sesstat g
	,v$sess_io h
where
	    a.sid=b.sid
	and a.sid=c.sid
	and a.sid=d.sid
	and a.sid=f.sid
	and a.sid=g.sid
	and a.sid=h.sid
	and c.statistic#=188
	and d.statistic#=190
	and f.statistic#=40
	and g.statistic#=189
order by
	a.qcsid
	,decode(a.sid,qcsid,0,a.sid)
/
set echo on