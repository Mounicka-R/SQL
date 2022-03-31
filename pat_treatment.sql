-------------1.Find out different treatments we provide from last three years.
select treat_name
from treatment t ,pat_treatment pt
where t.treat_id=pt.treat_id
and to_char(treat_date,'yy') between to_char(sysdate,'yy') and to_char(sysdate,'yy')-3;


---------2.Find the number patients we get from each each country
select country,count(patient_id)
from patient1 p,location l
where l.loc_id=p.loc_id
group by country;


---------3.Find all the patients who are currently taking the treatment of type Ayurvedic
select p.patient_nm,tt.treat_type_desc
from patient1 p,pat_treatment pt,treatment t,treat_type tt
where p.patient_id=pt.patient_id
and t.treat_id=pt.treat_id
and tt.treat_type_id=t.treat_type_id
and treat_type_desc='ayurvedic';


-----4.Find all the patients who are coming from metro cities (loc_type = 'Metro')
select patient_nm,loc_type
from patient1 p,location l
where l.loc_id=p.loc_id
and loc_type='metro';


----5.	Find the number of customers who are having insurance
select insurance_flg,count(patient_id)
from patient1
where insurance_flg='y'
group by insurance_flg; 


----6.	Find all the days where we provided more than 100 treatmentsin Ayurvedic type

select to_char(pt.treat_date,'dy'),count(pt.treat_id)
from treat_type tt, treatment t, pat_treatment pt
where tt.treat_type_id=t.treat_type_id
and t.treat_id=pt.treat_id 
and tt.treat_type_desc='ayurvedic'
group by to_char(pt.treat_date,'dy')
having count(pt.treat_id)>100;




----7.	Find the doctor who have the most number of treatments on 03-JAN-2013

select doc_nm  from(
select d.doc_nm ,count(t.treat_id),dense_rank() over (order by count(t.treat_id)desc)r
from doctor1 d,pat_treatment pt, treatment t
where d.doc_id=pt.doc_id
and t.treat_id=pt.treat_id
and to_char(pt.treat_date)='03-01-13'
group by d.doc_nm)
where r>=1;


----8.Find the doctor who did not have any treatments on 03-JAN-2013
select doc_nm
from doctor1 
where doc_id not in
(select doc_id
from pat_treatment
where to_char(treat_date,'dd-mm-yy')='03-01-13');

----9.	Find the treatments which were commonly given by both Doctor ‘RAM’ and ‘TIM’ gave on 03-JAN-2013

select treat_name
from treatment
where treat_id in
(select treat_id
from doctor1 d,pat_treatment pt
where d.doc_id=pt.doc_id
and doc_nm='ram'
and treat_date='03-01-13'
intersect
select treat_id
from doctor1 d,pat_treatment pt
where d.doc_id=pt.doc_id
and doc_nm='tim'
and treat_date='03-01-13');



