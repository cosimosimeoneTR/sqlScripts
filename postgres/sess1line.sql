select case when pid = pg_backend_pid() then -pid else pid end pid, datname as db, usename, application_name, client_addr, backend_start, xact_start, state, regexp_replace(substr(query,1,120), E'[\\n\\r]+', '\\n', 'g' ) as query from pg_stat_activity;
