
-- Ŀ�� ���� ����Ű : ctrl + enter
-- ���� ��ü ���� : F5

SELECT 1+1
FROM dual;

-- ���� ���� ��ɾ�
-- conn ������/��й�ȣ;
conn system/123456;

-- SQL�� ��/�ҹ��� ������ ����.
-- ��ɾ� Ű���� �빮��, �ĺ��ڴ� �ҹ��� �ַ� ����Ѵ�. (���� ��Ÿ�ϴ�� ���)
SELECT user_id, username
FROM all_users
WHERE username = 'HR';


-- ����� ���� ����
-- c## ���� ���� ���� : ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


-- 1. ����� ���� ����
-- CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER HR IDENTIFIED BY 123456;

-- 2. ���̺� �����̽� ����
-- ALTER USER ������ DEFAULT TABLESPACE users; : HR������ �⺻ ���̺� ������ 'users'�������� ����
ALTER USER HR DEFAULT TABLESPACE users;

-- 3. ������ ����� �� �ִ� �뷮 ����
-- HR ������ ��� �뷮�� ���Ѵ�� �����غ���
-- ALTER USER ������ QUOTA UNLIMITED ON ���̺����̽�;
ALTER USER HR QUOTA UNLIMITED ON users;

-- 4. ������ ������ �ο�
-- GRANT ���Ѹ�1, ���Ѹ�2 TO ������;
GRANT connect, resource TO HR; -- HR ������ connect, resource ������ �ο�


-- ���� ����
-- DROP USER ������ CASCADE;

-- ���� ��� ����
-- ALTER USER ������ ACCOUNT UNLOCK;

-- SQL ����

-- 3.
-- ���̺� EMPLOYEES �� ���̺� ������ ��ȸ�ϴ� QSL���� �ۼ��Ͻÿ�.
DESC employees;

-- ���̺� EMPLOYEES ���� EMPLOYEE_ID, FIRST_NAME (ȸ����ȣ, �̸�) �� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��� ���̺��� ��� ��ȣ�� �̸��� ��ȸ
SELECT employee_id, first_name
FROM employees;

-- 4. ���̺� EMPLOYEES �� <����>�� ���� ��µǵ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�. (�ѱ� ��Ī�� �ο��Ͽ� ��ȸ)
-- * ���Ⱑ ������ ����ǥ ���� ����
-- * AS ���� ����
-- ex) employee_id AS ��� ��ȣ (X)
--     employee_id AS "��� ��ȣ" (O)
-- AS(alias) : ��µǴ� �÷��� ��Ī�� �ο��ϴ� ��ɾ�
SELECT employee_id AS "��� ��ȣ" -- ���Ⱑ ������ " "�� ǥ��
      ,first_name AS �̸�
      ,last_name AS ��
      ,email AS �̸���
      ,phone_number AS ��ȭ��ȣ
      ,hire_date AS �Ի�����
      ,salary AS �޿�
FROM employees;

-- (*) �ֽ��͸�ũ : ��� �÷� ����
SELECT *
FROM employees;

-- 5. ���̺� EMPLOYEES �� JOB_ID�� �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- DISTINCT �÷��� : �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� Ű����
SELECT DISTINCT job_id
FROM employees;

-- 6. ���̺� EMPLOYEES �� SALARY(�޿�)�� 6000�� �ʰ��ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- WHERE ���� : ��ȸ ������ �ۼ��ϴ� ����
SELECT *
FROM employees
WHERE salary > 6000;

-- 7. ���̺� EMPLOYEES �� SALARY(�޿�)�� 10000�� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE salary = 10000;

-- 8. ���̺� EMPLOYEES �� ��� �Ӽ����� SALARY �� �������� �������� �����ϰ�, FIRST_NAME �� �������� �������� �����Ͽ� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ���� ��ɾ�
-- ORDER BY �÷��� [ASC/DESC];
-- ASC : ��������(defailt) => ���� ����
-- DESC : ��������
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 9. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- OR ���� : ~ �Ǵ�, ~ �̰ų�
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';

-- 10. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, IN Ű���带 ����Ͻÿ�.
-- �÷��� IN ('A', 'B') : OR ������ ��ü�Ͽ� ����� �� �ִ� Ű����
SELECT *
FROM employees
WHERE job_id IN('FI_ACCOUNT', 'IT_PROG');

