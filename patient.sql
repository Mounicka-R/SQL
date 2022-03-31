------1.Find all the patients who are treated in the first week of this month.
select fname||lname
from patient p,case c
where p.pat_id=c.pat_id
and to_char(admission_date,'w')=1
and to_char(admission_date,'mm-yy')=to_char(sysdate,'mm-yy');



-------2.Find all the doctors who have more than 3 admissions today
select d.fname||d.lname,count(c.admission_date)
from doctor d,case c
where  d.doc_id=c.doc_id
and (c.admission_date)=(sysdate)
group by d.doc_id,d.fname||d.lname
having count(c.admission_date)>3;


-----3.	Find the patient name (first,last) who got admitted today where the doctor is ‘TIM’
select p.fname||p.lname,admission_date
from doctor d,patient p,case c
where d.doc_id=c.doc_id
and p.pat_id=c.pat_id
and to_char(admission_date,'dd-mm-yy')=to_char(sysdate,'dd-mm-yy')
and d.fname='tim';

----4.	Find the Doctors whose phone numbers were not update (phone number is null)
select fname||lname
from doctor
where phone is null;

----5.	Display the doctors whose specialty is same as Doctor ‘TIM’
select doc_id,fname||lname
from doctor
where specialty=(select specialty
from doctor 
where fname='tim');

-----6.	Find out the number of cases monthly wise for the current year
select count(pat_id)
from case
where to_char(admission_date,'yyyy')=to_char(sysdate,'yyyy')
group by to_char(sysdate,'mm');


-----7.	Display the doctors who don’t have any cases registered this week
select fname||lname
from doctor
where doc_id 
not in (select doc_id
from case
where to_char(admission_date,'w-mm-yy')= to_char(sysdate,'w-mm-yy'));



-----8.	Display Doctor Name, Patient Name, Diagnosis for all the admissions which happened on 1st of Jan this year
select d.fname||d.lname,p.fname||p.lname,diagnosis
from doctor d,patient p, case c
where d.doc_id=c.doc_id
and p.pat_id=c.pat_id
and to_char(admission_date,'yy')=to_char(trunc(sysdate,'yy'));

------9.Display Doctor Name, patient count based on the cases registered in the hospital.
select d.fname||d.lname,A.pat from
(select doc_id,count(pat_id) pat
from case
group by doc_id) A,doctor d
where A.doc_id=d.doc_id;


-----10.Display the Patient_name, phone, insurance company, insurance code (first 3 characters of insurance company)
select fname||lname as pname,ins_comp,phone,substr(ins_comp,1,3)
from patient;


--------11.Create a view which gives the doctors whose specialty is ‘ORTHO’ and call it as ortho_doctors
create view ortho_doctors
as
select fname||lname,doc_id
from doctor
where speciality='ORTHO';

