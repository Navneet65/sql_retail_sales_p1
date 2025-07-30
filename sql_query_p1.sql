SELECT * FROM retail_sales;
-- Data Analysis & Business Key Problems & Answers
-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- Q2 Write a SQL query to retrieve all the transactions where the category is clothing and the quantity sold is more than 4 in the month of Nov 2022

SELECT 
*
FROM retail_sales
WHERE category = 'Clothing'
      AND 
	  to_char(sale_date,'YYYY-MM') = '2022-11'
	  AND 
	  quantity >= 4

SELECT * FROM retail_sales WHERE category = 'Clothing' AND to_char(sale_date,'YYYY-MM') = '2022-11' AND quantity >=4

-- Q3 Write a SQL query to calculate the total sales for each category

SELECT  
       category,
	   SUM(total_sale) as net_sale,
	   count(*) as total_orders
FROM retail_sales
GROUP BY 1

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' Category

SELECT 
      ROUND(AVG(age),2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Q5 Write a SQL query to find all transactions where the total_sales is greater than 1000.

SELECT * FROM retail_sales WHERE total_sale > 1000
	  
-- Q6 Write a SQL query to find the total number of  transactions (transaction_id) made by each gender in each category

SELECT 
      category,
	  gender,
      COUNT(*) as total_trans 
FROM retail_sales
GROUP 
      BY
      category,
	  gender
ORDER BY 1

-- Q7 Write a SQL query to calculate the average sale for each month. Find out the best-selling month in each year.
SELECT * FROM
(
 SELECT 
      EXTRACT(YEAR FROM sale_date) as year,
	  EXTRACT(MONTH FROM sale_date) as month,
	  AVG(total_sale) as avg_sale, 
	  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC)
FROM retail_sales
GROUP BY 1,2
) as t1
WHERE rank = 1
--ORDER BY 1,3 DESC

-- Q8 Write a SQL query to find the Top 5 customers based on the highest total sales

SELECT 
      customer_id,
	  SUM(total_sale) as total_sales
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT 
      category,
	 COUNT (DISTINCT customer_id) as total_cust
FROM retail_sales
GROUP BY category

-- Q10 Write a SQL query to create each shift and the number of orders (Example Morning <=12, Afternoon between 12 & 17, Evening >17 ) 


WITH hourly_sale
AS
(
SELECT *,
    CASE 
	    WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as Shift
FROM retail_sales
)
SELECT
      Shift,
      COUNT(*) as total_orders
FROM hourly_sale
GROUP BY Shift





	  