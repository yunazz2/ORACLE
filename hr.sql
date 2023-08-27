
-- 커서 실행 단축키 : ctrl + enter
-- 문서 전체 실행 : F5

SELECT 1+1
FROM dual;

-- 계정 접속 명령어
-- conn 계정명/비밀번호;
conn system/123456;

-- SQL은 대/소문자 구분이 없다.
-- 명령어 키워드 대문자, 식별자는 소문자 주로 사용한다. (각자 스타일대로 사용)
SELECT user_id, username
FROM all_users
WHERE username = 'HR';


-- 사용자 계정 생성
-- c## 없이 계정 생성 : ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


-- 1. 사용자 계정 생성
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;

-- 2. 테이블 스페이스 변경
-- ALTER USER 계정명 DEFAULT TABLESPACE users; : HR계정의 기본 테이블 영역을 'users'영역으로 지정
ALTER USER HR DEFAULT TABLESPACE users;

-- 3. 계정이 사용할 수 있는 용량 설정
-- HR 계정의 사용 용량을 무한대로 지정해보자
-- ALTER USER 계정명 QUOTA UNLIMITED ON 테이블스페이스;
ALTER USER HR QUOTA UNLIMITED ON users;

-- 4. 계정에 권한을 부여
-- GRANT 권한명1, 권한명2 TO 계정명;
GRANT connect, resource TO HR; -- HR 계정에 connect, resource 권한을 부여


-- 계정 삭제
-- DROP USER 계정명 CASCADE;

-- 계정 잠금 해제
-- ALTER USER 계정명 ACCOUNT UNLOCK;

-- SQL 예제

-- 3.
-- 테이블 EMPLOYEES 의 테이블 구조를 조회하는 QSL문을 작성하시오.
DESC employees;

-- 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름) 를 조회하는 SQL 문을 작성하시오.
-- 사원 테이블의 사원 번호와 이름을 조회
SELECT employee_id, first_name
FROM employees;

-- 4. 테이블 EMPLOYEES 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오. (한글 별칭을 부여하여 조회)
-- * 띄어쓰기가 없으면 따옴표 생략 가능
-- * AS 생략 가능
-- ex) employee_id AS 사원 번호 (X)
--     employee_id AS "사원 번호" (O)
-- AS(alias) : 출력되는 컬럼명에 별칭을 부여하는 명령어
SELECT employee_id AS "사원 번호" -- 띄어쓰기가 있으면 " "로 표기
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number AS 전화번호
      ,hire_date AS 입사일자
      ,salary AS 급여
FROM employees;

-- (*) 애스터리크 : 모든 컬럼 지정
SELECT *
FROM employees;

-- 5. 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL 문을 작성하시오.
-- DISTINCT 컬럼명 : 중복된 데이터를 제거하고 조회하는 키워드
SELECT DISTINCT job_id
FROM employees;

-- 6. 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- WHERE 조건 : 조회 조건을 작성하는 구문
SELECT *
FROM employees
WHERE salary > 6000;

-- 7. 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;

-- 8. 테이블 EMPLOYEES 의 모든 속성들을 SALARY 를 기준으로 내림차순 정렬하고, FIRST_NAME 을 기준으로 오름차순 정렬하여 조회하는 SQL 문을 작성하시오.
-- 정렬 명령어
-- ORDER BY 컬럼명 [ASC/DESC];
-- ASC : 오름차순(defailt) => 생략 가능
-- DESC : 내림차순
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;

-- 9. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- OR 연산 : ~ 또는, ~ 이거나
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';

-- 10. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
-- 컬럼명 IN ('A', 'B') : OR 연산을 대체하여 사용할 수 있는 키워드
SELECT *
FROM employees
WHERE job_id IN('FI_ACCOUNT', 'IT_PROG');

-- 11. 테이블 EMPLOYEES 의 JOB_ID가 ‘FI_ACCOUNT’ 이거나 ‘IT_PROG’ 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
-- 컬럼명 NOT IN ('A', 'B') : 'A', 'B'를 제외한 결과를 조회
SELECT *
FROM employees
WHERE job_id NOT IN('FI_ACCOUNT', 'IT_PROG');

