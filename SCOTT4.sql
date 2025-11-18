SELECT *
FROM tab
WHERE tname LIKE 'BIN%';

PURGE TABLE "BIN$2R64d32gRRWeEv8bCr+Cgg==$0";

CREATE TABLE professor3
AS
SELECT profno, name, pay
FROM professor;

SELECT * FROM professor3;

CREATE TABLE professor4
AS
SELECT profno, name, pay
FROM professor
WHERE 1 = 2;

SELECT * FROM professor4;

INSERT INTO professor4
SELECT * FROM professor4;

rollback;

CREATE TABLE professor5
AS
SELECT * FROM professor4;

TRUNCATE TABLE professor3;
TRUNCATE TABLE professor4;

INSERT ALL
WHEN profno between 1000 AND 2999
THEN INTO professor3 VALUES(profno, name, pay)
WHEN profno between 3000 AND 4999
THEN INTO professor4 VALUES(profno, name, pay)
SELECT profno, name, pay
FROM professor;

SELECT * FROM professor3;
SELECT * FROM professor4;
SELECT * FROM professor5;

INSERT ALL
INTO professor3 VALUES(profno, name, pay)
INTO professor4 VALUES(profno, name, pay)
INTO professor5 VALUES(profno, name, pay)
SELECT profno, name, pay
FROM professor;

UPDATE professor SET bonus = 200 WHERE position = 'assistant professor';
SELECT * FROM professor;

UPDATE professor SET pay = pay * 1.15 
WHERE position = (SELECT position 
                  FROM professor 
                  WHERE name = 'Sharon Stone')
      AND pay < 250;

SELECT * FROM professor
WHERE position = (SELECT position 
                  FROM professor 
                  WHERE name = 'Sharon Stone')
      AND pay < 250;
      
CREATE TABLE ch_total(
u_date VARCHAR2(6),
cust_no NUMBER,
u_time NUMBER,
charge NUMBER);

INSERT INTO charge_01 VALUES('141001', 1000, 2, 1000);
INSERT INTO charge_02 VALUES('141002', 1000, 3, 1500);

--merge
MERGE INTO ch_total total
USING charge_01 ch01
ON (total.u_date = ch01.u_date)
WHEN MATCHED THEN
UPDATE SET total.cust_no = ch01.cust_no
WHEN NOT MATCHED THEN
INSERT VALUES(ch01.u_date, ch01.cust_no, ch01.u_time, ch01.charge);

MERGE INTO ch_total total
USING charge_02 ch02
ON (total.u_date = ch02.u_date)
WHEN MATCHED THEN
UPDATE SET total.cust_no = ch02.cust_no
WHEN NOT MATCHED THEN
INSERT VALUES(ch02.u_date, ch02.cust_no, ch02.u_time, ch02.charge);

SELECT * FROM ch_total;

UPDATE emp e
SET sal = sal * 1.1
WHERE NOT EXISTS (SELECT 1
              FROM dept d
              WHERE e.deptno = d.deptno
              AND d.loc = 'DALLAS');
              
INSERT ALL
INTO professor4 VALUES(profno, name, pay)
SELECT profno, name, pay
FROM professor
WHERE profno <= 3000;

SELECT * FROM professor4;
SELECT * FROM professor;

UPDATE professor
SET bonus = 100
WHERE name = 'Sharon Stone';
              
commit;

CREATE TABLE new_emp1 (
no NUMBER(4) CONSTRAINT emp1_no_pk PRIMARY KEY,
name VARCHAR2(20) CONSTRAINT emp1_name_nn NOT NULL,
jumin VARCHAR2(13) CONSTRAINT emp1_jumin_nn NOT NULL
                   CONSTRAINT emp1_jumin_uk UNIQUE,
loc_code NUMBER(1) CONSTRAINT emp1_area_ck CHECK (loc_code < 5),
deptno VARCHAR2(6) CONSTRAINT emp1_deptno_fk REFERENCES dept2(dcode)
);

