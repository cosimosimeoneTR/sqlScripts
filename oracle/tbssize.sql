set echo off
set pause off
--set pagesize 500 lines 500
column tsname format a16
column REPORT noprint
column sumb format 9,999,999
column TOT format 9,999,999,999
column extents format 9999
column bytes format 9,999,999
column largest format 9,999,999
column Tot_Size_MB format 9,999,999
column Tot_Free_MB format 9,999,999
column Max_Free_MB format 9,999,999
column "%FULL" format 999.9
break on report
compute sum label TOT of Tot_Size_MB on report
compute sum label TOT of Tot_Free_MB on report

set echo off

select NULL report, a.tablespace_name tsname,
sum(a.tots)/(1024*1024) Tot_Size_MB,
sum(a.sumb)/(1024*1024) Tot_Free_MB,
100-sum(a.sumb)*100/sum(a.tots) "%FULL"
from
(
   select tablespace_name,0 tots,sum(bytes) sumb,max(bytes) largest
   from dba_free_space a
   group by tablespace_name
   union
   select tablespace_name,sum(bytes) tots,0,0
   from dba_data_files
   group by tablespace_name
   union
   select tablespace_name,sum(BYTES_USED+BYTES_FREE) tots,sum(BYTES_FREE) sumb,max(BYTES_FREE) largest
   from V$TEMP_SPACE_HEADER
   group by tablespace_name) a
where a.tablespace_name not like 'TI%'
and a.tablespace_name not like 'TO%'
and a.tablespace_name not like 'SYSTEM%'
and a.tablespace_name not like '%TEMP%'
group by A.tablespace_name
    UNION ALL
SELECT NULL report, A.tablespace_name tsname
      ,ROUND(SUM(NVL(p.bytes_used, 0))/1048576 + SUM((A.bytes_free + A.bytes_used) - NVL(p.bytes_used, 0)) / 1048576, 2) Tot_Size_MB
      ,ROUND(SUM((A.bytes_free + A.bytes_used) - NVL(p.bytes_used, 0)) / 1048576, 2) Tot_Free_MB
      ,100-ROUND(SUM((A.bytes_free + A.bytes_used) - NVL(p.bytes_used, 0)) / 1048576, 2) / ROUND(SUM(NVL(p.bytes_used, 0))/1048576 + SUM((A.bytes_free + A.bytes_used) - NVL(p.bytes_used, 0)) / 1048576, 2)  * 100 "%FULL"
 FROM sys.V_$TEMP_SPACE_HEADER A, sys.V_$TEMP_EXTENT_POOL p
 WHERE p.file_id(+) = A.file_id AND p.tablespace_name(+) = A.tablespace_name
 AND A.tablespace_name LIKE '%TEMP%'
group by A.tablespace_name;

set echo on
