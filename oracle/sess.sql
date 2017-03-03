--set pages 500 lines 180
col COMANDO for A20
col LETTE for 999,999,999,999
col machine for A20
col osuser for A10
col program for a20
col exec_time for A15
col status for A9
select
	a.sid
	,a.serial#
	,a.process
	,qualecomando(a.command) COMANDO
   ,a.status
	,c.value LETTE
	,to_char(a.logon_time,'DD-MON-YYYY HH24:MI:SS') LOGON_TIME
	,diffdate(a.logon_time,sysdate) EXEC_TIME
	,decode(a.osuser,'16006414','--- IO ---',a.osuser) osuser
	,substr(a.program,1,10) program
	,'§' X
from
	v$session a, v$sesstat c, v$sesstat d
where
	    a.sid=c.sid
	and a.sid=d.sid
	and a.schemaname <> 'SYS'
	and c.statistic#=188
	and d.statistic#=44
	and a.sid not in (select sid from v$px_session)
	and a.status ='ACTIVE'
order by a.sid
/
