select * from tab;
select * from emp;

SELECT distinct deptno FROM emp;

SELECT DISTINCT job, deptno
FROM emp
ORDER BY 1 DESC, 2 ASC;

select name as "이름", 'good morning!!' as "Message", 3 + 5 as summary from professor;

SELECT name || '''s ID: ' || id || ' , WEIGHT is ' || weight || 'Kg' as "ID AND WEIGHT"
FROM student;

SELECT * FROM emp;

SELECT ename || '(' || job || '), ' || ename || '''' || job || '''' as  "NAME AND JOB"
FROM emp;

SELECT ename || '''s sal is $' || sal AS "Name And Sal"
FROM emp;

SELECT *
FROM emp
WHERE empno >= 7839;

SELECT *
FROM emp
WHERE job = 'SALESMAN';

SELECT *
FROM emp
WHERE hiredate > '81/02/20';

SELECT job, ename, sal "현재급여", sal + 500 "인상된 급여"
FROM emp
WHERE job in ('MANAGER', 'SALESMAN');

SELECT * 
FROM professor
WHERE not pay >= 400
ORDER BY name;

SELECT *
FROM professor
MINUS
SELECT *
FROM professor
WHERE (pay >= 400 or bonus < 100);

SELECT * from emp;

SELECT *
FROM emp
WHERE sal + nvl(comm, 0) >= 2000;
