DECLARE @RAWDATA TABLE (
DataItemName VARCHAR(100),
CreditOrDebit VARCHAR(100),
AggregareOrPIT VARCHAR(100),
Scale  VARCHAR(100),
ValueTypeName VARCHAR(100),
IsActive VARCHAR(100),
IsIndustrySpecific VARCHAR(100),
INDUSTRYNAME VARCHAR(100)
)

INSERT INTO @RAWDATA VALUES('Product Subscriptions','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Service Contracts','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Sales of Goods','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Sales of Services','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Sales of Subsidiaries','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Sales Revenue','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Short Term Interest Income - Bank','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Short Term Dividend Income - Brokerage','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Long Term Note Income','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Realized Gain or Loss on Investments','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Realized F/X Gain or Loss','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Unrealized Investment Gain or Loss','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Unrealized F/X Gain or Loss','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Offset Incomes','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Fee Income','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Direct Sales Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Cost of Sales','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Costs','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('General Expense Overheads','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Administrative Expense Overheads','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Employee Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Insurance overheads','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('IT costs','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Marketing Overheads','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Overhead Costs','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('People Costs','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Site Costs','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Telecommunications Overheads','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Distribution Costs','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Commitment Fees','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Interest Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Unused Line Fees','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Interest Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Depreciation Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Amortization Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Tax Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('F/X Translation','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Expenses','Debit','Aggregate','7','Numeric','TRUE','FALSE','')


-- DEFAULT DATA
DECLARE @KPITYPE UNIQUEIDENTIFIER = '3A526188-BF41-4E0D-AC80-FB156BA76A01';
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PavanaKumar.Katta';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @DESCRIPTION NVARCHAR(3000) = 'Created from script';
DECLARE @DATATITEMTABLE TABLE (
	ID UNIQUEIDENTIFIER
	,INDUSTRYID UNIQUEIDENTIFIER
	,KPITYPEID UNIQUEIDENTIFIER
	,ISDEBIT BIT
	,ISAGGREGATE BIT
	,SACALE INT
	,VALUETYPEID UNIQUEIDENTIFIER
	,CREATEDBY NVARCHAR(1000)
	,CREATEDON DATETIME
	,DESCRIPTION NVARCHAR(3000)
	,NAME NVARCHAR(3000)
	,ISYSTEMDEFINED BIT
	,ISACTIVE BIT
	)

INSERT INTO RM_DATAITEM
SELECT NEWID()
	,CASE 
		WHEN ISINDUSTRYSPECIFIC = 'TRUE'
			THEN (
					SELECT Id
					FROM RM_Industry
					WHERE InvIndustryName = INDUSTRYNAME
					)
		ELSE NULL
		END
	,@KPITYPE
	,CASE 
		WHEN CREDITORDEBIT = 'CREDIT'
			THEN 0
		ELSE 1
		END
	,CASE 
		WHEN AGGREGAREORPIT = 'POINT IN TIME'
			THEN 0
		ELSE 1
		END
	,SCALE
	,(
		SELECT ID
		FROM RMX_VALUETYPE
		WHERE NAME = VALUETYPENAME
		)
	,@CREATEDBY
	,@CREATEDON
	,@DESCRIPTION
	,DATAITEMNAME
	,@ISSYSTEMDEFINED
	,CASE 
		WHEN ISACTIVE = 'TRUE'
			THEN 1
		ELSE 0
		END
FROM @RAWDATA
WHERE NOT EXISTS (
		SELECT NAME
		FROM RM_DataItem
		WHERE Name = DATAITEMNAME
		AND KPITypeId = @KPITYPE
		)

SELECT COUNT(*)
FROM RM_DATAITEM
WHERE KPITypeId = @KPITYPE
