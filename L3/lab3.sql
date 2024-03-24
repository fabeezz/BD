select e.*, d.*
from employees e, departments d;

select *
from employees
where department_id is NULL;

select e.*, d.*
from employees e join departments d on e.department_id = d.department_id;

-- doua metode pentru join

select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e join departments d on (e.department_id = d.department_id);

select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e, departments d
where e.department_id = d.department_id;


select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e, departments d
where e.department_id(+)= d.department_id; --122

select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e, departments d
where e.department_id= d.department_id(+); --107

select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e right outer join departments d on (e.department_id = d.department_id); --122

select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e left outer join departments d on (e.department_id = d.department_id); --107

select e.last_name || ' ' ||  e.first_name, d.department_name, e.department_id
from employees e full outer join departments d on (e.department_id = d.department_id); --123

--v1

--v2
select e.first_name, e.salary, j.job_title, l.city, c.country_name
from (((employees e join jobs j on e.job_id = j.job_id) 
    join departments d on e.department_id = d.department_id) 
    join locations l on d.location_id = l.location_id)
    join countries c on l.country_id = c.country_id
where e.manager_id = 100;

select e.first_name, e.salary, j.job_title, l.city, c.country_name
from employees e join jobs j using (job_id)
    join departments d using (department_id) 
    join locations l using (location_id)
    join countries c using (country_id)
where e.manager_id = 100;

select j.job_title, e.salary, j.max_salary
from jobs j join employees e on (j.max_salary<e.salary)
where e.employee_id=100;

select salary
from employees
where employee_id = 100;

select *
from jobs
where max_salary<(select salary from employees where employee_id = 100);

select e.first_name, e.hire_date
from employees e
where e.hire_date >(
    select e2.hire_date
    from employees e2
    where initcap(e2.last_name) = 'Gates'
);


select e2.employee_id, e2.last_name
from employees e2
where e2.department_id in (
    select e.department_id
    from employees e
    where lower(e.last_name) like '%t%'
);





--ex
describe employees;
select e.employee_id, d.department_id, l.location_id, c.country_name
from employees e join jobs j on j.job_id = e.job_id 
right outer join departments d on e.department_id = d.department_id
right outer join locations l on d.location_id = l.location_id
right outer join countries c on l.country_id = c.country_id; --149

select l.city, d.department_name dep
from locations l, departments d
where l.location_id(+) = d.location_id
order by dep desc; --27


--se cer codul depart al caror nume contin "re" sau in care lucreaza angajatii avand codul job-ului "SA_REP"
select department_id
from departments
where lower(department_name) like '%re%'
UNION
select department_id
from employees
where upper(job_id) = 'SA_REP'
and department_id is not NULL;

--sa se obt codurile depart in care nu lucreaza nimeni
select department_id
from departments
minus
select department_id
from employees;

select last_name, salary, department_id
from employees
where department_id in (
select department_id
from employees
where last_name = 'King'
) and last_name != 'King';