-- 12. 테이블 EMPLOYEES 의 JOB_ID가 ‘IT_PROG’ 이면서 SALARY 가 6000 이상인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- AND 연산 : ~ 이면서, 그리고, 동시에
-- WHERE A AND B;
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000;

-- 13. 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘S’로 시작하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- LIKE
-- 컬럼명 LIKE '와일드카드';
-- % : 와일드카드로, 여러 문자를 대체
-- _ : 와일드카드로, 한 문자를 대체
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- 14. 테이블 EMPLOYEES 의 FIRST_NAME 이 ‘s’로 끝나는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15. 테이블 EMPLOYEES 의 FIRST_NAME 에 ‘s’가 포함되는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16. 테이블 EMPLOYEES 의 FIRST_NAME 이 5글자인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE first_name LIKE '_____';
-- LENGTH(컬럼명) : 글자 수를 반환하는 함수
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;

-- 17. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL 인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- IS NULL;
SELECT *
FROM employees
WHERE commission_pct IS NULL;

-- 18. 테이블 EMPLOYEES 의 COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

-- 19. 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= '04/01/01';  -- SQL Developer 에서 문자형 데이터를 날짜형 데이터로 자동 변환

-- TO_DATE() : 문자형 데이터를 날짜형 데이터로 변환하는 함수
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD');

-- 20. 테이블 EMPLOYEES 의 사원의 HIRE_DATE가 04년도부터 05년도인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('20040101', 'YYYYMMDD') AND hire_date <= TO_DATE('20051231', 'YYYYMMDD');
-- 컬럼 BETWEEN A AND B;
-- : A보다 크거나 같고 B보다 작거나 같은 조건 (사이)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('20040101', 'YYYYMMDD') AND TO_DATE('20051231', 'YYYYMMDD');

SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';

-- 21. 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL 문을 각각 작성하시오.
-- dual : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블
-- CEIL() - 천장 : 지정한 값보다 크거나 같은 정수 중 가장 작은 수를 반환하는 함수
SELECT CEIL(12.45), CEIL(-12.45) FROM dual;


-- 22. 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL 문을 각각 작성하시오.
-- FLOOR() - 바닥 : 지정한 값보다 작거나 같은 정수 중 가장 큰 수를 반환하는 함수
SELECT FLOOR(12.55), FLOOR(-12.55) FROM dual;

-- 23. 각 소문제에 제시된 수와 자리 수를 이용하여 '반올림'하는 SQL문을 작성하시오.
-- ROUND(값, 자리수) : 지정한 값을 해당 자리수에서 반올림하는 함수
-- a  a  a  a  a.bbbb
--         -2 -1.0123(인덱스가 이렇게 된다.)
-- 0.54를 소수점 아래 첫째 자리에서 반올림하시오.
SELECT ROUND(0.54, 0) FROM dual;
-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오.
SELECT ROUND(0.54, 1) FROM dual;
-- 125.67 을 일의 자리에서 반올림하시오.
SELECT ROUND(125.67, -1) FROM dual;
-- 125.67 을 십의 자리에서 반올림하시오.
SELECT ROUND(125.67, -2) FROM dual;

-- 24. 각 소문제에 제시된 두 수를 이용하여 '나머지'를 구하는 SQL문을 작성하시오.
-- MOD(A, B) : A를 B로 나눈 나머지를 구하는 함수
-- 3을 8로 나눈 나머지를 구하시오.
SELECT MOD(3, 8) FROM dual;
-- 30을 4로 나눈 나머지를 구하시오.
SELECT MOD(30, 4) FROM dual;

-- 25. 각 소문제에 제시된 두 수를 이용하여 '제곱수'를 구하는 SQL문을 작성하시오.
-- POWER(A, B) : A의 B 제곱
-- 2의 10제곱을 구하시오.
SELECT POWER(2, 10) FROM dual;
-- 2의 31제곱을 구하시오.
SELECT POWER(2, 31) FROM dual;

