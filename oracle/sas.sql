break on tablespace skip 1 on qcsid skip 1
compute sum label QCSID of BLOCKS on qcsid
compute sum label QCSID of MEGA on qcsid
compute sum label TABLESPACE of BLOCKS on TABLESPACE
compute sum label TABLESPACE of MEGA on TABLESPACE
select   a.sid
         ,b.tablespace
         ,b.blocks
         ,((b.blocks * 32)/1024) MEGA
from     v$session a
         ,v$sort_usage b
where    a.saddr=b.session_addr
and      a.sid not in (select sid from v$px_session)
order    by a.sid
/
