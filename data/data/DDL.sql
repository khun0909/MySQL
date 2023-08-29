show character set;

show collation;

create table contact (
num integer auto_increment primary key,
name char(20),
address varchar(100),
tel char(20),
email char(100),
birthday date  
) ENGINE=MyISAM auto_increment=1 DEFAULT CHARSET=utf8;

alter table contact add age int;

desc contact;

alter table contact drop age;

desc contact;

alter table contact change tel phone int;

desc contact;

DROP TABLE contact;

SHOW TABLES;


CREATE TABLE tNullable
(
    name CHAR(10) NOT NULL,
    age INT
);

INSERT INTO tNullable (name, age) VALUES ('흥부', 36);
INSERT INTO tNullable (name) VALUES ('놀부');
INSERT INTO tNullable (age) VALUES (44); -- 에러

CREATE TABLE tCityDefault
(
	name CHAR(10) PRIMARY KEY,
	area INT NULL ,
	popu INT NULL ,
	metro CHAR(1) DEFAULT 'n' NOT NULL,
	region CHAR(6) NOT NULL
);

INSERT INTO tCityDefault (name, area, popu, region) VALUES ('진주', 712, 34, '경상');
INSERT INTO tCityDefault (name, area, popu, metro, region) VALUES ('인천', 1063, 295, 'y', '경기');

INSERT INTO tCityDefault VALUES ('강릉', 1111, 22, '강원');			-- 에러
INSERT INTO tCityDefault VALUES ('강릉', 1111, 22, DEFAULT, '강원');	-- 정상 실행

UPDATE tCityDefault SET metro = DEFAULT WHERE name = '인천'

SELECT *
FROM tCityDefault;


CREATE TABLE tCheckTest
(
	gender CHAR(3) NULL CHECK(gender = '남' OR gender = '여'),
	grade INT NULL CHECK (grade >= 1 AND grade <= 3),
	origin CHAR(3) NULL CHECK(origin IN ('동','서','남','북')),
	name CHAR(10) NULL CHECK(name LIKE '김%')
);

INSERT INTO tCheckTest (gender) VALUES ('여');
INSERT INTO tCheckTest (grade) VALUES (1);
INSERT INTO tCheckTest (origin) VALUES ('동');
INSERT INTO tCheckTest (name) VALUES ('김좌진');

INSERT INTO tCheckTest (gender) VALUES ('노');
INSERT INTO tCheckTest (grade) VALUES (0);
INSERT INTO tCheckTest (origin) VALUES ('중');
INSERT INTO tCheckTest (name) VALUES ('청산리');

UPDATE tCheckTest SET grade = 4 WHERE grade IS NOT NULL;


CREATE TABLE tCityPK
(
	name CHAR(10),
	area INT NULL ,
	popu INT NULL ,
	metro CHAR(1) NOT NULL,
	region CHAR(6) NOT NULL,
	CONSTRAINT PK_tCity_name PRIMARY KEY(name)
); 

CREATE TABLE tCityCompoKey
(
	name CHAR(10) PRIMARY KEY,
	region CHAR(6) PRIMARY KEY,
	area INT NULL ,
	popu INT NULL ,
	metro CHAR(1) NOT NULL
);

CREATE TABLE tCityCompoKey
(
	name CHAR(10) NOT NULL,
	region CHAR(6) NOT NULL,
	area INT NULL ,
	popu INT NULL ,
	metro CHAR(1) NOT NULL,
	CONSTRAINT PK_tCity_name_region PRIMARY KEY (name, region)
);

INSERT INTO tCityCompoKey VALUES ('광주', '전라', 123, 456, 'y');
INSERT INTO tCityCompoKey VALUES ('광주', '경기', 123, 456, 'n');

CREATE TABLE tCityUnique
(
	name CHAR(10) PRIMARY KEY,
	area INT NULL ,
	popu INT NULL,
	metro CHAR(1) NOT NULL,
	region CHAR(6) NOT NULL,
	CONSTRAINT Unique_tCity_area_popu UNIQUE(area, popu)
);


CREATE TABLE tSale
(
	saleno INT AUTO_INCREMENT PRIMARY KEY,
	customer NCHAR(10),
	product NCHAR(30)
);

INSERT INTO tSale (customer, product) 
VALUES ('단군', '지팡이');
INSERT INTO tSale (customer, product) 
VALUES ('고주몽', '고등어');

SELECT * FROM tSale;


