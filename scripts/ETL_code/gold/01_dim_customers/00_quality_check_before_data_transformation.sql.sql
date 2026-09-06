-- Check for any dubplicates arised after joining the table

SELECT cst_id, COUNT(*)
 FROM (SELECT 
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ea.cntry , 
	ci.cst_marital_status,
	ca.bdate ,
	ca.gen,
	ci.cst_gndr,
	ci.cst_create_date 
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS ea
ON ci.cst_key = ea.cid)t
GROUP BY t.cst_id
HAVING COUNT(*) > 1



-- Data integration
-- Createing a perfect columns by intregating data from two sources into one
SELECT 
	DISTINCT ci.cst_gndr,
	ca.gen,
	CASE 
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the master for the gender info
		ELSE COALESCE(ca.gen, 'n/a')
	END AS gender
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS ea
ON ci.cst_key = ea.cid
ORDER BY 1, 2


