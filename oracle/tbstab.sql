column segment_name format a30
column Mbytes format 9,999,999,999,999
break on X skip 1
compute sum label TOT of Mbytes on X
select
   distinct segment_name
   ,sum(nvl(bytes,0)/1048576) Mbytes
   ,'§' X
   from  dba_segments a
where upper(tablespace_name) = upper('&tablespace')
having sum(nvl(bytes,0)/1048576) >= 100
group by segment_name
order by segment_name
/
