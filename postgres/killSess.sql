\prompt 'pid to kill? ' pid
\echo '(trying to) kill pid ':pid
SELECT pg_terminate_backend(:pid) FROM pg_stat_activity  WHERE  :pid <> pg_backend_pid() /*AND datname = 'database_name'*/ ;

