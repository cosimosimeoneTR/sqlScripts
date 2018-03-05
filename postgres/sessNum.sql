\prompt 'pid to show? ' pid
SELECT
    pid,
    datname,
    usename,
    application_name,
    client_addr,
    to_char(backend_start,'HH24:MI:SS') backend_start,
    /*to_char(xact_start,'HH24:MI:SS') xact_start, */
    age(now(), xact_start) AS running_since,
    state,
    query
FROM
    pg_stat_activity
WHERE
    pid =:pid;