column owner format a10
column tablespace_name format a20
column segment_name format a30
column owner format a20
column partition_name format a16
column Mbytes format 9,999,999,999
select /*+ parallel (a,4) */
   owner
   ,tablespace_name
   ,segment_name
   ,sum(bytes)/1048576 Mbytes
   ,'§' X
   from  dba_segments a
where upper(tablespace_name) like upper('%&tablespace%')
 and upper(segment_name) like upper('%&tablename%')
 and nvl(upper(partition_name),'%%') like upper('%&partitionname%')
 and upper(owner) like upper('%&owner%')
 and bytes/1048576 > 1
group by owner
   ,tablespace_name
   ,segment_name
order by owner
   ,segment_name
   ,tablespace_name
/
