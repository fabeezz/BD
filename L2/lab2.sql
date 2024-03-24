describe employees;
select CONCAT(first_name, ' ') || last_name || 'castiga' || salary || 'lunar dar doreste' || salary*3
from employees;

select initcap(first_name), upper(last_name), length(first_name)
from employees
where upper(last_name) like 'J%' or upper(last_name) like 'M%' or upper(last_name) like '__A%'; 

select employee_id, first_name, last_name, nvl(to_char(manager_id), 'Nu exista manager')
from employees;

select employee_id, first_name, last_name, nvl2(to_char(manager_id), 'Exista manager','Nu exista manager')
from employees;

--se afiseaza var1 daca exista manager, var2 daca nu exista manager

select employee_id, first_name, last_name, nvl2(manager_id, 'Exista manager','Nu exista manager')
from employees;