-- 26. 각 소문제에 제시된 수를 이용하여 '제곱근'을 구하는 SQL문을 작성하시오.
-- SQRT(A) : A의 제곱근(A는 양의 정수와 실수만 사용 가능)
-- 2의 제곱근을 구하시오.
SELECT SQRT(2) FROM dual;

-- 100의 제곱근을 구하시오.
SELECT SQRT(100) FROM dual;

-- 27. 각 소문제에 제시된 수와 자리 수를 이용하여 해당 수를 '절삭'하는 SQL문을 작성하시오.
-- TRUNC(값, 자리수) : 지정한 값을 해당 자리수에서 절삭하는 함수
-- a  a  a  a  a.bbbb
--         -2 -1.0123(인덱스가 이렇게 된다.)
-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 0) FROM dual;
-- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 1) FROM dual;
-- 527425.1234 을 일의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -1) FROM dual;
-- 527425.1234 을 십의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28. 각 소문제에 제시된 수를 이용하여 '절댓값'을 구하는 SQL문을 작성하시오.
-- ABS(A) : A의 절댓값
-- -20 의 절댓값을 구하시오.
SELECT ABS(-20) FROM dual;
--12.456 의 절댓값을 구하시오.
SELECT ABS(-12.456) FROM dual;

-- 29. 문자열을 대문자, 소문자, 첫글자만 대문자로 변환하는 SQL문을 작성하시오.
-- UPPER() : 모두 대문자로 변환
-- LOWER() : 모두 소문자로 변환
-- INITCAP() : 첫 글자만 대문자
SELECT 'AlohA WoRlD~!' AS 원문
        ,UPPER('AlohA WoRlD~!') AS 대문자
        ,LOWER('AlohA WoRlD~!') AS 소문자
        ,INITCAP('AlohA WoRlD~!') AS "첫 글자만 대문자"
FROM dual;

-- 30. 문자열의 글자 수와 바이트 수를 출력하는 SQL문을 작성하시오.
-- LENGTH('문자열') : 글자 수
-- LENGTHB('문자열') : 바이트 수
-- * 영문, 숫자, 빈 칸 : 1 byte
-- * 한글             : 3 byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
      ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
      ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31. <예시>와 같이 각각 '함수'와 '기호'를 이용하여 두 문자열을 병합하여 출력하는 SQL문을 작성하시오.
-- 문자열 1 : 'ALOHA'
-- 문자열 2 : 'WORLD'
SELECT CONCAT('ALOHA', 'WORLD') AS 함수
      ,'ALOHA' || 'WORLD' AS 기호
FROM dual;

