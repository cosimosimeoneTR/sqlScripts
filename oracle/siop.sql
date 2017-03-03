break on qcsid skip 1
compute sum label TOTALE of BG on qcsid
--compute sum label TOTALE of CG on qcsid
compute sum label TOTALE of PhysicalRead on qcsid
compute sum label TOTALE of BlocksGet on qcsid
compute sum label TOTALE of BlocksChanges on qcsid
compute sum label TOTALE of PWD on qcsid
compute sum label TOTALE of COMMIT on qcsid
col COMANDO for A12
col process for a9
select	a.qcsid,
			a.sid,
--			b.serial#,
--			b.process,
			qualecomando(b.command) COMANDO,
			sum(c.block_gets) BlocksGet,
			sum(c.physical_reads) PhysicalRead,
			sum(c.block_changes) BlocksChanges,
			sum(d.value) PWD,
			sum(e.value) COMMIT,
			'§' x
from		v$px_session a,
			v$session b,
			v$sess_io c,
			v$sesstat d,
			v$sesstat e
where		a.sid=b.sid
and		b.sid=c.sid
and		c.sid=d.sid
and		d.sid=e.sid
--and		b.schemaname <> 'SYS'
and 		d.statistic#=87
and 		e.statistic#=4
group by	a.sid,
--b.serial#, b.process,
a.qcsid, qualecomando(b.command),'§'
order		by a.qcsid,a.sid
/
