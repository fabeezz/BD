-- salariatii cu salariul maxim din fiecare departament
select last_name
from employees 
where (salary, department_id) in 
(
select max(salary), department_id
from employees
group by department_id
);

select last_name, department_id
from employees 
where (salary, department_id) in 
(
select min(salary), department_id
from employees
group by department_id
);

select count(employee_id), department_id
from employees
group by department_id;

--comision mediu
select avg(commission_pct)
from employees;

select sum(commission_pct)/count(*)
from employees;

--max, min, sum, media sal pt fiecare job in care lucreaza angajati
select max(e.salary), min(e.salary), avg(e.salary), count(employee_id),j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
group by j.job_id, j.job_title
order by 4;

--care este jobul pe care lucreaza cei mai multi angajati
select max(numar)
from(
    select job_id, count(*) numar
    from employees
    group by job_id) joburi;
    
    --echivalent cu o superagregare

select job_id, max(count(*)) numar_maxim
from employees
group by job_id; --GRESIT

--corect!
select max(count(*)) numar_maxim
from employees
group by job_id;

select e.job_id, job_title, count(*) numar
from employees e, jobs j
where e.job_id = j.job_id
group by e.job_id, job_title
having count(*) = (select max(count(*)) numar_maxim
                    from employees
                    group by job_id);
                    
--salariatii care lucreaza pe jobul la care sunt angajati cei mai multi salariati

select first_name
from employees
where job_id in (select e.job_id
                from employees e, jobs j
                where e.job_id = j.job_id
                group by e.job_id, job_title
                having count(*) = (select max(count(*)) numar_maxim
                                    from employees
                                    group by job_id));

--nr de angajati care sunt sefi/mangeri
select employee_id
from employees
where employee_id in (select manager_id from employees);

select distinct manager_id
from employees
where manager_id is not null
order by 1;

--sa se afiseze diferenta din 

select max(salary), min(salary), max(salary)-min(salary) diferenta, count(*)
from employees
group by department_id;

--
select d.department_name, l.city, count(*) numar_ang, round(avg(e.salary), 2) salariu_med
from employees e, departments d, locations l
where e.department_id = d.department_id 
    and d.location_id = l.location_id
group by d.department_name, l.city;

--

                    

