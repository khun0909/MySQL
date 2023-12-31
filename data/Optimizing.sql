SHOW INDEX FROM EMP; 

CREATE TABLE IndexTable ( 
	a INT PRIMARY KEY,
	b INT UNIQUE, 
	c INT UNIQUE, 
	d INT
);

SHOW INDEX FROM IndexTable;

CREATE INDEX IDX_EMP_ENAME
ON EMP(ENAME);

DROP INDEX IDX_EMP_ENAME 
ON EMP;

CREATE INDEX IDX_DEPT_COM
ON DEPT(DEPTNO, DNAME);

SHOW INDEX FROM DEPT;

SELECT /*+ use_nl(d) */ *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.DEPTNO = 10;

SELECT /*+ ordered use_merge(d) */ *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.DEPTNO = 10;

SELECT /*+  use_hash(d) */ *
FROM EMP e, DEPT d
WHERE e.DEPTNO = d.DEPTNO AND e.DEPTNO = 10;


CREATE TABLE sales
        (sales_no INT,
         sale_year INT NOT NULL,
         sale_month INT NOT NULL,
         sale_day INT NOT NULL,
         customer_name  VARCHAR(30),
         price INT)
       PARTITION BY RANGE (sale_year)
       (PARTITION sales_q1 VALUES LESS THAN (2005),
        PARTITION sales_q2 VALUES LESS THAN (2009),
        PARTITION sales_q4 VALUES LESS THAN MAXVALUE);
       

INSERT INTO sales VALUES(1, 2004, 06, 12, 'scott', 2500);
INSERT INTO sales VALUES(2, 2005, 06, 17, 'jones', 4300);
INSERT INTO sales VALUES(3, 2005, 12, 12, 'miller', 1200);
INSERT INTO sales VALUES(4, 2006, 06, 22, 'ford', 5200);
INSERT INTO sales VALUES(5, 2005, 01, 01, 'lion', 2200); 
INSERT INTO sales VALUES(6, 2006, 12, 22, 'tiger', 3300);
INSERT INTO sales VALUES(7, 2010, 11, 11, 'adam', 3800);

SELECT *
FROM sales;

SELECT TABLE_SCHEMA, TABLE_NAME, PARTITION_NAME, PARTITION_ORDINAL_POSITION, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME =  'sales';

SELECT * FROM sales PARTITION (sales_q2);
 

ALTER TABLE sales
REORGANIZE PARTITION sales_q4 INTO (
PARTITION sales_q3 VALUES LESS THAN MAXVALUE);

CREATE TABLE employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)
PARTITION BY LIST(store_id) (
    PARTITION pNorth VALUES IN (3,5,6,9,17),
    PARTITION pEast VALUES IN (1,2,10,11,19,20),
    PARTITION pWest VALUES IN (4,12,13,14,18),
    PARTITION pCentral VALUES IN (7,8,15,16)
);

CREATE TABLE hash_employees (
    id INT NOT NULL,
    fname VARCHAR(30),
    lname VARCHAR(30),
    hired DATE NOT NULL DEFAULT '1970-01-01',
    separated DATE NOT NULL DEFAULT '9999-12-31',
    job_code INT,
    store_id INT
)
PARTITION BY HASH( YEAR(hired) )
PARTITIONS 4;

CREATE TABLE k1 (
    id INT NOT NULL,
    name VARCHAR(20),
    UNIQUE KEY (id)
)
PARTITION BY KEY()
PARTITIONS 2;


ALTER TABLE sales
REORGANIZE PARTITION sales_q4 INTO (
PARTITION sales_q3 VALUES LESS THAN MAXVALUE);   

SELECT *
FROM INFORMATION_SCHEMA.INNODB_FT_DEFAULT_STOPWORD;

