--set pagesize 500 lines 500
col COMANDO for A20
col AVANZ for 9,999,999,999
col sid for 999
col spid for A7
col osuser for A9
col program for a20
col module for a20
col schemaname for a9
col exec_time for A15
col status for A9
col at for A23
break on osuser skip 1
Select
    a.sid
   ,c.spid
   ,a.status
   ,a.schemaname
   ,decode(a.osuser,'16006414','--- IO ---',a.osuser) osuser
   ,a.program
   ,a.module
   --,qualecomando(a.command) COMANDO
   ,to_char(a.logon_time,'DD-MM HH24:MI:SS') LOGON_TIME
   ,a.Machine AT
From v$session a
      ,v$sess_io b
      ,v$process c
Where a.schemaname <> 'SYS'
   and a.sid = b.sid
   and a.paddr  = c.addr
Order by nvl(schemaname,' '), nvl(osuser,' '), sid
/
