SELECT * FROM public.reatail_sales
ORDER BY transactions_id ASC LIMIT 10

--step 1 Data Cleaning

	
-- 1. count number of rows in our datset
select count(*)
from public.reatail_sales

-- 2. count the number of male and females
select count(gender)
from public.reatail_sales
group by gender 

-- 3. check null values in datset
select *
from  public.reatail_sales
where quantiy is null
or 
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is  null
	or
category  is null
or 
quantiy is null
or
price_per_unit is null
or 
cogs is null
or total_sale is null




-- 4.Delete all null values from table
delete from public.reatail_sales
where quantiy is null
or 
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is  null
	or
category  is null
or 
quantiy is null
or
price_per_unit is null
or 
cogs is null
or total_sale is null



--- Data Exploration

--how may total sales we have
select count(*)  as total_sales
from public.reatail_sales

--how many unique customers record
select  count(Distinct customer_id)
from public.reatail_sales

-- Number of categories 
select Distinct category
from public.reatail_sales

--count number of unique categories
select count(DISTINCT category)
from public.reatail_sales





-- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)








-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *
from public.reatail_sales
where sale_date ='2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select *
from public.reatail_sales
where category ='Clothing'
and quantiy >=4
and 
TO_CHAR(sale_date,'YYYY-MM')='2022-11'



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum (total_sale),
	count(*) as total_orders
from public.reatail_sales
group by category



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age)
from public.reatail_sales
where category ='Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select transactions_id,total_sale
from public.reatail_sales
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(transactions_id)
from public.reatail_sales
group by 1,2 



-- Q.7 Write a SQL query to calculate the average sale for each month.Find out best selling month in each year
select * from(
	select 
		extract(Year from sale_date) as year,
		Extract(MONTH from sale_date) as Months,
		avg(total_sale) as avg_sales,
		Rank() over(partition by extract(Year from sale_date) order by avg(total_sale) desc) as rank
	from public.reatail_sales 
	group by 1,2
	
) as t1
where rank = 1


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select sum(total_sale) as Total_sale_by_each_customer,customer_id
from public.reatail_sales 
group by 2  
order by 1 desc 
limit 5

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select count(Distinct customer_id) as count_of_unique ,category
from  public.reatail_sales 
group by 2




-- Q.10 Write a SQL query to create each shift and number of orders
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sales
as
(	
select *,
  case
   	when extract(hour from sale_time)<=12 Then 'Morning'   
	when  extract(hour from sale_time) between 12 and  17 then 'Afternoon'
	Else 'Evening'
  end as shift
from public.reatail_sales 
)
select shift,
	count(*) as total_orders
from hourly_sales
group by shift


-- end of Project