-- 11. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, IN Ű���带 ����Ͻÿ�.
-- �÷��� NOT IN ('A', 'B') : 'A', 'B'�� ������ ����� ��ȸ
SELECT *
FROM employees
WHERE job_id NOT IN('FI_ACCOUNT', 'IT_PROG');

-- 12. ���̺� EMPLOYEES �� JOB_ID�� ��IT_PROG�� �̸鼭 SALARY �� 6000 �̻��� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- AND ���� : ~ �̸鼭, �׸���, ���ÿ�
-- WHERE A AND B;
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000;

-- 13. ���̺� EMPLOYEES �� FIRST_NAME �� ��S���� �����ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- LIKE
-- �÷��� LIKE '���ϵ�ī��';
-- % : ���ϵ�ī���, ���� ���ڸ� ��ü
-- _ : ���ϵ�ī���, �� ���ڸ� ��ü
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14. ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15. ���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ���ԵǴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16. ���̺� EMPLOYEES �� FIRST_NAME �� 5������ ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE first_name LIKE '_____';
-- LENGTH(�÷���) : ���� ���� ��ȯ�ϴ� �Լ�
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;

-- 17. ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL �� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- IS NULL;
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18. ���̺� EMPLOYEES �� COMMISSION_PCT�� NULL�� �ƴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19. ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�� �̻��� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';  -- SQL Developer ���� ������ �����͸� ��¥�� �����ͷ� �ڵ� ��ȯ

-- TO_DATE() : ������ �����͸� ��¥�� �����ͷ� ��ȯ�ϴ� �Լ�
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD');

-- 20. ���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD') AND hire_date <= TO_DATE('20051231', 'YYYYMMDD');
-- �÷� BETWEEN A AND B;
-- : A���� ũ�ų� ���� B���� �۰ų� ���� ���� (����)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('20040101', 'YYYYMMDD') AND TO_DATE('20051231', 'YYYYMMDD');

SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';

-- 21. 12.45, -12.45 ���� ũ�ų� ���� ���� �� ���� ���� ���� ����ϴ� SQL ���� ���� �ۼ��Ͻÿ�.
-- dual : ��� ����, �Լ� ��� ���� Ȯ���غ� �� �ִ� �ӽ� ���̺�
-- CEIL() - õ�� : ������ ������ ũ�ų� ���� ���� �� ���� ���� ���� ��ȯ�ϴ� �Լ�
SELECT CEIL(12.45), CEIL(-12.45) FROM dual;


-- 22. 12.55�� -12.55 ���� �۰ų� ���� ���� �� ���� ū ���� ����ϴ� SQL ���� ���� �ۼ��Ͻÿ�.
-- FLOOR() - �ٴ� : ������ ������ �۰ų� ���� ���� �� ���� ū ���� ��ȯ�ϴ� �Լ�
SELECT FLOOR(12.55), FLOOR(-12.55) FROM dual;

-- 23. �� �ҹ����� ���õ� ���� �ڸ� ���� �̿��Ͽ� '�ݿø�'�ϴ� SQL���� �ۼ��Ͻÿ�.
-- ROUND(��, �ڸ���) : ������ ���� �ش� �ڸ������� �ݿø��ϴ� �Լ�
-- a  a  a  a  a.bbbb
--         -2 -1.0123(�ε����� �̷��� �ȴ�.)
-- 0.54�� �Ҽ��� �Ʒ� ù° �ڸ����� �ݿø��Ͻÿ�.
SELECT ROUND(0.54, 0) FROM dual;
-- 0.54 �� �Ҽ��� �Ʒ� ��° �ڸ����� �ݿø��Ͻÿ�.
SELECT ROUND(0.54, 1) FROM dual;
-- 125.67 �� ���� �ڸ����� �ݿø��Ͻÿ�.
SELECT ROUND(125.67, -1) FROM dual;
-- 125.67 �� ���� �ڸ����� �ݿø��Ͻÿ�.
SELECT ROUND(125.67, -2) FROM dual;

-- 24. �� �ҹ����� ���õ� �� ���� �̿��Ͽ� '������'�� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- MOD(A, B) : A�� B�� ���� �������� ���ϴ� �Լ�
-- 3�� 8�� ���� �������� ���Ͻÿ�.
SELECT MOD(3, 8) FROM dual;
-- 30�� 4�� ���� �������� ���Ͻÿ�.
SELECT MOD(30, 4) FROM dual;

