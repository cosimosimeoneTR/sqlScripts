--set pages 500 lines 180
col Module for A30
col LETTE for 999G999G999G999
col machine for A20
col osuser for A10
col program for a10
col exec_time for A15
select
	a.sid
	,a.serial#
	,a.process
	,Module
	,c.value LETTE
	,to_char(a.logon_time,'DD-MON-YYYY HH24:MI:SS') LOGON_TIME
	,diffdate(a.logon_time,sysdate) EXEC_TIME
	,decode(a.osuser,'16006414','--- IO ---',a.osuser) osuser
	,substr(a.program,1,10) program
from
	v$session a, v$sesstat c, v$sesstat d
where
	    a.sid=c.sid
	and a.sid=d.sid
	and a.schemaname <> 'SYS'
	and c.statistic#=188
	and d.statistic#=44
	and a.sid not in (select sid from v$px_session)
order by a.logon_time
/
