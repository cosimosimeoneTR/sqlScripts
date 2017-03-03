--set pages 500 lines 180
col COMANDO for A20
col machine for A20
col osuser for A10
col module for A20
col exec_time for A10
select
	a.sid
	,a.process
	,a.serial#
	,qualecomando(a.command) COMANDO
	,module
	,a.machine
	,to_char(a.logon_time,'DD-MON HH24:MI:SS') LOGON_TIME
	,diffdate(a.logon_time,sysdate) EXEC_TIME
from
	v$session a
where a.schemaname <> 'SYS'
and a.sid not in (select sid from v$px_session)
order by a.osuser,LOGON_TIME
/