SELECT * FROM dept2;

INSERT INTO new_emp1 (no, name, jumin, loc_code, deptno)
VALUES (2000, 'null', '11112', 4, 1011);

SELECT * FROM new_emp1;

ALTER TABLE new_emp1
ADD CONSTRAINT emp1_name_uk UNIQUE(name);

UPDATE new_emp1
SET name = 'null2'
WHERE no = 2000;

DELETE FROM dept2
WHERE dcode = '1011';

CREATE TABLE tcons(
no NUMBER(5) CONSTRAINT tcons_no_pk PRIMARY KEY,
name VARCHAR2(20) CONSTRAINT tcons_name_nn NOT NULL,
jumin VARCHAR2(13) CONSTRAINT tcons_jumin_nn NOT NULL
                   CONSTRAINT tcons_jumin_uk UNIQUE,
area NUMBER(1) CONSTRAINT tcons_area_ck CHECK(area BETWEEN 1 AND 4),
deptno VARCHAR2(6) CONSTRAINT tcons_deptno_fk REFERENCES dept2(dcode)
);

ALTER TABLE tcons
ADD CONSTRAINT tcons_name_fk FOREIGN KEY(name) REFERENCES emp2(name);

SELECT * FROM emp2;

CREATE UNIQUE INDEX idx_emp_name
ON emp(ename);

SELECT * FROM emp;

SELECT /*+ INDEX(e SYS_C008356) */ *
FROM emp e
WHERE e.empno > 1000;

CREATE VIEW emp_dept_v AS
SELECT e.empno, e.ename, e.sal, d.dname, d.loc 
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

SELECT * FROM emp_dept_v;

SELECT a.deptno, a.sal, d.dname
FROM (SELECT deptno, MAX(sal) sal
      FROM emp
      GROUP BY deptno) a
JOIN dept d ON a.deptno = d.deptno;

SELECT * FROM student;
SELECT * FROM department;

SELECT d.dname, a.height as max_height, a.name, a.height
FROM (SELECT name, height, deptno1
      FROM student
      WHERE (deptno1, height) in (SELECT deptno1, max(height)
                                  FROM student
                                  GROUP BY deptno1)) a
JOIN department d ON a.deptno1 = d.deptno;

SELECT d.dname, height AS max_height, name, height
FROM (SELECT name, height, deptno1,
      RANK() OVER (PARTITION BY deptno1 ORDER BY height DESC) AS rnk
      FROM student) a
JOIN department d ON a.deptno1 = d.deptno
WHERE a.rnk = 1;

DROP SEQUENCE emp_seq;
CREATE SEQUENCE emp_seq
INCREMENT BY 100
START WITH 7877;

DROP SEQUENCE emp_seq;
CREATE SEQUENCE emp_seq
MINVALUE 1
MAXVALUE 10
CYCLE
CACHE 2;

SELECT emp_seq.nextval FROM dual;

-- procedure
--CREATE OR REPLACE PROCEDURE re_seq(sname IN VARCHAR2, bname OUT VARCHAR2)
--IS 
-- val NUMBER;
--BEGIN
-- EXECUTE IMMEDIATE 'select ' || sname || '.nextval from dual' INTO val;
-- EXECUTE IMMEDIATE 'alter sequence ' || sname || ' increment by -' || val || ' minvalue 0';
-- EXECUTE IMMEDIATE 'select ' || sname || '.nextval from dual' INTO val;
-- EXECUTE IMMEDIATE 'alter sequence ' || sname || ' increment by 1 minvalue 0';
--END;

--BEGIN
-- re_seq('emp_seq');
--END;

SELECT emp_seq.nextval FROM dual;
EXEC re_seq('emp_seq');

CREATE SYNONYM prof for professor;
CREATE PUBLIC SYNONYM proff for professor;

SELECT * FROM prof;

GRANT SELECT ON prof TO hr;