-- 25. �� �ҹ����� ���õ� �� ���� �̿��Ͽ� '������'�� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- POWER(A, B) : A�� B ����
-- 2�� 10������ ���Ͻÿ�.
SELECT POWER(2, 10) FROM dual;
-- 2�� 31������ ���Ͻÿ�.
SELECT POWER(2, 31) FROM dual;

-- 26. �� �ҹ����� ���õ� ���� �̿��Ͽ� '������'�� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- SQRT(A) : A�� ������(A�� ���� ������ �Ǽ��� ��� ����)
-- 2�� �������� ���Ͻÿ�.
SELECT SQRT(2) FROM dual;

-- 100�� �������� ���Ͻÿ�.
SELECT SQRT(100) FROM dual;

-- 27. �� �ҹ����� ���õ� ���� �ڸ� ���� �̿��Ͽ� �ش� ���� '����'�ϴ� SQL���� �ۼ��Ͻÿ�.
-- TRUNC(��, �ڸ���) : ������ ���� �ش� �ڸ������� �����ϴ� �Լ�
-- a  a  a  a  a.bbbb
--         -2 -1.0123(�ε����� �̷��� �ȴ�.)
-- 527425.1234 �� �Ҽ��� �Ʒ� ù° �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, 0) FROM dual;
-- 527425.1234 �� �Ҽ��� �Ʒ� ��° �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, 1) FROM dual;
-- 527425.1234 �� ���� �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, -1) FROM dual;
-- 527425.1234 �� ���� �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28. �� �ҹ����� ���õ� ���� �̿��Ͽ� '����'�� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ABS(A) : A�� ����
-- -20 �� ������ ���Ͻÿ�.
SELECT ABS(-20) FROM dual;
--12.456 �� ������ ���Ͻÿ�.
SELECT ABS(-12.456) FROM dual;

-- 29. ���ڿ��� �빮��, �ҹ���, ù���ڸ� �빮�ڷ� ��ȯ�ϴ� SQL���� �ۼ��Ͻÿ�.
-- UPPER() : ��� �빮�ڷ� ��ȯ
-- LOWER() : ��� �ҹ��ڷ� ��ȯ
-- INITCAP() : ù ���ڸ� �빮��
SELECT 'AlohA WoRlD~!' AS ����
        ,UPPER('AlohA WoRlD~!') AS �빮��
        ,LOWER('AlohA WoRlD~!') AS �ҹ���
        ,INITCAP('AlohA WoRlD~!') AS "ù ���ڸ� �빮��"
FROM dual;

-- 30. ���ڿ��� ���� ���� ����Ʈ ���� ����ϴ� SQL���� �ۼ��Ͻÿ�.
-- LENGTH('���ڿ�') : ���� ��
-- LENGTHB('���ڿ�') : ����Ʈ ��
-- * ����, ����, �� ĭ : 1 byte
-- * �ѱ�             : 3 byte
SELECT LENGTH('ALOHA WORLD') AS "���� ��"
      ,LENGTHB('ALOHA WORLD') AS "����Ʈ ��"
FROM dual;

SELECT LENGTH('�˷��� ����') AS "���� ��"
      ,LENGTHB('�˷��� ����') AS "����Ʈ ��"
FROM dual;

-- 31. <����>�� ���� ���� '�Լ�'�� '��ȣ'�� �̿��Ͽ� �� ���ڿ��� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
-- ���ڿ� 1 : 'ALOHA'
-- ���ڿ� 2 : 'WORLD'
SELECT CONCAT('ALOHA', 'WORLD') AS �Լ�
      ,'ALOHA' || 'WORLD' AS ��ȣ
FROM dual;

