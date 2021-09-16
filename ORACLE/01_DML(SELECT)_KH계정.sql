/*
    < SELECT >
    데이터 조회할 때 사용되는 구문
    
    >> RESULT SET: SELECT문을 통해 조회된 결과물 (즉, 조회된 행들의 집합을 의미)
    
    [표현법]
    SELECT 조회하고자하는 컬럼, 컬럼, 컬럼, ..
    FROM 테이블명;
*/

-- EMPLOYEE 테이블에 모든 컬럼 (*) 조회
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블에 사번, 이름, 급여만을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

select emp_id, emp_name, salary
from employee;
-- oracle의 키워드, 테이블명, 컬럼명 들은 대소문자를 구분하지 않음!

-- JOB 테이블에 모든 컬럼 조회
SELECT *
FROM JOB;

----------------------- 실습문제 --------------------------
-- 1. JOB 테이블에 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;
-- 2. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;
-- 3. DEPARTMENT 테이블에 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;
-- 4. EMPLOYEE 테이블에 사원명, 이메일, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

-------------------------------------------------------------------------

/*
    < 컬럼값을 통한 산술연산 >
    SELECT 절 컬럼명 작성 부분에 산술연산 기술 가능 (이 때 산술연산된 결과 조회)
*/
-- EMPLOYEE에 사원명, 사원의 연봉(급여*12) 조회
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

-- EMPLOYEE에 사원명, 급여, 보너스, 연봉, 보너스포함된연봉
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY + BONUS * SALARY) * 12
FROM EMPLOYEE;
--> 산술연산 과정 중 NULL값이 존재할 경우 산술연산한 결과값 마저도 무조건 NULL값으로 나옴.

-- EMPLOYEE에 사원명, 입사일, 근무일수
-- DATE형식끼리도 연산 가능
-- * 오늘날짜: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE
FROM EMPLOYEE;
-- DATE - DATE: 결과값은 일 단위!
-- 단, 값이 지저분하게 나오는 이유는 DATE형식은 년/월/일/시/분/초 단위로 시간정보까지 관리하기 때문

-- 현재 시스템 날짜 및 시간 조회
SELECT SYSDATE
FROM DUAL; -- 오라클에서 제공하는 가상테이블 (더미테이블)
--------------------------------------------------------------------------
/*
    < 컬럼명에 별칭 지정하기 >
    산술연산을 하게되면 컬럼명 지저분함.. 이 때 컬럼명으로 별칭 부여해서 깔끔하게 보여줌
    
    [표현법]
    컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
    
    AS 붙이든 안붙이든 부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 포함될 경우 반드시 더블쿼테이션("")로 묶어줘야함
*/
SELECT EMP_NAME 사원명, SALARY AS 급여, SALARY * 12 "연봉", (SALARY + SALARY* BONUS)*12 AS "총 소득"
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*
    < 리터럴 >
    임의로 지정한 문자열 ('')
    
    SELECT절에 리터럴을 제시하면 마치 테이블 상에 존재하는 데이터처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
*/
-- EMPLOYEE에 사번, 사원명, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY, '원'  AS 단위
FROM EMPLOYEE;

/*
    <연결 연산자: ||>
    여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음.
    
    System.out.println("num: " + num); // 여기서 '+'와 비슷한 개념
*/
-- 사번, 이름, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- 컬럼값과 리터럴 연결
-- XXX의 월급은 XXX원 입니다.
SELECT EMP_NAME || '의 월급은' || SALARY || '원 입니다.' "급여 정보"
FROM EMPLOYEE;

----------------------------------------------------------------------------

