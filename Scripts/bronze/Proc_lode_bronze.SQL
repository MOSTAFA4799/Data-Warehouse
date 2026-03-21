
exec bronze.load_bronze
create or alter procedure bronze.load_bronze 
as
begin
 begin try
   DECLARE @START_TIME DATETIME , @END_TIME DATETIME ,@BATCH_START_TIME DATETIME,@BATCH_END_TIME DATETIME
   SET @BATCH_START_TIME =GETDATE();
		print '-----------------------------------------';
		print 'Loading bronze layer';
		print '-----------------------------------------';
		print '=----------------------------------------';
		print 'Loading crm layer';
		print '-----------------------------------------';
		--------------------------------------------------------
		SET @START_TIME = GETDATE();
		print '>>trancating table : bronze.crm_cst_info';
		truncate table bronze.crm_cst_info; --لازاله التكرارات من الجدول لو حصله تنفيذ اكثر من مره
		print '>>inserting data into:bronze.crm_cst_infO';
		bulk insert bronze.crm_cst_info
		from 'F:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @END_TIME = GETDATE();
		PRINT '>>LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_TIME , @END_TIME) AS NVARCHAR) + 'SECONDS';
		----------------------------------------------------------------------------------------------------
		PRINT '--------------------------------------';
		print '>>inserting data into:bronze.crm_prd_info';
		PRINT '--------------------------------------';
		SET @START_TIME=GETDATE();
		bulk insert bronze.crm_prd_info
		from 'F:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @END_TIME =GETDATE();
		PRINT '>>LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_TIME , @END_TIME) AS NVARCHAR) + 'SECONDS';
		-----------------------------------------------------------------------------------------------------
		SET @START_TIME = GETDATE();
		PRINT '-----------------------------------------';
		PRINT ' >> bronze.crm_sales_details';
		PRINT '-----------------------------------------';
		bulk insert bronze.crm_sales_details
		from 'F:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @END_TIME = GETDATE();
		PRINT '>>LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_TIME , @END_TIME) AS NVARCHAR) + 'SECONDS';
		-----------------------------------------------------------------------------------------------------
		print '===========================================';
		print 'Loading ERp layer';
		print '===========================================';
		SET @START_TIME = GETDATE();
		bulk insert bronze.erp_CUST_AZ12
		from 'F:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @END_TIME =GETDATE();
		PRINT '>>LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_TIME , @END_TIME) AS NVARCHAR) + 'SECONDS';
		----------------------------------------------------------------------------------------------------
		PRINT '-----------------------------------------------';
		PRINT '>> bronze.erp_LOC_A101';
		PRINT '-----------------------------------------------';
		SET @START_TIME =GETDATE();
		bulk insert bronze.erp_LOC_A101
		from 'F:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @END_TIME =GETDATE();
		PRINT '>>LOAD DURATION :' + CAST(DATEDIFF(SECOND , @START_TIME , @END_TIME) AS NVARCHAR) + 'SECONDS';
		------------------------------------------------------------------------------------------------------
		PRINT '-----------------------------------------------';
		PRINT '>> bronze.erp_PX_CAT_G1V2';
		PRINT '-----------------------------------------------';
		SET @START_TIME =GETDATE();
		bulk insert bronze.erp_PX_CAT_G1V2
		from 'F:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
		firstrow = 2,
		fieldterminator = ',',
		tablock
		);
		SET @END_TIME =GETDATE();
		PRINT '-----------------------------------';
		-------------------------------------------------------------------------------------------------------
  SET @BATCH_END_TIME =GETDATE();
		print '==========================================';
		print ' >> loading bronze layer is complete ';
		print 'TOTSL LOADING DURATION : ' + CAST(DATEDIFF(SECOND , @BATCH_START_TIME , @BATCH_END_TIME) AS NVARCHAR ) + 'SECONDS';
		PRINT '=======================================';

  end try
	begin catch
		print '=================================================';
		print 'ERROR OCCURE DURING LODING BRONZE LAYER';
		print 'ERROR MESSAGE' + ERROR_MESSAGE();
		print 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		print 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		print '=================================================';
	end catch
end
