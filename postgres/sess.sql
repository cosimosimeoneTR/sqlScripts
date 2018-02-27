select case when pid = pg_backend_pid() then -pid else pid end pid, datname, usename, application_name, backend_start, client_addr, xact_start, state, query from pg_stat_activity;
