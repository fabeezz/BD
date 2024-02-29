SELECT * 
FROM employees
WHERE employee_id=107;

describe employees;

select employee_id, first_name,  last_name, job_id, hire_date
from employees;

select employee_id, last_name, salary*12 "ANNUAL SALARY"
from employees;

describe jobs;
select * from jobs;

select employee_id, salary sal
from employees
where salary > 10000
and employee_id < 150
order by salary desc;
-- ordinea este from, where, //toate celelalte//, select, order by

-- echivalenta cu e mai sus
select employee_id, salary
from employees
where salary > 10000
and employee_id < 150
order by 2 desc;

select employee_id, first_name || ' ' || last_name as NUME, job_id as "Angajat si titlu"
from employees;
-- || ' ' || concateneaza
-- ' ' pentru spatiu
-- " " strict pt ALIAS

select sysdate
from employees;

select sysdate
from dual;

alter session set nls_language = Romanian;
alter session set nls_language = American;

select to_char(sysdate, 'DD /MM/ YYYY')
from dual;
select to_char(sysdate, 'Day /Month/ YYYY')
from dual;

select employee_id, to_char(hire_date, 'Month') as Hire_Month
from employees;

select first_name, salary, commission_pct
from employees
order by commission_pct desc;

select first_name, salary, commission_pct
from employees
order by nvl(commission_pct, 0) desc;

select first_name, salary, nvl(commission_pct, 0)
from employees
order by 3 desc;

select to_char(sysdate, 'DD.MM.YYYY - HH24:MM:SS')
from dual;
