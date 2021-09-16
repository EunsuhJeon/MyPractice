/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ
    
    - ������ �Լ�: N���� ���� �о�鿩�� N���� ������� ���� (�� �ึ�� �Լ� ���� ��� ��ȯ)
    - �׷� �Լ�: N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT���� ������ �Լ��� �׷��Լ��� �Բ� ��� ����!
       ��? ��� ���� ������ �ٸ��� ������!
       
    >> �Լ����� ����� �� �ִ� ��ġ: SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/

--=============================== < ������ �Լ� > ===================================
/*
    < ���� ó�� �Լ� >
    * LENGTH / LENGTHB      => ����� NUMBERŸ��
    LENGTH(�÷�|'���ڿ���'): �ش� ���ڿ����� ���ڼ� ��ȯ
    LENGTHB(�÷�|'���ڿ���'): �ش� ���ڿ����� ����Ʈ�� ��ȯ
    
    '��' '��' '��' �ѱ� �� ���� �� 3BYTE
    ������, ����, Ư������ �� ���� �� 1BYTE
*/
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- �������̺�

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;
 
SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

------------------------------------------------------------------------------

/*
    *INSTR
    ���ڿ��κ��� Ư�� ������ ���� ��ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ���', 'ã�����ϴ¹���', [ã����ġ�ǽ��۰�, [����]])           => ������� NUMBERŸ��
    
    ã�� ��ġ�� ���۰�
    1: �տ������� ã�ڴ�.
    -1: �ڿ������� ã�ڴ�.
    
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ã����ġ�ǽ��۰��� 1�� �⺻��, ������ 1�� �⺻��.
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1) "_��ġ", INSTR(EMAIL, '@') "@��ġ" 
FROM EMPLOYEE;

-----------------------------------------------------------------------------------

/*
    * SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ (�ڹٿ��� substring()�޼ҵ�� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])          => ������� CHARACTER(���ڿ�)Ÿ��
    - STRING: ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION: ���ڿ��� ������ ������ġ��
    - LENGTH: ������ ���� ���� (���� �� ������ ����)
*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO,8,1) "����"
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3')
ORDER BY 1;

-- �Լ� ��ø���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1) "���̵�"
FROM EMPLOYEE;

-------------------------------------------------------------------------------

/*
    * LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰����ϴ� ����])       => ������� CHARACTERŸ��
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
*/
-- 20��ŭ�� ���� �� EMAIL�÷����� ���������� �����ϰ� ������ �κ��� �������� ä���� (����)
SELECT EMP_NAME, LPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ���� �� �⺻���� ����!
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850918-2****** ��ȸ
SELECT RPAD('850918-2', 14, '*')
FROM DUAL;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8), 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME, SUBSTR(EMP_NO,1,8) || '******'
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM/RTRIM(STRING, [�����ϰ����ϴ¹��ڵ�])       => ������� CHARACTERŸ��
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ����ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
*/
SELECT LTRIM('   K H ') FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;

/*
    *TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    
    TRIM([LEADING|TRAILING|BOTH] �����ϰ����ϴ¹��ڵ� FROM STRING)
*/
SELECT TRIM('   K H      ') FROM DUAL;
SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING: �� => LTRIM�� ����
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING: �� => RTRIM�� ����
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- BOTH: ����  => ���� �� �⺻��

-----------------------------------------------------------------------------------

/*
    *LOWER / UPPER/ INITCAP
    
    LOWER/UPPER/INITCAP(STRING)        => ������� CHARACTERŸ��
    
    LOWER: �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toLowerCase()�޼ҵ� ����)
    UPPER: �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toUpperCase()�޼ҵ� ����)
    INITCAP: �ܾ� �� ���ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ 
*/
SELECT LOWER('Welcom To My World!') FROM DUAL;
SELECT UPPER('Welcom To My World!') FROM DUAL;
SELECT INITCAP('welcom to myworld!') FROM DUAL;

--------------------------------------------------------------------------------

/*
    * CONCAT(STRING, STRING)        => ����� CHARACTERŸ��
*/
SELECT CONCAT('������', 'ABC') FROM DUAL;
SELECT '������' || 'ABC' FROM DUAL;

