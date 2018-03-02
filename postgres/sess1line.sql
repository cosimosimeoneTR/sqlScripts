SELECT
    CASE
        WHEN pid = pg_backend_pid() THEN - pid
        ELSE pid
    END pid,
    datname AS db,
    usename,
    application_name,
    client_addr,
    to_char(backend_start,'HH24:MI:SS') backend_start,
    /*to_char(xact_start,'HH24:MI:SS') xact_start, */
    age(xact_start,backend_start) AS connected_since,
    state,
    regexp_replace(substr(query,1,120),E'[\\n\\r]+','\\n','g') AS query
FROM
    pg_stat_activity
ORDER BY
    backend_start;
