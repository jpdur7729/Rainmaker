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

INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Energy - MSCI World Energy Index - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Materials - MSCI USA Materials - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Industrials - MSCI USA Industrials - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Healthcare - MSCI World Healthcare - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Financials - MSCI World Financials - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Information Technology - MSCI USA Info Tech - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Communication Services - MSCI USA Communication Services - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Utilities - MSCI USA Utilities - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Fundamentals - Dividend Yield','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Fundamentals - P/BV','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Fundamentals - P/E','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Fundamentals - P/E Forward','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (1 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (1 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (3 Month)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (3 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (5 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (10 Year)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('GICS - Real Estate - MSCI World Real Estate - Gross Returns (YTD)','Credit','Aggregate','7','Numeric','TRUE','TRUE','')
INSERT INTO @RAWDATA VALUES('Adjustment to EBIT','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Adjustment to EBITDA','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Adjustment to EBT','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Gross Interest Expense','Credit','Aggregate','7','Numeric','TRUE','FALSE','')

-- DEFAULT DATA
DECLARE @KPITYPE UNIQUEIDENTIFIER = '5FF41E39-363F-4FB5-A51E-F423DBC15469';
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @DESCRIPTION NVARCHAR(3000) = 'CREATED FROM SCRIPT';


DECLARE @DATATITEMTABLE TABLE(ID UNIQUEIDENTIFIER, INDUSTRYID UNIQUEIDENTIFIER, 
KPITYPEID UNIQUEIDENTIFIER, ISDEBIT BIT, ISAGGREGATE BIT, SACALE INT, VALUETYPEID UNIQUEIDENTIFIER, CREATEDBY NVARCHAR(1000),
CREATEDON DATETIME, DESCRIPTION NVARCHAR(3000), NAME NVARCHAR(3000), ISYSTEMDEFINED BIT, ISACTIVE BIT)


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