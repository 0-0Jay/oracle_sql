SELECT ename, sal + nvl(comm, 0) AS "급여"
FROM emp;

SELECT profno, name, pay, bonus, TO_CHAR((pay * 12 + NVL(bonus, 0)), '99,999') AS total
FROM professor
WHERE deptno = 201;

SELECT empno, ename, sal, comm, NVL2(comm, sal + comm, 0) AS nvl2
FROM emp
WHERE deptno = 30
ORDER BY 1;

SELECT empno, ename, comm, NVL2(comm, 'Exist', 'NULL') AS NVL2
FROM emp
WHERE deptno = 30;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering') AS dname
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', 'ETC') AS dname
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', 
                                    102, 'Multimedia Engineering', 
                                    103, 'Softeware Engineering', 
                                    'ETC') AS dname
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!' , 'GOOD!')) AS etc
FROM professor;

SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!' , 'GOOD!'), 'N/A') AS etc
FROM professor;

SELECT name, jumin, DECODE(SUBSTR(jumin, 7, 1), 1, 'MAN', 'WOMAN') AS gender
FROM student
WHERE deptno1 = 101;

SELECT name, tel, DECODE(SUBSTR(tel, 1, INSTR(tel, ')', 1, 1) - 1),
                         02, 'SEOUL', 031, 'GYEONGGI', 051, 'BUSAN', 
                         052, 'ULSAN', 055, 'GYEONGNAM') AS loc
FROM student
WHERE deptno1 = 101;

SELECT name, SUBSTR(jumin, 3, 2) month,
       CASE WHEN SUBSTR(jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4'
            WHEN SUBSTR(jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4'
            WHEN SUBSTR(jumin, 3, 2) BETWEEN '07' AND '09' THEN '3/4'
            WHEN SUBSTR(jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4'
       END quarter
FROM student;

SELECT empno, ename, sal,
       CASE WHEN sal BETWEEN 1 AND 1000 THEN 'LEVEL 1'
            WHEN sal BETWEEN 1001 AND 2000 THEN 'LEVEL 2'
            WHEN sal BETWEEN 2001 AND 3000 THEN 'LEVEL 3'
            WHEN sal BETWEEN 3001 AND 4000 THEN 'LEVEL 4'
            WHEN sal > 4000 THEN 'LEVEL 5'
       END "LEVEL"
FROM emp;

SELECT *
FROM t_reg
WHERE regexp_like(text, '^[a-z]|[0-9]$');

SELECT name, tel
FROM student
WHERE REGEXP_LIKE(tel, '^[0-9]{2}\)[0-9]{4}');

SELECT name, id
FROM student
WHERE REGEXP_LIKE(id, '^...r');

SELECT ip
FROM t_reg2
WHERE REGEXP_LIKE(ip, '^[10]{2}\.[10]{2}\.[10]{2}\.[1]');

SELECT COUNT(*), COUNT(comm) FROM emp;

SELECT AVG(sal), SUM(sal), COUNT(*), MAX(sal), MIN(sal), STDDEV(sal), VARIANCE(sal)
FROM emp
WHERE job = 'SALESMAN';

SELECT job, deptno, COUNT(*), sum(sal)
FROM emp
GROUP BY job, deptno
ORDER BY 1, 2;

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno
HAVING AVG(sal) >= 2000;

SELECT deptno, job, AVG(NVL(sal , 0)), COUNT(*)
FROM emp
GROUP BY ROLLUP(deptno, job);

CREATE TABLE professor2
AS SELECT deptno, position, pay
FROM professor;

SELECT * FROM professor2;

INSERT INTO professor2 VALUES(101, 'instructor', 100);
INSERT INTO professor2 VALUES(101, 'a full professor', 100);
INSERT INTO professor2 VALUES(101, 'assistance professor', 100);

SELECT deptno, job, ROUND(AVG(NVL(sal , 0)), 1), COUNT(*)
FROM emp
GROUP BY CUBE(deptno, job)
ORDER BY 1, 2;

SELECT grade, COUNT(*)
FROM student
GROUP BY grade
UNION ALL
SELECT deptno1, COUNT(*)
FROM student
GROUP BY deptno1;

SELECT grade, deptno1, COUNT(*)
FROM student
GROUP BY GROUPING SETS(grade, deptno1);

SELECT s.studno, s. name, s. grade, d.dname, p.name
FROM student s, department d, professor p
WHERE s.deptno1 = d.deptno AND s.deptno1 = p.deptno AND s.name = 'James Seo';

SELECT s.studno, s.name, s.grade, c.total
FROM student s
JOIN score c
ON s.studno = c.studno
WHERE c.total >= 90;

SELECT s.studno, s.name, c.total, 
       CASE WHEN c.total >= 90 THEN 'A'
            WHEN c.total >= 80 THEN 'B'
            WHEN c.total >= 70 THEN 'C'
            WHEN c.total >= 60 THEN 'D'
            ELSE 'F' END "학점"
FROM student s
JOIN score c
ON s.studno = c.studno;

SELECT * FROM department;
SELECT * FROM score;

SELECT s.*, h.grade
FROM score s
JOIN hakjum h ON s.total BETWEEN h.min_point AND h.max_point;

SELECT s.studno, s.name, d.dname, c.total, h.grade
FROM student s
JOIN department d ON s.deptno1 = d.deptno
JOIN score c ON s.studno = c.studno
JOIN hakjum h ON c.total BETWEEN h.min_point AND h.max_point
