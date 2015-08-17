select * from JOBS;
-- 3
select employee_id
        ,first_name
        ,last_name
        ,job_id
from EMPLOYEES 
where job_id like '%AD%';
--6
select employee_id
        ,first_name || ' ' || last_name  "nombre apellido"
        ,SALARY
from EMPLOYEES ;

--9
select department_id
        ,department_name
        ,city
from DEPARTMENTS, LOCATIONS
order by city desc;

-- 9
select department_id
        ,department_name
        ,city
from DEPARTMENTS d
inner join LOCATIONS l 
        on (d.LOCATION_ID=l.location_id)
order by city;


