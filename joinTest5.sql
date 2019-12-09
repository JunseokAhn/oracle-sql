--1. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 출력하시오. 
--   출력 시 년도를 기준으로 오름차순 정렬하시오. 

select first_name, hire_date, avg(salary)
from employees em join jobs jb using(job_id)
where jb.job_title = 'Sales Manager'
group by first_name, hire_date
order by to_char(hire_date, 'YYYY');

--2. 각 도시(city)에 있는 모든 부서 직원들의 평균급여를 조회하고자 한다. 
--   평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 직원수를 출력하시오. 
--   단, 도시에 근 무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.

select city, avg(salary), COUNT(*)
from locations join departments using(location_id) join employees using (department_id)
group by locations.city
having count(*)<=10;

--3. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하시오. 
--   (현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 않는다.)      
--   이름은 first_name, last_name을 아래의 실행결과와 같이 출력한다.

select employee_id 사번, first_name || ' ' || last_name 이름
from employees join job_history using(employee_id)
where job_history.job_id = 'AC_ACCOUNT';

--4. 자신의 매니저보다 연봉(salary)를 많이 받는 직원들의 성(last_name)과 연봉(salary)를 출 력하시오.
select em1.last_name 성, em1.salary 연봉
from employees em1 join employees em2 on (em1.manager_id = em2.employee_id)
where em1.salary>em2.salary;

--5. 2007년에 입사(hire_date)한 직원들의 사번(employee_id), 이름(first_name), 성(last_name), 
--   부서명(department_name)을 조회합니다.  
--   이때, 부서에 배치되지 않은 직원의 경우, ‘<Not Assigned>’로 출력하시오. 
 select employee_id 사번, first_name 이름, last_name 성, nvl(department_name, 'Not Assigned') 부서명
 from employees left outer join departments using (department_id)
 where to_char(hire_date, 'YYYY')>=2007;
 
 --6. 업무명(job_title)이 ‘Sales Representative’인 직원 중에서 연봉(salary)이 9,000이상, 10,000 이하인 
--   직원들의 이름(first_name), 성(last_name)과 연봉(salary)를 출력하시오
 select first_name || ' ' || last_name 이름, salary 연봉
 from employees join jobs using(job_id)
 where salary between 9000 and 10000 and job_title = 'Sales Representative'; 
 
 select first_name || ' ' || last_name 이름, salary 연봉
 from employees join jobs on (employees.job_id = jobs.job_id and job_title = 'Sales Representative')
 where salary between 9000 and 10000; 

 select first_name || ' ' || last_name 이름, salary 연봉
 from employees join jobs on (employees.job_id = jobs.job_id and job_title = 'Sales Representative' and salary between 9000 and 10000); 

--7. 부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오. 
--   이름은 last_name만 출력하며, 부서이름으로 오름차순 정렬하고, 
--   부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 출력합니다. 

select last_name 이름, department_name 부서이름, salary 급여
from employees join departments using(department_id)
where salary in (
select min(salary) from employees join departments using(department_id) group by department_id
)
order by 부서이름 asc, 이름 asc;

--8. EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때 6번째부터 10 번째까지 
--   5명의 last_name, first_name, salary를 조회하는 sql문장을 작성하시오.
select *
from
(select RANK() OVER (ORDER BY salary desc) ranking,
first_name || ' ' || last_name 이름, salary 월급
from employees
order by salary desc)
where ranking BETWEEN 6 AND 10;

--9. 사원의 부서가 속한 도시(city)가 ‘Seattle’인 사원의 이름, 해당 사원의 매니저 이름, 사원 의 부서이름을 출력하시오. 
--   이때 사원의 매니저가 없을 경우 ‘<없음>’이라고 출력하시오. 이름은 last_name만 출력하며, 
--   사원의 이름을 오름차순으로 정렬하시오. .
select E.last_name 사원, D.department_name 부서명, nvl(조건.매니저, '<없음>') 매니저
from employees E join departments D using(department_id)join locations using (location_id),(
select E1.employee_id 사원2, E2.last_name 매니저 from employees E1 join employees E2 on (E1.manager_id = E2.employee_id(+))) 조건
where city='Seattle' and 조건.사원2 = E.employee_id
order by 사원 asc;

--10. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 한다. 연봉 총합이 가장 높은 업무부터 
--    업무명(job_title)과 연봉 총합을 조회하시오. 단 연봉총합이 30,000보다 큰 업무만 출력하시오. 
select job_title, sum(salary)
from employees join jobs using(job_id)
group by job_title
having sum(salary)>=30000
order by sum(salary) desc;

