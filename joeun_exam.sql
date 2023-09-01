-- 1. 계정명을 joeun_exam 으로 하여, 생성하시오.
CREATE USER joeun_exam IDENTIFIED BY 123456;
-- 2. joeun_exam 계정에 기본 테이블스페이스를 users 로 변경하시오.
ALTER USER joeun_exam DEFAULT TABLESPACE users;
-- 3. joeun_exam 계정의 테이블스페이스 영역 할당량을 무제한으로 변경하시오.
ALTER USER joeun_exam QUOTA UNLIMITED ON users;
-- 4.joeun_exam 계정에 대하여 connect, resource 권한(롤)을 부여하시오.
GRANT connect, resource TO joeun_exam;
-- 5. 아래의 데이터 모델을 참조하여, board 라는 이름의 테이블을 정의하는 SQL을 작성하시오.
-- * 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컬럼명1    타입  [DEFAULT 기본값]  [NOT NULL/NULL] [제약조건],
        컬럼명2    타입  [DEFAULT 기본값]  [NOT NULL/NULL] [제약조건],
        컬럼명3    타입  [DEFAULT 기본값]  [NOT NULL/NULL] [제약조건],
        ...
    );
*/

CREATE TABLE board (
    BOARD_NO       NUMBER          NOT NULL    PRIMARY KEY
    ,TITLE       VARCHAR2(100)    NOT NULL
    ,CONTENT VARCHAR2(2000) NOT NULL
    ,WRITER VARCHAR2(20) NOT NULL
    ,REG_DATE DATE DEFAULT sysdate NOT NULL
    ,UPD_DATE DATE DEFAULT sysdate NOT NULL
);

-- 6. SEQ_BOARD 라는 이름으로 시퀀스를 생성하시오. (시퀀스의 시작값 : 1, 증분값 :1, 최댓값 : 100000 )
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100000;

-- 7. 아래 조회 결과와 같이, board 테이블에 데이터를 추가하는 SQL 문을 작성하시오.
INSERT INTO board (board_no, title, content, writer, reg_date, upd_date)
VALUES (1, '제목01', '내용01', '김조은', TO_DATE('22/12/27', 'YY/MM/DD'), TO_DATE('22/12/27', 'YY/MM/DD'));

INSERT INTO board (board_no, title, content, writer, reg_date, upd_date)
VALUES (2, '제목02', '내용02', '김조은', TO_DATE('22/12/27', 'YY/MM/DD'), TO_DATE('22/12/27', 'YY/MM/DD'));

-- 8. 아래 조회 결과와 같이, board 테이블의 데이터를 수정하는 SQL 문을 작성하시오.
UPDATE board
    SET title = '수정01'
        ,content = '수정01'
WHERE board_no = '1';

UPDATE board
    SET title = '수정02'
        ,content = '수정02'
WHERE board_no = '2';

-- 9. board 테이블에서 작성자가 김씨 인 게시글을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM board
WHERE writer LIKE '김%';

-- 10. board 테이블에서 writer 속성이 ‘김조은’ 인 게시글을 삭제하는 SQL 문을 작성하시오.
DELETE FROM board
WHERE writer = '김조은';


-- 2-1. 아래에 주어진 SQL 문을 실행하였을 때, 사원정보를 저장하고 있는 테이블 employee에서 사원명(emp_name)과 부서명이 조회되도록 함수 “get_dept_title”을 정의하시오.
-- (단, 부서명에 대한 정보는 department 테이블의 dept_title 컬럼에 저장되어 있다.)
CREATE OR REPLACE FUNCTION get_dept_title(p_emp_id NUMBER)
RETURN VARCHAR2
IS
    out_title department.dept_title%TYPE;
BEGIN
    SELECT  dept_title
        INTO out_title
        FROM employee e
            ,department d
    WHERE e.dept_code = d.dept_id
        AND e.emp_id = p_emp_id;
    RETURN out_title;
END;
/


-- 2-2. 아래에 주어진 SQL 문을 실행하였을 때, 사원번호(emp_id), 제목, 내용을 입력받아, [문제1번]에서 정의한
-- board 테이블에 사원명(emp_name) 으로 게시글을 작성하는 프로시저 “pro_emp_write”를 정의하시오. 
-- EXECUTE pro_emp_write( '200', '제목', '내용' );
CREATE OR REPLACE PROCEDURE pro_emp_write 
(
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2 DEFAULT '제목없음',
    IN_CONTENT IN VARCHAR2 DEFAULT '내용없음'
)
IS
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN
    SELECT emp_name INTO V_EMP_NAME
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    
    INSERT INTO board(board_no, title, writer, content)
    VALUES (SEQ_BOARD.nextval, IN_TITLE, V_EMP_NAME, IN_CONTENT);

END;
/







