DECLARE @RAWDATA TABLE (
	idindex INT
	,LEVEL1 VARCHAR(MAX)
	,LEVEL2 VARCHAR(MAX)
	,LEVEL3 VARCHAR(MAX)
	,LEVEL4 VARCHAR(MAX)
	,LEVEL5 VARCHAR(MAX)
	,LEVEL6 VARCHAR(MAX)
	,LEVEL7 VARCHAR(MAX)
	,LEVEL8 VARCHAR(MAX)
	,LEVEL9 VARCHAR(MAX)
	,LEVEL10 VARCHAR(MAX)
	,DATAITEMNAME VARCHAR(MAX)
	,INDUSTRYNAME VARCHAR(MAX)
	)
DECLARE @LEVEL1 TABLE (
	ID INT IDENTITY(1, 1)
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL2 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL3 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL4 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL5 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL6 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL7 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL8 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL9 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @LEVEL10 TABLE (
	ID INT
	,NAME VARCHAR(1000)
	)
DECLARE @FINALTABLE TABLE (
	NID INT IDENTITY(1, 1)
	,ID UNIQUEIDENTIFIER
	,NODENAME VARCHAR(1000)
	,ISSYSTEMDEFINED INT
	,PARENTID UNIQUEIDENTIFIER
	,PARENTNODENAME VARCHAR(1000)
	,KPIITYPEID UNIQUEIDENTIFIER
	,ISNEWNODE BIT
	,INDUSTRYID UNIQUEIDENTIFIER
	,IDINDEX INT
	)
DECLARE @NODEDATAITEMASSOCIATION TABLE (
	ID INT
	,NODEID UNIQUEIDENTIFIER
	,DATAITEMNAME VARCHAR(100)
	)
-- DEFAULT DATA 
DECLARE @KPITYPE UNIQUEIDENTIFIER = '192CEC9C-780A-4E82-AA50-FA07EACEB306'
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @ISNEWNODE BIT = 0;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @ISACTIVE BIT = 1;
DECLARE @EMPTYGUID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';

--- ENTER DATA HERE - START
INSERT INTO @RAWDATA
VALUES (
	1
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	2
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	3
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	4
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	5
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	6
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	7
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	8
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	9
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	10
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	11
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	12
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	13
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	14
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	15
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	16
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	17
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	18
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	19
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	20
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	21
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	22
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	23
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	24
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	25
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	26
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	27
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	28
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	29
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,'Share Capital - ordinary shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	30
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,'Share premium'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	31
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Paid in Capital Common Stock'
	,''
	,''
	,''
	,'Paid in Capital Common Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	32
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,'Preference share dividend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	33
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,'Share Capital - preference shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	34
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Paid in Capital Preferred Stock'
	,''
	,''
	,''
	,'Paid in Capital Preferred Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	35
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Capital Contribution Reserves'
	,''
	,''
	,''
	,'Capital Contribution Reserve'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	36
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Other Reserves'
	,''
	,''
	,''
	,'Other Capital reserves'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	37
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Other Comprehensive Income'
	,''
	,''
	,''
	,'Other comprehensive income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	38
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Translation Difference'
	,''
	,''
	,''
	,'Translation Difference'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	39
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Prior Years Retained Earnings'
	,'PY RE Brought Forward'
	,''
	,''
	,''
	,'Retained earnings brought forward'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	40
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Current Year Earnings'
	,'Current Year RE Adjustments'
	,''
	,''
	,''
	,'Current Year Net Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	41
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	42
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	43
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	44
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	45
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	46
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	47
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	48
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	49
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	50
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	51
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	52
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	53
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	54
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	55
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	56
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	57
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	58
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	59
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	60
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	61
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	62
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	63
	,'Financials'
	,'Total Net Debt'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	64
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Cash Assets'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	65
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Short Term Investments'
	,'Short Term Investments'
	,''
	,''
	,''
	,''
	,'Short Term Stock Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	66
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Sales Revenue Receivable'
	,''
	,''
	,''
	,''
	,'Sales Revenue Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	67
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,''
	,'Accrued Interest Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	68
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,''
	,'Cash Interest Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	69
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,''
	,'Dividend Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	70
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,''
	,'Trade Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	71
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,''
	,'Intergroup Debtors Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	72
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,''
	,'Receivable - Other Debtors'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	73
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,''
	,'Trade Debtors Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	74
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Trading Working Capital'
	,''
	,''
	,''
	,''
	,'Trading Working Capital'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	75
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Intercompany Receivables'
	,''
	,''
	,''
	,''
	,'Intercompany Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	76
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Other Accounts Receivable'
	,''
	,''
	,''
	,''
	,'Other Accounts Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	77
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Inventory'
	,'Current Inventory'
	,''
	,''
	,''
	,''
	,'Current Inventory'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	78
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Accrued Revenue'
	,''
	,''
	,''
	,''
	,'Accrued Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	79
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Prepaid Expenses'
	,''
	,''
	,''
	,''
	,'Prepayments of Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	80
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,''
	,''
	,'Long Term Investment Purchases Cash'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	81
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,''
	,''
	,'Long Term Investment Purchases Cost Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	82
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Accretions'
	,''
	,''
	,''
	,''
	,'Long Term Investment Accretion'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	83
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments FMV'
	,'Long Term Investment Adjustments'
	,''
	,''
	,''
	,''
	,'Long Term Investment Change in FMV'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	84
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Assets'
	,'Long Term Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Long Term Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	85
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	86
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	87
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	88
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	89
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	90
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	91
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	92
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	93
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	94
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	95
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	96
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	97
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	98
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	99
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	100
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	101
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	102
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	103
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Cash Assets'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	104
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Short Term Investments'
	,'Short Term Investments'
	,''
	,''
	,''
	,'Short Term Stock Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	105
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Sales Revenue Receivable'
	,''
	,''
	,''
	,'Sales Revenue Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	106
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Accrued Interest Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	107
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Cash Interest Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	108
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Dividend Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	109
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Trade Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	110
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,'Intergroup Debtors Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	111
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,'Receivable - Other Debtors'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	112
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,'Trade Debtors Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	113
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Trading Working Capital'
	,''
	,''
	,''
	,'Trading Working Capital'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	114
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Intercompany Receivables'
	,''
	,''
	,''
	,'Intercompany Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	115
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Other Accounts Receivable'
	,''
	,''
	,''
	,'Other Accounts Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	116
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Inventory'
	,'Current Inventory'
	,''
	,''
	,''
	,'Current Inventory'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	117
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Accrued Revenue'
	,''
	,''
	,''
	,'Accrued Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	118
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Prepaid Expenses'
	,''
	,''
	,''
	,'Prepayments of Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	119
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,''
	,'Long Term Investment Purchases Cash'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	120
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,''
	,'Long Term Investment Purchases Cost Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	121
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Accretions'
	,''
	,''
	,''
	,'Long Term Investment Accretion'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	122
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments FMV'
	,'Long Term Investment Adjustments'
	,''
	,''
	,''
	,'Long Term Investment Change in FMV'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	123
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Assets'
	,'Long Term Asset Adjustments'
	,''
	,''
	,''
	,'Long Term Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	124
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	125
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	126
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	127
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	128
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	129
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	130
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	131
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	132
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	133
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	134
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	135
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	136
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	137
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	138
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	139
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	140
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	141
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	142
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Interest Expenses Payable'
	,''
	,''
	,''
	,'Interest Accrual'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	143
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,'Expense Payable - Corporation Tax'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	144
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,'Expense Payable - Credit Card'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	145
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,'VAT Expenses Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	146
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Notes Payable'
	,''
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	147
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Liability Accruals'
	,'Current Accrued Expenses'
	,''
	,''
	,''
	,'Current Expense Accruals'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	148
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	149
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	150
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	151
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	152
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,''
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	153
	,'Financials'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	154
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Interest Expenses Payable'
	,''
	,''
	,''
	,''
	,'Interest Accrual'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	155
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,''
	,'Expense Payable - Corporation Tax'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	156
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,''
	,'Expense Payable - Credit Card'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	157
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,''
	,'VAT Expenses Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	158
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Notes Payable'
	,''
	,''
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	159
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Liability Accruals'
	,'Current Accrued Expenses'
	,''
	,''
	,''
	,''
	,'Current Expense Accruals'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	160
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	161
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	162
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	163
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	164
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,''
	,''
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	165
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,''
	,'Share Capital - ordinary shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	166
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,''
	,'Share premium'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	167
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Paid in Capital Common Stock'
	,''
	,''
	,''
	,''
	,'Paid in Capital Common Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	168
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,''
	,'Preference share dividend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	169
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,''
	,'Share Capital - preference shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	170
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Paid in Capital Preferred Stock'
	,''
	,''
	,''
	,''
	,'Paid in Capital Preferred Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	171
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Capital Contribution Reserves'
	,''
	,''
	,''
	,''
	,'Capital Contribution Reserve'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	172
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Other Reserves'
	,''
	,''
	,''
	,''
	,'Other Capital reserves'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	173
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Other Comprehensive Income'
	,''
	,''
	,''
	,''
	,'Other comprehensive income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	174
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Translation Difference'
	,''
	,''
	,''
	,''
	,'Translation Difference'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	175
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Prior Years Retained Earnings'
	,'PY RE Brought Forward'
	,''
	,''
	,''
	,''
	,'Retained earnings brought forward'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	176
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Current Year Earnings'
	,'Current Year RE Adjustments'
	,''
	,''
	,''
	,''
	,'Current Year Net Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	177
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,''
	,''
	,'Share Capital - ordinary shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	178
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,''
	,''
	,'Share premium'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	179
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Paid in Capital Common Stock'
	,''
	,''
	,''
	,''
	,''
	,'Paid in Capital Common Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	180
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,''
	,''
	,'Preference share dividend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	181
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,''
	,''
	,'Share Capital - preference shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	182
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Paid in Capital Preferred Stock'
	,''
	,''
	,''
	,''
	,''
	,'Paid in Capital Preferred Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	183
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Reserves'
	,'Capital Contribution Reserves'
	,''
	,''
	,''
	,''
	,''
	,'Capital Contribution Reserve'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	184
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Reserves'
	,'Other Reserves'
	,''
	,''
	,''
	,''
	,''
	,'Other Capital reserves'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	185
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Other Comprehensive Income'
	,''
	,''
	,''
	,''
	,''
	,'Other comprehensive income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	186
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Translation Difference'
	,''
	,''
	,''
	,''
	,''
	,'Translation Difference'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	187
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,''
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	188
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,''
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	189
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	190
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	191
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	192
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	193
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	194
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	195
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	196
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,''
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	197
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	198
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	199
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	200
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	201
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	202
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	203
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	204
	,'Financials'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	205
	,'Financials'
	,'Gross Interest Expense'
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,'Gross Interest Expense'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	206
	,'Financials'
	,'Book Value of Debt'
	,'Notes Payable'
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	207
	,'Financials'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	208
	,'Financials'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	209
	,'Financials'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	210
	,'Financials'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	211
	,'Financials'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,''
	,''
	,''
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	212
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Interest Expenses Payable'
	,''
	,''
	,''
	,''
	,''
	,'Interest Accrual'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	213
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,''
	,''
	,'Expense Payable - Corporation Tax'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	214
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,''
	,''
	,'Expense Payable - Credit Card'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	215
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,''
	,''
	,''
	,'VAT Expenses Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	216
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Notes Payable'
	,''
	,''
	,''
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	217
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Current Liabilities'
	,'Current Liability Accruals'
	,'Current Accrued Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Current Expense Accruals'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	218
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Cash Assets'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	219
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Short Term Investments'
	,'Short Term Investments'
	,''
	,''
	,''
	,'Short Term Stock Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	220
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Sales Revenue Receivable'
	,''
	,''
	,''
	,'Sales Revenue Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	221
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Accrued Interest Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	222
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Cash Interest Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	223
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Dividend Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	224
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,''
	,'Trade Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	225
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,'Intergroup Debtors Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	226
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,'Receivable - Other Debtors'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	227
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,''
	,'Trade Debtors Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	228
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Trading Working Capital'
	,''
	,''
	,''
	,'Trading Working Capital'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	229
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Intercompany Receivables'
	,''
	,''
	,''
	,'Intercompany Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	230
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Other Accounts Receivable'
	,''
	,''
	,''
	,'Other Accounts Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	231
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Inventory'
	,'Current Inventory'
	,''
	,''
	,''
	,'Current Inventory'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	232
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Accrued Revenue'
	,''
	,''
	,''
	,'Accrued Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	233
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Prepaid Expenses'
	,''
	,''
	,''
	,'Prepayments of Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	234
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,''
	,'Long Term Investment Purchases Cash'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	235
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,''
	,'Long Term Investment Purchases Cost Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	236
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Accretions'
	,''
	,''
	,''
	,'Long Term Investment Accretion'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	237
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments FMV'
	,'Long Term Investment Adjustments'
	,''
	,''
	,''
	,'Long Term Investment Change in FMV'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	238
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Assets'
	,'Long Term Asset Adjustments'
	,''
	,''
	,''
	,'Long Term Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	239
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	240
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	241
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	242
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	243
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	244
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	245
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	246
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	247
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	248
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	249
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	250
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	251
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	252
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	253
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	254
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	255
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	256
	,'Financials'
	,'Total Assets Less Current Liab.'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	257
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	258
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	259
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	260
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	261
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	262
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	263
	,'Financials'
	,'Total Cost of Goods Sold'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	264
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	265
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	266
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	267
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	268
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	269
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	270
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	271
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	272
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	273
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	274
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	275
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	276
	,'Financials'
	,'Total SG&A Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	277
	,'Financials'
	,'F/X Translation Gain or Loss'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,''
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	278
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	279
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	280
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	281
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	282
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	283
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	284
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	285
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	286
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	287
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	288
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	289
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	290
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	291
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	292
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	293
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	294
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	295
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	296
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	297
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,'Administrative Expenses'
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	298
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	299
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	300
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	301
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	302
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	303
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	304
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	305
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	306
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	307
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	308
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	309
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	310
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	311
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	312
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	313
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	314
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	315
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	316
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	317
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	318
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	319
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	320
	,'Profitability'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	321
	,'Profitability'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	322
	,'Profitability'
	,'EBITDA'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	323
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	324
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	325
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	326
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	327
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	328
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	329
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	330
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	331
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	332
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	333
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	334
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	335
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	336
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	337
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	338
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	339
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	340
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	341
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	342
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	343
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	344
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	345
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	346
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	347
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	348
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	349
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	350
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	351
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	352
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	353
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	354
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	355
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	356
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	357
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	358
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	359
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	360
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	361
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	362
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	363
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	364
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	365
	,'Profitability'
	,'EBIT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	366
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	367
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	368
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	369
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	370
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	371
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	372
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	373
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	374
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	375
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	376
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	377
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	378
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	379
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	380
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	381
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	382
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	383
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	384
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	385
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	386
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	387
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	388
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	389
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	390
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	391
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	392
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	393
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	394
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	395
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	396
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	397
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	398
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	399
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	400
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	401
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	402
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	403
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	404
	,'Profitability'
	,'EBT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	405
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	406
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	407
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	408
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	409
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	410
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	411
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	412
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	413
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	414
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	415
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	416
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	417
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	418
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	419
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	420
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	421
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	422
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	423
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	424
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,'Administrative Expenses'
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	425
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	426
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	427
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	428
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	429
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	430
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	431
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	432
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	433
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	434
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	435
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	436
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	437
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	438
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	439
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	440
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	441
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	442
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	443
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	444
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	445
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	446
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	447
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	448
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	449
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	450
	,'Profitability'
	,'Adjusted EBITDA'
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,'Adjustment to EBITDA'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	451
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	452
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	453
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	454
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	455
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	456
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	457
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	458
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	459
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	460
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	461
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	462
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	463
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	464
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	465
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	466
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	467
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	468
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	469
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	470
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	471
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	472
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	473
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	474
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	475
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	476
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	477
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	478
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	479
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	480
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	481
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	482
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	483
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	484
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	485
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	486
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	487
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	488
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	489
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	490
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	491
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	492
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	493
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	494
	,'Profitability'
	,'Adjusted EBIT'
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,'Adjustment to EBIT'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	495
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	496
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	497
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	498
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	499
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	500
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	501
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	502
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	503
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	504
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	505
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	506
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	507
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	508
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	509
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	510
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	511
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	512
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	513
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	514
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	515
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	516
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	517
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	518
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	519
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	520
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	521
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	522
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	523
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	524
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	525
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	526
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	527
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	528
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	529
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	530
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	531
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	532
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	533
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	534
	,'Profitability'
	,'Adjusted EBT'
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,''
	,'Adjustment to EBT'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	535
	,'Profitability'
	,'Revenues net of COGS'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	536
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	537
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	538
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	539
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	540
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	541
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	542
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	543
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	544
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	545
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	546
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	547
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	548
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	549
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,'Offset Income'
	,''
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	550
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	551
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,''
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	552
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,''
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	553
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	554
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	555
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	556
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	557
	,'Profitability'
	,'Total Revenue'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,''
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	558
	,'Profitability'
	,'Total Revenue'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,''
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	559
	,'Profitability'
	,'Total Revenue'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,''
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	560
	,'Profitability'
	,'Total Revenue'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	561
	,'Profitability'
	,'Total Revenue'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	562
	,'Profitability'
	,'Total Revenue'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	563
	,'Profitability'
	,'Total Revenue'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	564
	,'Profitability'
	,'Total Revenue'
	,'Other Income'
	,'Other Offset Income'
	,'Offset Income'
	,''
	,''
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	565
	,'Profitability'
	,'Total Revenue'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	566
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	567
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	568
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	569
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	570
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	571
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	572
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	573
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	574
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	575
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	576
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	577
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	578
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	579
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	580
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	581
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	582
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	583
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	584
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	585
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	586
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	587
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	588
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	589
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	590
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	591
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	592
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	593
	,'Profitability'
	,'Cost of Revenue'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	594
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,''
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	595
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,''
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	596
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,''
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	597
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	598
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	599
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	600
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	601
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	602
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	603
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	604
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	605
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	606
	,'Profitability'
	,'Cost of Revenue'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	607
	,'Profitability'
	,'Other Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,''
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	608
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	609
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	610
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	611
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	612
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	613
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	614
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	615
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Notes Payable'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	616
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	617
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	618
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	619
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	620
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,''
	,''
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	621
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	622
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	623
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	624
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	625
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	626
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	627
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	628
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	629
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	630
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	631
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	632
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	633
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	634
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	635
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	636
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	637
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	638
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	639
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	640
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	641
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	642
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	643
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	644
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	645
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	646
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	647
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	648
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	649
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	650
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Expenses'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	651
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	652
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	653
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	654
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	655
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Net Debt'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	656
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,'Share Capital - ordinary shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	657
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,'Share premium'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	658
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Paid in Capital Common Stock'
	,''
	,'Paid in Capital Common Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	659
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,'Preference share dividend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	660
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,'Share Capital - preference shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	661
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Paid in Capital Preferred Stock'
	,''
	,'Paid in Capital Preferred Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	662
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Capital Contribution Reserves'
	,''
	,'Capital Contribution Reserve'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	663
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Other Reserves'
	,''
	,'Other Capital reserves'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	664
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Other Comprehensive Income'
	,''
	,'Other comprehensive income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	665
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Translation Difference'
	,''
	,'Translation Difference'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	666
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Prior Years Retained Earnings'
	,'PY RE Brought Forward'
	,''
	,'Retained earnings brought forward'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	667
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Current Year Earnings'
	,'Current Year RE Adjustments'
	,''
	,'Current Year Net Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	668
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	669
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	670
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	671
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	672
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	673
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	674
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	675
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	676
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	677
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	678
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	679
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	680
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	681
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	682
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	683
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	684
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	685
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Enterprise Value'
	,'Minority Interests and Other Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	686
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	687
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	688
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	689
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Net Debt'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	690
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Net Debt'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	691
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Cash Assets'
	,'Bank and Cash on Hand'
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	692
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Short Term Investments'
	,'Short Term Investments'
	,''
	,''
	,'Short Term Stock Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	693
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Sales Revenue Receivable'
	,''
	,''
	,'Sales Revenue Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	694
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,'Accrued Interest Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	695
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,'Cash Interest Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	696
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,'Dividend Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	697
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,''
	,'Trade Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	698
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,'Intergroup Debtors Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	699
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,'Receivable - Other Debtors'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	700
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,''
	,'Trade Debtors Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	701
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Trading Working Capital'
	,''
	,''
	,'Trading Working Capital'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	702
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Intercompany Receivables'
	,''
	,''
	,'Intercompany Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	703
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Other Accounts Receivable'
	,''
	,''
	,'Other Accounts Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	704
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Inventory'
	,'Current Inventory'
	,''
	,''
	,'Current Inventory'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	705
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Accrued Revenue'
	,''
	,''
	,'Accrued Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	706
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Prepaid Expenses'
	,''
	,''
	,'Prepayments of Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	707
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,'Long Term Investment Purchases Cash'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	708
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,''
	,'Long Term Investment Purchases Cost Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	709
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Accretions'
	,''
	,''
	,'Long Term Investment Accretion'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	710
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments FMV'
	,'Long Term Investment Adjustments'
	,''
	,''
	,'Long Term Investment Change in FMV'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	711
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Assets'
	,'Long Term Asset Adjustments'
	,''
	,''
	,'Long Term Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	712
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	713
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	714
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	715
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	716
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	717
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	718
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	719
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	720
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	721
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	722
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	723
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	724
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	725
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	726
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	727
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	728
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	729
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	730
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Cash Assets'
	,'Bank and Cash on Hand'
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	731
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Short Term Investments'
	,'Short Term Investments'
	,''
	,'Short Term Stock Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	732
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Sales Revenue Receivable'
	,''
	,'Sales Revenue Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	733
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,'Accrued Interest Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	734
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,'Cash Interest Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	735
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,'Dividend Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	736
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Interests Receivable'
	,''
	,'Trade Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	737
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,'Intergroup Debtors Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	738
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,'Receivable - Other Debtors'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	739
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Debtors Receivable'
	,''
	,'Trade Debtors Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	740
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Trading Working Capital'
	,''
	,'Trading Working Capital'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	741
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Intercompany Receivables'
	,''
	,'Intercompany Receivables'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	742
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Accounts Receivable'
	,'Other Accounts Receivable'
	,''
	,'Other Accounts Receivable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	743
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Inventory'
	,'Current Inventory'
	,''
	,'Current Inventory'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	744
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Accrued Revenue'
	,''
	,'Accrued Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	745
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Current Assets'
	,'Current Asset Accruals'
	,'Prepaid Expenses'
	,''
	,'Prepayments of Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	746
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,'Long Term Investment Purchases Cash'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	747
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Purchases'
	,''
	,'Long Term Investment Purchases Cost Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	748
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments at Cost'
	,'Long Term Investment Accretions'
	,''
	,'Long Term Investment Accretion'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	749
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Investments FMV'
	,'Long Term Investment Adjustments'
	,''
	,'Long Term Investment Change in FMV'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	750
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Non-Current Assets'
	,'Long Term Assets'
	,'Long Term Asset Adjustments'
	,''
	,'Long Term Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	751
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Other Assets'
	,''
	,'Deferred Other Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	752
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Deferred Other Assets'
	,'Deferred Taxes'
	,''
	,'Deferred Taxes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	753
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,'Intangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	754
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Intangible Assets'
	,'Intangible Asset Adjustments'
	,''
	,'Intangible Assets - Software Development'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	755
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,'Fixed Assets - Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	756
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,'Fixed Assets - Computer Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	757
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,'Fixed Assets - Fixtures and Fittings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	758
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,'Fixed Assets - Office Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	759
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Fixed Assets Adjustments'
	,''
	,'Fixed Assets - Plant and Equipment'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	760
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Fixed Assets'
	,'Hardware Fixed Asset Closing Adjust'
	,''
	,'Hardware Depreciations'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	761
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Tangible Assets'
	,'Tangible Asset Adjustments'
	,''
	,'Tangible Asset Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	762
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Lease Assets'
	,'Lease Asset Adjustments'
	,''
	,'Lease Assets'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	763
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	764
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	765
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	766
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	767
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	768
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Assets'
	,'Total Assets'
	,'Other Assets'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	769
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Interest Expenses Payable'
	,''
	,'Interest Accrual'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	770
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,'Expense Payable - Corporation Tax'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	771
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,'Expense Payable - Credit Card'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	772
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,'VAT Expenses Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	773
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Notes Payable'
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	774
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Liability Accruals'
	,'Current Accrued Expenses'
	,''
	,'Current Expense Accruals'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	775
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	776
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	777
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	778
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	779
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Net Assets'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	780
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	781
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Interest Expenses Payable'
	,''
	,''
	,'Interest Accrual'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	782
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,'Expense Payable - Corporation Tax'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	783
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,'Expense Payable - Credit Card'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	784
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Other Expenses Payable'
	,''
	,''
	,'VAT Expenses Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	785
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Accounts Payable'
	,'Notes Payable'
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	786
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Current Liabilities'
	,'Current Liability Accruals'
	,'Current Accrued Expenses'
	,''
	,''
	,'Current Expense Accruals'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	787
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	788
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	789
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	790
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	791
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Liabilities'
	,'Total Liabilities'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	792
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,'Share Capital - ordinary shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	793
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,'Share premium'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	794
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Paid in Capital Common Stock'
	,''
	,''
	,'Paid in Capital Common Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	795
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,'Preference share dividend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	796
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,'Share Capital - preference shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	797
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Paid in Capital Preferred Stock'
	,''
	,''
	,'Paid in Capital Preferred Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	798
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Capital Contribution Reserves'
	,''
	,''
	,'Capital Contribution Reserve'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	799
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Reserves'
	,'Other Reserves'
	,''
	,''
	,'Other Capital reserves'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	800
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Other Comprehensive Income'
	,''
	,''
	,'Other comprehensive income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	801
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Translation Difference'
	,''
	,''
	,'Translation Difference'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	802
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Prior Years Retained Earnings'
	,'PY RE Brought Forward'
	,''
	,''
	,'Retained earnings brought forward'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	803
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Total Equity'
	,'Total Equity'
	,'Retained Earnings'
	,'Current Year Earnings'
	,'Current Year RE Adjustments'
	,''
	,''
	,'Current Year Net Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	804
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,'Share Capital - ordinary shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	805
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Common Stock'
	,''
	,''
	,''
	,'Share premium'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	806
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Common Equity'
	,'Paid in Capital Common Stock'
	,''
	,''
	,''
	,'Paid in Capital Common Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	807
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,'Preference share dividend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	808
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Preferred Stock'
	,''
	,''
	,''
	,'Share Capital - preference shares'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	809
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Preferred Equity'
	,'Paid in Capital Preferred Stock'
	,''
	,''
	,''
	,'Paid in Capital Preferred Stock'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	810
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Reserves'
	,'Capital Contribution Reserves'
	,''
	,''
	,''
	,'Capital Contribution Reserve'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	811
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Reserves'
	,'Other Reserves'
	,''
	,''
	,''
	,'Other Capital reserves'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	812
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Other Comprehensive Income'
	,''
	,''
	,''
	,'Other comprehensive income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	813
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Owners Equity'
	,'Owners Equity'
	,'Other Equity'
	,'Translation Difference'
	,''
	,''
	,''
	,'Translation Difference'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	814
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	815
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	816
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	817
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	818
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	819
	,'Reporting'
	,'PC: Key Trends'
	,'Financials'
	,'Capex'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	820
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	821
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	822
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	823
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	824
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	825
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	826
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	827
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	828
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	829
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	830
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	831
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	832
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	833
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	834
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	835
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	836
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	837
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	838
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	839
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,'Administrative Expenses'
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	840
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	841
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	842
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	843
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	844
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	845
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	846
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	847
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	848
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	849
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	850
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	851
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	852
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	853
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	854
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	855
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	856
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	857
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	858
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	859
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	860
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	861
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	862
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	863
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	864
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBITDA'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	865
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	866
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	867
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	868
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	869
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	870
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	871
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	872
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	873
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	874
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	875
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	876
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	877
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	878
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	879
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	880
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	881
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	882
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	883
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	884
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	885
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	886
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	887
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	888
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	889
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	890
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	891
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	892
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	893
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	894
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	895
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	896
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	897
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	898
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	899
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	900
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	901
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	902
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	903
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	904
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	905
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	906
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	907
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBIT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	908
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	909
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	910
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	911
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	912
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	913
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	914
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	915
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	916
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	917
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	918
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	919
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	920
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	921
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	922
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	923
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	924
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	925
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	926
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	927
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	928
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	929
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	930
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	931
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	932
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	933
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	934
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	935
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	936
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	937
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	938
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	939
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	940
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	941
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	942
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	943
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	944
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	945
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	946
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'EBT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	947
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	948
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	949
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	950
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	951
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	952
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	953
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	954
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	955
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	956
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	957
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	958
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	959
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	960
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	961
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	962
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	963
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	964
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	965
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	966
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,'Administrative Expenses'
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	967
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	968
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	969
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	970
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	971
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	972
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	973
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	974
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	975
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	976
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	977
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	978
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	979
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	980
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	981
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	982
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	983
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	984
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	985
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	986
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	987
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	988
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	989
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,''
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	990
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,''
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	991
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,'EBITDA'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	992
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBITDA'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Adjustment to EBITDA'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	993
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	994
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	995
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	996
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	997
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	998
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	999
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1000
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1001
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1002
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1003
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1004
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1005
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1006
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1007
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1008
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1009
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1010
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1011
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1012
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1013
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1014
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1015
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1016
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1017
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1018
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1019
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1020
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1021
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1022
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1023
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1024
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1025
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1026
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1027
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1028
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1029
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1030
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1031
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1032
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1033
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1034
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1035
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,'EBIT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1036
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBIT'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Adjustment to EBIT'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1037
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1038
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1039
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1040
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1041
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1042
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1043
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1044
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1045
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1046
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1047
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1048
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1049
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1050
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1051
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1052
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1053
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1054
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1055
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1056
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1057
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1058
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1059
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1060
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1061
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1062
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1063
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1064
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1065
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1066
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1067
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1068
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1069
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1070
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1071
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1072
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1073
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1074
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Income Statement'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1075
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,'EBT'
	,'Taxes'
	,'Tax Expenses'
	,''
	,''
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1076
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Adjusted EBT'
	,''
	,''
	,''
	,''
	,''
	,''
	,'Adjustment to EBT'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1077
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,''
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1078
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1079
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1080
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1081
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1082
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1083
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1084
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1085
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1086
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1087
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1088
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1089
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1090
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1091
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Other Income'
	,'Other Offset Income'
	,'Offset Income'
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1092
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Revenues net of COGS'
	,'Total Revenues'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1093
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Recurring Revenues'
	,'Product Subscriptions'
	,''
	,''
	,''
	,'Product Subscriptions'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1094
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Recurring Revenues'
	,'Service Contracts'
	,''
	,''
	,''
	,'Service Contracts'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1095
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1096
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1097
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1098
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1099
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Short Term Interest Income'
	,'ST Interest Income - Bank Balances'
	,'ST Interest Income'
	,''
	,''
	,''
	,'Short Term Interest Income - Bank'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1100
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Short Term Interest Income'
	,'ST Dividend Income - Brokerage'
	,'ST Dividend Income'
	,''
	,''
	,''
	,'Short Term Dividend Income - Brokerage'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1101
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Long Term Interest Income'
	,'Long Term Note Income'
	,'LT Note Income'
	,''
	,''
	,''
	,'Long Term Note Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1102
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Realized Gain or Loss'
	,'Realized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized Gain or Loss on Investments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1103
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Realized Gain or Loss'
	,'Realized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Realized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1104
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Unrealized Gain or Loss'
	,'Unrealized Investment Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized Investment Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1105
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Unrealized Gain or Loss'
	,'Unrealized F/X Gain or Loss'
	,''
	,''
	,''
	,''
	,'Unrealized F/X Gain or Loss'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1106
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Other Income'
	,'Other Offset Income'
	,'Offset Income'
	,''
	,''
	,''
	,'Offset Incomes'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1107
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Total Revenue'
	,'Other Income'
	,'Other Fee Income'
	,''
	,''
	,''
	,''
	,'Other Fee Income'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1108
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Goods'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1109
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Services'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1110
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Sales of Subsidiaries'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1111
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Revenues'
	,'Non-Recurring Revenues'
	,'Sales Revenue'
	,''
	,''
	,''
	,'Other Sales Revenue'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1112
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Cost of Goods Sold'
	,'COGS'
	,'Direct Sales Expense'
	,''
	,'Direct Sales Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1113
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Cost of Sales'
	,''
	,'Other Cost of Sales'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1114
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Sales Expenses'
	,'SG&A Other Costs'
	,''
	,'Other Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1115
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'General Expenses'
	,'General Expense Overheads'
	,''
	,'General Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1116
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Administrative Expenses'
	,''
	,''
	,'Administrative Expense Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1117
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Employee Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1118
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Insurance overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1119
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'IT costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1120
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Marketing Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1121
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Other Overhead Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1122
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'People Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1123
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Site Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1124
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Overheads'
	,'Overhead Expenses'
	,''
	,'Telecommunications Overheads'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1125
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'SG&A'
	,'Variable Costs'
	,'Variable Cost Expenses'
	,''
	,'Distribution Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1126
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Commitment Fees'
	,''
	,'Commitment Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1127
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Interest Expenses'
	,''
	,'Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1128
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Financing Costs'
	,'Unused Line Fees'
	,''
	,'Unused Line Fees'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1129
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Interest Expense'
	,'Other Interest Expenses'
	,'Other Interest Expense Adjustments'
	,''
	,'Other Interest Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1130
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Depreciation Expenses'
	,'Depreciation Expenses'
	,''
	,'Depreciation Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1131
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Depreciation and Amortization'
	,'Amortization Expenses'
	,'Amortization Expenses'
	,''
	,'Amortization Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1132
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Taxes'
	,'Tax Expenses'
	,'Tax Expenses'
	,''
	,'Tax Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1133
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Foreign Exchange'
	,'Foreign Exchange Translations'
	,'F/X Translation Expenses'
	,''
	,'F/X Translation'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1134
	,'Reporting'
	,'PC: Key Trends'
	,'Profitability'
	,'Net Profit from Sales'
	,'Total Expenses'
	,'Total Expenses'
	,'Other Expenses'
	,'Other Expense Overheads'
	,'Other Expenses'
	,''
	,'Other Expenses'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1135
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1136
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1137
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1138
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1139
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1140
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1141
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,''
	,'Goodwill Expenditures'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1142
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Notes Payable'
	,''
	,''
	,''
	,''
	,'Notes Payable'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1143
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,'LT Credit Facility Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1144
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Borrowings'
	,''
	,''
	,'PIK Borrowings'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1145
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,'LT Credit Facility Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1146
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Long Term Credit Facility Notes'
	,'LT Credit Facility Note Repayments'
	,''
	,''
	,'PIK Repayments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1147
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Book Value of Debt'
	,'Long Term Liabilities'
	,'Other Long Term Obligations'
	,'Other LT Obligations'
	,''
	,''
	,'Other Long Term Liabilites'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1148
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Cash'
	,'Bank and Cash on Hand'
	,''
	,''
	,''
	,'Bank & Cash in hand'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1149
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Other Capex Expenditures'
	,''
	,'Other Capex Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1150
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Infrastructure Capex Spend'
	,''
	,'Infrastructure Capex Spend'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1151
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Special Project Spending'
	,''
	,'Capex Special Project Spending'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1152
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Capex Project Spend Adjustments'
	,''
	,'Capex Project Spend Adjustments'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1153
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Development Costs'
	,''
	,'Capex Development Costs'
	,''
	)

INSERT INTO @RAWDATA
VALUES (
	1154
	,'Reporting'
	,'PC: Key Trends'
	,'Cash Flows'
	,'Free Cash Flow (after debt)'
	,'Free Cash Flow (before debt)'
	,'Capex'
	,'Capex'
	,'Capitalized Expenditures'
	,'Goodwill'
	,''
	,'Goodwill Expenditures'
	,''
	)

-- ENTER DATA HERE - END
DECLARE @INTIALCOUNT1 INT = 1
DECLARE @LEVEL1COUNT INT;

-- SETUP LEVEL 1 
INSERT INTO @LEVEL1
SELECT DISTINCT LEVEL1
FROM @RAWDATA

-- ASSIGN DATA 
SELECT @LEVEL1COUNT = COUNT(*)
FROM @LEVEL1

--SELECT * FROM @LEVEL1 
WHILE (@LEVEL1COUNT >= @INTIALCOUNT1)
BEGIN
	DECLARE @NAME1 VARCHAR(100)
	DECLARE @INDUSTRY1 VARCHAR(100)
	DECLARE @INDEX INT

	SELECT @NAME1 = NAME
	FROM @LEVEL1
	WHERE ID = @INTIALCOUNT1

	SELECT @INDUSTRY1 = INDUSTRYNAME
		,@INDEX = idindex
	FROM @RAWDATA
	WHERE LEVEL1 = @NAME1

	DECLARE @LEVELID1 UNIQUEIDENTIFIER = NEWID()

	IF (@NAME1 <> '')
	BEGIN
		INSERT INTO @NODEDATAITEMASSOCIATION
		SELECT DISTINCT DENSE_RANK() OVER (
				ORDER BY DATAITEMNAME
				)
			,@LEVELID1
			,DATAITEMNAME
		FROM @RAWDATA
		WHERE LEVEL1 = @NAME1
			AND LEVEL2 = ''

		--SELECT @NAME1 
		INSERT INTO @FINALTABLE
		VALUES (
			@LEVELID1
			,@NAME1
			,@ISSYSTEMDEFINED
			,NULL
			,NULL
			,@KPITYPE
			,@ISNEWNODE
			,CASE 
				WHEN @INDUSTRY1 = ''
					THEN @EMPTYGUID
				ELSE (
						SELECT TOP 1 ID
						FROM RM_Industry
						WHERE InvIndustryName = @INDUSTRY1
						)
				END
			,@INDEX
			);
	END

	--BEGIN LEVEL2 
	DELETE
	FROM @LEVEL2

	INSERT INTO @LEVEL2
	SELECT DISTINCT DENSE_RANK() OVER (
			ORDER BY LEVEL2
			)
		,LEVEL2
	FROM @RAWDATA
	WHERE LEVEL1 = @NAME1;

	--SELECT * FROM @LEVEL2 
	DECLARE @INTIALCOUNT2 INT = 1
	DECLARE @LEVELCOUNT2 INT;

	SELECT @LEVELCOUNT2 = COUNT(*)
	FROM @LEVEL2

	WHILE (@LEVELCOUNT2 >= @INTIALCOUNT2)
	BEGIN
		DECLARE @NAME2 VARCHAR(100)
		DECLARE @INDUSTRY2 VARCHAR(100)
		DECLARE @Index2 INT

		SELECT @NAME2 = NAME
		FROM @LEVEL2
		WHERE ID = @INTIALCOUNT2

		SELECT @INDUSTRY2 = INDUSTRYNAME
			,@Index2 = idindex
		FROM @RAWDATA
		WHERE LEVEL2 = @NAME2
			AND LEVEL1 = @NAME1

		DECLARE @LEVELID2 UNIQUEIDENTIFIER = NEWID()

		IF (@NAME2 <> '')
		BEGIN
			INSERT INTO @NODEDATAITEMASSOCIATION
			SELECT DISTINCT DENSE_RANK() OVER (
					ORDER BY DATAITEMNAME
					)
				,@LEVELID2
				,DATAITEMNAME
			FROM @RAWDATA
			WHERE LEVEL2 = @NAME2
				AND LEVEL1 = @NAME1
				AND LEVEL3 = ''

			--SELECT @NAME2 
			INSERT INTO @FINALTABLE
			VALUES (
				@LEVELID2
				,@NAME2
				,@ISSYSTEMDEFINED
				,@LEVELID1
				,@NAME1
				,@KPITYPE
				,@ISNEWNODE
				,CASE 
					WHEN @INDUSTRY2 = ''
						THEN @EMPTYGUID
					ELSE (
							SELECT TOP 1 ID
							FROM RM_Industry
							WHERE InvIndustryName = @INDUSTRY2
							)
					END
				,@Index2
				);
		END

		--BEGIN LEVEL3 
		DELETE
		FROM @LEVEL3

		INSERT INTO @LEVEL3
		SELECT DISTINCT DENSE_RANK() OVER (
				ORDER BY LEVEL3
				)
			,LEVEL3
		FROM @RAWDATA
		WHERE LEVEL2 = @NAME2
			AND LEVEL1 = @NAME1;

		--SELECT * FROM @LEVEL3 
		DECLARE @INTIALCOUNT3 INT = 1
		DECLARE @LEVELCOUNT3 INT;

		SELECT @LEVELCOUNT3 = COUNT(*)
		FROM @LEVEL3

		--SELECT * FROM @LEVEL3 
		WHILE (@LEVELCOUNT3 >= @INTIALCOUNT3)
		BEGIN
			DECLARE @NAME3 VARCHAR(100)
			DECLARE @INDUSTRY3 VARCHAR(100)
			DECLARE @Index3 INT

			SELECT @NAME3 = NAME
			FROM @LEVEL3
			WHERE ID = @INTIALCOUNT3

			SELECT @INDUSTRY3 = INDUSTRYNAME
				,@Index3 = idindex
			FROM @RAWDATA
			WHERE LEVEL3 = @NAME3
				AND LEVEL2 = @NAME2
				AND LEVEL1 = @NAME1

			DECLARE @LEVELID3 UNIQUEIDENTIFIER = NEWID()

			IF (@NAME3 <> '')
			BEGIN
				INSERT INTO @NODEDATAITEMASSOCIATION
				SELECT DISTINCT DENSE_RANK() OVER (
						ORDER BY DATAITEMNAME
						)
					,@LEVELID3
					,DATAITEMNAME
				FROM @RAWDATA
				WHERE LEVEL3 = @NAME3
					AND LEVEL2 = @NAME2
					AND LEVEL1 = @NAME1
					AND LEVEL4 = ''

				--SELECT @NAME3 
				INSERT INTO @FINALTABLE
				VALUES (
					@LEVELID3
					,@NAME3
					,@ISSYSTEMDEFINED
					,@LEVELID2
					,@NAME2
					,@KPITYPE
					,@ISNEWNODE
					,CASE 
						WHEN @INDUSTRY3 = ''
							THEN @EMPTYGUID
						ELSE (
								SELECT TOP 1 ID
								FROM RM_Industry
								WHERE InvIndustryName = @INDUSTRY3
								)
						END
					,@Index3
					);
			END

			--BEGIN LEVEL4 
			DELETE
			FROM @LEVEL4

			INSERT INTO @LEVEL4
			SELECT DISTINCT DENSE_RANK() OVER (
					ORDER BY LEVEL4
					)
				,LEVEL4
			FROM @RAWDATA
			WHERE LEVEL3 = @NAME3
				AND LEVEL2 = @NAME2
				AND LEVEL1 = @NAME1;

			DECLARE @INTIALCOUNT4 INT = 1
			DECLARE @LEVELCOUNT4 INT;

			SELECT @LEVELCOUNT4 = COUNT(*)
			FROM @LEVEL4

			WHILE (@LEVELCOUNT4 >= @INTIALCOUNT4)
			BEGIN
				DECLARE @NAME4 VARCHAR(100)
				DECLARE @INDUSTRY4 VARCHAR(100)
				DECLARE @Index4 INT

				SELECT @NAME4 = NAME
				FROM @LEVEL4
				WHERE ID = @INTIALCOUNT4

				SELECT @INDUSTRY4 = INDUSTRYNAME
					,@Index4 = idindex
				FROM @RAWDATA
				WHERE LEVEL4 = @NAME4
					AND LEVEL3 = @NAME3
					AND LEVEL2 = @NAME2
					AND LEVEL1 = @NAME1

				DECLARE @LEVELID4 UNIQUEIDENTIFIER = NEWID()

				IF (@NAME4 <> '')
				BEGIN
					INSERT INTO @NODEDATAITEMASSOCIATION
					SELECT DISTINCT DENSE_RANK() OVER (
							ORDER BY DATAITEMNAME
							)
						,@LEVELID4
						,DATAITEMNAME
					FROM @RAWDATA
					WHERE LEVEL4 = @NAME4
						AND LEVEL3 = @NAME3
						AND LEVEL2 = @NAME2
						AND LEVEL1 = @NAME1
						AND LEVEL5 = ''

					--SELECT @NAME3 
					INSERT INTO @FINALTABLE
					VALUES (
						@LEVELID4
						,@NAME4
						,@ISSYSTEMDEFINED
						,@LEVELID3
						,@NAME3
						,@KPITYPE
						,@ISNEWNODE
						,CASE 
							WHEN @INDUSTRY4 = ''
								THEN @EMPTYGUID
							ELSE (
									SELECT TOP 1 ID
									FROM RM_Industry
									WHERE InvIndustryName = @INDUSTRY4
									)
							END
						,@Index4
						);
				END

				--BEGIN LEVEL5 
				DELETE
				FROM @LEVEL5

				INSERT INTO @LEVEL5
				SELECT DISTINCT DENSE_RANK() OVER (
						ORDER BY LEVEL5
						)
					,LEVEL5
				FROM @RAWDATA
				WHERE LEVEL4 = @NAME4
					AND LEVEL3 = @NAME3
					AND LEVEL2 = @NAME2
					AND LEVEL1 = @NAME1;

				DECLARE @INTIALCOUNT5 INT = 1
				DECLARE @LEVELCOUNT5 INT;

				SELECT @LEVELCOUNT5 = COUNT(*)
				FROM @LEVEL5

				WHILE (@LEVELCOUNT5 >= @INTIALCOUNT5)
				BEGIN
					DECLARE @NAME5 VARCHAR(100)
					DECLARE @INDUSTRY5 VARCHAR(100)
					DECLARE @Index5 INT

					SELECT @NAME5 = NAME
					FROM @LEVEL5
					WHERE ID = @INTIALCOUNT5

					SELECT @INDUSTRY5 = INDUSTRYNAME
						,@Index5 = idindex
					FROM @RAWDATA
					WHERE LEVEL5 = @NAME5
						AND LEVEL4 = @NAME4
						AND LEVEL3 = @NAME3
						AND LEVEL2 = @NAME2
						AND LEVEL1 = @NAME1

					DECLARE @LEVELID5 UNIQUEIDENTIFIER = NEWID()

					IF (@NAME5 <> '')
					BEGIN
						INSERT INTO @NODEDATAITEMASSOCIATION
						SELECT DISTINCT DENSE_RANK() OVER (
								ORDER BY DATAITEMNAME
								)
							,@LEVELID5
							,DATAITEMNAME
						FROM @RAWDATA
						WHERE LEVEL5 = @NAME5
							AND LEVEL4 = @NAME4
							AND LEVEL3 = @NAME3
							AND LEVEL2 = @NAME2
							AND LEVEL1 = @NAME1
							AND LEVEL6 = ''

						--SELECT @NAME3 
						INSERT INTO @FINALTABLE
						VALUES (
							@LEVELID5
							,@NAME5
							,@ISSYSTEMDEFINED
							,@LEVELID4
							,@NAME4
							,@KPITYPE
							,@ISNEWNODE
							,CASE 
								WHEN @INDUSTRY5 = ''
									THEN @EMPTYGUID
								ELSE (
										SELECT TOP 1 ID
										FROM RM_Industry
										WHERE InvIndustryName = @INDUSTRY5
										)
								END
							,@Index5
							);
					END

					--BEGIN LEVEL6 
					DELETE
					FROM @LEVEL6

					INSERT INTO @LEVEL6
					SELECT DISTINCT DENSE_RANK() OVER (
							ORDER BY LEVEL6
							)
						,LEVEL6
					FROM @RAWDATA
					WHERE LEVEL5 = @NAME5
						AND LEVEL4 = @NAME4
						AND LEVEL3 = @NAME3
						AND LEVEL2 = @NAME2
						AND LEVEL1 = @NAME1;

					DECLARE @INTIALCOUNT6 INT = 1
					DECLARE @LEVELCOUNT6 INT;

					SELECT @LEVELCOUNT6 = COUNT(*)
					FROM @LEVEL6

					WHILE (@LEVELCOUNT6 >= @INTIALCOUNT6)
					BEGIN
						DECLARE @NAME6 VARCHAR(100)
						DECLARE @INDUSTRY6 VARCHAR(100)
						DECLARE @Index6 INT

						SELECT @NAME6 = NAME
						FROM @LEVEL6
						WHERE ID = @INTIALCOUNT6

						--SELECT @NAME6
						SELECT @INDUSTRY6 = INDUSTRYNAME
							,@Index6 = idindex
						FROM @RAWDATA
						WHERE LEVEL6 = @NAME6
							AND LEVEL5 = @NAME5
							AND LEVEL4 = @NAME4
							AND LEVEL3 = @NAME3
							AND LEVEL2 = @NAME2
							AND LEVEL1 = @NAME1

						DECLARE @LEVELID6 UNIQUEIDENTIFIER = NEWID()

						IF (@NAME6 <> '')
						BEGIN
							INSERT INTO @NODEDATAITEMASSOCIATION
							SELECT DISTINCT DENSE_RANK() OVER (
									ORDER BY DATAITEMNAME
									)
								,@LEVELID6
								,DATAITEMNAME
							FROM @RAWDATA
							WHERE LEVEL6 = @NAME6
								AND LEVEL5 = @NAME5
								AND LEVEL4 = @NAME4
								AND LEVEL3 = @NAME3
								AND LEVEL2 = @NAME2
								AND LEVEL1 = @NAME1
								AND LEVEL7 = ''

							INSERT INTO @FINALTABLE
							VALUES (
								@LEVELID6
								,@NAME6
								,@ISSYSTEMDEFINED
								,@LEVELID5
								,@NAME5
								,@KPITYPE
								,@ISNEWNODE
								,CASE 
									WHEN @INDUSTRY6 = ''
										THEN @EMPTYGUID
									ELSE (
											SELECT TOP 1 ID
											FROM RM_Industry
											WHERE InvIndustryName = @INDUSTRY6
											)
									END
								,@Index6
								);
						END

						--BEGIN LEVEL7 
						DELETE
						FROM @LEVEL7

						INSERT INTO @LEVEL7
						SELECT DISTINCT DENSE_RANK() OVER (
								ORDER BY LEVEL7
								)
							,LEVEL7
						FROM @RAWDATA
						WHERE LEVEL6 = @NAME6
							AND LEVEL5 = @NAME5
							AND LEVEL4 = @NAME4
							AND LEVEL3 = @NAME3
							AND LEVEL2 = @NAME2
							AND LEVEL1 = @NAME1;

						DECLARE @INTIALCOUNT7 INT = 1
						DECLARE @LEVELCOUNT7 INT;

						SELECT @LEVELCOUNT7 = COUNT(*)
						FROM @LEVEL7

						WHILE (@LEVELCOUNT7 >= @INTIALCOUNT7)
						BEGIN
							DECLARE @NAME7 VARCHAR(100)
							DECLARE @INDUSTRY7 VARCHAR(100)
							DECLARE @Index7 INT

							SELECT @NAME7 = NAME
							FROM @LEVEL7
							WHERE ID = @INTIALCOUNT7

							SELECT @INDUSTRY7 = INDUSTRYNAME
								,@Index7 = idindex
							FROM @RAWDATA
							WHERE LEVEL7 = @NAME7
								AND LEVEL6 = @NAME6
								AND LEVEL5 = @NAME5
								AND LEVEL4 = @NAME4
								AND LEVEL3 = @NAME3
								AND LEVEL2 = @NAME2
								AND LEVEL1 = @NAME1

							DECLARE @LEVELID7 UNIQUEIDENTIFIER = NEWID()

							IF (@NAME7 <> '')
							BEGIN
								INSERT INTO @NODEDATAITEMASSOCIATION
								SELECT DISTINCT DENSE_RANK() OVER (
										ORDER BY DATAITEMNAME
										)
									,@LEVELID7
									,DATAITEMNAME
								FROM @RAWDATA
								WHERE LEVEL7 = @NAME7
									AND LEVEL6 = @NAME6
									AND LEVEL5 = @NAME5
									AND LEVEL4 = @NAME4
									AND LEVEL3 = @NAME3
									AND LEVEL2 = @NAME2
									AND LEVEL1 = @NAME1
									AND LEVEL8 = ''

								INSERT INTO @FINALTABLE
								VALUES (
									@LEVELID7
									,@NAME7
									,@ISSYSTEMDEFINED
									,@LEVELID6
									,@NAME6
									,@KPITYPE
									,@ISNEWNODE
									,CASE 
										WHEN @INDUSTRY7 = ''
											THEN @EMPTYGUID
										ELSE (
												SELECT TOP 1 ID
												FROM RM_Industry
												WHERE InvIndustryName = @INDUSTRY7
												)
										END
									,@Index7
									);
							END

							--BEGIN LEVEL8 
							DELETE
							FROM @LEVEL8

							INSERT INTO @LEVEL8
							SELECT DISTINCT DENSE_RANK() OVER (
									ORDER BY LEVEL8
									)
								,LEVEL8
							FROM @RAWDATA
							WHERE LEVEL7 = @NAME7
								AND LEVEL6 = @NAME6
								AND LEVEL5 = @NAME5
								AND LEVEL4 = @NAME4
								AND LEVEL3 = @NAME3
								AND LEVEL2 = @NAME2
								AND LEVEL1 = @NAME1;

							DECLARE @INTIALCOUNT8 INT = 1
							DECLARE @LEVELCOUNT8 INT;

							SELECT @LEVELCOUNT8 = COUNT(*)
							FROM @LEVEL8

							WHILE (@LEVELCOUNT8 >= @INTIALCOUNT8)
							BEGIN
								DECLARE @NAME8 VARCHAR(100)
								DECLARE @INDUSTRY8 VARCHAR(100)
								DECLARE @Index8 INT

								SELECT @NAME8 = NAME
								FROM @LEVEL8
								WHERE ID = @INTIALCOUNT8

								SELECT @INDUSTRY8 = INDUSTRYNAME
									,@Index8 = idindex
								FROM @RAWDATA
								WHERE LEVEL8 = @NAME8
									AND LEVEL7 = @NAME7
									AND LEVEL6 = @NAME6
									AND LEVEL5 = @NAME5
									AND LEVEL4 = @NAME4
									AND LEVEL3 = @NAME3
									AND LEVEL2 = @NAME2
									AND LEVEL1 = @NAME1

								DECLARE @LEVELID8 UNIQUEIDENTIFIER = NEWID()
								DECLARE @DATAITEM8 VARCHAR(MAX)

								IF (@NAME8 <> '')
								BEGIN
									INSERT INTO @NODEDATAITEMASSOCIATION
									SELECT DISTINCT DENSE_RANK() OVER (
											ORDER BY DATAITEMNAME
											)
										,@LEVELID8
										,DATAITEMNAME
									FROM @RAWDATA
									WHERE LEVEL8 = @NAME8
										AND LEVEL7 = @NAME7
										AND LEVEL6 = @NAME6
										AND LEVEL5 = @NAME5
										AND LEVEL4 = @NAME4
										AND LEVEL3 = @NAME3
										AND LEVEL2 = @NAME2
										AND LEVEL1 = @NAME1
										AND LEVEL9 = ''

									INSERT INTO @FINALTABLE
									VALUES (
										@LEVELID8
										,@NAME8
										,@ISSYSTEMDEFINED
										,@LEVELID7
										,@NAME7
										,@KPITYPE
										,@ISNEWNODE
										,CASE 
											WHEN @INDUSTRY8 = ''
												THEN @EMPTYGUID
											ELSE (
													SELECT TOP 1 ID
													FROM RM_Industry
													WHERE InvIndustryName = @INDUSTRY8
													)
											END
										,@Index8
										);
								END

								--BEGIN LEVEL9 
								DELETE
								FROM @LEVEL9

								INSERT INTO @LEVEL9
								SELECT DISTINCT DENSE_RANK() OVER (
										ORDER BY LEVEL9
										)
									,LEVEL9
								FROM @RAWDATA
								WHERE LEVEL8 = @NAME8
									AND LEVEL7 = @NAME7
									AND LEVEL6 = @NAME6
									AND LEVEL5 = @NAME5
									AND LEVEL4 = @NAME4
									AND LEVEL3 = @NAME3
									AND LEVEL2 = @NAME2
									AND LEVEL1 = @NAME1;

								DECLARE @INTIALCOUNT9 INT = 1
								DECLARE @LEVELCOUNT9 INT;

								SELECT @LEVELCOUNT9 = COUNT(*)
								FROM @LEVEL9

								WHILE (@LEVELCOUNT9 >= @INTIALCOUNT9)
								BEGIN
									DECLARE @NAME9 VARCHAR(100)
									DECLARE @INDUSTRY9 VARCHAR(100)
									DECLARE @Index9 INT

									SELECT @NAME9 = NAME
									FROM @LEVEL9
									WHERE ID = @INTIALCOUNT9

									SELECT @INDUSTRY9 = INDUSTRYNAME
										,@Index9 = idindex
									FROM @RAWDATA
									WHERE LEVEL9 = @NAME9
										AND LEVEL8 = @NAME8
										AND LEVEL7 = @NAME7
										AND LEVEL6 = @NAME6
										AND LEVEL5 = @NAME5
										AND LEVEL4 = @NAME4
										AND LEVEL3 = @NAME3
										AND LEVEL2 = @NAME2
										AND LEVEL1 = @NAME1

									DECLARE @LEVELID9 UNIQUEIDENTIFIER = NEWID()

									IF (@NAME9 <> '')
									BEGIN
										INSERT INTO @NODEDATAITEMASSOCIATION
										SELECT DISTINCT DENSE_RANK() OVER (
												ORDER BY DATAITEMNAME
												)
											,@LEVELID9
											,DATAITEMNAME
										FROM @RAWDATA
										WHERE LEVEL9 = @NAME9
											AND LEVEL8 = @NAME8
											AND LEVEL7 = @NAME7
											AND LEVEL6 = @NAME6
											AND LEVEL5 = @NAME5
											AND LEVEL4 = @NAME4
											AND LEVEL3 = @NAME3
											AND LEVEL2 = @NAME2
											AND LEVEL1 = @NAME1
											AND LEVEL10 = ''

										INSERT INTO @FINALTABLE
										VALUES (
											@LEVELID9
											,@NAME9
											,@ISSYSTEMDEFINED
											,@LEVELID8
											,@NAME8
											,@KPITYPE
											,@ISNEWNODE
											,CASE 
												WHEN @INDUSTRY9 = ''
													THEN @EMPTYGUID
												ELSE (
														SELECT TOP 1 ID
														FROM RM_Industry
														WHERE InvIndustryName = @INDUSTRY9
														)
												END
											,@Index9
											);

										--BEGIN LEVEL10 
										DELETE
										FROM @LEVEL10

										INSERT INTO @LEVEL10
										SELECT DISTINCT DENSE_RANK() OVER (
												ORDER BY LEVEL10
												)
											,LEVEL10
										FROM @RAWDATA
										WHERE LEVEL9 = @NAME9
											AND LEVEL8 = @NAME8
											AND LEVEL7 = @NAME7
											AND LEVEL6 = @NAME6
											AND LEVEL5 = @NAME5
											AND LEVEL4 = @NAME4
											AND LEVEL3 = @NAME3
											AND LEVEL2 = @NAME2
											AND LEVEL1 = @NAME1;

										DECLARE @INTIALCOUNT10 INT = 1
										DECLARE @LEVELCOUNT10 INT;

										SELECT @LEVELCOUNT10 = COUNT(*)
										FROM @LEVEL10

										WHILE (@LEVELCOUNT10 >= @INTIALCOUNT10)
										BEGIN
											DECLARE @NAME10 VARCHAR(100)
											DECLARE @INDUSTRY10 VARCHAR(100)
											DECLARE @Index10 INT

											SELECT @NAME10 = NAME
											FROM @LEVEL10
											WHERE ID = @INTIALCOUNT10

											SELECT @INDUSTRY10 = INDUSTRYNAME
												,@Index10 = idindex
											FROM @RAWDATA
											WHERE LEVEL10 = @NAME10
												AND LEVEL9 = @NAME9
												AND LEVEL8 = @NAME8
												AND LEVEL7 = @NAME7
												AND LEVEL6 = @NAME6
												AND LEVEL5 = @NAME5
												AND LEVEL4 = @NAME4
												AND LEVEL3 = @NAME3
												AND LEVEL2 = @NAME2
												AND LEVEL1 = @NAME1

											DECLARE @LEVELID10 UNIQUEIDENTIFIER = NEWID()

											IF (@NAME10 <> '')
												INSERT INTO @NODEDATAITEMASSOCIATION
												SELECT DISTINCT DENSE_RANK() OVER (
														ORDER BY DATAITEMNAME
														)
													,@LEVELID10
													,DATAITEMNAME
												FROM @RAWDATA
												WHERE LEVEL10 = @NAME10
													AND LEVEL9 = @NAME9
													AND LEVEL8 = @NAME8
													AND LEVEL7 = @NAME7
													AND LEVEL6 = @NAME6
													AND LEVEL5 = @NAME5
													AND LEVEL4 = @NAME4
													AND LEVEL3 = @NAME3
													AND LEVEL2 = @NAME2
													AND LEVEL1 = @NAME1

											BEGIN
												INSERT INTO @FINALTABLE
												VALUES (
													@LEVELID10
													,@NAME10
													,@ISSYSTEMDEFINED
													,@LEVELID9
													,@NAME9
													,@KPITYPE
													,@ISNEWNODE
													,CASE 
														WHEN @INDUSTRY10 = ''
															THEN @EMPTYGUID
														ELSE (
																SELECT TOP 1 ID
																FROM RM_Industry
																WHERE InvIndustryName = @INDUSTRY10
																)
														END
													,@Index10
													);
											END

											SET @INTIALCOUNT10 = @INTIALCOUNT10 + 1
										END
												--END LEVEL10 
									END

									--SELECT * FROM @FINALTABLE
									SET @INTIALCOUNT9 = @INTIALCOUNT9 + 1
								END

								--END LEVEL9 
								SET @INTIALCOUNT8 = @INTIALCOUNT8 + 1
							END

							--END LEVEL8 
							SET @INTIALCOUNT7 = @INTIALCOUNT7 + 1
						END

						--END LEVEL7 
						SET @INTIALCOUNT6 = @INTIALCOUNT6 + 1
					END

					--END LEVEL6 
					SET @INTIALCOUNT5 = @INTIALCOUNT5 + 1
				END

				--END LEVEL5 
				SET @INTIALCOUNT4 = @INTIALCOUNT4 + 1
			END

			--END LEVEL4 
			SET @INTIALCOUNT3 = @INTIALCOUNT3 + 1;
		END

		--END LEVEL3 
		SET @INTIALCOUNT2 = @INTIALCOUNT2 + 1;
	END

	--END LEVEL2 
	SET @INTIALCOUNT1 = @INTIALCOUNT1 + 1
		--SELECT @INTIALCOUNT1
END

INSERT INTO RM_NODE
SELECT ID
	,NODENAME
	,ISSYSTEMDEFINED
	,PARENTID
	,KPIITYPEID
	,ISNEWNODE
	,CASE 
		WHEN INDUSTRYID = @EMPTYGUID
			THEN NULL
		ELSE INDUSTRYID
		END
	,IDINDEX
FROM @FINALTABLE
WHERE NODENAME <> ''
	AND KPIITYPEID = @KPITYPE
	AND INDUSTRYID IS NOT NULL
ORDER BY IDINDEX

INSERT INTO RM_DefaultNodeDataItemAssociation
SELECT NEWID()
	,NODEID
	,(
		SELECT DISTINCT ID
		FROM RM_DATAITEM
		WHERE NAME = DATAITEMNAME
		)
	,@KPITYPE
FROM @NODEDATAITEMASSOCIATION N
INNER JOIN @FINALTABLE F ON F.ID = N.NODEID
	AND F.INDUSTRYID IS NOT NULL
WHERE DataItemName <> ''



SELECT COUNT(*)
FROM RM_Node WHERE KPITypeId = @KPITYPE