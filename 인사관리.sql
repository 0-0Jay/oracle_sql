SELECT *
FROM employees;

-- 1. 입사 일자 2000년 이후인 사원 조회
SELECT *
FROM employees
WHERE hire_date >= '2000-01-01';

-- 2. salary가 10000 이상인데 2000년대 이후인 사원
SELECT *
FROM employees
WHERE salary >= 10000 AND hire_date >= '2000-01-01';

-- 3. 이름이 5글자인 사원
SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- 4. 급여(salary, salary+bonus)가 10000 이상인 사원
SELECT *
FROM employees
WHERE salary >= 10000 OR salary + 500 >= 10000;

SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
ORDER BY 1;

select TO_CHAR(hire_date, 'YYYY') AS year, COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(*) > 1
ORDER BY 2 DESC;

select TO_CHAR(hire_date, 'YYYY') AS year, department_id AS "부서", COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY'), department_id
ORDER BY 1, 2;

-- 조인
SELECT e.*, d.department_name
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
JOIN departments d
ON e.department_id = d.department_id
WHERE first_name = 'Alexander';

SELECT e.*
FROM employees e, jobs j, departments d
WHERE e.job_id = j.job_id AND e.department_id = d.department_id
AND e.first_name = 'Alexander';

SELECT e.employee_id, 
       e.first_name || '-' || e.last_name, 
       ee.employee_id, 
       ee.first_name || '-' || ee.last_name
FROM employees e
LEFT OUTER JOIN employees ee ON e.manager_id = ee.employee_id
ORDER BY 1;

SELECT /*+ INDEX(e EMP_EMP_ID_PK) */ * 
FROM employees;

INSERT INTO employees
SELECT employees_seq.nextval, first_name, last_name, 'email' || employees_seq.currval, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
FROM employees;

SELECT employees_seq.currval FROM dual;

DELETE FROM employees WHERE employee_id > 206;

SELECT /* INDEX(e EXP_EMP_ID_PK) */ *
FROM employees;

SELECT *
FROM employees
ORDER BY salary;

SELECT * FROM scott.proff;