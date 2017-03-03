break on Username skip 1
select   substr(SID,1,4) SID,
         substr(decode(osuser,'16006414','--- IO ---',osuser),1,13) Username,
         substr(username,1,13) DB_User,
         substr(module,1,30) WHAT,
         to_char(logon_time, 'dd/mm hh24:mi:ss') logon_time,
         process,
         Machine AT
         ,'§' X
from v$session
where schemaname <> 'SYS'
order by nvl(Username, ' '),
         --AT,
         logon_time,
         sid
/
