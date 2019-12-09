--1. ��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�. 
--   ��� �� �⵵�� �������� �������� �����Ͻÿ�. 

select first_name, hire_date, avg(salary)
from employees em join jobs jb using(job_id)
where jb.job_title = 'Sales Manager'
group by first_name, hire_date
order by to_char(hire_date, 'YYYY');

--2. �� ����(city)�� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�. 
--   ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�. 
--   ��, ���ÿ� �� ���ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.

select city, avg(salary), COUNT(*)
from locations join departments using(location_id) join employees using (department_id)
group by locations.city
having count(*)<=10;

--3. ��Public  Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����Ͻÿ�. 
--   (���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� �ʴ´�.)      
--   �̸��� first_name, last_name�� �Ʒ��� �������� ���� ����Ѵ�.

select employee_id ���, first_name || ' ' || last_name �̸�
from employees join job_history using(employee_id)
where job_history.job_id = 'AC_ACCOUNT';

--4. �ڽ��� �Ŵ������� ����(salary)�� ���� �޴� �������� ��(last_name)�� ����(salary)�� �� ���Ͻÿ�.
select em1.last_name ��, em1.salary ����
from employees em1 join employees em2 on (em1.manager_id = em2.employee_id)
where em1.salary>em2.salary;

--5. 2007�⿡ �Ի�(hire_date)�� �������� ���(employee_id), �̸�(first_name), ��(last_name), 
--   �μ���(department_name)�� ��ȸ�մϴ�.  
--   �̶�, �μ��� ��ġ���� ���� ������ ���, ��<Not Assigned>���� ����Ͻÿ�. 
 select employee_id ���, first_name �̸�, last_name ��, nvl(department_name, 'Not Assigned') �μ���
 from employees left outer join departments using (department_id)
 where to_char(hire_date, 'YYYY')>=2007;
 
 --6. ������(job_title)�� ��Sales Representative���� ���� �߿��� ����(salary)�� 9,000�̻�, 10,000 ������ 
--   �������� �̸�(first_name), ��(last_name)�� ����(salary)�� ����Ͻÿ�
 select first_name || ' ' || last_name �̸�, salary ����
 from employees join jobs using(job_id)
 where salary between 9000 and 10000 and job_title = 'Sales Representative'; 
 
 select first_name || ' ' || last_name �̸�, salary ����
 from employees join jobs on (employees.job_id = jobs.job_id and job_title = 'Sales Representative')
 where salary between 9000 and 10000; 

 select first_name || ' ' || last_name �̸�, salary ����
 from employees join jobs on (employees.job_id = jobs.job_id and job_title = 'Sales Representative' and salary between 9000 and 10000); 

--7. �μ����� ���� ���� �޿��� �ް� �ִ� ������ �̸�, �μ��̸�, �޿��� ����Ͻÿ�. 
--   �̸��� last_name�� ����ϸ�, �μ��̸����� �������� �����ϰ�, 
--   �μ��� ���� ��� �̸��� ���� ���� �������� �����Ͽ� ����մϴ�. 

select last_name �̸�, department_name �μ��̸�, salary �޿�
from employees join departments using(department_id)
where salary in (
select min(salary) from employees join departments using(department_id) group by department_id
)
order by �μ��̸� asc, �̸� asc;

--8. EMPLOYEES ���̺��� �޿��� ���� �޴� ������� ��ȸ���� �� 6��°���� 10 ��°���� 
--   5���� last_name, first_name, salary�� ��ȸ�ϴ� sql������ �ۼ��Ͻÿ�.
select *
from
(select RANK() OVER (ORDER BY salary desc) ranking,
first_name || ' ' || last_name �̸�, salary ����
from employees
order by salary desc)
where ranking BETWEEN 6 AND 10;

--9. ����� �μ��� ���� ����(city)�� ��Seattle���� ����� �̸�, �ش� ����� �Ŵ��� �̸�, ��� �� �μ��̸��� ����Ͻÿ�. 
--   �̶� ����� �Ŵ����� ���� ��� ��<����>���̶�� ����Ͻÿ�. �̸��� last_name�� ����ϸ�, 
--   ����� �̸��� ������������ �����Ͻÿ�. .
select E.last_name ���, D.department_name �μ���, nvl(����.�Ŵ���, '<����>') �Ŵ���
from employees E join departments D using(department_id)join locations using (location_id),(
select E1.employee_id ���2, E2.last_name �Ŵ��� from employees E1 join employees E2 on (E1.manager_id = E2.employee_id(+))) ����
where city='Seattle' and ����.���2 = E.employee_id
order by ��� asc;

--10. �� ����(job) ���� ����(salary)�� ������ ���ϰ��� �Ѵ�. ���� ������ ���� ���� �������� 
--    ������(job_title)�� ���� ������ ��ȸ�Ͻÿ�. �� ���������� 30,000���� ū ������ ����Ͻÿ�. 
select job_title, sum(salary)
from employees join jobs using(job_id)
group by job_title
having sum(salary)>=30000
order by sum(salary) desc;

