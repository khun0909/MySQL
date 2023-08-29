--  ============  Sub QUERY  ==============================

use emp_db;  -- 데이터베이스 선택

-- 1. set 연산자: UNION, UNION ALL, INTERSECT, EXCEPT

SELECT deptno from dept;
SELECT deptno from emp;

-- 1) UNION: 합집합: 두 테이블에서 동시에 검색된 결과 모두 출력
SELECT DEPTNO FROM dept UNION SELECT DEPTNO FROM emp; 

-- 2) UNION ALL: 합집합: 두 테이블에서 동시에 검색된 결과 모두 출력
SELECT DEPTNO FROM dept UNION ALL SELECT DEPTNO FROM emp; 

-- 3) INTERSECT: 교집합: 두 테이블에서 동시에 검색된 결과 중 중복된 데이터만 출력
SELECT DEPTNO FROM dept INTERSECT SELECT DEPTNO FROM emp; 

-- 4) EXCEPT: 차집합: 첫번째 테이블에서 검색된 결과 중 두번째 테이블에서 검색된 결과를 제외한 데이터만 출력
SELECT DEPTNO FROM dept EXCEPT SELECT DEPTNO FROM emp;


-- 2. sub query: 서브 쿼리: 쿼리문 안에 쿼리문이 존재하는 것
SELECT * FROM dept WHERE DEPTNO = (SELECT DEPTNO FROM emp WHERE ENAME = 'MILLER');

-- 1) 단일 행 서브 쿼리: 서브 쿼리의 결과가 단일 행으로 나오는 경우
SELECT avg(sal) FROM emp;
SELECT ENAME, sal FROM emp WHERE sal > (SELECT avg(SAL) FROM emp);

-- [문제] EMP 테이블에서 ENAME이 MILLER인 데이터와 같은 부서(DEPTNO)에서 근무하는 사원의 이름(ENAME)과 부서 번호(DEPTNO)를 출력하는 SQL 문을 작성
select ename, deptno from emp WHERE DEPTNO = (SELECT DEPTNO FROM emp WHERE ENAME = 'MILLER');

-- [문제] EMP 테이블에서 직속상관(MGR)의 이름이 KING인 사원의 이름(ENAME)과 급여(SAL)를 출력 
SELECT ENAME, SAL FROM emp WHERE MGR = (SELECT EMPNO FROM emp WHERE ENAME = 'KING');

-- 2) 다중 열 서브 쿼리: 서브 쿼리의 결과가 다중 열로 나오는 경우
SELECT * FROM tstaff WHERE(depart, gender) = (SELECT depart, gender FROM tstaff WHERE name = '안중근');

SELECT * FROM tstaff 
WHERE depart = (SELECT depart FROM tstaff WHERE name = '안중근')
  AND gender = (SELECT gender FROM tstaff WHERE name = '안중근');

-- 3) IN 연산자: 서브 쿼리의 결과가 여러 행 중에서 하나만 일치하면 출력
-- EMP 테이블에서 부서(DEPTNO)별로 가장 급여를 많이 받는 사원들과 동일한 급여를 받는 
-- 사원 번호(EMPNO), 사원이름(ENAME), 급여(SAL), 부서번호(DEPTNO)를 출력
SELECT empno, ename, sal, deptno FROM emp WHERE sal IN (SELECT max(sal) FROM emp GROUP BY deptno);

SELECT ename, sal, deptno FROM emp 
WHERE DEPTNO in (SELECT DISTINCT DEPTNO FROM emp WHERE sal >=3000);

-- 4) ALL 연산자: 서브 쿼리의 결과가 모두 일치하면 출력
-- DEPTNO가 30번인 소속 사원들 중에서 급여를 가장 많이 받는 사원보다 더 많은 급여를 받는 사람의 
-- 이름, 급여를 출력하는 쿼리문을 작성

SELECT ENAME, SAL FROM EMP

-- 5) ANY 연산자: 서브 쿼리의 결과가 하나라도 일치하면 출력
-- DEPTNO가 30번인 소속 사원들 중에서 급여가 가장 작은값 보다 많은 급여를 받는 사람의 이름, 급여 조회

SELECT ENAME, SAL FROM EMP WHERE SAL > ANY ( SELECT SAL FROM EMP 
                                                WHERE DEPTNO = 30 );

