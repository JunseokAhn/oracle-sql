--�ִ� �޿��� 10000�̻��� �μ��� �������

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING MAX(SALARY)>10000);


-- Seattle�� �ִ� �μ��� 3���̻� �Ի��� ��
SELECT TO_CHAR( HIRE_DATE, 'YYYY/MON')
FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID)
    JOIN LOCATIONS USING(LOCATION_ID)
WHERE CITY = 'Seattle'
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY/MON')
HAVING COUNT(*) >=3;
     

--���� Hunold�� ����� ����ϴ� Department�� �������

SELECT *
FROM DEPARTMENTS DM
WHERE DM.MANAGER_ID =
(SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE LOWER(LAST_NAME)='hunold');
--��������� ���� ��������� �������ִ� �ִ�޿�
select *
from jobs
where job_id =
(select job_id from employees where salary=
(select max(salary) from employees)); 


--5���̻� ���������� �Ŵ��� �Ŵ����� �������
select *
from employees em3
where em3.employee_id in(
select em2.employee_id
from employees em join employees em2 on (em.manager_id = em2.employee_id)
group by em2.employee_id
having count(*) >=5);

--it���α׷��ӷ� ���ߴ� ������� �����ϴ� ��
select em.job_id
from employees em join job_history hi using(employee_id)
where hi.job_id = 'IT_PROG';

select * from job_history;
-- �̸��� �̸��ϰ� �������� ����ϴ� ������� �̸��� �̸��� > FIRST_NAME�� ù���� + LAST_NAME
select first_name||' '||last_name �̸�, email
from employees
where email = upper(substr(first_name, 1, 1) || last_name);



--���쿡 ��ġ�� sports�μ��� ����µ�, �Ŵ�������� 120, �μ�id�� �˸°� ����
INSERT INTO DEPARTMENTS
(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES
(4502, 'SPORTS', 120, 1200);


--�ڱ� ��纸�� ���� �Ի��� ������� �������
select em.*
from employees em join employees em2 on (em.manager_id = em2.employee_id)
where em.hire_date > em2.hire_date;




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
--             AND em3.employee_id = ����.����id SELECT
--    e1.first_name
--FROM
--    employees   e1
--    JOIN employees   e2 ON ( e1.manager_id = e2.employee_id )
--WHERE
--    e1.hire_date < e2.hire_date;
--    
--
--
