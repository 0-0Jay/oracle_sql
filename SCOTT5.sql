SELECT * FROM tab;

WITH a AS (SELECT /*+ INDEX_DESC(w idx_with_pay)*/ pay
           FROM with_test1 w
           WHERE pay > 0
           AND rownum = 1), 
b AS (SELECT /*+ INDEX\(w idx_with_pay)*/ pay
      FROM with_test1 w
      WHERE pay > 0
      AND rownum = 1)
SELECT a.pay - b.pay FROM a, b;

SELECT s.grade, s.name, s.height, g.avg_height
FROM (SELECT grade, AVG(height) AS avg_height
      FROM student
      GROUP BY grade) g
JOIN student s ON s.grade = g.grade 
WHERE s.height > g.avg_height
ORDER BY 1;

SELECT grade, AVG(height) AS avg_height
      FROM student
      GROUP BY grade;