--pas 0
select department_id, avg(salary)
from employees
group by department_id;

--pas 1
select max(avg(salary))
from employees
group by department_id;

--pas 2
select department_id
from employees
group by department_id
having avg(salary) = (select max(avg(salary))
                    from employees
                    group by department_id);

--pas3
select d.department_name, min(e.salary)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_name
    having avg(e.salary) = (select max(avg(salary))
                        from employees
                        group by department_id);
                  
                  --un with      
with aux as 
    (select d.department_name, min(e.salary), round(avg(e.salary)) media
    from employees e, departments d
    where e.department_id = d.department_id
    group by d.department_name)
select max(media) maxim
from aux;

                --2 with uri
with aux as 
    (select d.department_name, min(e.salary), round(avg(e.salary)) media, min(salary)
    from employees e, departments d
    where e.department_id = d.department_id
    group by d.department_name),
tab_maxim as (
    select max(media) col_maxim
    from aux)
select *
from aux
where media = (select col_maxim from tab_maxim);


-- 
select *
from employees
where department_id in (
                        select d.department_id
                        from employees e, departments d
                        where e.department_id = d.department_id
                        group by d.department_id
                        having avg(e.salary) = (select max(avg(salary))
                        from employees
                        group by department_id));
        --EX3 (MAI SUS)
                        
--EX4
--a
select d.department_id, d.department_name, count(e.employee_id)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id, d.department_name
having count(e.employee_id) < 4;

--b
select d.department_id, d.department_name, count(e.employee_id) nr_ang
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id, d.department_name
having count(e.employee_id) = (select max(count(*)) numar_maxim
                                from employees
                                group by department_id);
                                
--DECODE
--12
select job_id, nvl(sum(decode(department_id, 30, salary)), 0) Dep30,
nvl(sum(decode(department_id, 50, salary)), 0) Dep50,
nvl(sum(decode(department_id, 80, salary)), 0) Dep80,
nvl(sum(salary),0) Total
from employees
group by job_id
order by 1;

--13
select count(*) total, job_id,
sum(decode(to_char(hire_date, 'yyyy'), 1997, 1, 0)) "AN 1997",
sum(decode(to_char(hire_date, 'yyyy'), 1998, 1, 0)) "AN 1998",
sum(decode(to_char(hire_date, 'yyyy'), 1999, 1, 0)) "AN 1999",
sum(decode(to_char(hire_date, 'yyyy'), 2000, 1, 0)) "AN 2000"
from employees
group by job_id;

--14

                                
