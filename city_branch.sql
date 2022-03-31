---1.Write a query to list the cities which have more population than Bangalore.
select city_name
from city
where city_population > (select city_population
from city
where city_name='bangalore');

----2.Display all the branch names from Chennai.
select b_name
from branch
where city_id = (select city_id
from city
where city_name='chennai');


------3.Display a city name which does not have any branches
select city_name
from city
where city_id not in (select city_id
from branch);


---4.Display branch name, address and phone number of all the branches where the name starts with either B or M and the city name starts with either B or C.
select b_name,b_address,b_phone
from city c ,branch b
where c.city_id=b.city_id
and b_name like 'b%' or b_nane like 'm%'
and city_name like 'b%' or city_name like 'c%';

----5.How many branches we have in Bangalore?
select count(b_name)
from branch
where city_id=(select city_id
from city
where city_name='bangalore');


----6.Display the branches which are in the Ring road of any city.
select b_name
from branch
where b.address like "%ring road%';


----7.Display the city name, branch name. Order the data based on the city name.
select city_name,b_name
from city c, branch b
where c.city_id=b.city_id
order by city_name;


---8.Display the city name and the number of branches in each city.
select city_name,count(b_id)
from city c ,branch b
where c.city_id=b.city_id
group by city_name;

----9.Display the city name which has most number of branches.
select city_name
from city c,branch b
where c.city_id=b.city_id
group by city_name
having count(b_id)=(select max(count(b_id))
from branch
group by city_id);



-----10.Display the city name, population, number of branches in each city.
select c1.city_name,c1.city_population,c.b_id
from(select city_id,count(b_id) b_id
from branch
group by city_id)c,city c1
where c.city_id=c1.city_id;