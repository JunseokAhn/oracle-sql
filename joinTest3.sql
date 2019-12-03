--CREATE TABLE USERINFO(
--ID VARCHAR2(18) PRIMARY KEY,
--PW VARCHAR2(30) NOT NULL,
--SEX CHAR, --������ �ѱ��ڶ� ����X
--AGE NUMBER, --���� ����X
--PHONE VARCHAR2(13) UNIQUE
--)
--
--SELECT * FROM USERINFO
--
--DELETE USERINFO
--
--DROP TABLE USERINFO
--
--INSERT INTO USERINFO
--VALUES
--('ID1')
--
--INSERT INTO USERINFO
--VALUES
--('ID2', 'PW1', 'M', 28, '010-2106-6534')
--
--INSERT INTO USERINFO
--(ID, PW, SEX, AGE, PHONE)
--VALUES
--('ID1', 'PW1', 'M', 28, '010-2106-6534')
--
--
--INSERT INTO USERINFO
--(ID, PW, SEX, AGE, PHONE)
--VALUES
--('ID2', 'PW2', 'M', 24, '123')
--
--DELETE USERINFO
--WHERE
--    PW='PW2'
--
--UPDATE USERINFO
--SET
--    PW='PW2'
--WHERE
--    PW='PW1'
--    
--    DROP TABLE USERINFO
--ROLLBACK
--
--SELECT   * FROM USERINFO
--COMMIT
--
--CREATE TABLE USERINFO(
--ID VARCHAR2(15) PRIMARY KEY,
--PW VARCHAR2(30) NOT NULL,
--NAME VARCHAR2(9) NOT NULL,
--AGE NUMBER,
--PHONE VARCHAR2(13) UNIQUE,
--INDATE DATE NOT NULL
--)
--DROP TABLE USERINFO
--
--INSERT INTO USERINFO
--(ID, PW, NAME, AGE, PHONE, INDATE)
--VALUES
--('ID1', 'PW1', 'NAME1', 1, '123-1321',SYSDATE)
--
--SELECT * FROM USERINFO
--
--UPDATE USERINFO
--    SET NAME='NAME3'
--WHERE ID='ID1'
--
--
--CREATE TABLE BOARD(
--BOARD_SEQ NUMBER PRIMARY KEY,
--ID VARCHAR2(15),
--NAME VARCHAR2(255) NOT NULL,
--TITLE VARCHAR2(300) NOT NULL,
--CONTENTS VARCHAR2(1000),
--INDATE DATE,
--CONSTRAINT FK_ID FOREIGN KEY (ID) REFERENCES USERINFO(ID)
--)
--
--SELECT * FROM BOARD
--SELECT * FROM USERINFO
--
--INSERT INTO BOARD
--(BOARD_SEQ, ID, NAME, TITLE, CONTENTS, INDATE)
--VALUES
--('1', 'ID1', 'NAME1', 'THIS', 'WW', SYSDATE)
--
--CREATE TABLE REPLY(
--REPLY_SEQ NUMBER PRIMARY KEY,
--BOARD_SEQ NUMBER,
--ID VARCHAR2(15),
--CONTENTS VARCHAR2(255) NOT NULL,
--INDATE DATE,
--CONSTRAINT FK_SEQ FOREIGN KEY(BOARD_SEQ) REFERENCES BOARD(BOARD_SEQ) ON DELETE CASCADE,
--CONSTRAINT FK_ID2 FOREIGN KEY(ID) REFERENCES USERINFO(ID) -- == BOARD���� �����͵� ��
--)
--
--DROP TABLE REPLY
--
--CREATE SEQUENCE BOARD_SEQ
--
--SELECT * FROM REPLY
--
--INSERT INTO REPLY
--(REPLY_SEQ, BOARD_SEQ, ID, CONTENTS, INDATE)
--VALUES
--(BOARD_SEQ.NEXTVAL, 1, 'ID1', 'TEST', SYSDATE)
--
--DELETE REPLY
--WHERE ID='ID1'
--
--DESC EMPLOYEES
--DESC DEPARTMENTS
--DESC job_history

SELECT 
    SUBSTR (LAST_NAME, 1, 4)�̸�,
    START_DATE ����������, 
    END_DATE ����������, 
    NEXT_DAY(END_DATE+INTERVAL '3'MONTH, '������') ������������Ⱓ
FROM 
    JOB_HISTORY HI, 
    EMPLOYEES EM
WHERE 
    EM.EMPLOYEE_ID = HI.EMPLOYEE_ID
    AND
    LOWER(FIRST_NAME) NOT LIKE '%ai%'
    and 
    LOWER(LAST_NAME) NOT LIKE '%ai%'
--

SELECT
    ROUND(AVG(SALARY), -3) "��� ����", 
    DEPARTMENT_NAME �μ���
FROM 
    DEPARTMENTS DM, 
    EMPLOYEES EM
WHERE 
    EM.DEPARTMENT_ID = DM.DEPARTMENT_ID
GROUP BY 
    DEPARTMENT_NAME


SELECT
    DEPARTMENT_NAME �μ���,
    MAX(SALARY) �ִ����
FROM
    DEPARTMENTS DM, EMPLOYEES EM
WHERE
    DM.DEPARTMENT_ID = EM.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME

SELECT DEPARTMENT_NAME, MAX(SALARY), LEADER
FROM 
    EMPLOYEES EMP,
    (SELECT
        DEPARTMENT_NAME, LAST_NAME || ' ' ||FIRST_NAME LEADER, EM.DEPARTMENT_ID
    FROM 
        DEPARTMENTS DM, EMPLOYEES EM
    WHERE
        DM.MANAGER_ID = EM.EMPLOYEE_ID(+)) DEP
WHERE DEP.DEPARTMENT_ID = EMP.DEPARTMENT_ID
GROUP BY DEP.DEPARTMENT_ID, LEADER, DEPARTMENT_NAME












--��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�. 
--   ��� �� �⵵�� �������� �������� �����Ͻÿ�. 



