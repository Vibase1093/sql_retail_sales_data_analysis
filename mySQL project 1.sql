SELECT *
FROM retail_sales;

-- data cleaning
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR 
    gender IS NULL
    OR 
    age IS NULL
    OR 
    category IS NULL
    OR 
    quantiy IS NULL
    OR 
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;
    
 -- data exploration
    
 -- how many sales we have?

SELECT COUNT (*) as total_sale FROM retail_sales

 -- how many unique customers we have?
 
SELECT COUNT (DISTINCT customer_id) as total_sale FROM retail_sales

-- how many unique category

SELECT COUNT (DISTINCT category) as total_sale FROM retail_sales

 -- the categories we have
 
 SELECT DISTINCT category FROM retail_sales
 
 -- data analysis & key business problems and answers
 
 -- write a query to retrieve all column for sales made on '2022-11-05'
 
 SELECT * 
 FROM retail_sales
 WHERE sale_date='2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- UPDATE retail_sales
    -- SET month_of_sale = MONTH(sale_date)
    -- WHERE month_of_sale Is NULL;

-- Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT (*) as total_orders 
FROM retail_sales
GROUP BY 1

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale >1000

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
    category,
    gender,
    COUNT (*) as total_trans
FROM retail_sales
GROUP BY
    category,
    gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT
    year,
    month,
    avg_monthly_sales
FROM
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH (sale_date) AS month,
        AVG(total_sale) AS avg_monthly_sales,
        RANK () OVER (PARTITION BY YEAR (sale_date) ORDER BY AVG(total_sale) DESC) AS rank_in_year
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE rank_in_year = 1;

-- OR    

SELECT 
    year,
    month,
    avg_sale
FROM 
(    
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_in_year
    FROM 
        retail_sales
    GROUP BY 
        YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rank_in_year = 1;

-- Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
    customer_id,
    SUM (total_sale) as total_sales
    FROM retail_sales
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 5

-- Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
    category,
    COUNT (DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;


-- End of Project














