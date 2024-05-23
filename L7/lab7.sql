--1. Folosind subcereri, s? se afi?eze numele ?i data angaj?rii 
--pentru salaria?ii care au fost angaja?i dup? Gates.

SELECT last_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT hire_date
    FROM employees
    WHERE INITCAP(last_name)=’Gates’);

--2. Folosind subcereri, scrie?i o cerere pentru a afi?a numele ?i salariul 
--pentru to?i colegii (din acela?i departament) lui Gates. Se va exclude Gates.

SELECT last_name, salary
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    WHERE LOWER(last_name)=’gates’)
    AND LOWER(last_name) <> ’gates’;

În care caz nu se poate înlocui ”=” cu ”IN”??

3. Folosind subcereri, s? se afi?eze numele ?i salariul angaja?ilor condu?i direct 
de pre?edintele companiei (acesta este considerat angajatul care nu are manager).

--4. Scrie?i o cerere pentru a afi?a numele, codul departamentului ?i salariul angaja?ilor 
--al c?ror cod de departament ?i salariu coincid cu codul departamentului ?i salariul unui 
--angajat care câ?tig? comision.
--Solu?ie: 

SELECT last_name, department_id, salary
FROM employees 
WHERE (department_id, salary) IN ( 
    SELECT department_id, salary 
    FROM employees 
    WHERE commission_pct IS NOT NULL );

--5. Rezolva?i problema 6 din laboratorul precedent utilizând subcereri: s? se afi?eze codul, 
--numele ?i salariul tuturor angaja?ilor care ca?tig? mai mult decât salariul mediu pentru job-ul 
--corespunz?tor ?i lucreaz? într-un departament cu cel pu?in unul dintre angaja?ii al c?ror nume 
--con?ine litera “t”. Vom considera salariul mediu al unui job ca fiind egal cu media aritmetic? 
--a limitelor sale admise (specificate în coloanele min_salary, max_salary din tabelul JOBS).
--Solu?ie: 

SELECT e.employee_id,e.last_name,e.salary 
FROM employees e 
WHERE e.salary > ( 
    SELECT (j.min_salary+j.max_salary)/2 
    FROM jobs j 
    WHERE j.job_id=e.job_id ) AND e.job_id IN (
        SELECT job_id 
        FROM employees m 
        WHERE e.department_id=m.department_id AND LOWER(m.last_name) LIKE '%t%' );

--6. Scrieti o cerere pentru a afi?a angaja?ii care câ?tig? mai mult decât oricare func?ionar 
--(job-ul con?ine ?irul “CLERK”). Sorta?i rezultatele dupa salariu, în ordine descresc?toare.
--Ce rezultat este returnat dac? se înlocuie?te “ALL” cu “ANY”?
--Solu?ie: 

SELECT * 
FROM employees e 
WHERE salary > ALL ( 
    SELECT salary 
    FROM employees 
    WHERE job_id LIKE '%CLERK' );
    
--7. Scrie?i o cerere pentru a afi?a numele, numele departamentului ?i salariul angaja?ilor care nu câ?tig? comision,
--dar al c?ror ?ef direct câ?tig? comision.

select e.last_name, d.department_name, e.salary
from employees e, departments d
where e.department_id = d.department_id and
e.commission_pct is not null
and e.manager_id in (
    select employee_id 
    from employees 
    where commission_pct is not null);
    
    
--8. S? se afi?eze numele, departamentul, salariul ?i job-ul tuturor angaja?ilor al c?ror salariu
--?i comision coincid cu salariul ?i comisionul unui angajat din Oxford.

select e.last_name, d.department_name, e.salary, j.job_title
from employees e, departments d, locations l, jobs j
where e.department_id = d.department_id (+) and d.location_id = l.location_id (+) and j.job_id = e.job_id
and (salary, commission_pct) in (
    select salary, commission_pct
    from employees e, departments d, locations l
    where e.department_id = d.department_id and d.location_id = l.location_id
        and l.city like 'Oxford'
);
    
    
    --GROUP BY--
    
select min(salary)
from employees;

select last_name
from employees
where salary = (select min(salary) from employees);

    
    
    
    
    
    
    
    
    
    