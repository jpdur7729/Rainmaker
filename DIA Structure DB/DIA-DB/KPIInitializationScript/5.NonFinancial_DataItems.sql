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

INSERT INTO @RAWDATA VALUES('Debt Maturity Schedule (fiscal-year 1)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Debt Maturity Schedule (fiscal-year 2)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Debt Maturity Schedule (fiscal-year 3)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Debt Maturity Schedule (fiscal-year 4)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Debt Maturity Schedule (fiscal-year 5)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Book Value Debt','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Debt Recoursed to Fund','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Enterprise Value of M&A Transactions (net)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Free Cash Flow (after debt service) (TTM)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Free Cash Flow (before debt service) (TTM)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Interest Coverage Ratio (TTM)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Management Ownership %','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Number of Employees','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Number of Employees (exited only)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Number of M&A Transactions (net)','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Number of Board Seats','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Capex % of Sales','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('EBITDA Margin %','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Gross Margin %','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Operating Margin %','Credit','Aggregate','7','Numeric','TRUE','FALSE','')
INSERT INTO @RAWDATA VALUES('Availability Factor','Credit','Aggregate','7','Numeric','TRUE','FALSE','10 - Energy')
INSERT INTO @RAWDATA VALUES('Consumption by Sector','Credit','Aggregate','7','Numeric','TRUE','TRUE','10 - Energy')
INSERT INTO @RAWDATA VALUES('Energy Production Distribution','Credit','Aggregate','7','Numeric','TRUE','TRUE','10 - Energy')
INSERT INTO @RAWDATA VALUES('Performance Ratio','Credit','Aggregate','7','Numeric','TRUE','TRUE','10 - Energy')
INSERT INTO @RAWDATA VALUES('Power Custs and Average Duration','Credit','Aggregate','7','Numeric','TRUE','TRUE','10 - Energy')
INSERT INTO @RAWDATA VALUES('Production Costs','Credit','Aggregate','7','Numeric','TRUE','TRUE','10 - Energy')
INSERT INTO @RAWDATA VALUES('Carrying Cost of Inventory','Credit','Aggregate','7','Numeric','TRUE','TRUE','15 - Materials')
INSERT INTO @RAWDATA VALUES('Customer Order Rate','Credit','Aggregate','7','Numeric','TRUE','TRUE','15 - Materials')
INSERT INTO @RAWDATA VALUES('Cycle Time: Dock to Stovk','Credit','Aggregate','7','Numeric','TRUE','TRUE','15 - Materials')
INSERT INTO @RAWDATA VALUES('Demand Forecast (MAPE)','Credit','Aggregate','7','Numeric','TRUE','TRUE','15 - Materials')
INSERT INTO @RAWDATA VALUES('Inventory Shrinkage','Credit','Aggregate','7','Numeric','TRUE','TRUE','15 - Materials')
INSERT INTO @RAWDATA VALUES('Percentage of Packaging Outsourced','Credit','Aggregate','7','Numeric','TRUE','TRUE','15 - Materials')
INSERT INTO @RAWDATA VALUES('Cycle Time','Credit','Aggregate','7','Numeric','TRUE','TRUE','20 - Industrials')
INSERT INTO @RAWDATA VALUES('Downtime','Credit','Aggregate','7','Numeric','TRUE','TRUE','20 - Industrials')
INSERT INTO @RAWDATA VALUES('Reject/Scrap','Credit','Aggregate','7','Numeric','TRUE','TRUE','20 - Industrials')
INSERT INTO @RAWDATA VALUES('Safety','Credit','Aggregate','7','Numeric','TRUE','FALSE','20 - Industrials')
INSERT INTO @RAWDATA VALUES('Total Labor Costs','Credit','Aggregate','7','Numeric','TRUE','FALSE','20 - Industrials')
INSERT INTO @RAWDATA VALUES('Total Materials Cost','Credit','Aggregate','7','Percent','TRUE','FALSE','20 - Industrials')
INSERT INTO @RAWDATA VALUES('Attrition/Retention','Credit','Aggregate','7','Numeric','TRUE','FALSE','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES('Customer Lifetime Value','Credit','Aggregate','7','Numeric','TRUE','TRUE','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES('Idle Time','Credit','Aggregate','7','Numeric','TRUE','TRUE','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES('Revenue/Customer','Credit','Aggregate','7','Numeric','TRUE','FALSE','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES('Service Renewal Rates','Credit','Aggregate','7','Numeric','TRUE','FALSE','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES('Utilizations','Credit','Aggregate','7','Numeric','TRUE','FALSE','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES('Customer Engagement Score','Credit','Aggregate','7','Numeric','TRUE','TRUE','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES('Customer Testimonial Rating','Credit','Aggregate','7','Numeric','TRUE','TRUE','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES('Number of Customer Complaints','Credit','Aggregate','7','Numeric','TRUE','TRUE','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES('Ontime/Product delivery','Credit','Aggregate','7','Numeric','TRUE','TRUE','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES('Open Positions','Credit','Aggregate','7','Numeric','TRUE','TRUE','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES('Time to launch new products','Credit','Aggregate','7','Numeric','TRUE','FALSE','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES('Average Days Admitted','Credit','Aggregate','7','Numeric','TRUE','TRUE','35 - Healthcare')
INSERT INTO @RAWDATA VALUES('Emergency Costs','Credit','Aggregate','7','Numeric','TRUE','TRUE','35 - Healthcare')
INSERT INTO @RAWDATA VALUES('Patient Satisfaction Score','Credit','Aggregate','7','Numeric','TRUE','TRUE','35 - Healthcare')
INSERT INTO @RAWDATA VALUES('Readmission Rates','Credit','Aggregate','7','Numeric','TRUE','TRUE','35 - Healthcare')
INSERT INTO @RAWDATA VALUES('Total Patients Admitted','Credit','Aggregate','7','Numeric','TRUE','FALSE','35 - Healthcare')
INSERT INTO @RAWDATA VALUES('Wait Times','Credit','Aggregate','7','Numeric','TRUE','FALSE','35 - Healthcare')
INSERT INTO @RAWDATA VALUES('Audit Cycle Times','Credit','Aggregate','7','Numeric','TRUE','FALSE','40 - Financials')
INSERT INTO @RAWDATA VALUES('Burn Rates','Credit','Aggregate','7','Numeric','TRUE','TRUE','40 - Financials')
INSERT INTO @RAWDATA VALUES('Error Reporting and Reconciliations','Credit','Aggregate','7','Numeric','TRUE','TRUE','40 - Financials')
INSERT INTO @RAWDATA VALUES('Net Profit Margin','Credit','Aggregate','7','Numeric','TRUE','TRUE','40 - Financials')
INSERT INTO @RAWDATA VALUES('Resource Utilization','Credit','Aggregate','7','Numeric','TRUE','FALSE','40 - Financials')
INSERT INTO @RAWDATA VALUES('Working Captial','Credit','Aggregate','7','Percent','TRUE','FALSE','40 - Financials')
INSERT INTO @RAWDATA VALUES('# of Support Tickets','Credit','Aggregate','7','Numeric','TRUE','FALSE','45 - Information Technology')
INSERT INTO @RAWDATA VALUES('Cash Runway','Credit','Aggregate','7','Numeric','TRUE','TRUE','45 - Information Technology')
INSERT INTO @RAWDATA VALUES('Close sale ratio','Credit','Aggregate','7','Numeric','TRUE','TRUE','45 - Information Technology')
INSERT INTO @RAWDATA VALUES('Mean time to recover','Credit','Aggregate','7','Numeric','TRUE','TRUE','45 - Information Technology')
INSERT INTO @RAWDATA VALUES('On Time Delivery Rates','Credit','Aggregate','7','Numeric','TRUE','TRUE','45 - Information Technology')
INSERT INTO @RAWDATA VALUES('Pipeline to close ratio','Credit','Aggregate','7','Numeric','TRUE','TRUE','45 - Information Technology')
INSERT INTO @RAWDATA VALUES('Customer Churn rate','Credit','Aggregate','7','Numeric','TRUE','TRUE','50 - Communication Services')
INSERT INTO @RAWDATA VALUES('Customers by region','Credit','Aggregate','7','Numeric','TRUE','TRUE','50 - Communication Services')
INSERT INTO @RAWDATA VALUES('Network operating costs','Credit','Aggregate','7','Numeric','TRUE','TRUE','50 - Communication Services')
INSERT INTO @RAWDATA VALUES('Revenue growth by plan','Credit','Aggregate','7','Numeric','TRUE','FALSE','50 - Communication Services')
INSERT INTO @RAWDATA VALUES('Subscriber Aqc costs','Credit','Aggregate','7','Percent','TRUE','FALSE','50 - Communication Services')
INSERT INTO @RAWDATA VALUES('Subscriber campaigns','Credit','Aggregate','7','Numeric','TRUE','FALSE','50 - Communication Services')
INSERT INTO @RAWDATA VALUES('Energy loss percentage','Credit','Aggregate','7','Numeric','TRUE','TRUE','55 - Utilities')
INSERT INTO @RAWDATA VALUES('OSHA Incident ratings','Credit','Aggregate','7','Numeric','TRUE','TRUE','55 - Utilities')
INSERT INTO @RAWDATA VALUES('Power supply expense per kWh','Credit','Aggregate','7','Numeric','TRUE','TRUE','55 - Utilities')
INSERT INTO @RAWDATA VALUES('Reliability','Credit','Aggregate','7','Numeric','TRUE','TRUE','55 - Utilities')
INSERT INTO @RAWDATA VALUES('Retail customer per reader','Credit','Aggregate','7','Percent','TRUE','FALSE','55 - Utilities')
INSERT INTO @RAWDATA VALUES('System load factor','Credit','Aggregate','7','Numeric','TRUE','FALSE','55 - Utilities')
INSERT INTO @RAWDATA VALUES('Average commision per sale','Credit','Aggregate','7','Numeric','TRUE','TRUE','60 - Real Estate')
INSERT INTO @RAWDATA VALUES('Properties advertised','Credit','Aggregate','7','Numeric','TRUE','TRUE','60 - Real Estate')
INSERT INTO @RAWDATA VALUES('Revenue per available room','Credit','Aggregate','7','Numeric','TRUE','FALSE','60 - Real Estate')
INSERT INTO @RAWDATA VALUES('Revenue per square foot','Credit','Aggregate','7','Numeric','TRUE','FALSE','60 - Real Estate')
INSERT INTO @RAWDATA VALUES('Total Construction Costs','Credit','Aggregate','7','Percent','TRUE','FALSE','60 - Real Estate')
INSERT INTO @RAWDATA VALUES('Variance to asking cost','Credit','Aggregate','7','Numeric','TRUE','FALSE','60 - Real Estate')


-- DEFAULT DATA
DECLARE @KPITYPE UNIQUEIDENTIFIER = '268A3F58-5A12-42D7-BCF2-620FDDA6B532';
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