-- 32. <예시>와 같이 주어진 문자열의 일부만 출력하는 SQL문을 작성하시오.
-- SUBSTR(문자열, 시작번호, 글자 수)
-- 'www.alohacampus.com'
SELECT SUBSTR('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTR('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTR('www.alohacampus.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTRB('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTRB('www.alohacampus.com', -3, 3) AS "3"
FROM dual;
-- 'www.알로하캠퍼스.com'
SELECT SUBSTR('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTR('www.알로하캠퍼스.com', 5, 6) AS "2"
      ,SUBSTR('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTRB('www.알로하캠퍼스.com', 5, 6*3) AS "2"
      ,SUBSTRB('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;

-- 33. <예시>와 같이 문자열에서 '특정 문자의 위치'를 구하는 SQL문을 작성하시오.
-- INSTR(문자열, 찾을 문자, 시작 번호, 순서)
-- 'ALOHACAMPUS' 문자열에서 2번째 A의 위치를 구하시오.
SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
      ,INSTR('ALOHACAMPUS', 'CAMPUS', 1, 1) AS "CAMPUS 위치"
FROM dual;

-- 34. <예시>와 같이 대상 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 SQL문을 작성하시오.
-- LPAD(문자열, 칸의 수, 채울 문자) : 문자열의 왼쪽에 지정한 칸을 확보한 후 특정 문자로 채움
-- RPAD(문자열, 칸의 수, 채울 문자) : 문자열의 오른쪽에 지정한 칸을 확보한 후 특정 문자로 채움
-- 'ALOHACAMPUS' 문자열에서 #########ALOHACAMPUS, ALOHACAMPUS#########로 나오도록
SELECT LPAD('ALOHACAMPUS', 20, '#') AS "왼쪽"
      ,RPAD('ALOHACAMPUS', 20, '#') AS "오른쪽"
FROM dual;

-- 35. 테이블 EMPLOYEES 의 FIRST_NAME과 HIRE_DATE 를 검색하되 <예시>와 같이 '날짜 형식을 지정'하는 SQL 문을 작성하시오.
-- TO_CHAR(데이터, '날짜/숫자 형식') : 특정 데이터를 문자열 형식으로 변환하는 함수
-- 날짜형 -> 문자형으로 변환해보자
SELECT first_name AS 이름
      ,hire_date
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS "hire_date를 형식 변환"
FROM employees;

-- 36. 테이블 EMPLOYEES 의 FIRST_NAME과 SALARY 를 검색하되 <예시>와 같이 날짜 형식을 지정하는 SQL 문을 작성하시오.
-- 숫자형 -> 문자형으로 변환해보자
SELECT first_name AS 이름
      ,salary AS 급여
      ,TO_CHAR(salary, '$999,999,999.00') 급여
FROM employees;

-- 37. <예시> 와 같이 문자형으로 주어진 데이터를 날짜형 데이터로 변환하는 SQL 문을 작성하시오.
-- TO DATE(데이터, 날짜형식) : 문자형 데이터를 날짜형 데이터로 변환하는 함수
-- * 해당 문자형 데이터를 날짜형으로 분석할 수 있는 위치와 형식을 지정해야 함.
-- 문자형 -> 날짜형
SELECT 20230822 AS 문자
      ,TO_DATE('20230822', 'YYYYMMDD') AS 날짜
      ,TO_DATE('2023.08.22', 'YYYY.MM.DD') AS 날짜2
      ,TO_DATE('2023-08-22', 'YYYY-MM-DD') AS 날짜3
      ,TO_DATE('2023/08/22', 'YYYY/MM/DD') AS 날짜4
FROM dual;

-- 38. <예시> 와 같이 문자형으로 주어진 데이터를 숫자형 데이터로 변환하는 SQL 문을 작성하시오.
-- TO_NUMBER(데이터, 형식) : 문자형 데이터를 숫자형 데이터로 변환하는 함수
SELECT '1,200,000' AS 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;

-- 39. 어제, 오늘, 내일 날짜를 출력하시오.
-- sysdate : 현재 날짜/ 시간 정보를 가지고있는 키워드
SELECT sysdate FROM dual;

SELECT sysdate-1 AS 어제
      ,sysdate AS 오늘
      ,sysdate+1 AS 내일
FROM dual;

-- 40. employees 테이블에서 이름, 입사일자와 오늘 날짜를 출력하고, 근무 달 수와 근속 연수를 출력하시오.
-- MONTHS_BETWEEN(A, B) : 날짜 A부터 B까지의 개월 수 차이를 반환하는 함수
-- (단, A > B => 즉, A가 더 최근 날짜로 지정되어야 양수로 반환)
SELECT first_name AS 이름
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') AS 입사일자
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') AS "오늘 날짜"
      ,TRUNC(sysdate - hire_date, 0) AS "근무 일 수"
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '개월' AS "근무 달 수"
      ,TRUNC((MONTHS_BETWEEN(sysdate, hire_date)) / 12) || '년' AS "근속 연수"
FROM employees;

-- 41. 오늘 날짜와 6개월 후의 날짜를 출력하는 SQL 문을 작성하시오.
-- ADD_MONTHS(날짜, 개월 수) : 지정한 날짜로부터 해당 개월 수 후의 날짜를 반환하는 함수
SELECT sysdate AS 오늘
      ,ADD_MONTHS(sysdate, 6) AS "6개월 후"
FROM dual;

SELECT '2023/07/25' AS "개강"
      ,ADD_MONTHS('2023/07/25', 6) AS "종강"
FROM dual;

-- 42. 오늘 날짜와 오늘 이후 돌아오는 토요일의 날짜를 출력하는 SQL 문을 작성하시오.
-- NEXT_DAY(날짜, 요일) : 지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2  3  4 5  6  7
-- * 일요일 : 1, 월요일 : 2 ... 토요일 : 7
SELECT sysdate AS "오늘"
      , NEXT_DAY(sysdate, 7) AS "다음 토요일"
FROM dual;

SELECT sysdate AS "오늘"
      , NEXT_DAY(sysdate, 1) AS "다음 일요일"
      , NEXT_DAY(sysdate, 2) AS "다음 월요일"
      , NEXT_DAY(sysdate, 3) AS "다음 화요일"
      , NEXT_DAY(sysdate, 4) AS "다음 수요일"
      , NEXT_DAY(sysdate, 5) AS "다음 목요일"
      , NEXT_DAY(sysdate, 6) AS "다음 금요일"
      , NEXT_DAY(sysdate, 7) AS "다음 토요일"
FROM dual;

-- 43. 오늘 날짜와 월초, 월말 일자를 구하는 SQL 문을 작성하시오.
-- LAST_DAY(날짜) : 지정한 날짜와 동일한 월의 월말 일자를 변환하는 함수

-- 날짜 데이터 : XXXXX.YYYYYY
--  1970년 01월 01일 00시 00분 00초 00ms => 2023년 8월 22일 ....
-- 지난 일자를 정수로 계산, 시간 정보는 소수 부분으로 계산
-- XXXXX.YYYYYY 날짜 데이터를 월 단위로 절삭하면 월초를 구할 수 있다.
SELECT TRUNC(sysdate, 'MM') 월초
      ,sysdate 오늘
      ,LAST_DAY(sysdate) 월말
FROM dual;

-- 44. 테이블 EMPLOYEES 의 COMMISSION_PCT 를 중복없이 검색하되, NULL 이면 0으로 조회하고 내림차순으로 정렬하는 SQL문을 작성하시오.
-- NVL(값, NULL을 대체할 값)
-- : 해당 값이 NULL이면 지정된 값으로 변환하는 함수
-- SELECT문 실행 순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELECT DISTINCT NVL(commission_pct, 0) AS "커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC;

-- 조회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다. ex) "커미션(%)"
SELECT DISTINCT NVL(commission_pct, 0) AS "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC;

-- 45. 테이블 EMPLOYEES 의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.
-- NVL2(값, NULL이 아닐 때 값, NULL일 때 값)
SELECT first_name 이름
      ,salary 급여
      ,commission_pct
      ,NVL(commission_pct, 0) 커미션
      ,salary + (salary * NVL(commission_pct, 0)) 최종급여
      ,NVL2(commission_pct, salary + (salary * commission_pct), salary) 최종급여2
FROM employees;

-- 46.테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.
-- DECODE(컬럼명, 조건값1, 반환값1, 조건값2, 반환값2, ...) : 지정한 컬럼의 값이 조건값에 일치하면 바로 뒤의 반환값을 출력하는 함수
SELECT first_name 이름
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
                             ) 부서
FROM employees;

SELECT *
FROM departments;

-- 47. 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성하시오.
-- CASE : 조건식을 만족할 때, 출력할 값을 지정하는 구문
-- CASE
--      WHEN 조건식 THEN 반환값
--      WHEN 조건식 THEN 반환값
-- END
SELECT first_name 이름
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
       End 부서
FROM employees;

-- 48. 테이블 EMPLOYEES 의 사원 수를 구하는 SQL 문을 작성하시오.
-- COUNT(컬럼명) : 컬럼을 지정하여 NULL을 제외한 데이터 개수를 반환하는 함수
-- NULL이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같기 때문에 일반적으로 COUNT(*)로 개수를 구한다.
SELECT COUNT(*) "사원 수"
      ,COUNT(commission_pct) "커미션 받는 사원 수"
      ,COUNT(department_id) "부서가 있는 사원 수"
FROM employees;

-- 49. 테이블 EMPLOYEES 의 최고급여, 최저급여를 구하는 SQL 문을 작성하시오.
-- MAX, MIN
SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM employees;

-- 50. 테이블 EMPLOYEES 의 급여합계, 급여평균을 구하는 SQL 문을 작성하시오.
-- SUM() : 합계
-- AVERAGE() : 평균
SELECT SUM(salary) 급여합계
      ,TRUNC(AVG(salary)) 급여평균
FROM employees;

-- 51. 테이블 EMPLOYEES 의 급여표준편자와 급여분산을 구하는 SQL 문을 작성하시오.
-- STDDEV() : 표준 편차
-- VARIANCE() : 급여분산
SELECT ROUND(STDDEV(salary), 2) 급여표준편차
      ,ROUND(VARIANCE(salary), 2) 급여분산
FROM employees;

-- 52. MS_STUDENT 테이블을 생성하시오.
-- * 테이블 생성
/*
    CREATE TABLE 테이블명 (
        컬럼명1    타입  [DEFAULT 기본값]  [NOT NULL/NULL] [제약조건],
        컬럼명2    타입  [DEFAULT 기본값]  [NOT NULL/NULL] [제약조건],
        컬럼명3    타입  [DEFAULT 기본값]  [NOT NULL/NULL] [제약조건],
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
    ,ETC        VARCHAR(1000)   DEFAULT '없음'    NULL
);

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민등록번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '학부 번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공 번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록 일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정 일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

DROP TABLE MS_STUDENT;

-- 53. MS_STUDENT 테이블에 성별, 재적, 입학일자, 졸업일자 속성을 추가하시오.
-- 테이블에 속성 추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULT 기본값 [NOT NULL];
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 테이블 속성 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54. MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH로 이름을 변경하고 데이터 타입을 DATE로 수정하시오.
-- 그리고 설명도 '생년월일'로 변경하시오.
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 속성 변경 - 타입 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 속성 변경 - NULL 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH NULL;
-- 속성 변경 - DEFAULT 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DEFAULT sysdata;

-- 동시에 적용 가능
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE DEFAULT sysdate NOT NULL;

DESC MS_STUDENT;

-- 55. MS_STUDENT 테이블의 학부번호 속성을 삭제하는 SQL 문을 작성하시오.
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56. MS_STUDENT 테이블을 삭제하는 SQL문을 작성하시오.
DROP TABLE MS_STUDENT;

-- 57. 아래 <예시>의 TABLE 기술서를 참고하여 MS_STUDENT 테이블을 생성하는 SQL 문을 작성하시오.
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL   PRIMARY KEY
    ,NAME       VARCHAR2(20)    NOT NULL
    ,BIRTH      DATE            NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,MJ_NO      VARCHAR2(10)    NOT NULL
    ,GENDER     CHAR(6)         DEFAULT '기타'    NOT NULL
    ,STATUS     VARCHAR2(10)    DEFAULT '대기'    NOT NULL
    ,ADM_DATE   DATE    NULL
    ,GRD_DATE   DATE    NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
);

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58. 아래 <예시> 를 참고하여 MS_STUDENT 테이블에 데이터를 삽입하는 SQL 문을 작성하시오.
-- 데이터 삽입(INSERT)
INSERT INTO MS_STUDENT (ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER
                    , STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC)
VALUES('20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', 'I01', '여'
        , '재학', '2018/03/01', NULL, sysdate, sysdate, NULL);
        
INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210001', '박서준', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'psj@univ.ac.kr', '서울', 'B02',
         '남', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210002', '김아윤', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'kay@univ.ac.kr', '인천', 'S01',
         '여', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20160001', '정수안', TO_DATE('1997/02/10', 'YYYY/MM/DD'), 'jsa@univ.ac.kr', '경남', 'J01',
         '여', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20150010', '윤도현', TO_DATE('1996/03/11', 'YYYY/MM/DD'), 'ydh@univ.ac.kr', '제주', 'K01',
         '남', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20130007', '안아람', TO_DATE('1994/11/24', 'YYYY/MM/DD'), 'aar@univ.ac.kr', '경기', 'Y01',
         '여', '재학', TO_DATE('2013/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, '영상예술 특기자' );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20110002', '한성호', TO_DATE('1992/10/07', 'YYYY/MM/DD'), 'hsh@univ.ac.kr', '서울', 'E03',
         '남', '재학', TO_DATE('2015/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

SELECT * FROM MS_STUDENT;

-- 59. MS_STUDENT 테이블에 데이터를 수정하는 SQL 문을 작성하시오.
/*
    UPDATE 테이블명
        SET 컬럼1 = 변경할 값,
            컬럼2 = 변경할 값,
            ...
    WHERE 조건;
*/
-- 1) 학생 번호가 20160001인 학생의 주소를 '서울'로, 재적 상태를 '휴학'으로 수정하시오
UPDATE MS_STUDENT
    SET address = '서울'
        ,status = '휴학'
WHERE st_no = '20160001';

-- 2) 학생 번호가 20150010인 학생의 주소를 '서울'로, 재적 상태를 '졸업', 졸업일자를 '20200220', 수정일자를 현재날짜로 그리고 특이사항을 '수석'으로 수정하시오.
UPDATE MS_STUDENT
    SET address = '서울'
        ,status = '졸업'
        ,grd_date = '2020/02/02'
        ,upd_date = sysdate
        ,etc = '수석'
WHERE st_no = '20150010';

-- 3) 학생 번호가 20130007인 학생의 재적 상태를 '졸업', 졸업일자를 '20200220', 수정일자를 현재 날짜로 수정하시오.
UPDATE MS_STUDENT
    SET status = '졸업'
        ,grd_date = '2020/02/02'
        ,upd_date = sysdate
