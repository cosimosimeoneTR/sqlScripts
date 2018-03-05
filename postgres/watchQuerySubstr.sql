\prompt 'Sleep in seconds? ' seconds
\prompt 'Substring to search? ' psubstring
select pid, client_addr, substr(application_name,1,25) application_name, /*to_char(now(),'Dy HH24:MI:SS') now,*/ to_char(xact_start,'HH24:MI:SS') xact_start, age(now(), xact_start) as running_since, state, regexp_replace(substr(query,1,100), E'[\\n\\r]+', '\\n', 'g' )   query from pg_stat_activity where pid <> pg_backend_pid() and lower(query) like '%'||lower(:'psubstring')||'%' order by backend_start; \watch :seconds
