-----1.Display Emp_name, Age of employee, consider folks who were born only in the month of MAY
select emp_name,date_of_birth,trunc(months_between(sysdate,date_of_birth)/12)
from employee1
where to_char(date_of_birth,'mm')='05';


----2.Display the highest paid employees in each department
select e.emp_name,e.ctc,d.dept_name
from department d,employee1 e
where d.dept_id=e.dept_id
and (e.ctc,d.dept_id) in
(select max(ctc),dept_id
from employee1
group by dept_id);



-----3.Top two employees in terms of salaries in each department
select*from (
select emp_name,ctc,dept_id,dense_rank() over(order by ctc desc)r
from  employee1 
group by dept_id,emp_name,ctc)
where r<=2;

----4.Display departments which does not have any employees yet
select dept_name,dept_id
from department 
where dept_id not in
(select dept_id
from employee1);


----5.What are the common job_roles we have between Accounting and IT departments
select job_role,job_id
from jobs 
where job_id  in
(select j.job_id
from jobs j,employee1 e,department d
where j.job_id=e.job_id
and d.dept_id=e.dept_id
and d.dept_name='IT'
intersect
select j.job_id
from jobs j,employee1 e,department d
where j.job_id=e.job_id
and d.dept_id=e.dept_id
and d.dept_name='Accounting');

----6.Identify employees whose CTC is not inline with respective jobs min_ctc and max_ctc

select emp_name
from jobs j,employee1 e
where j.job_id =e.job_id
and ctc not between min_ctc and max_ctc;


-----7.Display the Department Name, employee name, job_role for those who joined us in the month of Apr 19
select dept_name,emp_name,job_role,date_of_join
from department d,jobs j, employee1 e
where d.dept_id=e.dept_id
and j.job_id=e.job_id 
and to_char(date_of_join,'mm-yy') = '04-19';


----8.Find Job roles where we don’t have any employees
select job_role
from jobs 
where job_id not in
(select job_id
from employee1);

----9.Display Department Name, Number of Employees and Number of unique jobs we have in the department
select d.dept_name,count(emp_id),count(distinct(job_id))
from department d,employee1 e
where d.dept_id=e.dept_id
group by d.dept_id,d.dept_name;

----10.Display jobs where we have zero employees
select job_id,job_role
from jobs 
where job_id not in
(select job_id
from employee1);


-----11.Display Department Name, Male Employee Count, Female Employee Count 

select d.dept_name ,count(case when UPPER(gender)='M' then 1 end )Male,
count(case when UPPER(Gender) = 'F' then 1 end) Female
from department d,employee1 e
where d.dept_id=e.dept_id
group by d.dept_name;


------12.Display Department Names, Employee Name, Job Desc to all female employees who joined in the month of Nov or Jan and in the year of 2018 or 2020
select d.dept_name,e.emp_name,date_of_join
from department d,employee1 e
where d.dept_id=e.dept_id
and gender ='F'
and to_char(date_of_join,'mon')in ('nov','jan') or
to_char(date_of_join,'yyyy')in ('2018','2020') ;


-----13.Display the department where we have the oldest person in the office

select *from (select dept_name,emp_name,date_of_birth,dense_rank() over(order by (date_of_birth))r
from department d,employee1 e
where d.dept_id=e.dept_id)
where r<=1;

----14.Find job role where we have most number of employees.

select j.job_role,e.job_id,count(emp_id)
from jobs j,employee1 e
where j.job_id=e.job_id
group by j.job_id,j.job_role,e.job_id;