/*
    < DISTINCT >
    컬럼에 중복된 값들은 한 번씩만 표시하고자 할 때 사용
*/
-- EMPLOYEE에 직급코드 조회
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE에 직급코드 (중복제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE; -- 7행 조회

-- EMPLOYEE에 부서코드 (중복제거) 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

-- 유의사항: DISTINCT는 SELECT절에 딱 한 번만 기술 가능
/*
SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
FROM EMPLOYEE;
*/

SELECT DISTINCT JOB_CODE, DEPT_CODE
FROM EMPLOYEE;
-- (JOB_CODE, DEPT_CODE) 쌍으로 묶어 중복 판별


--=============================================================================

/*
    < WHERE 절 >
    조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 사용
    이 대 WHERE절에 조건식을 제시하게 됨
    조건식에서는 다양한 연산자들 사용 가능!
    
    [표현법]
    SELECT 조회하고자하는컬럼, 컬럼 || 산술연산, ...
    FROM 테이블명
    WHERE 조건식;
    
    >> 비교연산자 <<
    >, <, >=, <=        --> 대소비교
    =                   --> 같은지비교
    !=, ^=, <>          --> 같지않은지비교   
*/
-- EMPLOYEE에서 부서코드가 'D9'인 사원들만 조회 (이 때, 모든 컬럼 조회)
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE에서 부서코드가 'D1'인 사원들의 사원명, 급여만 조회
SELECT EMP_NAME, SALARY--, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

-- 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE <> 'D1';
-- WHERE DEPT_CODE != 'D1';
-- WHERE DEPT_CODE ^= 'D1';

-- 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYTEE에서 재직중(ENT_YN 컬럼값이 'N')인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';

---------------------------- 실습문제 -------------------------------------
-- 1. 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회
SELECT EMP_NAME, SALARY, HIRE_DATE, SALARY * 12 연봉
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT EMP_NAME, SALARY, SALARY * 12 연봉, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;
--WHERE 연봉 >= 50000000; -- 오류 (WHERE절에서는 SELECT절에서 작성된 별칭 사용 불가!)
-- 실행순서: FROM절 -> WHERE절 -> SELECT절

-- 3. 직급코드가 'J3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE <> 'J3';

------------------------------------------------------------------------------

/*
    < 논리 연산자 >
    여러개의 조건을 엮어서 제시하고자 할 때 사용
    
    AND (~이면서, 그리고)
    OR (~이거나, 또는)  
*/
-- 부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

-- 급여가 350만원 이상 600만원 이하를 받는 사원들의 사원명, 사번, 급여 조회
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <=6000000;

------------------------------------------------------------------------------

/*
    < BETWEEN AND >
    조건식에서 사용되는 구문
    ~이상 ~이하인 범위에 대한 조건을 제시할 때 사용되는 연산자 (초과, 미만은 해당 안됨)
    
    [표현법]
    비교대상컬럼 BETWEEN 하한값 AND 상한값
    => 해당 컬럼값이 하한값 이상이고 상한값 이하인 경우
*/
SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

SELECT EMP_NAME, EMP_ID, SALARY
FROM EMPLOYEE
--WHERE SALARY < 3500000 OR SALARY > 6000000;
--WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;
-- NOT: 논리부정연산자
-- 컬럼명 앞 또는 BETWEEN 앞에 기입 가능

-- 입사일이 '90/01/01' ~ '01/01/01'
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '01/01/01'; -- DATE 형식은 대소비교 가능!
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-----------------------------------------------------------------------------

/*
    < LIKE >
    비교하고자하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    
    - 특정패턴 제시 시 '%', '_'를 와일드카드로 사용할 수 있음
    >> '%': 0글자 이상
    EX) 비교대상컬럼 LIKE '문자%'   => 비교대상컬럼값이 문자로 '시작'되는 것을 조회
        비교대상컬럼 LIKE '%문자'   => 비교대상컬럼값이 문자로 '끝'나는 것을 조회
        비교대상컬럼 LIKE '%문자%'  => 비교대상컬럼값에 문자가 '포함'되는 것을 조회 (키워드검색에 사용됨)
        
    >> '_': 1글자
    EX) 비교대상컬럼 LIKE '_문자'   => 비교대상컬럼값에 문자앞에 무조건 한 글자가 올 경우 조회
        비교대상컬럼 LIKE '__문자'  => 비교대상컬럼값에 문자앞에 무조건 두 글자가 올 경우 조회
        비교대상컬럼 LIKE '_문자_'  => 비교대상컬럼값에 문자앞뒤에 무조건 한 글자씩 올 경우 조회
*/
-- 사원들 중 성이 전씨인 사원들의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름 중에 '하'가 포함된 사원들의 사원명, 주민번호, 전화번호 조회
SELECT EMP_NAME, EMP_NO, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 이름의 가운데 글자가 '하'인 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

-- 전화번호의 3번째 자리가 1인 사원들의 사번, 사원명, 전화번호, 이메일
-- 와일드카드: _(1글자), %(0글자 이상)
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';

-- 이메일 중 '_'앞글자가 3글자인 사원들의 사번, 이름, 이메일 조회
-- EX) sim_bs@kh.or.kr
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%'; -- 원하는 결과가 나오지 않음
-- 와일드 카드로 사용되고 있는 문자와 컬럼값에 담긴 문자가 동일하기 때문에 제대로 조회 안됨 (다 와일드카드 _로 인식함)
--> 어떤 것이 와일드카드고 어떤 것이 데이터값인지 구분해야함!
--> 데이터값으로 취급하고자하는 값 앞에 나만의 와일드카드를 제시하고 ESCAPE OPTION으로 등록하는 방법 사용!
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';

-- 위의 사원들이 아닌 그 외의 사원들 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE NOT EMAIL LIKE '___$_%' ESCAPE '$';
-- WHERE EMAIL NOT LIKE '___$_%' ESCAPE '$';
-- NOT은 컬럼명 앞 또는 LIKE 앞에 기입 가능

--------------------------------- 실습문제 --------------------------------------
-- 1. EMPLOYEE에서 이름이 '연'으로 끝나는 사원들의 사원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 2. EMPLOYEE에서 전화번호 처음 3자리가 010 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- 3. EMPLOYEE에서 이름에 '하'가 포함되어있고 급여가 240만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2400000;

-- 4. DEPARTMENT에서 해외영업부인 부서들의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

-----------------------------------------------------------------------------

