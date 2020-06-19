with temp as (
    select 'M' gender from dual union all
    select 'F' gender from dual union all
    select 'X' gender from dual
)

select gender,
       decode(gender,'M', '����', 'F', '����', '��Ÿ') gender2
from temp;


select ename, job, decode(job, 'PRESIDENT', '�濵��', 'MANAGER', '������', 'ANALYST', '�м���') JOB_KR
from SCOTT.EMP
where EMPNO in ('7839', '7566', '7788');

--null üũ ����
select ename, comm, decode(comm, null, 'N', 'Y') COMM_YN
from SCOTT.EMP
where EMPNO in ('7839', '7566', '7499');


select ename, deptno, decode(deptno, '10', 'NEW YORK,
                                    '20', 'DALLAS',
                                    '30', 'CHICAGO',
                                    '40', 'BOSTON') LOC
from SCOTT.EMP
where empno in ('7839', '7566', '7499')
order by deptno;

select ename, job, decode(job, 'CLERK', decode(MGR, '7788', 'SCOTT',
                                                    '7698', 'BLAKE',
                                                    '7782', 'CLARK'),
                                'ANALYST', decode(MGR, '7566', 'JONES',
                                                        '7698', 'BLAKE')
                                ) MGRNAME
from scott.emp a
where empno in ('7876', '7900', '7934', '7902', '7788')
order by job, empno;


select sum(decode(to_char(HIREDATE, 'MM'), '01', 1)) "1��",
        sum(decode(to_char(HIREDATE, 'MM'), '02', 1)) "2��",
        sum(decode(to_char(HIREDATE, 'MM'), '03', 1)) "3��",
        sum(decode(to_char(HIREDATE, 'MM'), '04', 1)) "4��",
        sum(decode(to_char(HIREDATE, 'MM'), '05', 1)) "5��",
        sum(decode(to_char(HIREDATE, 'MM'), '06', 1)) "6��",
        sum(decode(to_char(HIREDATE, 'MM'), '07', 1)) "7��",
        sum(decode(to_char(HIREDATE, 'MM'), '08', 1)) "8��",
        sum(decode(to_char(HIREDATE, 'MM'), '09', 1)) "9��",
        sum(decode(to_char(HIREDATE, 'MM'), '10', 1)) "10��",
        sum(decode(to_char(HIREDATE, 'MM'), '11', 1)) "11��",
        sum(decode(to_char(HIREDATE, 'MM'), '12', 1)) "12��"      
from scott.emp;