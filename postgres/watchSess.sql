\prompt 'Sleep in seconds? ' seconds
select pid, client_addr, to_char(now(),'Dy HH24:MI:SS') now,substr(application_name,1,25) application_name, to_char(xact_start,'Dy HH24:MI:SS') xact_start, state, regexp_replace(substr(query,1,120), E'[\\n\\r]+', '\\n', 'g' )   query from pg_stat_activity where pid <> pg_backend_pid(); \watch :seconds
