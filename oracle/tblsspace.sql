col TablespaceName for A20
col TableName for A40
col mb for 9,999,999,999
--set pages 1000
select tablespace_name  TablespaceName
      ,segment_name     TableName
      ,sum(bytes)/1024/1024 MB
      ,count(*) extents
      ,'§' x
from user_extents
where upper(tablespace_name) like '%'||upper('&tablespace')||'%' and upper(segment_name) like '%'||upper('&table')||'%'
group by tablespace_name,segment_name,'§'
order by tablespace_name, MB
;