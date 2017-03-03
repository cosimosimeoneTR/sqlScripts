col object_name for A30
col owner for A12
col obj_type for A22
col lck_type for A22
select	sid,
         owner,
			object_id,
			object_name,
			object_type obj_type,
			v$lock.type lck_type,
			decode(v$lock.type,'TM','DML enqueue'
			                  ,'TX','Transaction enqueue'
			                  ,'UL','User supplied'
			                  ,'???')
from		dba_objects,
			v$lock
where		object_id=v$lock.id1
  and		owner not in ('SYS','SYSTEM')
/
