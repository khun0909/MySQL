// MySQL 연결 테스트

const mysql =require('mysql2'); //mysql2 모듈 로드

const conn = {         //MySQL 연결
    host: 'localhost', //DB서버 호스트, '127.0.0.1'
    port: '3306',       //포트
    user: 'root',
    password: '3128',
    database: 'emp_db'
};

// DB Connection 객체를 이용한 DB연결 및 SQL 실행
const connection = mysql.createConnection(conn);
connection.connect();  //DB연결

sql='SELECT * FROM tcar';
connection.query(sql, (error, result, fields) =>{
    if (error) {
        console.log(error);    
    }
    console.log('SQL 실행 결과:\n', result);
});