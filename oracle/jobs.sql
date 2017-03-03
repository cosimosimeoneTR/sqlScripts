col log_user for a13
col what for a30
select job
   , log_user
   , broken
   , what
   , to_char(this_date, 'dd/mm hh24:mi:ss') this_date
   --, to_char(last_date, 'dd/mm hh24:mi:ss') last_date
   , to_char(next_date, 'dd/mm hh24:mi:ss') next_date
from user_jobs
order by this_date, next_date desc, job
;