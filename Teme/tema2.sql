--Ex 1: Folosind clauza with, pentru fiecare departament afisati 
--informatii despre angajatii cu cel mai mare salariu din acel departament.
--Daca intr-un departament nu lucreaza nimeni, veti afisa 
--un mesaj corespunzator (diferit de "nu lucreaza nimeni").
WITH max_salaries AS (
    SELECT department_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id
),
max_sal_employees AS (
    SELECT e.department_id, e.employee_id, e.first_name,
        e.last_name, e.salary
    FROM employees e, max_salaries ms
    WHERE e.department_id = ms.department_id 
        AND e.salary = ms.max_salary
)
SELECT d.department_name,
    CASE WHEN e.employee_id IS NULL THEN 
        'Departamentul nu are angajati!'
    ELSE 
        TO_CHAR(e.employee_id)
    END AS employee_id,
    NVL(e.first_name, '-') AS fn, NVL(e.last_name, '-') AS ln, NVL(e.salary, '0') AS sal
FROM departments d
LEFT OUTER JOIN max_sal_employees e ON d.department_id = e.department_id
ORDER BY sal DESC;
-- 27 rezultate


--Ex 2: Afisati codul si numele departamentului si numele complet 
--al managerului departamentelor pentru managerii de departament 
--avand salariul mai mare decat media salariilor angajatilor 
--al caror sef direct are un numar de telefon ce contine sirul "67".
WITH emp_67 AS (
    SELECT avg(e.salary) as avg_salary
    FROM employees e, employees m
    WHERE e.manager_id = m.employee_id
        AND m.phone_number LIKE '%67%'
)
SELECT d.department_id, d.department_name,
    m.first_name || ' ' || m.last_name as manager_name
FROM departments d, employees m 
WHERE d.manager_id = m.employee_id
    AND m.salary > (SELECT avg_salary FROM emp_67)
ORDER BY d.department_id;
-- 7 rezultate

--Ex 3: Afisati departamentele in care lucreza angajati 
--al caror manager direct are un numar de telefon ce contine fix 10 CIFRE. 
--(Atentie la forma actuala a numerelor de telefon din baza de date. 
--Folositi doar functiile prezente in fisierele oferite ca suport la laborator.) 
--Se vor afisa doar departamentele a caror medie salariala 
--este mai mare decat media salariala a intregii firme.

WITH dep_10 AS (
    SELECT DISTINCT d.department_id, d.department_name,
        ROUND(AVG(e.salary)) avg_sal_dep
    FROM departments d, employees e, employees m
    WHERE d.department_id = e.department_id AND e.manager_id = m.employee_id
        AND LENGTH(REPLACE(m.phone_number, '.', '')) = 10
    GROUP BY d.department_id, d.department_name), 
company AS (
    SELECT ROUND(AVG(e1.salary)) avg_sal_comp
    FROM employees e1)
SELECT d.department_id, d.department_name
FROM dep_10 d, company c
WHERE d.avg_sal_dep > c.avg_sal_comp;
-- 7 rezultate



