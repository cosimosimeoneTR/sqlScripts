\prompt 'pid to show? ' pid
select pid, datname, usename, application_name, backend_start, client_addr, xact_start, state, query from pg_stat_activity  where pid = :pid;