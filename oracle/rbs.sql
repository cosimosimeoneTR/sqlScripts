SET echo OFF
SET termout ON
SET heading ON
--SET PAGESIZE   60
--SET LINESIZE   126

COLUMN pgm_notes    FORMAT a80        HEADING 'Notes'
COLUMN rbs          FORMAT a10        HEADING 'RBS'             JUST center
COLUMN oracle_user  FORMAT a12        HEADING 'Oracle|Username'
COLUMN sid_serial   FORMAT a12        HEADING 'SID , Serial'
COLUMN module        FORMAT a25        HEADING 'What'
COLUMN unix_pid     FORMAT a10        HEADING 'O/S|PID'
COLUMN Client_User  FORMAT a20        HEADING 'Client|Username'
COLUMN Unix_user    FORMAT a12        HEADING 'O/S|Username'
COLUMN login_time   FORMAT a17        HEADING 'Login Time'
COLUMN last_txn     FORMAT a17        HEADING 'Last Active'
COLUMN undo_b      FORMAT 99,999,999,999 HEADING 'Undo MB'
 SELECT r.name                   rbs,
        nvl(s.username, 'None')  oracle_user,
        p.username               unix_user,
        to_char(s.sid)||' , '||to_char(s.serial#) as sid_serial,
        s.module                 module,
        p.spid                   unix_pid,
        t.used_ublk * TO_NUMBER(x.value)/(1024*1024)  as undo_b,
        '§' X
   FROM v$process     p,
        v$rollname    r,
        v$session     s,
        v$transaction t,
        v$parameter   x
  WHERE s.taddr = t.addr
    AND s.paddr = p.addr(+)
    AND r.usn   = t.xidusn(+)
    AND x.name  = 'db_block_size'
  ORDER
     BY r.name
/
SET echo On