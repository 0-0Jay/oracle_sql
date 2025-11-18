--join
SELECT s.studno, s.name, p.profno, p.name
FROM student s
LEFT OUTER JOIN professor p ON s.profno = p.profno
ORDER BY 1;

SELECT p.profno, p.name, s.studno, s.name
FROM professor p
RIGHT OUTER JOIN student s ON p.profno = s.profno;

SELECT p.profno, p.name, s.studno, s.name
FROM professor p
FULL OUTER JOIN student s ON p.profno = s.profno;

-- right outer
SELECT s.studno, s.name, p.profno, p.name
FROM student s, professor p
WHERE s.profno(+) = p.profno
ORDER BY 1;

-- left outer
SELECT s.studno, s.name, p.profno, p.name
FROM student s, professor p
WHERE s.profno = p.profno(+)
ORDER BY 1;

-- full outer
SELECT s.studno, s.name, p.profno, p.name
FROM student s, professor p
WHERE s.profno(+) = p.profno
UNION
SELECT s.studno, s.name, p.profno, p.name
FROM student s, professor p
WHERE s.profno = p.profno(+)
ORDER BY 1;

SELECT s.name, s.deptno1, d.dname AS dept_name
FROM student s, department d
WHERE s.deptno1 = d.deptno;

SELECT s.name, s.deptno1, d.dname AS dept_name
FROM student s
JOIN department d ON s.deptno1 = d.deptno;

SELECT * FROM emp2;
SELECT * FROM p_grade;

SELECT e.name, e.position, 
       TO_CHAR(e.pay, '99,999,999') AS "PAY", 
       TO_CHAR(p.s_pay, '99,999,999') AS "Low Pay",
       TO_CHAR(p.e_pay, '99,999,999') AS "High Pay"
FROM emp2 e
JOIN p_grade p ON e.position = p.position;

SELECT e.name,
       TRUNC(MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, -144), e.BIRTHDAY) / 12) AS "AGE",
       e.position AS "CURR_POSITION",
       p.position AS "BE_POSITION"
FROM emp2 e
JOIN p_grade p ON TRUNC(MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, -144), e.BIRTHDAY) / 12) BETWEEN p.s_age AND p.e_age;
    
SELECT * FROM customer;
SELECT * FROM gift;

SELECT c.gname AS "CUST_NAME",
       c.point,
       g.gname AS "GIFT_NAME"
FROM customer c
JOIN gift g ON c.point >= g.g_start AND g.gname = 'Notebook';

SELECT p.profno, p.name, p.hiredate, COUNT(pp.hiredate) AS "COUNT"
FROM professor p
LEFT OUTER JOIN professor pp ON p.hiredate > pp.hiredate
GROUP BY p.profno, p.name, p.hiredate
ORDER BY COUNT(pp.hiredate);

SELECT * FROM emp;

SELECT e.empno, e.ename, e.hiredate, COUNT(ee.hiredate) AS "COUNT"
FROM emp e
LEFT OUTER JOIN emp ee ON e.hiredate > ee.hiredate
GROUP BY e.empno, e.ename, e.hiredate
ORDER BY COUNT(ee.hiredate);

DROP TABLE board PURGE;
CREATE TABLE board(
board_id NUMBER PRIMARY KEY,
title VARCHAR2(100) NOT NULL,
content VARCHAR(1000) NOT NULL,
author VARCHAR2(20) NOT NULL,
created_at DATE DEFAULT sysdate
);

SELECT * FROM board;
INSERT INTO board(board_id, title, content, author) VALUES(1, '제목1입니다.', '내용1입니다.', 'user01');
INSERT INTO board(board_id, title, content, author, created_at) VALUES(2, '제목2입니다.', '내용2입니다.', 'user01', sysdate -1);
commit;
ROLLBACK;

-- 열 추가
ALTER TABLE board
ADD like_it NUMBER DEFAULT 1;

-- 열 이름 수정
ALTER TABLE board
RENAME COLUMN like_it TO stars;

-- 열 삭제
ALTER TABLE board
DROP COLUMN stars;

DELETE FROM board;
TRUNCATE TABLE board;

SELECT * FROM board;
INSERT INTO board VALUES(1, '1번제목', '1번내용', 'user01', sysdate);
INSERT INTO board VALUES((SELECT MAX(board_id) FROM board) + 1, '2번제목', '2번내용', 'user01', sysdate);

DELETE FROM board
WHERE board_id = 11;

UPDATE board SET title = '제목 3', content = '내용 3' WHERE board_id = 3;
commit;

UPDATE board SET title = '제목 10', content = '내용 10', author = 'user03' WHERE board_id = 10;

UPDATE board SET title = '제목' || board_id, content = '내용' || board_id WHERE board_id in (4, 5, 6, 7);