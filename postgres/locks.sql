SELECT
    locktype,
    relation::regclass,
    mode,
    transactionid AS tid,
    virtualtransaction AS vtid,
    pid,
    GRANTED
FROM
    pg_catalog.pg_locks l
LEFT JOIN pg_catalog.pg_database db ON
    db.oid = l.database
WHERE
    NOT pid = pg_backend_pid();
