set echo off
column owner format a10
column dummy noprint
column segment_name format a30
column Extent format 9,999,999
column Mbytes format 9,999,999,999,999
break on dummy skip 1
compute sum label x of Mbytes on dummy
select null dummy
      ,owner
      ,segment_name
      ,SUM(extents) Extent
      ,sum(nvl(bytes,0)/1048576) Mbytes
   from  dba_segments
where UPPER(segment_name) like  upper('%&table%')
group by segment_name,owner
order by Mbytes, segment_name
/
set echo on