--11. 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 업무명(job_title), 
--    부서 명(department_name)을 조회하시오. 
--    단 도시명(city)이 ‘Seattle’인 지역(location)의 부서 (department)에 근무하는 직원을 사원번호 오름차순순으로 출력하시오.

SELECT 
    em.EMPLOYEE_ID, FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
  FROM 
    employees em join jobs using(job_id) join departments using (department_id) join locations using(location_id)
 WHERE 
    CITY = 'Seattle' 
 ORDER BY 
    em.EMPLOYEE_ID ASC;

--12. 2001~20003년사이에 입사한 직원의 이름(first_name), 입사일(hire_date), 관리자사번 (employee_id), 
--    관리자 이름(fist_name)을 조회합니다. 단, 관리자가 없는 사원정보도 출력 결과에 포함시켜 출력한다.
select em.first_name 이름, em.hire_date 입사일, em2.employee_id 관리자사번, em2.first_name 관리자이름
from employees em left outer join employees em2 on (em.manager_id = em2.employee_id)
where to_char(em.hire_date, 'YYYY') between 2001 and 2003;

--13. ‘Sales’ 부서에 속한 직원의 이름(first_name), 급여(salary), 부서이름(department_name)을 조회하시오. 
--    단, 급여는 100번 부서의 평균보다 적게 받는 직원 정보만 출력되어야 한다. 
select first_name 이름, salary 급여, department_name 부서이름
from employees join departments using (department_id)
where department_name='Sales' and salary < (
        select avg(salary) from employees E join departments D using (department_id)
        where department_id = 100
        group by D.department_name
        );

--14. Employees 테이블에서 입사한달(hire_date)별로 인원수를 조회하시오.    
select to_char(hire_date,'MM') 입사달, count(*) 인원수 
from employees 
group by to_char(hire_date, 'MM')
order by to_char(hire_date, 'MM') asc;

--15. 부서별 직원들의 최대, 최소, 평균급여를 조회하되, 
--    평균급여가 ‘IT’ 부서의 평균급여보다 많고, ‘Sales’ 부서의 평균보다 적은 부서 정보만 출력하시오. 
select max(salary), min(salary), round(avg(salary), 2)평균
from employees join departments using(department_id)
group by department_name
having avg(salary) between 
(select avg(salary) from employees join departments using(department_id) where department_name = 'IT' group by department_id) 
and 
(select avg(salary) from employees join departments using(department_id) where department_name = 'Sales' group by department_id);
      
--16. 각 부서별로 직원이 한명만 있는 부서만 조회하시오. 
--    단, 직원이 없는 부서에 대해서는 ‘<신생부서>’라는 문자열이 출력되도록 하고,
--    출력결과는 다음과 같이 부서명이 내림차순 으로 정렬되어야한다. 

select nvl(department_name, '<신생부서>') 부서명, count(*)
from employees right join departments using (department_id)
group by department_name
having count(*)  <=1
order by 부서명 desc;



--17. 부서별 입사월별 직원수를 출력하시오. 
--    단, 직원수가 5명 이상인 부서만 출력되어야 하며 출력결과는 부서이름 순으로 한다.
select department_name 부서, to_char(hire_date, 'MON', 'NLS_DATE_LANGUAGE=ENGLISH') 입사월, count(*) 직원수
from employees left join departments using(department_id)
group by department_name, to_char(hire_date, 'MON', 'NLS_DATE_LANGUAGE=ENGLISH')
having count(*) >=5
order by  부서 asc;

--18. 국가(country_name) 별 도시(city)별 직원수를 조회하시오. 
--    단, 부서에 속해있지 않은 직원 이 있기 때문에 106명의 직원만 출력이 된다. 
--    부서정보가 없는 직원은 국가명과 도시명 대신에 ‘<부서없음>’이 출력되도록 하여 107명 모두 출력되게 한다.
select nvl(country_name, '<부서없음>') 국가, nvl(city, '<부서없음>') 도시, count(*) 직원수
from employees left join departments using (department_id) left join locations using(location_id) left join countries using(country_id)
group by country_name, city;

