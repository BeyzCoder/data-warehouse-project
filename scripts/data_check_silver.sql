/* Silver Checker: Data Cleansing & Data Transformation & Data Quality */

/* 
==================================
table silver.crm_customer_info
==================================
*/

/* Looks for duplicates and null value */
SELECT
	cst_id,
	COUNT(*)
FROM silver.crm_customer_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

/* Cleanse data by removing unwanted spaces */
-- Exectation: No Results
SELECT
	cst_firstname
FROM silver.crm_customer_info
WHERE cst_firstname != TRIM(cst_firstname)
-- Exectation: No Results
SELECT
	cst_lastname
FROM silver.crm_customer_info
WHERE cst_lastname != TRIM(cst_lastname)

/* Data Standardization & Consistency */
SELECT DISTINCT
	cst_gndr
FROM silver.crm_customer_info

SELECT DISTINCT
	cst_material_status
FROM silver.crm_customer_info

/* 
==================================
table silver.crm_prd_info
==================================
*/
	
--WHERE SUBSTRING(prd_key, 7, LEN(prd_key)) NOT IN (SELECT sls_prd_key FROM bronze.crm_sales_details)
--WHERE REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') NOT IN (SELECT DISTINCT id FROM bronze.erp_px_cat_g1v2)

/* Unwated spaces */
-- Expectation: No Results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

/* Check NULLs or Negative Numbers */
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

/* Normalize data */
-- Expectation: word not character
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

/* Check for invalid date order */
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt > prd_start_dt
