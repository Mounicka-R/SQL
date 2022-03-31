-----------------------------resort management system----------------------------------


------1.Query to find out country wise resort count.
select count(res_id)
from resort
group by country_id;



------2.Query to display country wise customer count.
select count(cust_id)
from customer
group by country_id;


------3.Query to display country, resort count and customer count.
select country_name,nvl(resort.res_id,o),nvl(customer.cust_id,0) from
(select country_id,count(resort_id) res_id
from resort
group by country_id)resort,(select country_id,count(cust_id) cust_id
from customer
group by country_id)customer,country c
where c.resort_id=resort.country_id(+)
and c.resort_id=customer.country_id(+);


-------4.Display countries in which we don’t have any resorts.
select country_name
from country
where country_id not in
(select country_id
from resort);


------5.Display countries in which we have minimum of 100 customers.
select country_id,country_name,count(cust_id)
from country c,customer cu
where c.country_id=cu.country_id
group by country_id,country_name
having count(cust_id)<100;


-----6.Display how many resorts we have in the country where resort ‘Beach front’ is
select count(resort_id)
from resort r
where country_id =
(select country_id
from resort
where resort_name='beach front');


------7.Display customers whose name starts with F or R and who are either from India or Srilanka.
select cust_name
from country c, customer cu
where c.country_id=cu.country_id
and cust_name like 'f%' or cust_name like 'r%'
and country_name like 'india' or country_name like 'srilanka';


------8.Display customer names who are from US and do not have any phone numbers.
select cust_name
from country c,customer cu
where c.country_id=cu.country_id
and country_name like 'us'
and cust_phone is null;


----9.Display Country name, resort name. Display all the countries in the list whether we have resorts or not.
select country_name,resort_name
from country c,resort r
where c.country_id=r.country_id(+);



