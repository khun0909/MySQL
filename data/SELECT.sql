-- 데이터베이스 연결(p184~)
use emp_db ;  -- 데이터베이스 선택

--  일반 조회
--  1. SELECT * FROM 테이블명(p187~);
SELECT * FROM tcity;

--  2. SELECT 컬럼명 FROM 테이블명;
SELECT name, area, popu FROM tcity;

--  3. SELECT 컬럼명 AS 별칭 FROM 테이블명;
SELECT name AS 도시명, area AS '면적(제곱Km)', popu AS '인구(만명)', metro AS 대도시, region AS 지역
FROM tcity;

-- 4. 계산식을 이용한 결과 출력
SELECT name AS 도시명, popu * 10000 AS '인구(명)', area * 0.3025 AS '면적(제곱마일)' FROM tcity;

SELECT name, area, popu, popu * 10000/area AS '인구밀도(명/제곱Km)' FROM tcity;

-- 5. 상수를 이용한 결과 출력
SELECT 60 * 60 * 24 AS '1일(초)', 60 * 60 * 24 * 365 AS '1년(초)';

-- 6. CONCAT() 함수를 이용해 필드값을 연결하여 출력
SELECT CONCAT(name, '(', region, ')') AS '도시명(지역)', area, metro FROM tcity;

-- 7. DISTINCT를 이용해 중복된 데이터를 제거하여 출력
SELECT region from tcity;

SELECT DISTINCT region FROM tcity;

-- 8. ORDER BY를 이용해 정렬하여 출력(ASC: 오름차순, DESC: 내림차순)
SELECT name, area, popu FROM tcity ORDER BY area;

SELECT name, area, popu FROM tcity ORDER BY area DESC;

select name, area, popu, metro from tcity order by region, name desc;

-- 9. 계산식을 이용한 정렬
SELECT name, area, popu, popu * 10000/area AS '인구밀도(명/제곱Km)' 
FROM tcity 
ORDER BY popu * 10000/area DESC;

-- 문제: 직원 목록을 월급이 적은 사람부터 순서대로 출력하되 월급이 같다면 성취도가 높은 사람을 먼저 조회
SELECT * FROM tstaff ORDER BY salary, score DESC;

-- 10. WHERE를 이용한 조건 검색(p200~)
SELECT * FROM tcity WHERE region = '서울';

-- 광역시 데이터 조회
SELECT * FROM tcity WHERE metro = 'y';

SELECT * FROM tcity WHERE area >= 1000;

-- 문제: 월급이 400만원 이상인 직원의 이름 조회(월급이 높은 순서대로)
SELECT name, salary FROM tstaff WHERE salary >= 400 ORDER BY salary DESC;

-- null 데이터 조회
SELECT * FROM tstaff WHERE score IS NULL;

SELECT * FROM tstaff WHERE score IS NOT NULL; -- NULL이 아닌 데이터 조회

-- 11. AND, OR, NOT을 이용한 조건 검색(p201~)
SELECT * FROM tcity WHERE popu >= 100 AND area >= 700;

SELECT * FROM tcity WHERE region='강원' AND popu >= 20 or area >= 500;

SELECT * FROM tcity WHERE region='강원' AND (popu >= 20 or area >= 500);

SELECT * FROM tcity WHERE region !='강원';
SELECT * FROM tcity WHERE NOT(region ='강원');

SELECT * FROM tcity WHERE region !='강원' AND region !='경기';
SELECT * FROM tcity WHERE NOT(region ='강원' OR region ='경기');

-- 문제: tstaff에서 영업부의 여직원 이름을 조회
SELECT * FROM tstaff 
WHERE depart = '영업부' AND gender = '여' 
ORDER BY score DESC;

-- 12. LIKE를 이용한 문자열 검색
-- 1) 문자열의 일부분을 검색(문자열의 앞부분)
SELECT * FROM tstaff WHERE name LIKE '김%';

-- 2) 문자열의 일부분을 검색('길'이 포함된 문자열)
SELECT * FROM tstaff WHERE name LIKE '%길%';

-- 3) 문자열의 일부분을 검색(두번째 글자가 '길'인 데이터)
SELECT * FROM tstaff WHERE name LIKE '_길%';

-- 13. BETWEEN을 이용한 범위 검색(p201~)
SELECT * FROM tstaff WHERE score BETWEEN 70 AND 90;

SELECT * FROM tstaff WHERE score >= 70 AND score <= 90;

SELECT * FROM tstaff WHERE name BETWEEN '가' and '사'

SELECT * FROM tstaff WHERE joindate BETWEEN '2019-01-01' AND '2019-12-31';

-- 14. IN을 이용한 범위 검색
SELECT * FROM tstaff WHERE grade IN ('사원', '대리', '과장');

SELECT * FROM tstaff WHERE grade = '사원' OR grade = '대리' OR grade = '과장';

SELECT * FROM tstaff WHERE grade NOT IN ('사원', '대리', '과장');

SELECT * FROM tstaff WHERE name LIKE '김%' or name LIKE '이%';

-- 15. LIMIT을 이용한 데이터 출력 개수 제한(p205~)
SELECT * FROM tstaff ORDER BY score DESC LIMIT 5;  -- 1~5번째 데이터 출력

SELECT * FROM tstaff ORDER BY score DESC LIMIT 5, 5; -- 6번째부터 5개 데이터 출력

