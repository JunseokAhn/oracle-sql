--------select last_name,first_name,employee_id,salary
--------from employees
--------where job_id ='FI_ACCOUNT' and salary >5000
------
--------select last_name,first_name,employee_id,salary
--------from employees
--------where salary>2000 and job_id = 'PU_CLERK'
----------order by salary desc
--------
------select employee_id,last_name,first_name,department_name
------from employees,departments
------where employees.salary between 4000 and 8000 and employees.job_id='FI_ACCOUNT'
------and employees.manager_id = departments.manager_id
----
------select employee_id, last_name , first_name
------from employees,departments
------where departments.department_name = 'Finance' --and departments.department_id = employees.department_id
------
------select avg(salary) 평균봉급
------from employees,departments
------where departments.department_name = 'Finance' and departments.department_id = employees.department_id
------
------select max(salary) 최고봉급
------from employees,departments
------where departments.department_name = 'Executive' and departments.department_id = employees.department_id
----
------select *
------from employees
------where salary > (
------select avg(salary) from employees
------)
----
----
----select *
----from employees,departments,locations
----where employees.employee_id=departments.department_id
----and departments.location_id = locations.location_id
--
----select first_name,last_name,region_name
----from employees,regions,departments,locations,countries
----WHERE employees.department_id = departments.department_id and departments.location_id = locations.location_id
----and locations.country_id=countries.country_id and countries.region_id = regions.region_id
--
----select to_char(sysdate,'YYYYYYYYY/mmmmMM-dDD') from dual
--
----select last_name , to_char(hire_date,'YYYY-mm-dd') from employees
--
----select '10'+1 from dual  --기본적으로 문자열이여도 숫자로만 되어있으면 자동
--
----select to_date('2019-11-23','yyyy-mm-dd') from dual
----
----select * from employees
----where hire_date>to_date('2005-11-23','yyyy-mm-dd')  --데이트끼리는 비교가능
--
--
------1.
------select last_name,employee_id,department_name from departments,employees
------where salary>10000 and employees.department_id = departments.department_id
----
-------2.
----select employee_id,hire_date,last_name from employees
----where hire_date>=to_date('2002','yyyy')and hire_date<=to_date('2005','yyyy')
----
--------3.
----select hire_date,last_name,employee_id,salary from employees
----where JOB_id='IT_PROG' or JOB_id='SA_MAN' order by salary asc
----
----4
----select * from employees where hire_date>= to_date('2008-01-01','yyyy-mm-dd')
--
----5
----select * from employees where employee_id = 150 or employee_id = 140
----order by last_name
--
------6
----select last_name,hire_date,department_name,city from departments,employees,locations
----where 걍 3개 조인 ㄱ
--
------7
----select * from jobs order by job_title
----
----8
--
--select last_name,job_title from jobs,employees
--where last_name like 'S%' or last_name like '%s' --+조인문
--
----9
--SELECT
--    EM.FIRST_NAME || ' ' || EM.LAST_NAME 이름, EM2.FIRST_NAME || ' ' || EM2.LAST_NAME 상사
--FROM 
--    EMPLOYEES EM, EMPLOYEES EM2
--WHERE 
--    EM.MANAGER_ID = EM2.EMPLOYEE_ID(+) --null값 출력


SELECT
    EM.FIRST_NAME || ' ' || EM.LAST_NAME 이름, 
    NVL(EM2.FIRST_NAME || EM2.LAST_NAME, 'NULL') 상사
FROM
    EMPLOYEES EM, EMPLOYEES EM2
WHERE
    EM.MANAGER_ID =EM2.EMPLOYEE_ID(+)
    
    
--select NVL(department_name,'Staff'),last_name,salary            --널이 나올수 있는곳에 저거 하고
--from employees,departments
--where employees.department_id = departments.department_id(+)        --부족한 부분에 추가

--select last_name,first_name,NVL(commission_pct*salary,'0') from employees
--order by commission_pct

 --SELECT 
--    JOB_ID, AVG(SALARY), MIN(SALARY), MAX(SALARY)
--FROM
--    EMPLOYEES --EMPLOYEES들중
--WHERE
--    SALARY>=5000    --SALARY가 5000이상인 사람들을
--GROUP BY
--    JOB_ID  --JOB_ID를 기준으로 그룹화해서
--HAVING
--    AVG(SALARY)>=7000    --그 그룹중 SALARY의 평균이 7000인 그룹만 불러온다

