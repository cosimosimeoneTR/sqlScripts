set echo off
col QCSID for a5
col SID for 9999
col COMANDO for A8
col module for A17
col LETTE for 999G999G999G999
col SCRITTE for 999G999G999
col PHIS_LETTE for 999G999G999G999
col PHIS_SCRITTE for 999G999G999
col Block_Chang for 999G999G999
col RATE for 9G999G999
col EXEC_TIME for A15
break on QCSID skip 1
compute sum label TOTALE of LETTE on QCSID
compute sum label TOTALE of SCRITTE on QCSID
compute sum label TOTALE of PHIS_LETTE on QCSID
compute sum label TOTALE of PHIS_SCRITTE on QCSID

select
        nvl(to_char(a.qcsid),'SER') qcsid
        ,b.sid
        ,qualecomando(b.command) COMANDO
        ,b.module
        ,f.value LETTE
        ,g.value SCRITTE
        ,c.value PHIS_LETTE
        ,d.value PHIS_SCRITTE
        ,to_char(b.logon_time,'HH24:MI:SS') LOGON
        ,diffdate(b.logon_time,sysdate) EXEC_TIME
        ,'§' x
from
        v$px_session a
        ,v$session b
        ,v$sesstat c
        ,v$sesstat d
        ,v$sesstat f
        ,v$sesstat g
where
        a.sid(+)=b.sid
        and b.sid=c.sid
        and c.sid=d.sid
        and d.sid=f.sid
        and f.sid=g.sid
        and b.schemaname <> 'SYS'
        and c.statistic#=42
        and d.statistic#=46
        and f.statistic#=40
        and g.statistic#=43
        and b.status ='ACTIVE'
order by
        a.qcsid
        ,decode(a.sid,qcsid,0,a.sid)
/
set echo on