/*
    < 함수 FUNCTION >
    전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
    
    - 단일행 함수: N개의 값을 읽어들여서 N개의 결과값을 리턴 (매 행마다 함수 실행 결과 반환)
    - 그룹 함수: N개의 값을 읽어들여서 1개의 결과값을 리턴 (그룹을 지어 그룹별로 함수 실행 결과 반환)
    
    >> SELECT절에 단일행 함수랑 그룹함수를 함께 사용 못함!
       왜? 결과 행의 갯수가 다르기 때문에!
       
    >> 함수식을 기술할 수 있는 위치: SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
*/

--=============================== < 단일행 함수 > ===================================
/*
    < 문자 처리 함수 >
    * LENGTH / LENGTHB      => 결과값 NUMBER타입
    LENGTH(컬럼|'문자열값'): 해당 문자열값의 글자수 반환
    LENGTHB(컬럼|'문자열값'): 해당 문자열값의 바이트수 반환
    
    '강' '나' 'ㄱ' 한글 한 글자 당 3BYTE
    영문자, 숫자, 특수문자 한 글자 당 1BYTE
*/
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;
 
SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

------------------------------------------------------------------------------

/*
    *INSTR
    문자열로부터 특정 문자의 시작 위치를 찾아서 반환
    
    INSTR(컬럼|'문자열값', '찾고자하는문자', [찾을위치의시작값, [순번]])           => 결과값은 NUMBER타입
    
    찾을 위치의 시작값
    1: 앞에서부터 찾겠다.
    -1: 뒤에서부터 찾겠다.
    
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 찾을위치의시작값은 1이 기본값, 순번도 1이 기본값.
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1) "_위치", INSTR(EMAIL, '@') "@위치" 
FROM EMPLOYEE;

-----------------------------------------------------------------------------------

/*
    * SUBSTR
    문자열에서 특정 문자열을 추출해서 반환 (자바에서 substring()메소드와 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])          => 결과값이 CHARACTER(문자열)타입
    - STRING: 문자타입컬럼 또는 '문자열값'
    - POSITION: 문자열을 추출할 시작위치값
    - LENGTH: 추출할 문자 갯수 (생략 시 끝까지 추출)
*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) "성별"
FROM EMPLOYEE;

-- 여자사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';

-- 남자사원들만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3')
ORDER BY 1;

-- 함수 중첩사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1) "아이디"
FROM EMPLOYEE;

-------------------------------------------------------------------------------

/*
    * LPAD / RPAD
    문자열을 조회할 때 통일감 있게 조회하고자 할 때 사용
    
    LPAD/RPAD(STRING, 최종적으로 반환할 문자의 길이, [덧붙이고자하는 문자])       => 결과값은 CHARACTER타입
    
    문자열에 덧붙이고자 하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
*/
-- 20만큼의 길이 중 EMAIL컬럼값은 오른쪽으로 정렬하고 나머지 부분은 공백으로 채워짐 (왼편)
SELECT EMP_NAME, LPAD(EMAIL, 20) -- 덧붙이고자 하는 문자 생략 시 기본값이 공백!
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850918-2****** 조회
SELECT RPAD('850918-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO,1,8) || '******'
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    문자열에서 특정 문자를 제거한 나머지를 반환
    
    LTRIM/RTRIM(STRING, [제거하고자하는문자들])       => 결과값은 CHARACTER타입
    
    문자열의 왼쪽 혹은 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
*/
SELECT LTRIM('   K H ') FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;

/*
    *TRIM
    문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 문자열 반환
    
    TRIM([LEADING|TRAILING|BOTH] 제거하고자하는문자들 FROM STRING)
*/
SELECT TRIM('   K H      ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING: 앞 => LTRIM과 유사
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING: 뒤 => RTRIM과 유사
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- BOTH: 양쪽  => 생략 시 기본값

-----------------------------------------------------------------------------------

/*
    *LOWER / UPPER/ INITCAP
    
    LOWER/UPPER/INITCAP(STRING)        => 결과값은 CHARACTER타입
    
    LOWER: 다 소문자로 변경한 문자열 반환 (자바에서의 toLowerCase()메소드 유사)
    UPPER: 다 대문자로 변경한 문자열 반환 (자바에서의 toUpperCase()메소드 유사)
    INITCAP: 단어 앞 글자마다 대문자로 변경한 문자열 반환 
*/
SELECT LOWER('Welcom To My World!') FROM DUAL;
SELECT UPPER('Welcom To My World!') FROM DUAL;
SELECT INITCAP('welcom to myworld!') FROM DUAL;

--------------------------------------------------------------------------------

/*
    * CONCAT(STRING, STRING)        => 결과값 CHARACTER타입
*/
SELECT CONCAT('가나다', 'ABC') FROM DUAL;
SELECT '가나다' || 'ABC' FROM DUAL;

SELECT CONCAT('가나다', 'ABC', '123') FROM DUAL; -- 오류 발생. 두 개의 문자열만 연결할 수 있음.
SELECT '가나다' || 'ABC' || '123' FROM DUAL;

----------------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)         => 결과값은 CHARACTER타입
*/
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr','gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------------

/*
    < 숫자 처리 함수 >
    
    *ABS
    숫자의 절대값을 구해주는 함수
    
    ABS(NUMBER)     => 결과값은 NUMBER타입
    
    * ORACLE에서는 정수형, 실수형 구분하지 않고 모두 NUMBER타입
*/
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;
SELECT ABS(3)FROM DUAL;

----------------------------------------------------------------------------------

/*
    * MOD
    두 수를 나눈 나머지값을 반환해주는 함수 (JAVA에서의 %연산과 유사)
    
    MOD(NUMBER, NUMBER)     => 결과값 NUMBER타입
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

-----------------------------------------------------------------------------------

/*
    * ROUND
    반올림한 결과를 반환
    
    ROUND(NUMBER, [위치])     => 결과값은 NUMBER타입
    
    위치: 해당 위치까지 나타나도록 하겠다.
*/
SELECT ROUND(123.456) FROM DUAL; -- 위치 생략 시 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

---------------------------------------------------------------------------------

/*
    *CEIL
    올림처리해주는 함수
    위치 지정은 불가함.
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.152) FROM DUAL;


------------------------------------------------------------------------------

/*
    * FLOOR
    소수점 아래 버림처리하는 함수
    위치 지정은 불가함.
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.152) FROM DUAL;

-----------------------------------------------------------------------------

/*
    * TRUNC
    위치 지정 가능한 버림처리해주는 함수
    
    TRUNC(NUMBER, [위치])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456,-1) FROM DUAL;

---------------------------------------------------------------------------------

/*
    < 날짜 처리 함수 >
*/

-- * SYSDATE: 시스템 날짜 및 시간 반환 (현재 날짜 및 시간)
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2): 두 날짜 사이의 개월 수    => 내부적으로 DATE1 -DATE2 후 나누기 30, 31이 진행됨
--   => 결과값은 NUMBER타입
-- EMPLOYEE에서 사원명, 입사일, 근무일수 조회
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) "근무일수",
       CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월차' "근무개월수"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER): 특정 날짜에 해당 숫자만큼의 개월수를 더해 그 날짜 리턴
