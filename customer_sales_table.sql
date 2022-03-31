-------1.Find all the customers who did not make any sales from last two months. 
select cust_name
from customer_retail
where cust_id not in
(select cust_id
from sales_retail
where to_char(sales_date,'mm')between to_char(add_months(sysdate,-2)) and to_char(sysdate,'mm'));
select*from customer_retail;
select*from sales_retail;
-------2.Find top 10 customers in terms of sales in the current year
select*from(select cu.cust_name,s.cust_id,dense_rank() over(order by (sales_id)desc)r
from customer_retail cu,sales_retail s
where cu.cust_id=s.cust_id
and to_char(sales_date,'yy')=to_char(sysdate,'yy'))
where r<=10;


-------3.How many different cities from which we have our customers
select cust_name,count(cust_city)
from customer_retail
group by cust_id,cust_name;


----4.	Find customers who are from the same city as Customer ‘TIM’
select cust_name
from customer_retail
where cust_city = (select cust_city
from customer_retail
where cust_name='tim');

-----5.	Find how many different customers we got yesterday
select cust_name,sales_date
from customer_retail cu,sales_retail s
where cu.cust_id=s.cust_id
and to_char(sales_date,'dd-mm-yy')=to_char(sysdate-1,'dd-mm-yy');

----11.	Display the citywise current year YTD and previous year YTD.
----City_name	Current_YTD	   Prev_YTD
select to_char(sales_date,'yyyy'),to_char(sales_date,'yyyy')-1 , cust_city
from customer_retail cu,sales_retail s
where cu.cust_id=s.cust_id
group by to_char(sales_date,'yyyy'),to_char(sales_date,'yyyy')-1,cust_city;


to_char(sales_date,'yy')=to_char(sales_date,'yy')
or to_char(sales_date,'yy')=to_char(sales_date,'yy')-1

select*from sales_retail;
select * from customer_retail;

---12.	Display cities that have more number of customers than the city ‘HYD’.
select cust_city,count(cust_id)
from customer_retail 
group by cust_city 
having count(cust_id) > (select count(cust_id)
from customer_retail
where cust_city='hyd');


-----14.Display the customers who made sales yesterday and today
select cust_name,sales_date
from customer_retail cu,sales_retail s
where cu.cust_id=s.cust_id
and to_char(sales_date,'dd-mm-yy')=to_char(sysdate,'dd-mm-yy') 
and to_char(sales_date,'dd-mm-yy')=to_char(sysdate-1,'dd-mm-yy');

----15.	Display the cities whose number of customers ids more than the number of customers in city ‘Chennai’.
select cust_city,count(cust_id)
from customer_retail
group by cust_city
having count(cust_id) > (select count(cust_id)
from customer_retail
where cust_city='chennai');


----17.Display the top 1 customer based on sales in every year.
select *from(select cu.cust_name,cu.cust_id, dense_rank() over(order by (sales_date)desc )r
from customer_retail cu,sales_retail s
where cu.cust_id=s.cust_id
and to_char(sales_date,'yy')=to_char(trunc(sysdate,'yy')))
where r>=1;


select*from sales_retail;
select*from customer_retail;


