select case when pid = pg_backend_pid() then -pid else pid end pid, datname, usename, application_name, client_addr, /*to_char(backend_start,'HH24:MI:SS')*/ backend_start, /*xact_start,*/ age(xact_start, backend_start) as age, state, query from pg_stat_activity
order by backend_start;
