SELECT
    CASE
        WHEN pid = pg_backend_pid() THEN - pid
        ELSE pid
    END pid,
    datname,
    usename,
    application_name,
    client_addr,
    /*to_char(backend_start,'HH24:MI:SS')*/
    backend_start,
    /*xact_start,*/
    age(now(), xact_start) AS running_since,
    state,
    query
FROM
    pg_stat_activity
ORDER BY
    backend_start;
