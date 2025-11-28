CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start DATETIME, @batch_end DATETIME;
	BEGIN TRY
		SET @batch_start = GETDATE();
		PRINT '============================';
		PRINT 'Loading Bronze Layer' ;
		PRINT '============================';

		PRINT '----------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
		/* BULK insert the crm cust_info.csv file to the database */
		PRINT '>> Truncating Table: bronze.crm_customer_info';
		TRUNCATE TABLE bronze.crm_customer_info;

		PRINT '>> Inserting Data Into: bronze.crm_customer_info';
		BULK INSERT bronze.crm_customer_info
		FROM 'E:\Documents\Practice_project\Data-Warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,	-- Skip the first row, which is the header in csv
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
		/* BULK insert the crm prd_info.csv file to the database */
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\Documents\Practice_project\Data-Warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,	-- Skip the first row, which is the header in csv
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
		/* BULK insert the crm sales_details.csv file to the database */
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\Documents\Practice_project\Data-Warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,	-- Skip the first row, which is the header in csv
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------------------------';

		PRINT '----------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
		/* BULK insert the erp CUST_AZ12.csv file to the database */
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\Documents\Practice_project\Data-Warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,	-- Skip the first row, which is the header in csv
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
		/* BULK insert the erp LOC_A101.csv file to the database */
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\Documents\Practice_project\Data-Warehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,	-- Skip the first row, which is the header in csv
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------------------------';

		SET @start_time = GETDATE();
		/* BULK insert the erp PX_CAT_G1V2.csv file to the database */
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\Documents\Practice_project\Data-Warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,	-- Skip the first row, which is the header in csv
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------------------------';
		SET @batch_end = GETDATE();

		PRINT '============================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' -Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start, @batch_end) AS NVARCHAR) + 'seconds';
		PRINT '============================';
	END TRY
	BEGIN CATCH
		PRINT '============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '============================================';
	END CATCH
END