--19. 각 부서별 최대 급여자의 아이디(employee_id), 이름(first_name), 급여(salary)를 출력하시오. 
--    단, 최대 급여자가 속한 부서의 평균급여를 마지막으로 출력하여 평균급여와 비교할 수 있게 할 것.
select E.employee_id 아이디, E.first_name 이름, E.salary 급여, A.AVG 부서평균
from employees E, (
    select department_id, round(avg(salary),0) AVG, max(salary) MAX
    from employees E join departments D using(department_id)
    group by department_id
    )A
where E.salary=A.MAX and E.department_id = A.department_id;

--20. 커미션(commission_pct)별 직원수를 조회하시오. 
--    커미션은 아래실행결과처럼 0.2, 0.25는 모두 .2로, 0.3, 0.35는 .3 형태로 출력되어야 한다. 
--    단, 커미션 정보가 없는 직원들도 있는 데 커미션이 없는 직원 그룹은 ‘<커미션 없음>’이 출력되게 한다.
select NVL(to_char(trunc(commission_pct,1)),'<커미션 없음>')commission_pct, count(*)
from employees
group by commission_pct;

--21. 커미션(commission_pct)을 가장 많이 받은 상위 4명의 부서명(department_name), 
--    직원명 (first_name), 급여(salary), 커미션(commission_pct) 정보를 조회하시오. 
--    출력결과는 커미션 을 많이 받는 순서로 출력하되 동일한 커미션에 대해서는 급여가 높은 직원이 먼저 출력
select *
from
(select department_name 부서명, first_name 직원명, salary 급여, max(commission_pct) 커미션
from employees join departments using(department_id)
where commission_pct is not null
group by department_name, first_name, salary
order by 커미션 desc)
where rownum<=4;

--22. 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.
select last_name 이름, salary*12*commission_pct 연봉
from employees
where salary*12*commission_pct>=12000;

 --23. 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.
select last_name, department_id
from employees join departments using(department_id)
where employee_id = 176;

 --24. 연봉이 5000 에서 12000의 범위 이외인 사람들의 LAST_NAME 및 연봉을 조회힌다.
select last_name, salary*12*commission_pct 연봉
from employees
where salary*12*commission_pct between 5000 and 12000;

--25. LAST_NAME 이 'Kochhar' 인 사원과 동일한 연봉 및 커미션을 버는 사원들의 
--LAST_NAME, 부서 번호 및 연봉을 조회한다.
select Last_name, department_name, salary
from employees join departments using (department_id)
where (salary, nvl(commission_pct,0)) in (
        select salary, nvl(commission_pct,0)
        from employees
        where last_name = 'Kochhar')
    and
    last_name !='Kochhar';
    
-- 26. 기존의 직업을 여전히 가지고 있는 사원들의 사번 및 JOB_ID 를 조회한다.
select employee_id 사번, job_id
from employees
where  
    employee_id not in (select employee_id from job_history);

--27 부서가 있는 국가 ID 및 국가 이름을 조회힌다.(NOT EXISTS 사용)
select country_id, country_name, department_name
from departments join locations using(location_id) join countries using(country_id);


--28 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 
--LAST_NAME, 부서 번호 및 연봉을 조회한다.
select last_name, department_name, salary*12*nvl(commission_pct,1) 연봉
from employees join departments using(department_id)
where (salary, nvl(commission_pct,0)) in
(select salary, nvl(commission_pct,0)
from employees join departments using(department_id)
where location_id = 1700);


--29 도시 이름이 T 로 시작하는 지역에 사는 사원들의 사번, LAST_NAME 및 부서 번호를 조회한다.
select employee_id 사번, last_name, department_name
from employees join departments using(department_id) join locations using(location_id)
where city like 'T%';

-- 30  각 부서별 평균 연봉보다 더 받는 동일부서 근무사원들의
--      LAST_NAME, 연봉, 부서번호 및 해당 부서의 평균 연봉을 조회한다.
--      결과는 부서별 연봉을 기준으로 정렬한다.
select last_name, salary*nvl(commission_pct,1)*12 연봉, department_name 부서, A.AVG 부서평균
from employees join departments using(department_id) 
    join
    (
        select round(avg(salary),2) AVG, department_id
        from employees join departments using(department_id)
        group by department_id
    ) A 
    using(department_id)
where salary > a.avg 
order by 연봉 desc;

select last_name, salary*nvl(commission_pct,1)*12 연봉, department_name 부서, A.AVG 부서평균
from (employees join departments using(department_id)) b,
    
    (
        select round(avg(salary),2) AVG, department_id
        from employees join departments using(department_id)
        group by department_id
    ) A 
   
where salary > a.avg and a.department_id = b.department_id
order by 연봉 desc;


