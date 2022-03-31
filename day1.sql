


----1.Write the select statement which gives all the products which costs more than Rs 250.
select p_name,cost
from product
where cost>250;

-----2.Write the select statement which gives product name, cost, price and profit. (profit formula is price – cost)
select p_name,cost,price,price-cost as profit
from product;

-----3.Find the products which give more profit than product Mouse
select p_name,price-cost as profit
from product
where price-cost >(select price-cost as profit
from product
where p_name ='mouse');

-------4.Display the products which give the profit greater than 100 Rs
select p_name,price-cost as profit
from product
where (price-cost) >100;

------5.Display the products which are not from Stationary and Computer family.
select p_name
from product
where p_family not in ('stationary','computer');

------6.Display the products which give more profit than the p_id 102.
select p_name
from product
where (price-cost) >(select price-cost as profit
from product
where p_id=102);

-------7.Display products which are launched in the year of 2010.
select p_name
from product
where to_char(launch_date,'yyyy')=2010;

-----8.Display the products which name starts with either ‘S’ or ‘W’ and which belongs to Stationary and cost more than 300 Rs
select p_name
from product
where p_name  like 's%' or 
p_name like 'w%'
and p_family ='stationary'
and cost>300;

-----9.Display the products which are launching next month.
select p_name
from product
where to_char(launch_date,'mm-yy')=to_char(add_months(sysdate,1),'mm-yy');

-----10.Display product name which has the maximum price in the entire product table.
select p_name,price
from product
where price=(select max(price)
from product);

----11.List the product name, cost, price, profit and percentage of profit we get in each product.
select p_name,cost,price,price-cost as profit,(((price-cost)/cost)*100) as percentage 
from product;

----12.Display how many products we have in Computer family which has the price range between 2000 and 50000.
select price, count(p_name)
from product
where p_family ='computer'
and (price between 2000 and 50000);

