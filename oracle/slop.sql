set echo off
col opname for A15
col message for A50
col units for A10
col Who for A30
col "%" for 999.99
col totalwork for 999G999
col sofar for 999G999
col QCSID for 999
col sid for 9999
break on QCSID skip 1
select
	a.qcsid
	,a.sid
	,decode(c.osuser,'16006414','--- IO ---',c.osuser)||' '||c.username||' '||c.module Who
	--,a.opname
	,((a.sofar * 100) / a.totalwork) "%"
	,to_char(a.start_time,'DD/mm HH24:MI:SS') START_TIME
	,to_char(to_date('19700101','YYYYmmdd') +
       ( a.time_remaining / (60 * 60 * 24) ),'HH24:MI:SS') Time_Remaining
   --,substr(message,instr(message,':')+3) Object_name
   ,message
from
	v$session_longops a
	,(select sid, max(start_time) start_time from v$session_longops group by sid) b
	,v$session c
where
	a.sid = b.sid
	and a.sid = c.sid
	and a.serial# = c.serial#
	and a.start_time = b.start_time
	and (sofar/totalwork)*100 < 100
order by a.qcsid,Time_Remaining desc
/
set echo on
