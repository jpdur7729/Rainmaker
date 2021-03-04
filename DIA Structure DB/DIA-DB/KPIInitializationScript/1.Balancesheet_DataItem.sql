DECLARE @RAWDATA TABLE (
DATAITEMNAME VARCHAR(100),
CREDITORDEBIT VARCHAR(100),
AGGREGAREORPIT VARCHAR(100),
SCALE  VARCHAR(100),
VALUETYPENAME VARCHAR(100),
ISACTIVE VARCHAR(100),
ISINDUSTRYSPECIFIC VARCHAR(100),
INDUSTRYNAME VARCHAR(100)
)

INSERT INTO @RAWDATA VALUES('Bank & Cash in hand','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Short Term Stock Investments','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Sales Revenue Receivable','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Accrued Interest Income','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Interest Receivable','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Dividend Receivable','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Trade Receivables','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Intergroup Debtors Receivables','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Receivable - Other Debtors','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Trade Debtors Receivable','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Trading Working Capital','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Intercompany Receivables','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Accounts Receivable','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Current Inventory','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Accrued Income','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Prepayments of Expenses','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Long Term Investment Purchases Cash','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Long Term Investment Purchases Cost Adjustments','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Long Term Investment Accretion','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Long Term Investment Change in FMV','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Long Term Assets','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Deferred Other Assets','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Deferred Taxes','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Intangible Asset Adjustments','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Intangible Assets - Software Development','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Fixed Assets - Adjustments','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Fixed Assets - Computer Equipment','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Fixed Assets - Fixtures and Fittings','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Fixed Assets - Office Equipment','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Fixed Assets - Plant and Equipment','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Hardware Depreciations','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Tangible Asset Adjustments','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Lease Assets','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Capex Spending','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Infrastructure Capex Spend','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Capex Special Project Spending','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Capex Project Spend Adjustments','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Capex Development Costs','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Goodwill Expenditures','Credit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Interest Accrual','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Expense Payable - Corporation Tax','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Expense Payable - Credit Card','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('VAT Expenses Payable','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Notes Payable','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Current Expense Accruals','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('LT Credit Facility Borrowings','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('PIK Borrowings','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('LT Credit Facility Repayments','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('PIK Repayments','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Long Term Liabilites','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Share Capital - ordinary shares','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Share premium','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Paid in Capital Common Stock','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Preference share dividend','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Share Capital - preference shares','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Paid in Capital Preferred Stock','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Capital Contribution Reserve','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other Capital reserves','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Other comprehensive income','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Translation Difference','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Retained earnings brought forward','Debit','Point in time','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Current Year Net Income','Debit','Point in time','7','Numeric','TRUE','FALSE','')


-- DEFAULT DATA
DECLARE @KPITYPE UNIQUEIDENTIFIER = '0F39AA09-EFE5-4524-B1DA-7169E2E11E6D';
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @DESCRIPTION NVARCHAR(3000) = 'CREATED FROM SCRIPT';
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