SELECT * FROM tstaff ORDER BY score DESC LIMIT 5 OFFSET 5; -- 6번째부터 5개 데이터 출력

-- 16. scala 함수
SELECT * FROM emp WHERE MOD(empno, 2) = 1;  -- 짝수 사번(짝수면 0, 홀수면 1)

select name, length(name) from usertbl;  -- 문자열의 길이

select SUBSTRING(HIREDATE, 1, 4) 년도, SUBSTRING(HIREDATE, 6, 2) 월 from emp;  -- 문자열의 일부분 추출

-- 날짜 관련 함수
SELECT CURDATE();  -- 현재 날짜
SELECT CURTIME();  -- 현재 시간

SELECT DATEDIFF(CURDATE(), '2000-01-01')

SELECT STR_TO_DATE('2020-01-01', '%Y-%m-%d')  -- 문자열을 날짜로 변환

SELECT DATE_FORMAT(CURDATE(), '%Y-%m-%d')  -- 날짜를 문자열로 변환

-- 17. 데이터 집계 함수
SELECT COUNT(*) as 직원수 FROM tstaff;  -- 데이터 개수
SELECT ROUND(AVG(score), 2) as 평균점수 FROM tstaff;  -- 평균 점수

-- 남녀 평균 점수
SELECT ROUND(AVG(score), 2) as 남자평균점수 FROM tstaff WHERE gender = '남'; 

SELECT ROUND(AVG(score), 2) as '평균점수(여자)' FROM tstaff WHERE gender = '여'; 

SELECT COUNT(DISTINCT depart) as 부서수 FROM tstaff;  -- 부서 수

-- 18. 그룹별 계산(GROUP BY)-(p211~)
SELECT depart, ROUND(AVG(salary), 1) as 평균급여 FROM tstaff GROUP BY depart;  -- 부서별 급여 평균

-- 여러개의 그룹핑(집계함수 다수 사용)-(p2013~)
SELECT depart, count(*), MAX(joindate), AVG(score), SUM(salary) 
FROM tstaff GROUP BY depart;

-- [문제] 도시 목록에서 지역별 인구수를 조회
SELECT region, sum(popu) FROM tcity GROUP BY region;

-- [문제] 직원 정보에서 직급별 인원수를 조회후 사용자가 입력한 순서대로 정렬
SELECT grade, count(*) FROM tstaff GROUP BY grade
ORDER BY grade;

SELECT grade, count(*) FROM tstaff GROUP BY grade
ORDER BY FIELD(grade, '사원', '대리', '과장', '차장', '부장', '이사') DESC;


-- 두개 이상의 필드를 이용해 GROUP BY 진행
SELECT depart, grade, count(*) FROM tstaff 
GROUP BY depart, grade
ORDER BY depart, FIELD(grade, '사원', '대리', '과장', '차장', '부장', '이사') DESC;

-- 19. HAVING을 이용한 그룹핑(그룹핑된 데이터를 조건으로 검색)-(p215~)
SELECT depart, grade, count(*) 
FROM tstaff
GROUP BY depart, grade
HAVING count(*) >= 2
ORDER BY depart;

-- 20. GROUP BY와 HAVING을 이용한 문제
SELECT depart, MAX(salary) 
FROM tstaff 
WHERE depart IN ('영업부','인사과')
GROUP BY depart;

SELECT depart, MAX(salary) 
FROM tstaff 
GROUP BY depart
HAVING depart IN ('영업부','인사과')

-- 21. pivot을 이용한 데이터 변환
-- 1) 테이블 생성
CREATE TABLE pivotTest(
    uName CHAR(20),
    season CHAR(20),
    amount INT
);

-- 2) 데이터 입력
INSERT INTO pivotTest VALUES
    ('aespa', '겨울', 10), 
    ('블랙핑크', '여름', 15) , 
    ('aespa', '가을', 25) , 
    ('aespa', '봄', 3) ,
	('aespa', '봄', 37) , 
    ('블랙핑크', '겨울', 40) , 
    ('aespa', '여름', 14) ,
    ('aespa', '겨울', 22) ,
	('블랙핑크', '여름', 64);

SELECT * FROM pivotTest;

-- 3) pivot을 이용한 데이터 집계
SELECT uName, 
  SUM(IF(season='봄', amount, 0)) AS '봄', 
  SUM(IF(season='여름', amount, 0)) AS '여름',
  SUM(IF(season='가을', amount, 0)) AS '가을',
  SUM(IF(season='겨울', amount, 0)) AS '겨울',
  SUM(amount) AS '합계' 
 FROM pivotTest 
GROUP BY uName ;

-- JSON_OBJECT: JOIN 데이터로 정보 제공
SELECT JSON_OBJECT('name', name, 'birthyear', birthyear) AS 'JSON 값'
FROM usertbl 
WHERE birthyear >= 1980;

-- json 하수 사용
set @json = "{'usertbl':[
    {'name':'김철수', 'birthyear':1980},
    {'name':'이영희', 'birthyear':1985},
    {'name':'박영수', 'birthyear':1990}
    ]
}";

SELECT JSON_VALUE(@json, '$.usertbl[0].name') AS '첫번째 이름',
    JSON_VALUE(@json, '$.usertbl[1].name') AS '두번째 이름',
    JSON_VALUE(@json, '$.usertbl[2].name') AS '세번째 이름';


