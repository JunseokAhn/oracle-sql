--�ִ� �޿��� 10000�̻��� �μ��� �������
--SELECT DM.department_id, DM.department_name, DM.location_id, DM.manager_id
--FROM
--    EMPLOYEES EM, DEPARTMENTS DM
--WHERE dm.department_id = em.department_id
--GROUP BY DM.department_id, DM.department_name, DM.location_id, DM.manager_id
--HAVING MAX(SALARY)>=10000

-- Seattle�� �ִ� �μ��� 3���̻� �Ի��� ��


--���� Hunold�� ����� ����ϴ� Department�� �������
--SELECT *
--FROM
--(SELECT EM.EMPLOYEE_ID
--FROM
--    EMPLOYEES EM, DEPARTMENTS DM
--WHERE
--    EM.DEPARTMENT_ID = DM.DEPARTMENT_ID
--    AND
--    LAST_NAME = 'Hunold') TB,
--    DEPARTMENTS DM
--WHERE dm.manager_id=tb.employee_id
    

--��������� ���� ��������� �������ִ� �ִ�޿�
--SELECT MAX_SALARY
--FROM 
--    (SELECT JOB_ID  FROM EMPLOYEES WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEES)) JOB_ID,
--    JOBS JB
--WHERE JOB_ID.JOB_ID = JB.JOB_ID

--5���̻� ���������� �Ŵ��� �Ŵ����� �������

--SELECT*
--FROM(SELECT
--    em2.employee_id
--FROM
--    (
--        SELECT
--            dm.department_id �μ�id
--        FROM
--            departments   dm,
--            employees     em
--        WHERE
--            em.department_id = dm.department_id
--        GROUP BY
--            dm.department_id
--        HAVING
--            COUNT(em.employee_id) > 4
--    )����,
--    departments   dm2,
--    employees     em2
--WHERE
--     ����.�μ�id = dm2.department_id
--    AND dm2.manager_id = em2.employee_id) ����2,
--    EMPLOYEES EM3
--    
--WHERE ����2.employee_id = em3.employee_id


--IT���α׷��ӷ� ���ߴ� ������� �����ϴ� �� //


-- �̸��� �̸��ϰ� �������� ����ϴ� ������� �̸��� �̸��� > FIRST_NAME�� ù���� + LAST_NAME
--SELECT
--    em.first_name
--    || ' '
--    || em.last_name �̸�,
--    em.email
--FROM
--    employees em
--WHERE
--    upper(substr(em.first_name, 1, 1)
--          || em.last_name) = em.email


--���쿡 ��ġ�� sports�μ��� ����µ�, �Ŵ�������� 120, �μ�id�� �˸°� ����
--INSERT INTO DEPARTMENTS
--(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
--VALUES
--(4502, 'SPORTS', 120, 1200)


--�ڱ� ��纸�� ���� �Ի��� ������� �������
--SELECT em3.first_name
--FROM
--(SELECT em.hire_date �����Ի���, em.employee_id ����ID, em2.hire_date ����Ի���, em2.employee_id ���ID
--FROM 
--    EMPLOYEES EM, EMPLOYEES EM2
--WHERE
--    EM.MANAGER_ID = EM2.EMPLOYEE_ID) ����,
--    employees EM3
-- WHERE ����.�����Ի��� < ����.����Ի���
--            AND em3.employee_id = ����.����id
--             AND em3.employee_id = ����.����id
             
--    SELECT E1.FIRST_NAME FROM  EMPLOYEES E1 JOIN EMPLOYEES E2 ON (E1.MANAGER_ID=E2.EMPLOYEE_ID) 
--WHERE E1.HIRE_DATE < E2.HIRE_DATE
    


