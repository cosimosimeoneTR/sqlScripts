-- ALTER SYSTEM SET track_activity_query_size = 16384;
\prompt 'pid show? ' pid
select state, query from pg_stat_activity where pid = :pid;
