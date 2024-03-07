describe employees;
select CONCAT(first_name, ' ') || last_name || 'castiga' || salary || 'lunar dar doreste' || salary*3
from employees;

select initcap(first_name), upper(last_name), length(first_name)
from employees
where upper(last_name) like 'J%' or upper(last_name) like 'M%' or upper(last_name) like '__A%'; 


