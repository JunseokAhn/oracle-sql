--최대 급여가 10000이상인 부서의 모든정보

SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM EMPLOYEES
GROUP BY DEPARTMENT_ID HAVING MAX(SALARY)>10000);


-- Seattle에 있는 부서중 3명이상 입사한 달
SELECT TO_CHAR( HIRE_DATE, 'YYYY/MON')
FROM EMPLOYEES JOIN DEPARTMENTS USING(DEPARTMENT_ID)
    JOIN LOCATIONS USING(LOCATION_ID)
WHERE CITY = 'Seattle'
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY/MON')
HAVING COUNT(*) >=3;
     

--성이 Hunold인 사람이 담당하는 Department의 모든정보

SELECT *
FROM DEPARTMENTS DM
WHERE DM.MANAGER_ID =
(SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE LOWER(LAST_NAME)='hunold');
--현재봉급이 가장 높은사람이 받을수있는 최대급여
select *
from jobs
where job_id =
(select job_id from employees where salary=
(select max(salary) from employees)); 


--5명이상 부하직원을 거느린 매니저의 모든정보
select *
from employees em3
where em3.employee_id in(
select em2.employee_id
from employees em join employees em2 on (em.manager_id = em2.employee_id)
group by em2.employee_id
having count(*) >=5);

--it프로그래머로 일했던 사람들이 지금하는 일
select em.job_id
from employees em join job_history hi using(employee_id)
where hi.job_id = 'IT_PROG';

select * from job_history;
-- 이름을 이메일과 관련지어 사용하는 사람들의 이름과 이메일 > FIRST_NAME의 첫글자 + LAST_NAME
select first_name||' '||last_name 이름, email
from employees
where email = upper(substr(first_name, 1, 1) || last_name);



--도쿄에 위치한 sports부서를 만드는데, 매니저사번은 120, 부서id는 알맞게 생성
INSERT INTO DEPARTMENTS
(DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES
(4502, 'SPORTS', 120, 1200);


--자기 상사보다 먼저 입사한 사원들의 모든정보
select em.*
from employees em join employees em2 on (em.manager_id = em2.employee_id)
where em.hire_date > em2.hire_date;




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
--             AND em3.employee_id = 조건.부하id SELECT
--    e1.first_name
--FROM
--    employees   e1
--    JOIN employees   e2 ON ( e1.manager_id = e2.employee_id )
--WHERE
--    e1.hire_date < e2.hire_date;
--    
--
--
