/* Silver Checker: Data Cleansing & Data Transformation & Data Quality */

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
