SELECT * from public.dept;

SELECT coalesce(dname,'') || '-' || coalesce(loc,'') AS dep FROM Dept;

SELECT column_name FROM information_schema.columns WHERE table_name='emp' AND is_nullable='YES';
