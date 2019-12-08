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
(select avg(salary) from employees join departments using(department_id) where department_name = 'Sales' group by department_id)
      
        