--   => 결과값 DATE타입
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE에서 사원명, 입사일, 입사 후 6개월이 된 날짜 조회
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, 요일(문자|숫자)): 특정 날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
--   => 결과값은 DATE타입
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금') FROM DUAL;
-- 1: 일요일, 2: 월요일, .... 7: 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL; -- 오류 발생 (현재 언어가 KOREAN으로 설정되어있기 때문)

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 언어를 영어로 변경

SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일') FROM DUAL; -- 오류 발생

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE): 해당 월의 마지막 날짜를 구해서 반환
--   => 결과값 DATE타입
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE에서 사원명, 입사일, 입사한 달의 마지막 날짜, 입사한 달에 근무한 일수
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT: 특정 날짜로부터 년도|월|일 값을 추출해서 반환하는 함수
    
    EXTRACT(YEAR FROM DATE): 년도만을 추출
    EXTRACT(MONTH FROM DATE): 월만을 추출
    EXTRACT(DAY FROM DATE): 일만을 추출
    
    => 결과값은 NUMBER타입
*/
-- 사원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME,
       EXTRACT(YEAR FROM HIRE_DATE) "입사년도",
       EXTRACT(MONTH FROM HIRE_DATE) "입사월",
       EXTRACT(DAY FROM HIRE_DATE) "입사일"
FROM EMPLOYEE
ORDER BY 입사년도, 입사월, 입사일;

----------------------------------------------------------------------------

/*
    < 형변환 함수 >
    
    * TO_CHAR: 숫자타입 또는 날짜타입의 값을 문자타입으로 변환해주는 함수
    
    TO_CHAR(숫자|날짜, [포맷])        => 결과값은 CHARACTER타입
*/
-- 숫자타입 => 문자타입
SELECT TO_CHAR(1234) FROM DUAL; -- '1234'

SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5칸짜리 공간확보, 오른쪽정렬, 빈칸공백
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 빈칸 0으로
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- 현재설정된 나라(LOCAL)의 화폐단위
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

-- 사원들의 급여, 연봉
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')"급여", TO_CHAR(SALARY * 12, 'L999,999,999')"연봉" -- 자리수는 넉넉하게 작성
FROM EMPLOYEE;

-- 날짜타입 => 문자타입
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- '21/09/16'
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- HH: 12시간형식
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- PM을 기재해도 현재 시간이 오전이면 결과값은 오전으로 나타남.
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- HH24: 24시간 형식
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD')
FROM EMPLOYEE;

-- EX) '1990년 02월 06일' 형식으로
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"')
FROM EMPLOYEE;

-- 년도와 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- 월과 관련된 포맷
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM') -- 로마 기호
FROM DUAL;

-- 일에대한 포맷
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 년 기준 N일째
       TO_CHAR(SYSDATE, 'DD'), -- 월 기준 N일째
       TO_CHAR(SYSDATE, 'D') -- 주 기준 N일째
FROM DUAL;

-- 요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
       
------------------------------------------------------------------------------

/*
    * TO_DATE: 숫자타입 또는 문자타입 데이터를 날짜타입으로 변환시켜주는 함수
    
    TO_DATE(숫자|문자, [포맷])        => 결과값 DATE타입
*/

SELECT TO_DATE(20200101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;
SELECT TO_DATE(070101) FROM DUAL; -- 에러 (0으로 시작하는 날짜를 만드려면 ''로 묶어줘야 함)
SELECT TO_DATE('070101') FROM DUAL;

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 결과값: 2098/06/30 -- YY: 무조건 현재세기로 반영함

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- RR: 해당 두 자리 년도값이 50미만일 경우 현재세기 반영, 50 이상일 경우 이전세기 반영

-------------------------------------------------------------------------------

/*
    * TO_NUMBER: 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
    
    TO_NUMBER(문자, [포맷])     => 결과값은 NUMBER타입
*/
SELECT TO_NUMBER('05123467') FROM DUAL;

SELECT '1000000' + '550000' FROM DUAL; --결과: 1550000 --> 오라클에서는 자동형변환이 잘 되어있음

SELECT '1,000,000' + '550,000' FROM DUAL; -- 에러 발생!

SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;



----------------------------------------------------------------------------

/*
    < NULL 처리 함수 >
*/
-- * NVL(컬럼, 해당컬럼값이 NULL일 경우 반환할 값)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

-- 전 사원의 이름, 보너스 포함 연봉
SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS,0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '부서없음')
FROM EMPLOYEE;

-- * NVL2(컬럼, 반환값1, 반환값2)
--   컬럼값이 존재할 경우 반환값1 반환
--   컬럼값이 NULL일 경우 반환값2 반환
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '부서있음', '부서없음')
FROM EMPLOYEE;

-- * NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 일치하면 NULL 반환
-- 두 개의 값이 일치하지 않으면 비교대상1값을 반환
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '234') FROM DUAL;

-------------------------------------------------------------------------------
/*
    < 선택 함수 >
    
    * DECODE(비교하고자하는대상(컬럼|산술연산|함수식), 비교값1, 결과값1, 비교값2, 결과값2, ..., 결과값N)
    
    SWITCH(비교대상) {
    CASE 비교값1: 
    CASE 비교값2:
    ...
    DEFAULT: 
    }
*/
-- 사번, 사원명, 주민번호, 성별
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별"
FROM EMPLOYEE;

-- 직원의 급여 조회 시 각 직급별로 인상해서 조회
-- J7인 사원은 급여를 10% 인상
-- J6인 사원은 급여를 15% 인상
-- J5인 사원은 급여를 20% 인상
-- 그 외의 사원은 급여를 5% 인상
SELECT EMP_NAME, JOB_CODE, SALARY 급여, 
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15, 
                        'J5', SALARY * 1.2, 
                              SALARY * 1.05) "인상된 급여"
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN 조건식1 THEN 결과값1
         WHEN 조건식2 THEN 결과값2
         ...
         ELSE 결과값N
    END
    
    (JAVA에서의 IF-ELSE IF문과 유사)
*/

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '고급'
            WHEN SALARY >= 3500000 THEN '중급'
            ELSE '초급'
       END "등급"
FROM EMPLOYEE;





















