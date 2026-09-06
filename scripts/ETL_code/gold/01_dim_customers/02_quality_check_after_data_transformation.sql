SELECT	
	customer_key,
	customer_id,
	customer_number,
	first_name,
	last_name,
	country,
	marital_status,
	gender,
	birthdate,
	create_date
FROM gold.dim_customers


-- Check for any duplicates
SELECT	
	customer_id,
	COUNT(*)
FROM gold.dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1

-- Data standaridation and consistency
SELECT	
	DISTINCT gender
FROM gold.dim_customers