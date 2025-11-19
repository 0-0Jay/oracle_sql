SELECT * FROM tab;

SELECT *
FROM professor p
JOIN department d
ON p.deptno = d.DEPTNO ;

SELECT * FROM emp e
WHERE ename = 'FORD';

SELECT * FROM emp e
WHERE sal > 3300;

SELECT * 
FROM emp
WHERE sal > (SELECT sal
             FROM EMP e
             WHERE e.ename = 'FORD');

SELECT d.dname, a.sal AS max_salary
FROM (SELECT deptno, max(sal) AS sal
	  FROM emp e
	  GROUP BY deptno) a
JOIN dept d ON a.deptno = d.deptno;

SELECT empno, ename, sal, deptno, (SELECT dname FROM dept WHERE deptno = e.deptno) dname
FROM emp e;

SELECT s.name AS stud_name, d.dname AS dept_name
FROM student s
JOIN department d ON s.deptno1 = d.deptno
WHERE s.deptno1 = (SELECT deptno1
				   FROM student
				   WHERE name = 'Anthony Hopkins');	

SELECT p.name AS prof_name, TO_CHAR(p.hiredate, 'yyyy-mm-dd') AS hiredate, d.dname AS dept_name
FROM professor p
JOIN department d ON p.DEPTNO = d.DEPTNO 
WHERE p.hiredate > (SELECT hiredate 
                    FROM professor
                    WHERE name = 'Meg Ryan');

SELECT dcode 
FROM dept2 
WHERE area = 'Pohang Main Office';

SELECT *
FROM emp2 
WHERE deptno IN (0001, 1003, 1006, 1007);

SELECT e.empno, e.name, e.deptno
FROM emp2 e
WHERE e.deptno IN (SELECT dcode 
				  FROM dept2 
				  WHERE area = 'Pohang Main Office');		

SELECT * 
FROM dept d
WHERE EXISTS (SELECT *
			  FROM dept d2
			  WHERE d2.deptno = 10);

SELECT *
FROM emp2 
WHERE position = 'Section head'  

SELECT e.name, e.position, e.pay AS salary
FROM emp2 e
WHERE pay > ANY (SELECT MIN(pay)
                 FROM emp2 
                 WHERE position = 'Section head');

SELECT s.weight
FROM student s
WHERE s.weight < ANY (SELECT weight
                      FROM student
                      WHERE grade = 2);

SELECT d.dname, e.name, e.pay 
FROM emp2 e
JOIN dept2 d ON e.deptno = d.dcode
WHERE e.pay < ALL (SELECT AVG(pay) AS avg_sal
                   FROM emp2
                   GROUP BY deptno);

SELECT grade, MAX(weight) AS max_weight
FROM student 
GROUP BY grade;

SELECT grade, name, weight
FROM student s
WHERE (s.grade, s.weight) IN (SELECT grade, MAX(weight) AS max_weight 
                            FROM student
                            GROUP BY grade);

SELECT p.profno, p.name AS prof_name, p.hiredate, d.dname AS dept_name
FROM professor p
JOIN department d ON p.deptno = d.deptno
WHERE (p.deptno, p.hiredate) IN (SELECT deptno, MIN(hiredate) AS old_hiredate 
                                 FROM professor
                                 GROUP BY deptno)
ORDER BY 3;

SELECT * FROM emp2;

SELECT e.name, e.position, TO_CHAR(e.pay, '$999,999,999') AS salary
FROM emp2 e
WHERE (e.position, e.pay) IN (SELECT position , MAX(pay)
                               FROM emp2
                               GROUP BY position)
ORDER BY e.pay;

SELECT name, position, pay
FROM emp2 e
WHERE 1=1
AND e.pay >= (SELECT TRUNC(AVG(pay))
        	  FROM emp2
     		  WHERE e.position = position);

SELECT name, position, pay,
       (SELECT TRUNC(AVG(pay)) FROM emp2 WHERE position = e.position) AS avg_pay
FROM emp2 e;

WITH emp AS
(SELECT''|| deptno || '' AS deptno, MAX(pay) AS salary
 FROM emp2
 GROUP BY deptno)
SELECT d.dname, e.salary
FROM emp e
JOIN dept2 d ON e.deptno = d.dcode;

CREATE TABLE with_test1 (
NO NUMBER,
name VARCHAR2(10),
pay NUMBER(6))
TABLESPACE users;

BEGIN
	FOR i IN 1 .. 5000000 LOOP
		INSERT INTO with_test1 VALUES(1, dbms_random.string('A', 5), dbms_random.value(6, 99999));
	END LOOP
	COMMIT;
END;

SELECT MAX(pay) - MIN(pay) FROM with_test1;

CREATE INDEX idx_with_pay ON with_test1(pay);

WITH a AS (SELECT /*+ INDEX_DESC(w idx_with_pay)*/ pay
           FROM with_test1 w
           WHERE pay > 0
           AND rownum = 1), 
b AS (SELECT /*+ INDEX\(w idx_with_pay)*/ pay
      FROM with_test1 w
      WHERE pay > 0
      AND rownum = 1)
SELECT a.pay - b.pay FROM a, b;

SELECT *
FROM emp;

SELECT LPAD(ename, LEVEL * 4, '*')
FROM emp e
CONNECT BY PRIOR empno = mgr
START WITH empno = 7839;

SELECT LPAD(e.ename, LEVEL * 6 + LENGTH(e.ename), '*'), LEVEL, empno, mgr
FROM emp e
CONNECT BY PRIOR empno = mgr
START WITH mgr IS NULL;

SELECT name || '-' || position, ''||empno, ''||pempno
FROM emp2
CONNECT BY PRIOR empno = pempno
START WITH pempno IS NULL;