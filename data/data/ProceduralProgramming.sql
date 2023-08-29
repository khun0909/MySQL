DELIMITER //
CREATE PROCEDURE ifProc()
BEGIN
	DECLARE hireDATE DATE; -- 입사일
	DECLARE curDATE DATE; -- 오늘
	DECLARE days INT; -- 근무한 일수

	SELECT HIREDATE INTO hireDate -- hire_date 열의 결과를 hireDATE에 대입
	   FROM EMP
	   WHERE EMPNO = 7369;

	SET curDATE = CURRENT_DATE(); -- 현재 날짜
	SET days =  DATEDIFF(curDATE, hireDATE); -- 날짜의 차이, 일 단위

	IF (days/365) >= 5 THEN -- 5년이 지났다면
		  SELECT CONCAT('입사한지 5년이 지났습니다.');
	ELSE
		  SELECT '입사한지 아직 5년이 되지 않았습니다.' ;
	END IF;
END //
DELIMITER ;

CALL ifProc();

DELIMITER //
CREATE PROCEDURE ifElseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    IF point >= 90 THEN
		SET credit = 'A';
    ELSEIF point >= 80 THEN
		SET credit = 'B';
    ELSEIF point >= 70 THEN
		SET credit = 'C';
    ELSEIF point >= 60 THEN
		SET credit = 'D';
    ELSE
		SET credit = 'F';
    END IF;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END //
DELIMITER ;

CALL ifElseProc();

DELIMITER //
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    CASE 
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
    END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END //
DELIMITER ;

CALL caseProc();


DELIMITER //
CREATE PROCEDURE fibonacci()
BEGIN
	DECLARE i INT; -- 3에서 10까지 증가할 변수
	DECLARE f1 INT;
	DECLARE f2 INT;
	DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 3;
   	SET f1 = 1;
    SET f2 = 1;
    SET hap = f1 + f2;

	WHILE (i <= 10) DO
		SET hap = f1 + f2;
		SET f1 = f2;
		SET f2 = hap;
		SET i = i + 1;      
	END WHILE;

	SELECT hap;   
END //
DELIMITER ;

CALL fibonacci();


DELIMITER //
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    myWhile: WHILE (i <= 100) DO  -- While문에 label을 지정
	IF (i%7 = 0) THEN
		SET i = i + 1;     
		ITERATE myWhile; -- 지정한 label문으로 가서 계속 진행
	END IF;
        
        SET hap = hap + i; 
        IF (hap > 1000) THEN 
		LEAVE myWhile; -- 지정한 label문을 떠남. 즉, While 종료.
	END IF;
        SET i = i + 1;
    END WHILE;

    SELECT hap;   
END //
DELIMITER ;

CALL whileProc();



DELIMITER //
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 존재하지 않' AS '메시지';
    SELECT * FROM EMPS;  -- noTable은 없음.  
END //
DELIMITER ;

CALL errorProc();

DELIMITER //
CREATE PROCEDURE insertError()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
		SHOW ERRORS; -- 오류 메시지 출
		SELECT '오류가 발생했네요. 작업은 취소시켰습니다.' AS '메시지'; 
		ROLLBACK; -- 오류 발생시 작업을 롤백
    END;
    INSERT INTO userTBL VALUES('adam', '박문석', 1970, '제주', NULL, 
		NULL, 170, CURRENT_DATE()); 
END //
DELIMITER ;

CALL insertError();

PREPARE selectQuery FROM 'SELECT * FROM EMP';
EXECUTE selectQuery;
DEALLOCATE PREPARE selectQuery;

PREPARE paramQuery FROM 'SELECT * FROM EMP WHERE empno = ?';
SET @empno = 7788;
EXECUTE paramQuery USING @empno;
DEALLOCATE PREPARE paramQuery;

-- 프로시저 생성
DELIMITER // 
CREATE PROCEDURE myproc(vuserid char(15), vname varchar(20)CHARACTER set utf8, vbirthyear int(11),	
vaddr char(100)CHARACTER set utf8, vmobile char(11), vmdate date) 
begin
	INSERT INTO  usertbl
	VALUES(vuserid, vname, vbirthyear, vaddr, vmobile, vmdate);
end //
DELIMITER ;

-- 프로시저 호출
call myproc('BoA', '권보아', 1986, '남양주', '01012341234', '1986-11-5');

-- 확인
SELECT * FROM usertbl;

-- 프로시저 삭제
DROP PROCEDURE myproc;


CREATE TABLE EMP01(
	EMPNO INT PRIMARY KEY,	
	ENAME VARCHAR(10) NOT NULL,
	JOB VARCHAR(20)
);

CREATE TABLE SAL01(
	SALNO INT PRIMARY KEY AUTO_INCREMENT,
	SAL FLOAT(7,2),
	EMPNO INT REFERENCES EMP01(EMPNO) ON DELETE CASCADE
);


DELIMITER // 
CREATE TRIGGER TRG_01
AFTER INSERT 
ON EMP01
FOR EACH ROW
BEGIN 
INSERT INTO SAL01(SAL, EMPNO) VALUES(100, NEW.EMPNO); 
END // 
DELIMITER ;

INSERT INTO EMP01 
VALUES(2, '박문석', '프로그래머');


SELECT * FROM EMP01;

SELECT * FROM SAL01;

DELIMITER // 
CREATE TRIGGER TRG_02
AFTER DELETE ON EMP01
FOR EACH ROW
BEGIN
DELETE FROM SAL01 WHERE EMPNO=OLD.EMPNO;
END // 
DELIMITER ;

DELETE FROM EMP01 WHERE EMPNO=2;

SELECT * FROM EMP01;

SELECT * FROM SAL01;

DROP TRIGGER TRG_01;

DROP TRIGGER TRG_02; 

DELIMITER // 
CREATE TRIGGER emp_sal_chk
BEFORE UPDATE ON EMP
FOR EACH ROW 
BEGIN
	IF (NEW.sal < OLD.sal OR NEW.sal > OLD.sal * 1.1) THEN
	    SIGNAL SQLSTATE '50000' 
        SET MESSAGE_TEXT = '잘못된 수정입니다..';
    END IF;
END // 
DELIMITER ;

UPDATE EMP 
SET SAL = SAL * 1.2;

SELECT * FROM EMP;


-- 트리거 실습
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10));

INSERT INTO testTbl VALUES(1, '소녀시대');
INSERT INTO testTbl VALUES(2, '트와이스');
INSERT INTO testTbl VALUES(3, '블랙핑크');


DROP TRIGGER IF EXISTS testTrg;

DELIMITER // 
CREATE TRIGGER testTrg  -- 트리거 이름
    AFTER  DELETE -- 삭제후에 작동하도록 지정
    ON testTbl -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	SET @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행시 작동되는 코드들
END // 
DELIMITER ;

SET @msg = '';

INSERT INTO testTbl VALUES(4, '에스파');
SELECT @msg;

UPDATE testTbl SET txt = 'ITZY' WHERE id = 2;
SELECT @msg;

DELETE FROM testTbl WHERE id = 4;
SELECT @msg;