-- 32. <����>�� ���� �־��� ���ڿ��� �Ϻθ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
-- SUBSTR(���ڿ�, ���۹�ȣ, ���� ��)
-- 'www.alohacampus.com'
SELECT SUBSTR('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTR('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTR('www.alohacampus.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTRB('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTRB('www.alohacampus.com', -3, 3) AS "3"
FROM dual;
-- 'www.�˷���ķ�۽�.com'
SELECT SUBSTR('www.�˷���ķ�۽�.com', 1, 3) AS "1"
      ,SUBSTR('www.�˷���ķ�۽�.com', 5, 6) AS "2"
      ,SUBSTR('www.�˷���ķ�۽�.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.�˷���ķ�۽�.com', 1, 3) AS "1"
      ,SUBSTRB('www.�˷���ķ�۽�.com', 5, 6*3) AS "2"
      ,SUBSTRB('www.�˷���ķ�۽�.com', -3, 3) AS "3"
FROM dual;

-- 33. <����>�� ���� ���ڿ����� 'Ư�� ������ ��ġ'�� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- INSTR(���ڿ�, ã�� ����, ���� ��ȣ, ����)
-- 'ALOHACAMPUS' ���ڿ����� 2��° A�� ��ġ�� ���Ͻÿ�.
SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1��° A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2��° A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3��° A"
      ,INSTR('ALOHACAMPUS', 'CAMPUS', 1, 1) AS "CAMPUS ��ġ"
FROM dual;

-- 34. <����>�� ���� ��� ���ڿ��� ����/�����ʿ� ����ϰ� ������� Ư�� ���ڷ� ä��� SQL���� �ۼ��Ͻÿ�.
-- LPAD(���ڿ�, ĭ�� ��, ä�� ����) : ���ڿ��� ���ʿ� ������ ĭ�� Ȯ���� �� Ư�� ���ڷ� ä��
-- RPAD(���ڿ�, ĭ�� ��, ä�� ����) : ���ڿ��� �����ʿ� ������ ĭ�� Ȯ���� �� Ư�� ���ڷ� ä��
-- 'ALOHACAMPUS' ���ڿ����� #########ALOHACAMPUS, ALOHACAMPUS#########�� ��������
SELECT LPAD('ALOHACAMPUS', 20, '#') AS "����"
      ,RPAD('ALOHACAMPUS', 20, '#') AS "������"
FROM dual;

-- 35. ���̺� EMPLOYEES �� FIRST_NAME�� HIRE_DATE �� �˻��ϵ� <����>�� ���� '��¥ ������ ����'�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- TO_CHAR(������, '��¥/���� ����') : Ư�� �����͸� ���ڿ� �������� ��ȯ�ϴ� �Լ�
-- ��¥�� -> ���������� ��ȯ�غ���
SELECT first_name AS �̸�
      ,hire_date
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS "hire_date�� ���� ��ȯ"
FROM employees;

-- 36. ���̺� EMPLOYEES �� FIRST_NAME�� SALARY �� �˻��ϵ� <����>�� ���� ��¥ ������ �����ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ������ -> ���������� ��ȯ�غ���
SELECT first_name AS �̸�
      ,salary AS �޿�
      ,TO_CHAR(salary, '$999,999,999.00') �޿�
FROM employees;

-- 37. <����> �� ���� ���������� �־��� �����͸� ��¥�� �����ͷ� ��ȯ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- TO DATE(������, ��¥����) : ������ �����͸� ��¥�� �����ͷ� ��ȯ�ϴ� �Լ�
-- * �ش� ������ �����͸� ��¥������ �м��� �� �ִ� ��ġ�� ������ �����ؾ� ��.
-- ������ -> ��¥��
SELECT 20230822 AS ����
      ,TO_DATE('20230822', 'YYYYMMDD') AS ��¥
      ,TO_DATE('2023.08.22', 'YYYY.MM.DD') AS ��¥2
      ,TO_DATE('2023-08-22', 'YYYY-MM-DD') AS ��¥3
      ,TO_DATE('2023/08/22', 'YYYY/MM/DD') AS ��¥4
FROM dual;

-- 38. <����> �� ���� ���������� �־��� �����͸� ������ �����ͷ� ��ȯ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- TO_NUMBER(������, ����) : ������ �����͸� ������ �����ͷ� ��ȯ�ϴ� �Լ�
SELECT '1,200,000' AS ����
      ,TO_NUMBER('1,200,000', '999,999,999') AS ����
FROM dual;

-- 39. ����, ����, ���� ��¥�� ����Ͻÿ�.
-- sysdate : ���� ��¥/ �ð� ������ �������ִ� Ű����
SELECT sysdate FROM dual;

SELECT sysdate-1 AS ����
      ,sysdate AS ����
      ,sysdate+1 AS ����
FROM dual;

-- 40. employees ���̺��� �̸�, �Ի����ڿ� ���� ��¥�� ����ϰ�, �ٹ� �� ���� �ټ� ������ ����Ͻÿ�.
-- MONTHS_BETWEEN(A, B) : ��¥ A���� B������ ���� �� ���̸� ��ȯ�ϴ� �Լ�
-- (��, A > B => ��, A�� �� �ֱ� ��¥�� �����Ǿ�� ����� ��ȯ)
SELECT first_name AS �̸�
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') AS �Ի�����
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') AS "���� ��¥"
      ,TRUNC(sysdate - hire_date, 0) AS "�ٹ� �� ��"
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '����' AS "�ٹ� �� ��"
      ,TRUNC((MONTHS_BETWEEN(sysdate, hire_date)) / 12) || '��' AS "�ټ� ����"
FROM employees;

-- 41. ���� ��¥�� 6���� ���� ��¥�� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ADD_MONTHS(��¥, ���� ��) : ������ ��¥�κ��� �ش� ���� �� ���� ��¥�� ��ȯ�ϴ� �Լ�
SELECT sysdate AS ����
      ,ADD_MONTHS(sysdate, 6) AS "6���� ��"
FROM dual;

SELECT '2023/07/25' AS "����"
      ,ADD_MONTHS('2023/07/25', 6) AS "����"
FROM dual;

-- 42. ���� ��¥�� ���� ���� ���ƿ��� ������� ��¥�� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
-- NEXT_DAY(��¥, ����) : ������ ��¥ ���� ���ƿ��� ������ ��ȯ�ϴ� �Լ�
-- �� �� ȭ �� �� �� ��
-- 1  2  3  4 5  6  7
-- * �Ͽ��� : 1, ������ : 2 ... ����� : 7
SELECT sysdate AS "����"
      , NEXT_DAY(sysdate, 7) AS "���� �����"
FROM dual;

SELECT sysdate AS "����"
      , NEXT_DAY(sysdate, 1) AS "���� �Ͽ���"
      , NEXT_DAY(sysdate, 2) AS "���� ������"
      , NEXT_DAY(sysdate, 3) AS "���� ȭ����"
      , NEXT_DAY(sysdate, 4) AS "���� ������"
      , NEXT_DAY(sysdate, 5) AS "���� �����"
      , NEXT_DAY(sysdate, 6) AS "���� �ݿ���"
      , NEXT_DAY(sysdate, 7) AS "���� �����"
FROM dual;

-- 43. ���� ��¥�� ����, ���� ���ڸ� ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- LAST_DAY(��¥) : ������ ��¥�� ������ ���� ���� ���ڸ� ��ȯ�ϴ� �Լ�

-- ��¥ ������ : XXXXX.YYYYYY
--  1970�� 01�� 01�� 00�� 00�� 00�� 00ms => 2023�� 8�� 22�� ....
-- ���� ���ڸ� ������ ���, �ð� ������ �Ҽ� �κ����� ���
-- XXXXX.YYYYYY ��¥ �����͸� �� ������ �����ϸ� ���ʸ� ���� �� �ִ�.
SELECT TRUNC(sysdate, 'MM') ����
      ,sysdate ����
      ,LAST_DAY(sysdate) ����
FROM dual;

-- 44. ���̺� EMPLOYEES �� COMMISSION_PCT �� �ߺ����� �˻��ϵ�, NULL �̸� 0���� ��ȸ�ϰ� ������������ �����ϴ� SQL���� �ۼ��Ͻÿ�.
-- NVL(��, NULL�� ��ü�� ��)
-- : �ش� ���� NULL�̸� ������ ������ ��ȯ�ϴ� �Լ�
-- SELECT�� ���� ����
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELECT DISTINCT NVL(commission_pct, 0) AS "Ŀ�̼�(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC;

-- ��ȸ�� �÷��� ��Ī���� ORDER BY ������ ����� �� �ִ�. ex) "Ŀ�̼�(%)"
SELECT DISTINCT NVL(commission_pct, 0) AS "Ŀ�̼�(%)"
FROM employees
ORDER BY "Ŀ�̼�(%)" DESC;

-- 45. ���̺� EMPLOYEES �� FIRST_NAME, SALARY, COMMISSION_PCT �Ӽ��� �̿��Ͽ� <����>�� ���� SQL ���� �ۼ��Ͻÿ�.
-- NVL2(��, NULL�� �ƴ� �� ��, NULL�� �� ��)
SELECT first_name �̸�
      ,salary �޿�
      ,commission_pct
      ,NVL(commission_pct, 0) Ŀ�̼�
      ,salary + (salary * NVL(commission_pct, 0)) �����޿�
      ,NVL2(commission_pct, salary + (salary * commission_pct), salary) �����޿�2
FROM employees;

-- 46.���̺� EMPLOYEES �� FIRST_NAME, DEPARTMENT_ID �Ӽ��� �̿��Ͽ� <����>�� ���� SQL ���� �ۼ��Ͻÿ�.
-- DECODE(�÷���, ���ǰ�1, ��ȯ��1, ���ǰ�2, ��ȯ��2, ...) : ������ �÷��� ���� ���ǰ��� ��ġ�ϸ� �ٷ� ���� ��ȯ���� ����ϴ� �Լ�
SELECT first_name �̸�
      ,DECODE(department_id, 10, 'Administration',
                             20, 'Marketing',
                             30, 'Purchasing',
                             40, 'Human Resources',
                             50, 'Shipping',
                             60, 'IT',
                             70, 'Public Relations',
                             80, 'Sales',
                             90, 'Execution',
                             100, 'Finance'
                             ) �μ�
FROM employees;

SELECT *
FROM departments;

-- 47. ���̺� EMPLOYEES �� FIRST_NAME, DEPARTMENT_ID �Ӽ��� �̿��Ͽ� <����>�� ���� SQL ���� �ۼ��Ͻÿ�.
-- CASE : ���ǽ��� ������ ��, ����� ���� �����ϴ� ����
-- CASE
--      WHEN ���ǽ� THEN ��ȯ��
--      WHEN ���ǽ� THEN ��ȯ��
-- END
SELECT first_name �̸�
      ,CASE WHEN department_id = 10 THEN 'Administration'
            WHEN department_id = 20 THEN 'Marketing'
            WHEN department_id = 30 THEN 'Purchasing'
            WHEN department_id = 40 THEN 'Human Resources'
            WHEN department_id = 50 THEN 'Shipping'
            WHEN department_id = 60 THEN 'IT'
            WHEN department_id = 70 THEN 'Public Relations'
            WHEN department_id = 80 THEN 'Sales'
            WHEN department_id = 90 THEN 'Execution'
            WHEN department_id = 100 THEN 'Finance'
       End �μ�
FROM employees;

-- 48. ���̺� EMPLOYEES �� ��� ���� ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- COUNT(�÷���) : �÷��� �����Ͽ� NULL�� ������ ������ ������ ��ȯ�ϴ� �Լ�
-- NULL�� ���� �����Ͷ�� � �÷��� �����ϴ��� ������ ���� ������ �Ϲ������� COUNT(*)�� ������ ���Ѵ�.
SELECT COUNT(*) "��� ��"
      ,COUNT(commission_pct) "Ŀ�̼� �޴� ��� ��"
      ,COUNT(department_id) "�μ��� �ִ� ��� ��"
FROM employees;

-- 49. ���̺� EMPLOYEES �� �ְ�޿�, �����޿��� ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- MAX, MIN
SELECT MAX(salary) �ְ�޿�
      ,MIN(salary) �����޿�
FROM employees;

-- 50. ���̺� EMPLOYEES �� �޿��հ�, �޿������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- SUM() : �հ�
-- AVERAGE() : ���
SELECT SUM(salary) �޿��հ�
      ,TRUNC(AVG(salary)) �޿����
FROM employees;

-- 51. ���̺� EMPLOYEES �� �޿�ǥ�����ڿ� �޿��л��� ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- STDDEV() : ǥ�� ����
-- VARIANCE() : �޿��л�
SELECT ROUND(STDDEV(salary), 2) �޿�ǥ������
      ,ROUND(VARIANCE(salary), 2) �޿��л�
FROM employees;

-- 52. MS_STUDENT ���̺��� �����Ͻÿ�.
-- * ���̺� ����
/*
    CREATE TABLE ���̺�� (
        �÷���1    Ÿ��  [DEFAULT �⺻��]  [NOT NULL/NULL] [��������],
        �÷���2    Ÿ��  [DEFAULT �⺻��]  [NOT NULL/NULL] [��������],
        �÷���3    Ÿ��  [DEFAULT �⺻��]  [NOT NULL/NULL] [��������],
        ...
    );
*/

CREATE TABLE MS_STUDENT (
    ST_NO       NUMBER          NOT NULL    PRIMARY KEY
    ,NAME       VARCHAR2(20)    NOT NULL
    ,CTZ_NO     CHAR(14)        NOT NULL
    ,EMAIL      VARCHAR(100)    NOT NULL    UNIQUE
    ,ADDRESS    VARCHAR(1000)   NULL
    ,DEPT_NO    NUMBER          NOT NULL
    ,MJ_NO      NUMBER          NOT NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR(1000)   DEFAULT '����'    NULL
);

COMMENT ON TABLE MS_STUDENT IS '�л����� ������ �����Ѵ�.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '�л� ��ȣ';
COMMENT ON COLUMN MS_STUDENT.NAME IS '�̸�';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '�̸���';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '�ּ�';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '�к� ��ȣ';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '���� ��ȣ';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '��� ����';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '���� ����';
COMMENT ON COLUMN MS_STUDENT.ETC IS 'Ư�̻���';

DROP TABLE MS_STUDENT;

-- 53. MS_STUDENT ���̺� ����, ����, ��������, �������� �Ӽ��� �߰��Ͻÿ�.
-- ���̺� �Ӽ� �߰�
-- ALTER TABLE ���̺�� ADD �÷��� Ÿ�� DEFAULT �⺻�� [NOT NULL];
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '��Ÿ' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '����';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '���' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '����';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '��������';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '��������';

-- ���̺� �Ӽ� ����
-- ALTER TABLE ���̺�� DROP COLUMN �÷���;
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54. MS_STUDENT ���̺��� CTZ_NO �Ӽ��� BIRTH�� �̸��� �����ϰ� ������ Ÿ���� DATE�� �����Ͻÿ�.
-- �׸��� ���� '�������'�� �����Ͻÿ�.
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '�������';

-- �Ӽ� ���� - Ÿ�� ����
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- �Ӽ� ���� - NULL ����
ALTER TABLE MS_STUDENT MODIFY BIRTH NULL;
-- �Ӽ� ���� - DEFAULT ����
ALTER TABLE MS_STUDENT MODIFY BIRTH DEFAULT sysdata;

-- ���ÿ� ���� ����
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE DEFAULT sysdate NOT NULL;

DESC MS_STUDENT;

-- 55. MS_STUDENT ���̺��� �кι�ȣ �Ӽ��� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56. MS_STUDENT ���̺��� �����ϴ� SQL���� �ۼ��Ͻÿ�.
DROP TABLE MS_STUDENT;

-- 57. �Ʒ� <����>�� TABLE ������� �����Ͽ� MS_STUDENT ���̺��� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL   PRIMARY KEY
    ,NAME       VARCHAR2(20)    NOT NULL
    ,BIRTH      DATE            NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,MJ_NO      VARCHAR2(10)    NOT NULL
    ,GENDER     CHAR(6)         DEFAULT '��Ÿ'    NOT NULL
    ,STATUS     VARCHAR2(10)    DEFAULT '���'    NOT NULL
    ,ADM_DATE   DATE    NULL
    ,GRD_DATE   DATE    NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '����' NULL
);

