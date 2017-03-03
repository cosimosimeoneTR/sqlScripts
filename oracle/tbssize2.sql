set pause off
set echo off
--set pagesize 500 lines 500
column tsname format a25
column REPORT noprint
column sumb format 9,999,999,999
column TOT format 9,999,999,999,999
column extents format 9999
column bytes format 9,999,999,999
column largest format 9,999,999,999
column Tot_Size_in_KB format 9,999,999,999
column Tot_Free_in_KB format 9,999,999,999
column Max_Free_in_KB format 9,999,999,999
column Pct_Used format 999
break on report
compute sum label TOT of Tot_Size_in_KB on report
compute sum label TOT of Tot_Free_in_KB on report

set echo off

select NULL report, a.tablespace_name tsname,
sum(a.largest)/1024 Max_Free_in_KB,
sum(a.tots)/1024 Tot_Size_in_KB,
sum(a.sumb)/1024 Tot_Free_in_KB,
100-sum(a.sumb)*100/sum(a.tots) Pct_Used
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
group by a.tablespace_name;

set echo on