--11. �� ���(employee)�� ���ؼ� ���(employee_id), �̸�(first_name), ������(job_title), 
--    �μ� ��(department_name)�� ��ȸ�Ͻÿ�. 
--    �� ���ø�(city)�� ��Seattle���� ����(location)�� �μ� (department)�� �ٹ��ϴ� ������ �����ȣ �������������� ����Ͻÿ�.

SELECT 
    em.EMPLOYEE_ID, FIRST_NAME, JOB_TITLE, DEPARTMENT_NAME
  FROM 
    employees em join jobs using(job_id) join departments using (department_id) join locations using(location_id)
 WHERE 
    CITY = 'Seattle' 
 ORDER BY 
    em.EMPLOYEE_ID ASC;

--12. 2001~20003����̿� �Ի��� ������ �̸�(first_name), �Ի���(hire_date), �����ڻ�� (employee_id), 
--    ������ �̸�(fist_name)�� ��ȸ�մϴ�. ��, �����ڰ� ���� ��������� ��� ����� ���Խ��� ����Ѵ�.
select em.first_name �̸�, em.hire_date �Ի���, em2.employee_id �����ڻ��, em2.first_name �������̸�
from employees em left outer join employees em2 on (em.manager_id = em2.employee_id)
where to_char(em.hire_date, 'YYYY') between 2001 and 2003;

--13. ��Sales�� �μ��� ���� ������ �̸�(first_name), �޿�(salary), �μ��̸�(department_name)�� ��ȸ�Ͻÿ�. 
--    ��, �޿��� 100�� �μ��� ��պ��� ���� �޴� ���� ������ ��µǾ�� �Ѵ�. 
select first_name �̸�, salary �޿�, department_name �μ��̸�
from employees join departments using (department_id)
where department_name='Sales' and salary < (
        select avg(salary) from employees E join departments D using (department_id)
        where department_id = 100
        group by D.department_name
        );

--14. Employees ���̺��� �Ի��Ѵ�(hire_date)���� �ο����� ��ȸ�Ͻÿ�.    
select to_char(hire_date,'MM') �Ի��, count(*) �ο��� 
from employees 
group by to_char(hire_date, 'MM')
order by to_char(hire_date, 'MM') asc;

--15. �μ��� �������� �ִ�, �ּ�, ��ձ޿��� ��ȸ�ϵ�, 
--    ��ձ޿��� ��IT�� �μ��� ��ձ޿����� ����, ��Sales�� �μ��� ��պ��� ���� �μ� ������ ����Ͻÿ�. 
select max(salary), min(salary), round(avg(salary), 2)���
from employees join departments using(department_id)
group by department_name
having avg(salary) between 
(select avg(salary) from employees join departments using(department_id) where department_name = 'IT' group by department_id) 
and 
(select avg(salary) from employees join departments using(department_id) where department_name = 'Sales' group by department_id);
      
--16. �� �μ����� ������ �Ѹ� �ִ� �μ��� ��ȸ�Ͻÿ�. 
--    ��, ������ ���� �μ��� ���ؼ��� ��<�Ż��μ�>����� ���ڿ��� ��µǵ��� �ϰ�,
--    ��°���� ������ ���� �μ����� �������� ���� ���ĵǾ���Ѵ�. 

select nvl(department_name, '<�Ż��μ�>') �μ���, count(*)
from employees right join departments using (department_id)
group by department_name
having count(*)  <=1
order by �μ��� desc;



--17. �μ��� �Ի���� �������� ����Ͻÿ�. 
--    ��, �������� 5�� �̻��� �μ��� ��µǾ�� �ϸ� ��°���� �μ��̸� ������ �Ѵ�.
select department_name �μ�, to_char(hire_date, 'MON', 'NLS_DATE_LANGUAGE=ENGLISH') �Ի��, count(*) ������
from employees left join departments using(department_id)
group by department_name, to_char(hire_date, 'MON', 'NLS_DATE_LANGUAGE=ENGLISH')
having count(*) >=5
order by  �μ� asc;

--18. ����(country_name) �� ����(city)�� �������� ��ȸ�Ͻÿ�. 
--    ��, �μ��� �������� ���� ���� �� �ֱ� ������ 106���� ������ ����� �ȴ�. 
--    �μ������� ���� ������ ������� ���ø� ��ſ� ��<�μ�����>���� ��µǵ��� �Ͽ� 107�� ��� ��µǰ� �Ѵ�.
select nvl(country_name, '<�μ�����>') ����, nvl(city, '<�μ�����>') ����, count(*) ������
from employees left join departments using (department_id) left join locations using(location_id) left join countries using(country_id)
group by country_name, city;

--19. �� �μ��� �ִ� �޿����� ���̵�(employee_id), �̸�(first_name), �޿�(salary)�� ����Ͻÿ�. 
--    ��, �ִ� �޿��ڰ� ���� �μ��� ��ձ޿��� ���������� ����Ͽ� ��ձ޿��� ���� �� �ְ� �� ��.
select E.employee_id ���̵�, E.first_name �̸�, E.salary �޿�, A.AVG �μ����
from employees E, (
    select department_id, round(avg(salary),0) AVG, max(salary) MAX
    from employees E join departments D using(department_id)
    group by department_id
    )A