SELECT CONCAT('������', 'ABC', '123') FROM DUAL; -- ���� �߻�. �� ���� ���ڿ��� ������ �� ����.
SELECT '������' || 'ABC' || '123' FROM DUAL;

----------------------------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)         => ������� CHARACTERŸ��
*/
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr','gmail.com')
FROM EMPLOYEE;

-------------------------------------------------------------------------------

/*
    < ���� ó�� �Լ� >
    
    *ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER)     => ������� NUMBERŸ��
    
    * ORACLE������ ������, �Ǽ��� �������� �ʰ� ��� NUMBERŸ��
*/
SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;
SELECT ABS(3)FROM DUAL;

----------------------------------------------------------------------------------

/*
    * MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ� (JAVA������ %����� ����)
    
    MOD(NUMBER, NUMBER)     => ����� NUMBERŸ��
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

-----------------------------------------------------------------------------------

/*
    * ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND(NUMBER, [��ġ])     => ������� NUMBERŸ��
    
    ��ġ: �ش� ��ġ���� ��Ÿ������ �ϰڴ�.
*/
SELECT ROUND(123.456) FROM DUAL; -- ��ġ ���� �� 0
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456, -1) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

---------------------------------------------------------------------------------

/*
    *CEIL
    �ø�ó�����ִ� �Լ�
    ��ġ ������ �Ұ���.
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.152) FROM DUAL;


------------------------------------------------------------------------------

/*
    * FLOOR
    �Ҽ��� �Ʒ� ����ó���ϴ� �Լ�
    ��ġ ������ �Ұ���.
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.152) FROM DUAL;

-----------------------------------------------------------------------------

/*
    * TRUNC
    ��ġ ���� ������ ����ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456,-1) FROM DUAL;

---------------------------------------------------------------------------------

/*
    < ��¥ ó�� �Լ� >
*/

-- * SYSDATE: �ý��� ��¥ �� �ð� ��ȯ (���� ��¥ �� �ð�)
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2): �� ��¥ ������ ���� ��    => ���������� DATE1 -DATE2 �� ������ 30, 31�� �����
--   => ������� NUMBERŸ��
-- EMPLOYEE���� �����, �Ի���, �ٹ��ϼ� ��ȸ
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) "�ٹ��ϼ�",
       CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������' "�ٹ�������"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER): Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� �� ��¥ ����
--   => ����� DATEŸ��
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE���� �����, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����)): Ư�� ��¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
--   => ������� DATEŸ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- 1: �Ͽ���, 2: ������, .... 7: �����
SELECT SYSDATE, NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL; -- ���� �߻� (���� �� KOREAN���� �����Ǿ��ֱ� ����)

-- ��� ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- �� ����� ����

SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL; -- ���� �߻�

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE): �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
--   => ����� DATEŸ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE���� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� �޿� �ٹ��� �ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT: Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    EXTRACT(YEAR FROM DATE): �⵵���� ����
    EXTRACT(MONTH FROM DATE): ������ ����
    EXTRACT(DAY FROM DATE): �ϸ��� ����
    
    => ������� NUMBERŸ��
*/
-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,
       EXTRACT(YEAR FROM HIRE_DATE) "�Ի�⵵",
       EXTRACT(MONTH FROM HIRE_DATE) "�Ի��",
       EXTRACT(DAY FROM HIRE_DATE) "�Ի���"
FROM EMPLOYEE
ORDER BY �Ի�⵵, �Ի��, �Ի���;

----------------------------------------------------------------------------

/*
    < ����ȯ �Լ� >
    
    * TO_CHAR: ����Ÿ�� �Ǵ� ��¥Ÿ���� ���� ����Ÿ������ ��ȯ���ִ� �Լ�
    
    TO_CHAR(����|��¥, [����])        => ������� CHARACTERŸ��
*/
-- ����Ÿ�� => ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL; -- '1234'

SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ¥�� ����Ȯ��, ����������, ��ĭ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- ��ĭ 0����
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- ���缳���� ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

-- ������� �޿�, ����
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')"�޿�", TO_CHAR(SALARY * 12, 'L999,999,999')"����" -- �ڸ����� �˳��ϰ� �ۼ�
FROM EMPLOYEE;

-- ��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- '21/09/16'
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- HH: 12�ð�����
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- PM�� �����ص� ���� �ð��� �����̸� ������� �������� ��Ÿ��.
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL; -- HH24: 24�ð� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD')
FROM EMPLOYEE;

-- EX) '1990�� 02�� 06��' ��������
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM') -- �θ� ��ȣ
FROM DUAL;

-- �Ͽ����� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), -- �� ���� N��°
       TO_CHAR(SYSDATE, 'DD'), -- �� ���� N��°
       TO_CHAR(SYSDATE, 'D') -- �� ���� N��°
FROM DUAL;

-- ���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'DY')
FROM DUAL;
       
------------------------------------------------------------------------------

/*
    * TO_DATE: ����Ÿ�� �Ǵ� ����Ÿ�� �����͸� ��¥Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_DATE(����|����, [����])        => ����� DATEŸ��
*/

SELECT TO_DATE(20200101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;
SELECT TO_DATE(070101) FROM DUAL; -- ���� (0���� �����ϴ� ��¥�� ������� ''�� ������� ��)
SELECT TO_DATE('070101') FROM DUAL;

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- �����: 2098/06/30 -- YY: ������ ���缼��� �ݿ���

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- RR: �ش� �� �ڸ� �⵵���� 50�̸��� ��� ���缼�� �ݿ�, 50 �̻��� ��� �������� �ݿ�

-------------------------------------------------------------------------------

/*
    * TO_NUMBER: ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_NUMBER(����, [����])     => ������� NUMBERŸ��
*/
SELECT TO_NUMBER('05123467') FROM DUAL;

SELECT '1000000' + '550000' FROM DUAL; --���: 1550000 --> ����Ŭ������ �ڵ�����ȯ�� �� �Ǿ�����

SELECT '1,000,000' + '550,000' FROM DUAL; -- ���� �߻�!

SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('550,000', '999,999') FROM DUAL;



----------------------------------------------------------------------------

/*
    < NULL ó�� �Լ� >
*/
-- * NVL(�÷�, �ش��÷����� NULL�� ��� ��ȯ�� ��)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

-- �� ����� �̸�, ���ʽ� ���� ����
SELECT EMP_NAME, (SALARY + SALARY * NVL(BONUS,0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�μ�����')
FROM EMPLOYEE;

-- * NVL2(�÷�, ��ȯ��1, ��ȯ��2)
--   �÷����� ������ ��� ��ȯ��1 ��ȯ
--   �÷����� NULL�� ��� ��ȯ��2 ��ȯ
SELECT EMP_NAME, BONUS, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
FROM EMPLOYEE;

-- * NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� ��ġ�ϸ� NULL ��ȯ
-- �� ���� ���� ��ġ���� ������ �񱳴��1���� ��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '234') FROM DUAL;

-------------------------------------------------------------------------------
/*
    < ���� �Լ� >
    
    * DECODE(���ϰ����ϴ´��(�÷�|�������|�Լ���), �񱳰�1, �����1, �񱳰�2, �����2, ..., �����N)
    
    SWITCH(�񱳴��) {
    CASE �񱳰�1: 
    CASE �񱳰�2:
    ...
    DEFAULT: 
    }
*/
-- ���, �����, �ֹι�ȣ, ����
SELECT EMP_ID, EMP_NAME, EMP_NO, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') "����"
FROM EMPLOYEE;

-- ������ �޿� ��ȸ �� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ�
-- J6�� ����� �޿��� 15% �λ�
-- J5�� ����� �޿��� 20% �λ�
-- �� ���� ����� �޿��� 5% �λ�
SELECT EMP_NAME, JOB_CODE, SALARY �޿�, 
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 
                        'J6', SALARY * 1.15, 
                        'J5', SALARY * 1.2, 
                              SALARY * 1.05) "�λ�� �޿�"
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����N
    END
    
    (JAVA������ IF-ELSE IF���� ����)
*/

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '���'
            WHEN SALARY >= 3500000 THEN '�߱�'
            ELSE '�ʱ�'
       END "���"
FROM EMPLOYEE;





