WHERE st_no = 20130007;
    
-- 4) 학생번호가 20110002인 학생의 재적 상태를 '퇴학', 수정일자를 현재 날짜, 특이사항을 '자진 퇴학'으로 수정하시오.
UPDATE MS_STUDENT
    SET status = '퇴학'
        ,upd_date = sysdate
        ,etc = '자진 퇴학'
WHERE st_no = 20110002;

-- 60. MS_STUDENT 테이블에 데이터를 삭제하는 SQL 문을 작성하시오.
DELETE FROM MS_STUDENT
WHERE st_no = '20110002';

-- 61. MS_STUDENT 테이블의 모든 속성을 조회하는 SQL 문을 작성하시오.
SELECT * FROM MS_STUDENT;

-- 62. MS_STUDENT 테이블의 모든 속성을 조회하여 MS_STUDENT_BACK 백업 테이블을 생성하는 SQL 문을 작성하시오.
-- 백업 테이블 만들기
CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

-- 63. MS_STUDENT 테이블의 튜플을 삭제하는 SQL 문을 작성하시오.
DELETE FROM MS_STUDENT;

-- 64. MS_STUDENT_BACK 테이블의 모든 속성을 조회하여 MS_STUDENT 테이블에 삽입하는 SQL 문을 작성하시오.
INSERT INTO MS_STUDENT
SELECT * FROM MS_STUDENT_BACK;

-- 65. MS_STUDENT 테이블의 성별 속성이 (‘여’, ‘남‘, ‘기타‘ ) 값만 입력가능하도록 하는 제약조건을 추가하시오.
-- 제약 조건 걸기
ALTER TABLE MS_STUDENT
ADD CONSTRAINT MS_STD_GENDER_CHECK
CHECK (gender IN ('여', '남', '기타'));

UPDATE MS_STUDENT
    SET GENDER = '???';

-- 제약조건
-- 기본 키(PRIMARY KEY) : 중복 불가, NULL 불가(필수 입력)
--      => 해당 테이블의 데이터를 고유하게 구분할 수 있는 속성으로 지정
-- 고유 키(UNIQUE KEY) : 중복 불가, NULL 허용
--      => 중복되지 않아야 할 데이터(ID, 주민 번호, 이메일, ...)
-- CHECK 제약조건 : 지정한 값만 입력/수정 가능하도록 제한하는 조건
--      => 지정한 값이 아닌 다른 값을 입력/수정하는 경우
-- "체크 제약조건(HR.MS_STD_GENDER_CHECK)이 위배되었습니다" 에러 발생