COMMENT ON TABLE MS_STUDENT IS '�л����� ������ �����Ѵ�.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '�л� ��ȣ';
COMMENT ON COLUMN MS_STUDENT.NAME IS '�̸�';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '�������';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '�̸���';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '�ּ�';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '������ȣ';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '����';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '����';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '��������';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '��������';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '�������';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '��������';
COMMENT ON COLUMN MS_STUDENT.ETC IS 'Ư�̻���';

-- 58. �Ʒ� <����> �� �����Ͽ� MS_STUDENT ���̺� �����͸� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ������ ����(INSERT)
INSERT INTO MS_STUDENT (ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER
                    , STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC)
VALUES('20180001', '�ּ���', '991005', 'csa@univ.ac.kr', '����', 'I01', '��'
        , '����', '2018/03/01', NULL, sysdate, sysdate, NULL);
        
INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210001', '�ڼ���', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'psj@univ.ac.kr', '����', 'B02',
         '��', '����', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210002', '�����', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'kay@univ.ac.kr', '��õ', 'S01',
         '��', '����', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20160001', '������', TO_DATE('1997/02/10', 'YYYY/MM/DD'), 'jsa@univ.ac.kr', '�泲', 'J01',
         '��', '����', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20150010', '������', TO_DATE('1996/03/11', 'YYYY/MM/DD'), 'ydh@univ.ac.kr', '����', 'K01',
         '��', '����', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20130007', '�Ⱦƶ�', TO_DATE('1994/11/24', 'YYYY/MM/DD'), 'aar@univ.ac.kr', '���', 'Y01',
         '��', '����', TO_DATE('2013/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, '���󿹼� Ư����' );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20110002', '�Ѽ�ȣ', TO_DATE('1992/10/07', 'YYYY/MM/DD'), 'hsh@univ.ac.kr', '����', 'E03',
         '��', '����', TO_DATE('2015/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

SELECT * FROM MS_STUDENT;

-- 59. MS_STUDENT ���̺� �����͸� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
/*
    UPDATE ���̺��
        SET �÷�1 = ������ ��,
            �÷�2 = ������ ��,
            ...
    WHERE ����;
*/
-- 1) �л� ��ȣ�� 20160001�� �л��� �ּҸ� '����'��, ���� ���¸� '����'���� �����Ͻÿ�
UPDATE MS_STUDENT
    SET address = '����'
        ,status = '����'
WHERE st_no = '20160001';

-- 2) �л� ��ȣ�� 20150010�� �л��� �ּҸ� '����'��, ���� ���¸� '����', �������ڸ� '20200220', �������ڸ� ���糯¥�� �׸��� Ư�̻����� '����'���� �����Ͻÿ�.
UPDATE MS_STUDENT
    SET address = '����'
        ,status = '����'
        ,grd_date = '2020/02/02'
        ,upd_date = sysdate
        ,etc = '����'
