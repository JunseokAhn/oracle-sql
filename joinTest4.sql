--최대 급여가 10000이상인 부서의 모든정보
--SELECT DM.department_id, DM.department_name, DM.location_id, DM.manager_id
--FROM
--    EMPLOYEES EM, DEPARTMENTS DM
--WHERE dm.department_id = em.department_id
--GROUP BY DM.department_id, DM.department_name, DM.location_id, DM.manager_id
--HAVING MAX(SALARY)>=10000

-- Seattle에 있는 부서중 3명이상 입사한 달


--성이 Hunold인 사람이 담당하는 Department의 모든정보
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
    

--현재봉급이 가장 높은사람이 받을수있는 최대급여
--SELECT MAX_SALARY
--FROM 
--    (SELECT JOB_ID  FROM EMPLOYEES WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEES)) JOB_ID,
--    JOBS JB
--WHERE JOB_ID.JOB_ID = JB.JOB_ID

--5명이상 부하직원을 거느린 매니저의 모든정보

--SELECT*
--FROM(SELECT
--    em2.employee_id
--FROM
--    (
--        SELECT
--            dm.department_id 부서id
--        FROM
--            departments   dm,
--            employees     em
--        WHERE
--            em.department_id = dm.department_id
--        GROUP BY
--            dm.department_id
--        HAVING
--            COUNT(em.employee_id) > 4
--    )조건,
--    departments   dm2,
--    employees     em2
--WHERE
--     조건.부서id = dm2.department_id
--    AND dm2.manager_id = em2.employee_id) 조건2,
--    EMPLOYEES EM3
--    
--WHERE 조건2.employee_id = em3.employee_id


--IT프로그래머로 일했던 사람들이 지금하는 일 //


-- 이름을 이메일과 관련지어 사용하는 사람들의 이름과 이메일 > FIRST_NAME의 첫글자 + LAST_NAME
--SELECT
--    em.first_name
--    || ' '
--    || em.last_name 이름,
--    em.email
--FROM
--    employees em
--WHERE
--    upper(substr(em.first_name, 1, 1)
--          || em.last_name) = em.email


--도쿄에 위치한 sports부서를 만드는데, 매니저사번은 120, 부서id는 알맞게 생성
--INSERT INTO DEPARTMENTS
--(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
--VALUES
--(4502, 'SPORTS', 120, 1200)


--자기 상사보다 먼저 입사한 사원들의 모든정보
--SELECT em3.first_name
--FROM
--(SELECT em.hire_date 부하입사일, em.employee_id 부하ID, em2.hire_date 상사입사일, em2.employee_id 상사ID
--FROM 
--    EMPLOYEES EM, EMPLOYEES EM2
--WHERE
--    EM.MANAGER_ID = EM2.EMPLOYEE_ID) 조건,
--    employees EM3
-- WHERE 조건.부하입사일 < 조건.상사입사일
--            AND em3.employee_id = 조건.부하id
--             AND em3.employee_id = 조건.부하id
             
--    SELECT E1.FIRST_NAME FROM  EMPLOYEES E1 JOIN EMPLOYEES E2 ON (E1.MANAGER_ID=E2.EMPLOYEE_ID) 
--WHERE E1.HIRE_DATE < E2.HIRE_DATE
    


