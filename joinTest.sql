select last_name, first_name, department_name
from employees EM, departments de
where de.department_id = em.department_id


select * from employees
where department_id is null


desc departments

desc employees

select job_id from employees


select first_name || ' ' || last_name 이름, employee_id 아이디, salary 급여
from employees em
where em.job_id = 'FI_ACCOUNT' and em.salary>=5000

select first_name || ' ' || last_name 이름, employee_id 아이디, salary 급여
from employees
where salary>=2000 and job_id= 'PU_CLERK'
order by salary desc

select first_name || ' ' || last_name 이름, employee_id 아이디
from employees
where salary between 4000 and 8000

SELECT EMPLOYEE_ID ID, FIRST_NAME || ' ' || LAST_NAME NAME, DEPARTMENT_NAME DENAME
FROM EMPLOYEES EM, DEPARTMENTS DM
WHERE EM.SALARY BETWEEN 4000 AND 8000 AND EM.JOB_ID='FI_ACCOUNT' AND EM.DEPARTMENT_ID = DM.DEPARTMENT_ID

select employee_id ID, first_name || ' ' || last_name NAME
from employees EM, departments DM
where DM.department_name = 'Finance' and  EM.DEPARTMENT_ID = DM.DEPARTMENT_ID

select employee_id ID, first_name||' '||last_name

select max(salary) from employees
select min(salary) from employees
select avg(salary) from employees

select avg(salary) from employees em, departments dm
where dm.department_name = 'Finance' and em.department_id = dm.department_id

select max(salary) from employees em, departments dm
where dm.department_name = 'Executive' and em.department_id = dm.department_id

--select max(salary), first_name from employees em, departments dm
--where dm.department_name = 'Executive' and em.department_id = dm.department_id

select * from employees
where salary = (select max(salary) from employees)

select * from employees
where salary> ( select avg(salary) from employees)
order by salary desc

select tname from tab

desc locations
desc departments
desc employees
desc countries
desc regions


select em.first_name, lo.city
from employees em, departments dm, locations lo
where em.department_id = dm.department_id and dm.location_id = lo.location_id

select em.first_name, re.region_name
from employees em, departments dm, locations lo, countries co, regions re
where em.department_id = dm.department_id and 
lo.location_id = dm.location_id and 
co.country_id = lo.country_id and 
re.region_id = co.region_id