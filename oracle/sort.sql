break on qcsid skip 1
compute sum label Totale of MEMORY on qcsid
compute sum label Totale of DISK on qcsid
compute sum label Totale of ROWS on qcsid
col COMANDO for A15
col MEMORY for 9,999,999,999
col DISK for 9,999,999,999
col "ROWS" for 9,999,999,999
col qcsid for 9999
select	a.qcsid,
			a.sid,
			b.serial#,
			b.process,
			qualecomando(b.command) COMANDO,
			sum(c.value) MEMORY,
			sum(d.value) DISK,
			sum(e.value) "ROWS"
from		v$px_session a,
			v$session b,
			v$sesstat c,
			v$sesstat d,
			v$sesstat e
where		a.sid=b.sid
and		b.sid=c.sid
and		c.sid=d.sid
and		d.sid=e.sid
and		b.schemaname <> 'SYS'
and		c.statistic#=180
and		d.statistic#=181
and		e.statistic#=182
group by	a.sid, b.serial#, b.process, a.qcsid, qualecomando(b.command)
order		by a.qcsid,a.sid
/
