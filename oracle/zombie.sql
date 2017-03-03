--set pagesize 500 lines 500
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
   ,a.osuser
   ,a.program
   ,a.module
   ,to_char(sysdate -
       ( a.LAST_CALL_ET / (60 * 60 * 24) ),'DD-MON HH24:MI:SS') Last_Call
   ,a.Machine AT
   ,'§' X
From v$session a
      ,v$sess_io b
Where a.schemaname <> 'SYS'
   and a.sid = b.sid
   and a.logon_time < sysdate - 2
   and status != 'ACTIVE'
Order by nvl(osuser,' '), nvl(module,' '), nvl(program,' ')
/
