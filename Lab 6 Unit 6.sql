-- Lab 6 Unit 6

/*
Instructions

Write queries to answer the following questions:

1. Write a query to find what is the total business done by each store.

2. Convert the previous query into a stored procedure.

3. Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

4. Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total 
sales amount for the store). Call the stored procedure and print the results.

5. In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, 
otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store
 and flag value.
 */
 
-- 1.

select s.store_id, sum(p.amount) as total_business from sakila.store s 
join inventory i 
on s.store_id = i.store_id
join rental r 
on i.inventory_id = r.inventory_id
join payment p 
on r.rental_id = p.rental_id
group by s.store_id;

-- 2. 

delimiter //

create procedure get_total_business()
begin
select s.store_id, SUM(p.amount) AS total_business
from sakila.store s
join inventory i 
on s.store_id = i.store_id
join rental r 
on i.inventory_id = r.inventory_id
join payment p 
on r.rental_id = p.rental_id
group by s.store_id;
end //

delimiter ;

-- 3. 

DELIMITER //

create procedure  get_total_business_dynamic(in store_id int)
begin
select s.store_id, sum(p.amount) as total_business
FROM sakila.store s
JOIN inventory i 
on s.store_id = i.store_id
join rental r 
on i.inventory_id = r.inventory_id
join ayment p 
on r.rental_id = p.rental_id
where s.store_id = storeId
group by s.store_id;
end //

delimiter ;

-- 4. 

delimiter //

create procedure get_total_business_with_print()
begin
declare total_sales_value float;
    
select sum(p.amount) into total_sales_value from sakila.store s
join inventory i 
on s.store_id = i.store_id
join rental r 
on i.inventory_id = r.inventory_id
join payment p 
on r.rental_id = p.rental_id;
    
select total_sales_value as total_sales;
end //

delimiter ;

call get_total_business_with_print();

-- 5.

delimiter //

create procedure get_total_business_with_fag(in store_id int)
begin
declare total_sales_value float;
declare flag varchar(20);
    
select sum(p.amount) into total_sales_value from sakila.store s
join inventory i 
on s.store_id = i.store_id
join rental r 
on i.inventory_id = r.inventory_id
join payment p 
on r.rental_id = p.rental_id
where s.store_id = storeId;
    
if total_sales_value > 30000 then
        set flag = 'green_flag';
    else
        set flag = 'red_flag';
    end if;
    
    select total_sales_value as total_sales, flag;
end //

delimiter ;
