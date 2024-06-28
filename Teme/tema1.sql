--Ex1: Sa se afiseze orasul si codul locatiei in care lucreaza in prezent salariatii angajati pe un job 
--al carui titlu se termina in "clerk" sau care se gaseste intr-o tara 
--a carei denumire are pe a 4-a sau a 5-a pozitie litera "a".

select distinct l.city, l.location_id
from employees e, jobs j, departments d, locations l, countries c
where 
    e.department_id = d.department_id 
        and e.job_id = j.job_id
            and d.location_id = l.location_id 
                and l.country_id = c.country_id
    and
    lower(j.job_title) like '%clerk'
        or
    lower(c.country_name) like '___a%' or lower(c.country_name) like '____a%';
    
--23 rezultate

--------------------------------------------------------------------------------------------------------------------
--Ex 2a): Sa se afiseze numele complet, job-ul (titlul) actual 
--si departamentul (numele) actual
--pentru angajatii care in prezent lucreaza intr-un departament si pe un job
--pe care au lucrat in trecut si alti salariati angajati dupa 29-Octombrie-1993.
--Se va tine cont atat de job, cat si de departament. Ordonati rezultatele descrescator 
--in functie de codul departamentului si apoi dupa titlul jobului.

select e.first_name || ' ' || e.last_name "Nume complet", j.job_title, d.department_name
from employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
where e.department_id in (
    select jh.department_id
    from job_history jh
    join employees e1 on e1.department_id = jh.department_id
    join departments d1 on e1.department_id = d1.department_id
    where jh.start_date > to_date('29/10/1993', 'dd/mm/yy')
    and e1.employee_id = jh.employee_id
)
and e.job_id in (
    select job_id
    from job_history
    where start_date > to_date('29/10/1993', 'dd/mm/yy')
)
order by
d.department_id desc,
j.job_title desc;

--55 rezultate

--------------------------------------------------------------------------------------------------------------------
--Ex 2b): Modificati cererea anterioara astfel incat sa se tina cont doar de lista 
--job-urilor pe care au lucrat in trecut angajatii indiferent de departamentul in care au lucrat.
--Discutati diferentele aparute in cod, cat si despre rezultatele obtinute.
                            
select distinct e.first_name || ' ' || e.last_name as "full name", j.job_title, d.department_name, d.department_id
from employees e
join jobs j on e.job_id = j.job_id
left outer join departments d on e.department_id = d.department_id
join job_history jh on j.job_id = jh.job_id
where jh.start_date > to_date('29/10/1993', 'dd/mm/yy')
order by
d.department_id desc,
j.job_title desc;

--57 rezultate

--------------------------------------------------------------------------------------------------------------------
--Ex2c): Sa se afiseze numele complet, job-ul (titlul) actual si departamentul (numele) actual
--pentru angajatii care in prezent lucreaza intr-un departament sau pe un job
--pe care au lucrat in trecut si alti salariati angajati dupa 29-Octombrie-1993. 
--Discutati diferentele aparute in cod, cat si despre rezultatele obtinute.

select e.first_name || ' ' || e.last_name "Nume complet", j.job_title, d.department_name
from employees e
join jobs j on e.job_id = j.job_id
join departments d on e.department_id = d.department_id
where e.department_id in (
    select jh.department_id
    from job_history jh
    join employees e1 on e1.department_id = jh.department_id
    join departments d1 on e1.department_id = d1.department_id
    where jh.start_date > to_date('29/10/1993', 'dd/mm/yy')
    and e1.employee_id = jh.employee_id
)
UNION
select distinct e.first_name || ' ' || e.last_name "Nume complet", j.job_title, d.department_name
from employees e
join jobs j on e.job_id = j.job_id
left outer join departments d on e.department_id = d.department_id
join job_history jh on j.job_id = jh.job_id
where jh.start_date > to_date('29/10/1993', 'dd/mm/yy');


--83 rezultate



