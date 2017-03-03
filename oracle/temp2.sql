break on tablespace skip 1 on qcsid skip 1
column MEGA format 9,999,999,999
column blocks format 9,999,999,999
column qcsid format 99999
column module format a25
column osuser format a13
compute sum label QCSID of BLOCKS on qcsid
compute sum label QCSID of MEGA on qcsid
compute sum label TABLESPACE of BLOCKS on TABLESPACE
compute sum label TABLESPACE of MEGA on TABLESPACE
select   null qcsid
         ,a.sid
         ,a.module
         ,decode(a.osuser,'16006414','--- IO ---',a.osuser) osuser
         ,b.tablespace
         ,((b.blocks * 32)/1024) MEGA
from     v$session a
         ,v$sort_usage b
where    a.saddr=b.session_addr
and      a.sid not in (select sid from v$px_session)
union all
select   a.qcsid
         ,a.sid
         ,c.module
         ,decode(c.osuser,'16006414','--- IO ---',c.osuser) osuser
         ,b.tablespace
         ,((b.blocks * 32)/1024) MEGA
from     v$px_session a
         ,v$sort_usage b
         ,v$session c
where    a.saddr=b.session_addr
and a.sid=c.sid
order    by qcsid,sid
;