WHERE st_no = '20150010';

-- 3) �л� ��ȣ�� 20130007�� �л��� ���� ���¸� '����', �������ڸ� '20200220', �������ڸ� ���� ��¥�� �����Ͻÿ�.
UPDATE MS_STUDENT
    SET status = '����'
        ,grd_date = '2020/02/02'
        ,upd_date = sysdate
WHERE st_no = 20130007;
    
-- 4) �л���ȣ�� 20110002�� �л��� ���� ���¸� '����', �������ڸ� ���� ��¥, Ư�̻����� '���� ����'���� �����Ͻÿ�.
UPDATE MS_STUDENT
    SET status = '����'
        ,upd_date = sysdate
        ,etc = '���� ����'
WHERE st_no = 20110002;

-- 60. MS_STUDENT ���̺� �����͸� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
DELETE FROM MS_STUDENT
WHERE st_no = '20110002';

-- 61. MS_STUDENT ���̺��� ��� �Ӽ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM MS_STUDENT;

-- 62. MS_STUDENT ���̺��� ��� �Ӽ��� ��ȸ�Ͽ� MS_STUDENT_BACK ��� ���̺��� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��� ���̺� �����
CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

-- 63. MS_STUDENT ���̺��� Ʃ���� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
DELETE FROM MS_STUDENT;

