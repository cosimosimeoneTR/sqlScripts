col sid for 9999
col serial# for 9999999
col qcsid for 9999
col opname for a15
col "%_complete" for 999.9999

select qcsid
      ,sid
      ,serial#
      ,opname
      ,to_char(start_time,'dd-mon-yyyy hh24:mi:ss') "Start Time"
      ,(sofar/totalwork)*100 "%_complete"
from v$session_longops
where (sofar/totalwork)*100 < 100
order by 5
/
