col COMANDO for A20
col AVANZ for 9,999,999,999
col sid for 999
col osuser for A10
col program for a20
col module for a25
col schemaname for a10
col exec_time for A15
col status for A9
col at for A29
Select
    a.sid
   ,a.status
   ,a.schemaname
   ,a.program
   ,a.module
   ,qualecomando(a.command) COMANDO
   ,diffdate(a.logon_time,sysdate) EXEC_TIME
   ,'§' X
From v$session a
      ,v$sess_io b
Where a.schemaname <> 'SYS'
   and a.sid = b.sid
   and module like 'MONITOR%'
Order by nvl(program,' '),module
/