-- 64. MS_STUDENT_BACK ���̺��� ��� �Ӽ��� ��ȸ�Ͽ� MS_STUDENT ���̺� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
INSERT INTO MS_STUDENT
SELECT * FROM MS_STUDENT_BACK;

-- 65. MS_STUDENT ���̺��� ���� �Ӽ��� (������, ������, ����Ÿ�� ) ���� �Է°����ϵ��� �ϴ� ���������� �߰��Ͻÿ�.
-- ���� ���� �ɱ�
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STD_GENDER_CHECK
CHECK (gender IN ('��', '��', '��Ÿ'));

UPDATE MS_STUDENT
    SET GENDER = '???';

-- ��������
-- �⺻ Ű(PRIMARY KEY) : �ߺ� �Ұ�, NULL �Ұ�(�ʼ� �Է�)
--      => �ش� ���̺��� �����͸� �����ϰ� ������ �� �ִ� �Ӽ����� ����
-- ���� Ű(UNIQUE KEY) : �ߺ� �Ұ�, NULL ���
--      => �ߺ����� �ʾƾ� �� ������(ID, �ֹ� ��ȣ, �̸���, ...)
-- CHECK �������� : ������ ���� �Է�/���� �����ϵ��� �����ϴ� ����
--      => ������ ���� �ƴ� �ٸ� ���� �Է�/�����ϴ� ���
-- "üũ ��������(HR.MS_STD_GENDER_CHECK)�� ����Ǿ����ϴ�" ���� �߻