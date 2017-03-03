break on qcsid skip 1
compute sum label TOTALE of BG on qcsid
compute sum label TOTALE of CG on qcsid
compute sum label TOTALE of PR on qcsid
compute sum label TOTALE of BC on qcsid
compute sum label TOTALE of CC on qcsid
compute sum label TOTALE of PWD on qcsid
col COMANDO for A25
select	a.qcsid,
			a.sid,
			b.serial#,
			b.process,
			qualecomando(b.command) COMANDO,
			sum(c.block_gets) BG,
			sum(c.consistent_gets) CG,
			sum(c.physical_reads) PR,
			sum(c.block_changes) BC,
			sum(c.consistent_changes) CC,
			sum(d.value) PWD
from		v$px_session a,
			v$session b,
			v$sess_io c,
			v$sesstat d
where		a.sid=b.sid
and		b.sid=c.sid
and		c.sid=d.sid
and		b.schemaname <> 'SYS'
and 		d.statistic#=87
group by	a.sid, b.serial#, b.process, a.qcsid, qualecomando(b.command)
order		by a.qcsid,a.sid
/
