INSERT INTO tCity 
VALUES ('평택', 453, 51, 'n', '경기');

SELECT * 
FROM tCity;

TRUNCATE TABLE tCity;

INSERT INTO tCity (name, area, popu, metro, region) VALUES 
('서울',605,974,'y','경기'), 
('부산',765,342,'y','경상'),
('오산',42,21,'n','경기'),
('청주',940,83,'n','충청'),
('전주',205,65,'n','전라'),
('순천',910,27,'n','전라'),
('춘천',1116,27,'n','강원'),
('홍천',1819,7,'n','강원');

INSERT INTO tStaff(name, depart, gender, joindate, grade, salary, score)
SELECT name, region, metro, '20210629', '신입', area, popu 
FROM tCity 
WHERE region = '경기';

CREATE TABLE tSudo 
AS 
SELECT name, area, popu 
FROM tCity 
WHERE region = '경기';

SELECT * FROM tSudo;

CREATE TABLE tCityCopy 
AS 
SELECT *
FROM tCity;

-- 샘플 데이터 생성
CREATE TABLE memberTBL(SELECT userID, name, addr FROM usertbl LIMIT 3);

ALTER TABLE memberTBL
ADD CONSTRAINT pk_memberTBL PRIMARY KEY (userID);

SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('karina', '카리나', '수원' );
INSERT INTO memberTBL VALUES('winter', '윈터', '부산' );
INSERT INTO memberTBL VALUES('vivian', '닝닝', '하얼빈' );

SELECT * FROM memberTBL;

INSERT INTO memberTBL VALUES('karina', '카리나', '수원' );
INSERT INTO memberTBL VALUES('aeri', '지젤', '서울' );
SELECT * FROM memberTBL;

INSERT IGNORE INTO memberTBL VALUES('karina', '카리나', '수원' );
INSERT IGNORE INTO memberTBL VALUES('aeri', '지젤', '서울' );
SELECT * FROM memberTBL;


DELETE FROM tCity 
WHERE name = '부산';

DELETE FROM tCity 
WHERE region = '경기';

DELETE FROM tCity;

SELECT * FROM tCity 
WHERE popu > 50;

ROLLBACK;

UPDATE tCity 
SET popu = 1000, region = '충청' 
WHERE name = '서울';

UPDATE tCity 
SET popu = 1000, region = '충청';

UPDATE tCity 
SET popu = popu * 2 
WHERE name = '오산';

ROLLBACK;


DROP TABLE DEPT01;

CREATE TABLE DEPT01
AS
SELECT *
FROM DEPT;

DELETE FROM DEPT01;

SELECT *
FROM DEPT01;

ROLLBACK;

SELECT *
FROM DEPT01;

DELETE FROM DEPT01 
WHERE DEPTNO=20;

SELECT *
FROM DEPT01;

COMMIT;

SELECT *
FROM DEPT01;

DELETE FROM DEPT01
WHERE DEPTNO=40;

DROP TABLE DEPT02;

CREATE TABLE DEPT02
AS 
SELECT * FROM DEPT;

ROLLBACK;

SELECT *
FROM DEPT01;

DELETE FROM DEPT02
WHERE DEPTNO=30;

TRUNCATE TABLE DEPTPPP;

ROLLBACK;

SELECT *
FROM DEPT02;

DROP TABLE DEPT01;

CREATE TABLE DEPT01
AS
SELECT *
FROM DEPT;

DELETE FROM DEPT01
WHERE DEPTNO=40;

COMMIT;

DELETE FROM DEPT01 
WHERE DEPTNO=30; 

SAVEPOINT C1; 

DELETE FROM DEPT01 
WHERE DEPTNO =20; 

SAVEPOINT C2; 

DELETE FROM DEPT01 
WHERE DEPTNO =10; 

ROLLBACK TO C2; 

SELECT *
FROM DEPT01;

ROLLBACK;

SELECT *
FROM DEPT01;

















