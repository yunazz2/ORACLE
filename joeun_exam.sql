-- 1. �������� joeun_exam ���� �Ͽ�, �����Ͻÿ�.
CREATE USER joeun_exam IDENTIFIED BY 123456;
-- 2. joeun_exam ������ �⺻ ���̺����̽��� users �� �����Ͻÿ�.
ALTER USER joeun_exam DEFAULT TABLESPACE users;
-- 3. joeun_exam ������ ���̺����̽� ���� �Ҵ緮�� ���������� �����Ͻÿ�.
ALTER USER joeun_exam QUOTA UNLIMITED ON users;
-- 4.joeun_exam ������ ���Ͽ� connect, resource ����(��)�� �ο��Ͻÿ�.
GRANT connect, resource TO joeun_exam;
-- 5. �Ʒ��� ������ ���� �����Ͽ�, board ��� �̸��� ���̺��� �����ϴ� SQL�� �ۼ��Ͻÿ�.
-- * ���̺� ����
/*
    CREATE TABLE ���̺�� (
        �÷���1    Ÿ��  [DEFAULT �⺻��]  [NOT NULL/NULL] [��������],
        �÷���2    Ÿ��  [DEFAULT �⺻��]  [NOT NULL/NULL] [��������],
        �÷���3    Ÿ��  [DEFAULT �⺻��]  [NOT NULL/NULL] [��������],
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

-- 6. SEQ_BOARD ��� �̸����� �������� �����Ͻÿ�. (�������� ���۰� : 1, ���а� :1, �ִ� : 100000 )
CREATE SEQUENCE SEQ_BOARD
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100000;

-- 7. �Ʒ� ��ȸ ����� ����, board ���̺� �����͸� �߰��ϴ� SQL ���� �ۼ��Ͻÿ�.
INSERT INTO board (board_no, title, content, writer, reg_date, upd_date)
VALUES (1, '����01', '����01', '������', TO_DATE('22/12/27', 'YY/MM/DD'), TO_DATE('22/12/27', 'YY/MM/DD'));

INSERT INTO board (board_no, title, content, writer, reg_date, upd_date)
VALUES (2, '����02', '����02', '������', TO_DATE('22/12/27', 'YY/MM/DD'), TO_DATE('22/12/27', 'YY/MM/DD'));

-- 8. �Ʒ� ��ȸ ����� ����, board ���̺��� �����͸� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
UPDATE board
    SET title = '����01'
        ,content = '����01'
WHERE board_no = '1';

UPDATE board
    SET title = '����02'
        ,content = '����02'
WHERE board_no = '2';

-- 9. board ���̺��� �ۼ��ڰ� �达 �� �Խñ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM board
WHERE writer LIKE '��%';

-- 10. board ���̺��� writer �Ӽ��� ���������� �� �Խñ��� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
DELETE FROM board
WHERE writer = '������';


-- 2-1. �Ʒ��� �־��� SQL ���� �����Ͽ��� ��, ��������� �����ϰ� �ִ� ���̺� employee���� �����(emp_name)�� �μ����� ��ȸ�ǵ��� �Լ� ��get_dept_title���� �����Ͻÿ�.
-- (��, �μ��� ���� ������ department ���̺��� dept_title �÷��� ����Ǿ� �ִ�.)
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


-- 2-2. �Ʒ��� �־��� SQL ���� �����Ͽ��� ��, �����ȣ(emp_id), ����, ������ �Է¹޾�, [����1��]���� ������
-- board ���̺� �����(emp_name) ���� �Խñ��� �ۼ��ϴ� ���ν��� ��pro_emp_write���� �����Ͻÿ�. 
-- EXECUTE pro_emp_write( '200', '����', '����' );
CREATE OR REPLACE PROCEDURE pro_emp_write 
(
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2 DEFAULT '�������',
    IN_CONTENT IN VARCHAR2 DEFAULT '�������'
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







