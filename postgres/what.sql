-- ALTER SYSTEM SET track_activity_query_size = 16384;
\prompt 'pid to show? ' pid
SELECT
    state,
    query
FROM
    pg_stat_activity
WHERE
    pid =:pid;