/*
    < IS NULL / IS NOT NULL >
    컬럼값에 NULL이 있을 경우 NULL값 비교에 사용되는 연산자
*/
-- 보너스를 받지 않는 사원(BONUS값이 NULL인)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS = NULL; -- 정상적으로 조회 안 됨.
WHERE BONUS IS NULL;

-- 보너스를 받는 사원(BONUS값이 NULL이 아닌)들의 사번, 이름, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
--WHERE BONUS != NULL; -- 정상적으로 조회 안 됨.
--WHERE BONUS IS NOT NULL;
WHERE NOT BONUS IS NULL;
-- NOT은 컬럼명 앞 또는 IS 뒤에 기입 가능

-- 사수가 없는 사원(MANAGER_ID값이 NULL인)들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- 부서배치를 아직 받지 않고 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

------------------------------------------------------------------------------

/*
    < IN >
    비교대상컬럼값이 내가 제시한 목록 중에 일치하는 값이 있는지
    
    [표현법]
    비교대상컬럼 IN ('값1', '값2', '값3', ...)
*/
-- 부서코드가 D6이거나 D8이거나 D5인 부서원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
WHERE DEPT_CODE IN ('D6', 'D8', 'D5');

-- 그 외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6', 'D8', 'D5');

--=============================================================================

/*
    < 연산자 우선순위 >
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL / LIKE '특정패턴' / IN
    5. BETWEEN AND 
    6. NOT (논리연산자)
    7. AND (논리연산자)
    8. OR (논리연산자)
*/
-- ** OR보다 AND가 먼저 연산됨!
-- 직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;


--------------------------- 실습문제 ----------------------------------------
-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 (사원명, 사수사번, 부서코드) 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL 
  AND DEPT_CODE IS NULL;

-- 2. 연봉(보너스포함X)이 3000만원 이상이고 보너스를 받지 않는 사원들의 (사번, 사원명, 급여, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY * 12 >= 30000000 
  AND BONUS IS NULL;

-- 3. 입사일이 '95/01/01'이상이고 부서배치를 받은 사원들의 (사번, 사원명, 입사일, 부서코드) 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' 
  AND DEPT_CODE IS NOT NULL;

-- 4. 급여가 200만원 이상 500만원 이하고 입사일이 '01/01/01'이상이고 보너스를 받지 않는 사원들의 
--   (사번, 사원명, 급여, 입사일, 보너스) 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000) 
  AND HIRE_DATE >= '01/01/01' 
  AND BONUS IS NULL;

-- 5. 보너스포함연봉이 NULL이 아니고 이름에 '하'가 포함되어있는 사원들의 (사번, 사원명, 급여, 보너스포함연봉) 조회 (별칭부여)
SELECT EMP_ID, EMP_NAME, SALARY, (SALARY + SALARY * BONUS) * 12 "보너스 포함 연봉"
FROM EMPLOYEE
WHERE (SALARY + SALARY * BONUS) * 12 IS NOT NULL 
  AND EMP_NAME LIKE '%하%';
  

----------------------------------------------------------------------------------
SELECT EMP_ID, EMP_NAME, SALARY -- 3번째로 실행
FROM EMPLOYEE -- 1번째로 실행
WHERE DEPT_CODE IS NULL; -- 2번째로 실행
--===============================================================================

/*
    < ORDER BY 절 >
    SELECT문 가장 마지막 줄에 작성 뿐만아니라 실행순서 또한 마지막에 실행
    
    [표현법]
    SELECT 조회할컬럼, 컬럼, 산술연산식 AS "별칭", ...
    FROM 조회하고자하는 테이블명
    WHERE 조건식
    ORDER BY 정렬기준의컬럼명|별칭|컬럼순번   [ASC|DESC]  [NULLS FIRST|NULLS LAST];
    
    - ASC: 오름차순 정렬 (생략 시 기본값)
    - DESC: 내림차순 정렬
    
    - NULLS FIRST: 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 데이터를 맨 앞에 배치 (생략 시 DESC일 때의 기본값)
    - NULLS LAST: 정렬하고자 하는 컬럼값에 NULL이 있을 경우 해당 데이터를 맨 뒤에 배치 (생략 시 ASC일 때의 기본값)   
*/

SELECT *
FROM EMPLOYEE
--ORDER BY BONUS;   
--ORDER BY BONUS ASC;                -- 오름차순 정렬일 때 기본적으로 NULLS LAST!
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC;               -- 내림차순 정렬일 때 기본적으로 NULLS FIRST!
ORDER BY BONUS DESC, SALARY ASC;     -- 정렬기준 여러개 제시 가능(첫번째 기준의 컬럼값이 중복될 경우 두번째 기준의 컬럼을 가지고 정렬함)

-- 전 사원의 사원명, 연봉 조회 (이 때 연봉별 내림차순 정렬 조회)
SELECT EMP_NAME, SALARY * 12 "연봉"
FROM EMPLOYEE
--ORDER BY SALARY * 12 DESC;
--ORDER BY 연봉 DESC;   -- 별칭 사용 가능
ORDER BY 2 DESC;       -- 컬럼 순번 사용 가능