where E.salary=A.MAX and E.department_id = A.department_id;

--20. Ŀ�̼�(commission_pct)�� �������� ��ȸ�Ͻÿ�. 
--    Ŀ�̼��� �Ʒ�������ó�� 0.2, 0.25�� ��� .2��, 0.3, 0.35�� .3 ���·� ��µǾ�� �Ѵ�. 
--    ��, Ŀ�̼� ������ ���� �����鵵 �ִ� �� Ŀ�̼��� ���� ���� �׷��� ��<Ŀ�̼� ����>���� ��µǰ� �Ѵ�.
select NVL(to_char(trunc(commission_pct,1)),'<Ŀ�̼� ����>')commission_pct, count(*)
from employees
group by commission_pct;

--21. Ŀ�̼�(commission_pct)�� ���� ���� ���� ���� 4���� �μ���(department_name), 
--    ������ (first_name), �޿�(salary), Ŀ�̼�(commission_pct) ������ ��ȸ�Ͻÿ�. 
--    ��°���� Ŀ�̼� �� ���� �޴� ������ ����ϵ� ������ Ŀ�̼ǿ� ���ؼ��� �޿��� ���� ������ ���� ���
select *
from
(select department_name �μ���, first_name ������, salary �޿�, max(commission_pct) Ŀ�̼�
from employees join departments using(department_id)
where commission_pct is not null
group by department_name, first_name, salary
order by Ŀ�̼� desc)
where rownum<=4;

--22. ������ 12000 �̻�Ǵ� �������� LAST_NAME �� ������ ��ȸ�Ѵ�.
select last_name �̸�, salary*12*commission_pct ����
from employees
where salary*12*commission_pct>=12000;

 --23. �����ȣ�� 176 �� ����� LAST_NAME �� �μ� ��ȣ�� ��ȸ�Ѵ�.
select last_name, department_id
from employees join departments using(department_id)
where employee_id = 176;

 --24. ������ 5000 ���� 12000�� ���� �̿��� ������� LAST_NAME �� ������ ��ȸ����.
select last_name, salary*12*commission_pct ����
from employees
where salary*12*commission_pct between 5000 and 12000;

--25. LAST_NAME �� 'Kochhar' �� ����� ������ ���� �� Ŀ�̼��� ���� ������� 
--LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
select Last_name, department_name, salary
from employees join departments using (department_id)
where (salary, nvl(commission_pct,0)) in (
        select salary, nvl(commission_pct,0)
        from employees
        where last_name = 'Kochhar')
    and
    last_name !='Kochhar';
    
-- 26. ������ ������ ������ ������ �ִ� ������� ��� �� JOB_ID �� ��ȸ�Ѵ�.
select employee_id ���, job_id
from employees
where  
    employee_id not in (select employee_id from job_history);

--27 �μ��� �ִ� ���� ID �� ���� �̸��� ��ȸ����.(NOT EXISTS ���)
select country_id, country_name, department_name
from departments join locations using(location_id) join countries using(country_id);


--28 ��ġ ID �� 1700 �� ������� ������ Ŀ�̼��� ������ ������� 
--LAST_NAME, �μ� ��ȣ �� ������ ��ȸ�Ѵ�.
select last_name, department_name, salary*12*nvl(commission_pct,1) ����
from employees join departments using(department_id)
where (salary, nvl(commission_pct,0)) in
(select salary, nvl(commission_pct,0)
from employees join departments using(department_id)
where location_id = 1700);


--29 ���� �̸��� T �� �����ϴ� ������ ��� ������� ���, LAST_NAME �� �μ� ��ȣ�� ��ȸ�Ѵ�.
select employee_id ���, last_name, department_name
from employees join departments using(department_id) join locations using(location_id)
where city like 'T%';

-- 30  �� �μ��� ��� �������� �� �޴� ���Ϻμ� �ٹ��������
--      LAST_NAME, ����, �μ���ȣ �� �ش� �μ��� ��� ������ ��ȸ�Ѵ�.
--      ����� �μ��� ������ �������� �����Ѵ�.
select last_name, salary*nvl(commission_pct,1)*12 ����, department_name �μ�, A.AVG �μ����
from employees join departments using(department_id) 
    join
    (
        select round(avg(salary),2) AVG, department_id
        from employees join departments using(department_id)
        group by department_id
    ) A 
    using(department_id)
where salary > a.avg 
order by ���� desc;

select last_name, salary*nvl(commission_pct,1)*12 ����, department_name �μ�, A.AVG �μ����
from (employees join departments using(department_id)) b,
    
    (
        select round(avg(salary),2) AVG, department_id
        from employees join departments using(department_id)
        group by department_id
    ) A 
   
where salary > a.avg and a.department_id = b.department_id
order by ���� desc;


