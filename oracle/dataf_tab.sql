col TableName for a25
col DataFile for a55
select
   /* parallel (a,4) (b,4) */
   distinct a.segment_name TableName
            ,b.file_name   DataFile
from 	DBA_EXTENTS       a,
	   DBA_DATA_FILES    b
where a.FILE_ID = b.FILE_ID
 and  a.RELATIVE_FNO = b.RELATIVE_FNO
 and  a.segment_name = '&table_name'
;