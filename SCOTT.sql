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

-- 집합연산자 (union)
SELECT studno, name, deptno1
FROM student
UNION ALL
SELECT profno, name, deptno
FROM professor;

-- 단일행 함수
SELECT SUBSTR(ename, 1, 2)
FROM emp;

-- 다중행 함수
SELECT COUNT(*)
FROM emp;

SELECT name,
       tel,
       SUBSTR(tel, 1, instr(tel, ')')-1) as "AREA CODE"
FROM student
WHERE deptno1 = 201;

SELECT LPAD(ename, 9, '123456789') AS "LPAD",
       RPAD(ename, 9, SUBSTR('123456789', length(ename) + 1)) AS "RPAD"
FROM emp
WHERE deptno = 10;

SELECT ename, REPLACE(ename, SUBSTR(ename, 1, 2), '**') AS "REPLACE"
FROM emp
WHERE deptno = 10;

SELECT ename, REPLACE(ename, SUBSTR(ename, 2, 2), '--') AS "REPLACE"
FROM emp
WHERE deptno = 20;

SELECT name, jumin, REPLACE(jumin, SUBSTR(jumin, 7, 7), '-/-/-/-') AS "REPLACE"
FROM student
WHERE deptno1 = 101;

SELECT name, tel, REPLACE(tel, SUBSTR(tel, 5, 3), '***') AS "REPLACE"
FROM student
WHERE deptno1 = 102;

SELECT name, tel, REPLACE(tel, SUBSTR(tel, 9, 4), '****') AS "REPLACE"
FROM student
WHERE deptno1 = 101;

SELECT ROUND(12.12345, 4),
       TRUNC(12.12345, 2),
       MOD(12, 10),
       CEIL(12.12345),
       FLOOR(12.12345),
       POWER(2,2)
FROM dual;

SELECT sysdate, MONTHS_BETWEEN('2025/02/01','2025/01/01') bet,
       ADD_MONTHS(sysdate, 1) "add",
       sysdate + 31 add2,
       NEXT_DAY(sysdate, '금') next,
       LAST_DAY(ADD_MONTHS(sysdate, 1)) last,
       TO_CHAR(ROUND(sysdate), 'rrrr/mm/dd hh24:mi:ss') round,
       TO_CHAR(TRUNC(sysdate), 'rrrr/mm/dd hh24:mi:ss') trunc
FROM dual;

SELECT TO_CHAR(1234, '09999') tochar,
       TO_CHAR(1234, '9999.99') num,
       TO_CHAR(123456789, '999,999,999') format
from dual;

SELECT empno, ename, 
       TO_CHAR(hiredate, 'yyyy-mm-dd') AS "HIREDATE", 
       TO_CHAR((sal * 12 + comm), '$999,999') AS "SAL", 
       TO_CHAR(((sal * 12 + comm) * 1.15), '$999,999') AS "15% UP"
FROM emp
WHERE comm IS NOT NULL;