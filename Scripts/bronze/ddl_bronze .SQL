/*
======================================
DDl script : create bronze table
======================================
script purpose
this script create tables in the bronze scheme , dropping exst table
if they alredy exist
run this script to redefine DDL structure
=======================================================
*/
if object_id('bronze.crm_cst_info','U') is not null
  drop table bronze.crm_cst_info;
create table bronze.crm_cst_info(
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar (50),
cst_lastname nvarchar (50),
cst_material_status nvarchar (50),
cst_gender nvarchar (50),
cst_createdate date 
);

if object_id('bronze.crm_prd_info','U') is not null
  drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
prd_id int,
prd_key nvarchar(50),
prd_cost nvarchar (50),
prd_nm nvarchar (50),
prd_line nvarchar (50),
prd_SD date,
prd_ED date 
);

if object_id('bronze.crm_sales_details','U') is not null
  drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id bigint ,
sls_order_dt bigint ,
sls_ship_dt bigint ,
sls_due_dt bigint ,
sls_sales int,
sls_quantity int,
sls_price int 
);

--============================
--ERP
--============================

if object_id('bronze.erp_CUST_AZ12','U') is not null
  drop table bronze.erp_CUST_AZ12;
create table bronze.erp_CUST_AZ12(
cid nvarchar(50),
Bdate date,
gender nvarchar(50)
);

if object_id('bronze.erp_LOC_A101','U') is not null
  drop table bronze.erp_LOC_A101;
create table bronze.erp_LOC_A101(
cid nvarchar(50),
cntry nvarchar(50)
);

if object_id('bronze.erp_PX_CAT_G1V2','U') is not null
  drop table bronze.erp_PX_CAT_G1V2;
create table bronze.erp_PX_CAT_G1V2(
id nvarchar(50),
cat nvarchar(50),
subcat nvarchar (50),
MAINTENANCE nvarchar (50)
);end
