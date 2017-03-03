col object_name for A30
select	owner,
			object_id,
			object_name,
			object_type,
			v$lock.type
			,'§' X
from		dba_objects,
			v$lock
where		object_id=v$lock.id1
  and		owner not in ('SYS','SYSTEM')
/
