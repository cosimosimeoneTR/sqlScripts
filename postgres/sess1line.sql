select case when pid = pg_backend_pid() then -pid else pid end pid, datname as db, usename, application_name, client_addr, to_char(backend_start,'HH24:MI:SS') backend_start, /*to_char(xact_start,'HH24:MI:SS') xact_start, */ age(xact_start, backend_start) as age, state, regexp_replace(substr(query,1,120), E'[\\n\\r]+', '\\n', 'g' ) as query from pg_stat_activity
order by backend_start;
