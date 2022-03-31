-----------------------------publisher model--------------------------------------



1.Identify the relationships between each table.
author------>book_author== 1:M
author<----->book == M:M
publisher--->book == 1:M
book-------->book_author == 1:M


2.Query to get the number of books by each publisher.
select pub_nm,count(book_id)
from publisher p,book b
where p.pub_id=b.pub_id
group by pub_nm,pub_id;


3.Write a query which gives book_name, author_name for publisher ‘XYZ’
select book_nm,a.au_f_name||a.au_l_name
from author a,publisher p,book b,book_author ba
where a.au_id=ba.au_id
and b.book_id=ba.book_id
and p.pub_id=b.pub_id
and pub_nm='xyz';


4.Which book was written by more than 3 authors?
select book_id,book_nm
from book b,book_author ba
where b.book_id=ba.book_id
group by book_id,book_nm
having count(au_id)>3;



5.Want to include city and state information of author as well in the model. So, modifiy the model and show us the new model what you come up with.


state --------->  city
                   |
		   |
         |--------- -------------|
         |                       |
     author                 publisher


6.Display publisher name, pub_city and metro flag of the city. If city is CHN or MUM or DEL or CAL then display the flag as ‘Y’ otherwise ‘N’
select pub_nm,pub_city,case when pub_city in ('CHN',MUM','DEL','CAL') then 'Y'
else 'N'
end 'metro flag'
from publisher;


7.Display the authors whose age is greater than the author ‘RAM KUMAR’
select au_f_name||au_l_name
from author
where (sysdate-dob)
>(select (sysdate-aud_dob)
from author
where au_f_name||au_l_name='ram kumar');


8.Display the publisher name, author_name and no of books they wrote.
select pub_nm,au_f_name||au_l_name,count(book_id)
from author a,publisher p, book b,book_author ba
where a.au_id=ba.au_id
and b.book_id=ba.book_id
and p.pub_id=b.pub_id
group by pub_nm,au_f_name||au_l_name;


9.Which author wrote the maximum number of books?
select au_nm
from book b,author a, book_author ba
where a.au_id=ba.au_id
and b.book_id=ba.book_id
group by au_nm,au_id
having count(book_id)=(select max(count(book_id)
from author a, book b
where a.au_id=b.au_id
group by au_id);

