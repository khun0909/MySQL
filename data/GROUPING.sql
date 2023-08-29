
SELECT COUNT(*) 
FROM tStaff;

SELECT COUNT(*) AS "총 직원수" 
FROM tStaff;


SELECT COUNT(*) 
FROM tStaff 
WHERE salary >= 400;

SELECT COUNT(*) 
FROM tStaff 
WHERE salary >= 10000;

SELECT COUNT(name) 
FROM tStaff;

SELECT COUNT(depart) 
FROM tStaff;

SELECT COUNT(DISTINCT depart) 
FROM tStaff;

SELECT COUNT(score) 
FROM tStaff;

SELECT COUNT(*) - COUNT(score) 
FROM tStaff;

SELECT COUNT(*) 
FROM tStaff 
WHERE score IS NULL;

SELECT SUM(popu), AVG(popu) 
FROM tCity;

SELECT MIN(area), MAX(area) 
FROM tCity;

SELECT SUM(score), AVG(score) 
FROM tStaff 
WHERE depart = '인사과';

SELECT MIN(salary), MAX(salary) 
FROM tStaff 
WHERE depart = '영업부';


SELECT MIN(name) 
FROM tStaff;

SELECT AVG(salary) 
FROM tStaff;

SELECT SUM(salary)/COUNT(*) 
FROM tStaff;

SELECT AVG(score) 
FROM tStaff;

SELECT SUM(score)/COUNT(*) 
FROM tStaff;

SELECT COUNT(*) 
FROM tStaff 
WHERE depart = '비서실';

SELECT MAX(salary) 
FROM tStaff 
WHERE depart = '비서실';

SELECT '영업부', AVG(salary) 
FROM tStaff 
WHERE depart='영업부';

SELECT '총무부', AVG(salary) 
FROM tStaff 
WHERE depart='총무부';

SELECT '인사과', AVG(salary) 
FROM tStaff 
WHERE depart='인사과';

SELECT depart, AVG(salary) 
FROM tStaff 
GROUP BY depart;

SELECT depart, COUNT(*), MAX(joindate), AVG(score) 
FROM tStaff 
GROUP BY depart; 

SELECT depart, gender, COUNT(*) 
FROM tStaff 
GROUP BY depart, gender;

SELECT depart, gender, COUNT(*) 
FROM tStaff 
GROUP BY depart, gender 
ORDER BY depart, gender;

SELECT depart, salary 
FROM tStaff 
GROUP BY depart;

SELECT depart, AVG(salary) 
FROM tStaff 
GROUP BY depart 
HAVING AVG(salary) >= 340;

SELECT depart, AVG(salary) 
FROM tStaff 
GROUP BY depart 
HAVING AVG(salary) >= 340 
ORDER BY AVG(salary);

SELECT depart, MAX(salary) 
FROM tStaff 
WHERE depart IN ('인사과', '영업부') 
GROUP BY depart;

SELECT depart, MAX(salary) 
FROM tStaff 
GROUP BY depart 
HAVING depart IN ('인사과', '영업부');


SELECT ROW_NUMBER( ) OVER(ORDER BY birthyear ASC) '나이가 많은 순서', name, birthyear
FROM usertbl;

SELECT ROW_NUMBER( ) OVER(ORDER BY birthyear ASC, name ASC) '나이가 많은 순서', name, birthyear
FROM usertbl;

SELECT ROW_NUMBER( ) OVER(PARTITION BY addr ORDER BY birthyear ASC) '나이가 많은 순서', addr, name, birthyear
FROM usertbl;


SELECT DENSE_RANK( ) OVER(ORDER BY birthyear ASC) '나이가 많은 순서', name, birthyear
FROM usertbl;


SELECT RANK( ) OVER(ORDER BY birthyear ASC) '나이가 많은 순서', name, birthyear
FROM usertbl;

SELECT NTILE(5) OVER(ORDER BY birthyear ASC) '나이가 많은 순서', name, birthyear
FROM usertbl;

SELECT name, addr, birthyear AS "태어난 해", birthyear - (LEAD(birthyear, 1) OVER(ORDER BY birthyear desc)) as "나이 차이"
FROM usertbl;

SELECT name, addr, birthyear AS "태어난 해", birthyear - (LAG(birthyear, 1) OVER(ORDER BY birthyear desc)) as "나이 차이"
FROM usertbl;

SELECT name, addr, birthyear AS "태어난 해", birthyear - (FIRST_VALUE(birthyear) OVER(PARTITION BY addr ORDER BY birthyear desc)) as "나이 차이"
FROM usertbl;

SELECT name, addr, birthyear AS "태어난 해", CUME_DIST() OVER(PARTITION BY addr ORDER BY birthyear desc) * 100 AS "누적인원 백분율"
FROM usertbl;

CREATE TABLE pivotTest
   (  uName CHAR(20),
      season CHAR(20),
      amount INT );
     
INSERT  INTO  pivotTest VALUES
	('aespa' , '겨울',  10) , ('블랙핑크' , '여름',  15) , ('aespa' , '가을',  25) , ('aespa' , '봄',    3) ,
	('aespa' , '봄',    37) , ('블랙핑크' , '겨울',  40) , ('aespa' , '여름',  14) ,('aespa' , '겨울',  22) ,
	('블랙핑크' , '여름',  64) ;

SELECT * FROM pivotTest;

SELECT uName, 
  SUM(IF(season='봄', amount, 0)) AS '봄', 
  SUM(IF(season='여름', amount, 0)) AS '여름',
  SUM(IF(season='가을', amount, 0)) AS '가을',
  SUM(IF(season='겨울', amount, 0)) AS '겨울',
  SUM(amount) AS '합계' 
 FROM pivotTest 
GROUP BY uName ;

SELECT JSON_OBJECT('name', name, 'birthyear', birthyear) AS 'JSON 값'
FROM usertbl 
WHERE birthyear >= 1980;

-- JSON 함수 사용
SET @json='{ "usertbl" :
  [
	{"name":"카리나","birthyear":2000},
	{"name":"지젤","birthyear":2000},
	{"name":"윈터","birthyear":2001},
    {"name":"닝닝","birthyear":2002}
  ]
}' ;


SELECT JSON_VALID(@json);

SELECT JSON_SEARCH(@json, 'one', '카리나');

SELECT JSON_EXTRACT(@json, '$.usertbl[2].name');

SELECT JSON_INSERT(@json, '$.usertbl[0].mDate', '2000-04-01');

SELECT JSON_REPLACE(@json, '$.usertbl[0].name', '유지민');

SELECT JSON_REMOVE(@json, '$.usertbl[0]');