SELECT ENAME, SAL FROM EMP WHERE SAL > ( SELECT MIN(SAL) FROM EMP 
                                                WHERE DEPTNO = 30 );

-- 6) EXISTS 연산자: 서브 쿼리의 결과가 존재하면 출력(참/거짓)
-- EMP 테이블에서 SAL 이 2000 이 넘는 사원이 있으면 ENAME, SAL을 조회
SELECT ENAME, SAL FROM EMP WHERE EXISTS (SELECT 1 FROM EMP WHERE SAL > 2000);

-- 최고 급여를 받는 직원들 목록 출력
SELECT * FROM tstaff 
WHERE (depart, salary) IN (SELECT depart, max(salary) 
                           FROM tstaff GROUP BY depart);


-- ==================  JOIN  ==============================

-- 예제 테이블 생성 및 데이터 추가하기

-- 1. tcar 테이블 생성
CREATE TABLE TCAR
(
	car VARCHAR(30) NOT NULL,		-- 이름
	capacity INT NOT NULL,		-- 배기량
	price INT NOT NULL,			-- 가격
	maker VARCHAR(30) NOT NULL		-- 제조사
);


DESC tcar;

-- 2. tcar 테이블에 데이터 추가
INSERT INTO TCAR (car, capacity, price, maker) VALUES ('소나타', 2000, 2500, '현대');
INSERT INTO TCAR (car, capacity, price, maker) VALUES ('티볼리', 1600, 2300, '쌍용');
INSERT INTO TCAR (car, capacity, price, maker) VALUES ('A8', 3000, 4800, 'Audi');
INSERT INTO TCAR (car, capacity, price, maker) VALUES ('SM5', 2000, 2600, '삼성');

-- 3. tmaker 테이블 생성
CREATE TABLE tmaker(
    maker VARCHAR(30) NOT NULL,		-- 제조사
    factory char(10) NOT NULL,	-- 공장
    deomestic CHAR(1) NOT NULL	-- 국가
);

-- 4. tmaker 테이블에 데이터 추가
INSERT INTO tmaker VALUES ('현대', '울산', 'y'),
('쌍용', '용인', 'y`'),('Audi', '독일', 'n'), ('삼성', '광주', 'y'),
('BMW', '독일', 'n'), ('벤츠', '독일', 'n'), ('기아', '서울', 'y');

-- 6. 테이블 정보 확인
DESC tmaker;

-- 5. tcar 테이블과 tmaker 테이블의 데이터를 조회
SELECT * FROM tcar;

SELECT * FROM tmaker;

COMMIT;


-- JOIN: 두 개 이상의 테이블을 연결하여 데이터를 검색하는 방법

SELECT * FROM emp WHERE `ENAME` = 'MILLER'; -- MILLER의 부서번호(DEPTNO)에 따른 부서명 출력

-- 1. CROSS JOIN: 모든 행을 다 출력
SELECT * FROM emp, dept; -- CROSS JOIN: 모든 행을 다 출력

-- 2. EQUI JOIN: 조인 조건에 맞는 행만 출력
-- emp, dept의 DEPTNO가 같은 행만 출력
SELECT * FROM emp, dept WHERE emp.deptno = dept.deptno; -- EQUI JOIN: 조인 조건에 맞는 행만 출력

-- emp의 ename이 MILLE인 사원의 이름과 부서명 출력
SELECT emp.ename, dept.dname, emp.deptno from emp, dept WHERE emp.deptno = dept.deptno AND ename = 'MILLER';

SELECT ename, dname, e.deptno from emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'MILLER';

-- [문제] DEPT 테이블의 LOC가 ‘NEW YORK’ 인 사원의 EMP 테이블의 이름(ENAME)과 급여(SAL)를 조회
SELECT ename, sal FROM emp, dept WHERE emp.deptno = dept.deptno AND loc = 'NEW YORK';

-- [문제] EMP 테이블의 JOB이 ‘MANAGER’인 사원의 EMP 테이블의 ENAME, DEPT 테이블의 DNAME을 조회
SELECT ename, dname FROM emp, dept WHERE emp.deptno = dept.deptno AND job = 'MANAGER';

-- 3. HASH JOIN: 조인 조건에 맞는 행만 출력
SELECT /*+ HASH_JOIN(D) */ E.empno, E.ename, D.dname
FROM    DEPT D JOIN EMP E
on D.deptno = E.deptno;