DELETE FROM tSale 
WHERE saleno = 2;

INSERT INTO tSale (customer, product) 
VALUES ('박혁거세', '계란');

SELECT * 
FROM tSale;


INSERT INTO tSale (saleno, customer, product) 
VALUES (2, '고주몽', '고등어');


ALTER TABLE tSale AUTO_INCREMENT = 100;

INSERT INTO tSale (customer, product) 
VALUES ('왕건', '너구리');

UPDATE tSale 
SET product = '짜파게티' 
WHERE saleno = LAST_INSERT_ID();

SELECT * 
FROM tSale;


CREATE TABLE tEmployee
(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES ('아이린', 650, '대구시');
INSERT INTO tEmployee VALUES ('슬기', 480, '안산시');
INSERT INTO tEmployee VALUES ('웬디', 625, '서울시');

CREATE TABLE tProject
(
	projectID INT PRIMARY KEY,
	employee CHAR(10) NOT NULL,
	project VARCHAR(30) NOT NULL,
	cost INT
);

INSERT INTO tProject VALUES (1, '아이린', '홍콩 수출건', 800);
INSERT INTO tProject VALUES (2, '아이린', 'TV 광고건', 3400);
INSERT INTO tProject VALUES (3, '아이린', '매출분석건', 200);
INSERT INTO tProject VALUES (4, '슬기', '경영 혁신안 작성', 120);
INSERT INTO tProject VALUES (5, '슬기', '대리점 계획', 85);
INSERT INTO tProject VALUES (6, '웬디', '노조 협상건', 24);

INSERT INTO tProject VALUES (7, '조이', '원자재 매입', 900);

DELETE FROM tEmployee WHERE name = '아이린';

DROP TABLE tProject;
DROP TABLE tEmployee;

CREATE TABLE tEmployee
(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES ('아이린', 650, '대구시');
INSERT INTO tEmployee VALUES ('슬기', 480, '안산시');
INSERT INTO tEmployee VALUES ('웬디', 625, '서울시');

CREATE TABLE tProject
(
	projectID INT PRIMARY KEY,
	employee CHAR(10) NOT NULL,
	project VARCHAR(30) NOT NULL,
	cost INT,
	CONSTRAINT FK_emp FOREIGN KEY(employee) REFERENCES tEmployee(name)
);

INSERT INTO tProject VALUES (1, '아이린', '홍콩 수출건', 800);
INSERT INTO tProject VALUES (2, '아이린', 'TV 광고건', 3400);
INSERT INTO tProject VALUES (3, '아이린', '매출분석건', 200);
INSERT INTO tProject VALUES (4, '슬기', '경영 혁신안 작성', 120);
INSERT INTO tProject VALUES (5, '슬기', '대리점 계획', 85);
INSERT INTO tProject VALUES (6, '웬디', '노조 협상건', 24);


INSERT INTO tProject VALUES (7, '조이', '원자재 매입', 900);

DELETE FROM tEmployee WHERE name = '아이린';


INSERT INTO tEmployee VALUES ('조이', 330, '제주');
INSERT INTO tProject VALUES (7, '조이', '원자재 매입', 900);

DELETE FROM tProject WHERE employee = '아이린';
DELETE FROM tEmployee WHERE name = '아이린';

DROP TABLE tEmployee;


DROP TABLE tProject;
DROP TABLE tEmployee;

CREATE TABLE tEmployee
(
	name CHAR(10) PRIMARY KEY,
	salary INT NOT NULL,
	addr VARCHAR(30) NOT NULL
);

INSERT INTO tEmployee VALUES ('아이린', 650, '대구시');
INSERT INTO tEmployee VALUES ('슬기', 480, '안산시');
INSERT INTO tEmployee VALUES ('웬디', 625, '서울시');

CREATE TABLE tProject
(
	projectID INT PRIMARY KEY,
	employee CHAR(10) NOT NULL,
	project VARCHAR(30) NOT NULL,
	cost INT,
	CONSTRAINT FK_emp FOREIGN KEY(employee) REFERENCES tEmployee(name)
	ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO tProject VALUES (1, '아이린', '홍콩 수출건', 800);
INSERT INTO tProject VALUES (2, '아이린', 'TV 광고건', 3400);
INSERT INTO tProject VALUES (3, '아이린', '매출분석건', 200);
INSERT INTO tProject VALUES (4, '슬기', '경영 혁신안 작성', 120);
INSERT INTO tProject VALUES (5, '슬기', '대리점 계획', 85);
INSERT INTO tProject VALUES (6, '웬디', '노조 협상건', 24);


DELETE FROM tEmployee WHERE name = '아이린';

SELECT * FROM tEmployee;

SELECT * FROM tProject;

UPDATE tEmployee 
SET name = '조이', salary=330, addr='제주' 
WHERE Name = '웬디';

SELECT * FROM tEmployee;

SELECT * FROM tProject;

-- 회원 테이블
CREATE TABLE tMember
(
    member VARCHAR(20) PRIMARY KEY, 	-- 아이디
    age INT NOT NULL,                      	-- 나이 
    email VARCHAR(30) NOT NULL,           	-- 이메일
    ADDr VARCHAR(50) NOT NULL,            	-- 주소
    money INT DEFAULT 1000 NOT NULL,     	-- 예치금
    grade INT DEFAULT 1 NOT NULL,         	-- 고객등급. 1=준회원, 2=정회원, 3=우수회원
    remark VARCHAR(100) NULL             	-- 메모 사항
);

-- 회원 데이터
INSERT INTO tMember VALUES ('춘향',16,'1004@naver.com','전남 남원시',20000, 2, '');
INSERT INTO tMember VALUES ('이도령',18,'wolf@gmail.com','서울 신사동',150000, 3, '');
INSERT INTO tMember VALUES ('향단',25,'candy@daum.net','전남 남원시',5000, 2, '');
INSERT INTO tMember VALUES ('방자',28,'devlin@ssang.co.kr','서울 개포동',1000, 1, '요주의 고객');

-- 상품 분류 테이블
CREATE TABLE tCategory
(
   category VARCHAR(10) PRIMARY KEY,	-- 분류명
   discount INT NOT NULL,			-- 할인율
   delivery INT NOT NULL,                   	-- 배송비
   takeback CHAR(1)                         	-- 반품 가능성
);

-- 분류 데이터
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('식품', 0, 3000, 'n');
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('패션', 10, 2000, 'y');
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('가전', 20, 2500, 'y');
INSERT INTO tCategory (category, discount, delivery, takeback) VALUES ('성인', 5, 1000, 'n');

-- 상품 테이블
CREATE TABLE tItem
(
    item VARCHAR(20) PRIMARY KEY,   	-- 상품명
    company VARCHAR(20) NULL,            	-- 제조사
    num INT NOT NULL,                      	-- 재고
    price INT NOT NULL,                     	-- 정가
    category VARCHAR(10) NOT NULL,       	-- 분류
    CONSTRAINT item_fk FOREIGN KEY(category) REFERENCES tCategory(category)
);

-- 상품 데이터
INSERT INTO tItem (item,company,num,price,category) VALUES ('노트북', '샘성', 3, 820000, '가전');
INSERT INTO tItem (item,company,num,price,category) VALUES ('청바지', '방방', 80, 32000, '패션');
INSERT INTO tItem (item,company,num,price,category) VALUES ('사과', '문경농원', 24, 16000, '식품');
INSERT INTO tItem (item,company,num,price,category) VALUES ('대추', '보은농원', 19, 15000, '식품');
INSERT INTO tItem (item,company,num,price,category) VALUES ('전자담배', 'TNG', 4, 70000, '성인');
INSERT INTO tItem (item,company,num,price,category) VALUES ('마우스', '논리텍', 3, 90000, '가전');

CREATE TABLE tOrder
(
  orderID INT AUTO_INCREMENT PRIMARY KEY,	-- 주문 번호
  member VARCHAR(20) NOT NULL REFERENCES tMember(member),   	-- 주문자
  item VARCHAR(20) NOT NULL REFERENCES tItem(item),			-- 상품
  orderDate DATE DEFAULT SYSDATE() NOT NULL,	-- 주문 날자
  num INT NOT NULL,				-- 개수
  status INT DEFAULT 1 NOT NULL,			-- 1:주문, 2:배송중, 3:배송완료, 4:반품
  remark VARCHAR(1000) NULL			-- 메모 사항
);

-- 주문 데이터
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('춘향','청바지','2019-12-3',3,2);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('향단','대추','2019-12-4',10,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('방자','전자담배','2019-12-2',4,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('향단','사과','2019-12-5',5,2);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('이도령','노트북','2019-12-5',2,1);
INSERT INTO tOrder (member,item,orderDate,num,status) VALUES ('방자','노트북','2019-12-1',1,3);



