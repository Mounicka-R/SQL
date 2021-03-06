----1.Display all the customers who do not have a phone number(Phone column is null).
select cust_name
from customer
where phone is null;

----2.Display the customer names who are from Bangalore or Chennai.
select cust_name
from customer
where city in ('bangalore','chennai');

----3.Display the products whose price is more than 3000 and less than 5000.
select prod_name
from product
where price between 3000 and 5000;

----4.Display the customers who are from the same city as Mike.
select cust_name
from customer 
where city =(select city
from customer
where cust_name='mike');

---5.Display the products that were not sold in the previous year.
select prod_name
from product
where prod_id not in (select prod_id
from sales
where to_char(sale_date,'yy')=to_char(add_months(sysdate,-12),'yy'));



----6.Display customers who did not buy any products from the family accessories.
select cust_name
from customer
where cust_id not in (select cust_id
from product p, sales s
where p.prod_id=s.prod_id 
and p_family='accessories');



----7.Display the customers who have done more than 2 sales in the current month.
select cust_name
from customer
where cust_id in (select cust_id
from sales
where to_char(sales_date,'mm-yy')=to_char(sysdate,'mm-yy')
group by cust_id
having count(s_id)>2);


or


select cust_name,count(sales_id)
from customer_retail cu,sales_retail s
where cu.cust_id=s.cust_id
and to_char(sales_date,'mm-yy')=to_char(sysdate,'mm-yy')
group by cust_name
having count(sales_id)>2;



----8.Display products that are sold in the current year and not in the previous year.
select prod_name
from product
where prod_id=(select prod_id
from sales
where to_char(sale_date,'yy')=to_char(sysdate,'yy')
and to_char(sale_date,'yy')!= to_char(add_months(sysdate,-12),'yy'));


or

select cust_name
from customer_retail
where cust_id in (select cust_id
from sales_retail
where to_char(sales_date,'yy')= to_char(sysdate,'yy')
minus
select cust_id
from sales_retail
where to_char(sales_date,'yy')=to_char(sysdate,'yy')-1);

-----9.Display statewise total sales amount.
select state,sum(amount)
from customer c, sales s
where c.cust_id=s.cust_id
group by state;


-----10.Display the cities that have more than 10 customers.
select city,count(cust_id)
from customer
group by city
having count(cust_id)>10;