-- 4. NON EQUI JOIN: 조인 조건에 맞는 행만 출력
SELECT ENAME, SAL, GRADE
FROM EMP, SALGRADE 
WHERE SAL BETWEEN LOSAL AND HISAL;


-- ===== INSERT, UPDATE, DELETE =====
-- 1. INSERT: 데이터 추가
-- 1) 테이블에 데이터 추가 기본

desc tcity;

insert into tcity VALUES('이천', 461, 21, 'n', '경기'), 
                        ('대구', 883, 248, 'y', '경북');
insert into tcity VALUES('영월', 0, 0,'n' , '경기'); 

SELECT * FROM tcity;

-- 2) SELECT를 이용해 조회한 데이터를 기존 테이블에 삽입
-- tCity 테이블에서 조회한 데이터를 tStaff 테이블에 삽입
SELECT name, region, metro, '20210629','신입', area, popu FROM tcity
WHERE region = '경기';

INSERT INTO tstaff(name, depart, gender, joindate, grade, salary, score) 
    SELECT name, region, metro, '20210629','신입', area, popu FROM tcity

SELECT * FROM tstaff;

-- 3) CREATE TABLE AS SELECT: 새로운 테이블을 생성하면서 데이터를 삽입
-- tCity 테이블에서 region이 경기 인 데이터의 name, area, popu 필드로 tSudo 테이블을 생성
CREATE TABLE tsudo AS 
    SELECT name, area, popu FROM tcity WHERE region = '경기';

SELECT * FROM tsudo;

DESC tsudo;

-- [문제] 성취도가 80점 이상인 직원만 골라 이름 과 월급에 대한 보고서를 별도의 테이블로 작성
CREATE TABLE treport AS 
    SELECT name, salary FROM tstaff WHERE score >= 80;

SELECT * FROM treport;

-- 3. DELETE 구문: 삭제 쿼리
-- 1) DELETE: 테이블의 모든 데이터 삭제
SELECT * FROM treport;
DELETE FROM treport; -- 테이블 초기화
SELECT * FROM treport;

-- 2) DELETE WHERE: 조건에 맞는 데이터만 삭제
SELECT * FROM tstaff;
DELETE FROM tstaff WHERE gender = 'y' or gender = 'n';
SELECT * FROM tstaff;

-- 4. UPDATE 구문: 수정 쿼리
-- 1) UPDATE: 테이블의 모든 데이터 수정
SELECT * FROM tsudo;
UPDATE tsudo SET area = 1124, popu = 4;
SELECT * FROM tsudo;

-- 2) UPDATE WHERE: 조건에 맞는 데이터만 수정
SELECT * FROM tcity WHERE name = '영월';
UPDATE tcity SET area = 1124, popu = 4 WHERE name = '영월';
SELECT * FROM tcity;

-- 5. ROLLBACK-트랜잭션 취소 / COMMIT-트랜잭션 확정 
SELECT @@autocommit; -- 1: 자동 커밋, 0: 수동 커밋 => 기본값 1
set autocommit = 0; -- 수동 커밋으로 변경
SELECT @@autocommit;

-- 1) ROLLBACK: 트랜잭션 취소
DELETE FROM tsudo; -- 테이블 초기화

ALTER TABLE tsudo ADD no int NOT NULL; -- no 필드 마지막 피드 뒤에 추가
SELECT * FROM tsudo;
insert into tsudo VALUES ( '이천', 100, 200, 1 ),( '대구', 100, 200, 2 );
SELECT * FROM tsudo;

insert into tsudo VALUES ( '영월', 100, 200, 3 );
SAVEPOINT A; -- SAVEPOINT: 트랜잭션의 중간에 저장점을 지정

insert into tsudo VALUES ( '평창', 100, 200, 4 );
SAVEPOINT B; -- SAVEPOINT: 트랜잭션의 중간에 저장점을 지정

SELECT * FROM tsudo;

UPDATE tsudo SET no=100 WHERE name = '평창';
SELECT * FROM tsudo;

ROLLBACK TO A; -- ROLLBACK: 트랜잭션 취소
SELECT * FROM tsudo;

COMMIT; -- COMMIT: 트랜잭션 확정/저장, ROLLBACK을 사용할 수 없다.

SELECT * FROM tsudo;


set autocommit = 1; -- 자동 커밋으로 변경
SELECT @@autocommit;





 