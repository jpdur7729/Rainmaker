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

INSERT INTO @RAWDATA VALUES('Cash Flows - Beginning Cash Balance','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Collections from Customers','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Interest Income','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Dividends Receipts','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Other Operating Cash Receipts','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Payments to Suppliers','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Payments to Employees','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Interest Payments','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Payment of Taxes','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Operating - Other Operating Cash Payments','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Collection on Loans','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Sale of Debt Instruments','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Sale of Equity Instruments','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Sale of Productive Assets','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Purchase of Productive Assets','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Purchase of Debt Instruments','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Investing - Purchase of Equity Instruments','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Financing - Issuance of Long-Term Debt','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Financing - Issuance of Equity Securities','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Financing - Payment of Dividends','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Financing - Acquisition of an Entity/''s Own Equity Securities','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Financing - Repayment of Amounts Borrowed','Debit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Cash Flows - Ending Cash Balance','Credit','Aggregate','7','Numeric','TRUE','FALSE','')

-- DEFAULT DATA
DECLARE @KPITYPE UNIQUEIDENTIFIER = '646A9649-0E42-4442-8AA0-FD1D8CCE117E';
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