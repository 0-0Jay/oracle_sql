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