DECLARE @RAWDATA TABLE (
	idindex int,
	LEVEL1 VARCHAR(MAX)
	,LEVEL2 VARCHAR(MAX)
	,LEVEL3 VARCHAR(MAX)
	,LEVEL4 VARCHAR(MAX)
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
DECLARE @FINALTABLE TABLE (
	NID INT IDENTITY(1, 1)
	,ID UNIQUEIDENTIFIER
	,NODENAME VARCHAR(1000)
	,ISSYSTEMDEFINED INT
	,PARENTID UNIQUEIDENTIFIER
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
DECLARE @KPITYPE UNIQUEIDENTIFIER = '268A3F58-5A12-42D7-BCF2-620FDDA6B532'
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @ISNEWNODE BIT = 0;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @ISACTIVE BIT = 1;
DECLARE @EMPTYGUID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';

--INSERT SCRIPT - BEGIN
INSERT INTO @RAWDATA VALUES(1,'Debt Maturity Schedule (fiscal-year 1)','','','','Debt Maturity Schedule (fiscal-year 1)','')
INSERT INTO @RAWDATA VALUES(2,'Debt Maturity Schedule (fiscal-year 2)','','','','Debt Maturity Schedule (fiscal-year 2)','')
INSERT INTO @RAWDATA VALUES(3,'Debt Maturity Schedule (fiscal-year 3)','','','','Debt Maturity Schedule (fiscal-year 3)','')
INSERT INTO @RAWDATA VALUES(4,'Debt Maturity Schedule (fiscal-year 4)','','','','Debt Maturity Schedule (fiscal-year 4)','')
INSERT INTO @RAWDATA VALUES(5,'Debt Maturity Schedule (fiscal-year 5)','','','','Debt Maturity Schedule (fiscal-year 5)','')
INSERT INTO @RAWDATA VALUES(6,'Book Value Debt','','','','Book Value Debt','')
INSERT INTO @RAWDATA VALUES(7,'Debt Recoursed to Fund','','','','Debt Recoursed to Fund','')
INSERT INTO @RAWDATA VALUES(8,'Enterprise Value of M&A Transactions (net)','','','','Enterprise Value of M&A Transactions (net)','')
INSERT INTO @RAWDATA VALUES(9,'Free Cash Flow (after debt service) (TTM)','','','','Free Cash Flow (after debt service) (TTM)','')
INSERT INTO @RAWDATA VALUES(10,'Free Cash Flow (before debt service) (TTM)','','','','Free Cash Flow (before debt service) (TTM)','')
INSERT INTO @RAWDATA VALUES(11,'Interest Coverage Ratio (TTM)','','','','Interest Coverage Ratio (TTM)','')
INSERT INTO @RAWDATA VALUES(12,'Management Ownership %','','','','Management Ownership %','')
INSERT INTO @RAWDATA VALUES(13,'Number of Employees','','','','Number of Employees','')
INSERT INTO @RAWDATA VALUES(14,'Number of Employees (exited only)','','','','Number of Employees (exited only)','')
INSERT INTO @RAWDATA VALUES(15,'Number of M&A Transactions (net)','','','','Number of M&A Transactions (net)','')
INSERT INTO @RAWDATA VALUES(16,'Number of Board Seats','','','','Number of Board Seats','')
INSERT INTO @RAWDATA VALUES(17,'Capex % of Sales','','','','Capex % of Sales','')
INSERT INTO @RAWDATA VALUES(18,'EBITDA Margin %','','','','EBITDA Margin %','')
INSERT INTO @RAWDATA VALUES(19,'Gross Margin %','','','','Gross Margin %','')
INSERT INTO @RAWDATA VALUES(20,'Operating Margin %','','','','Operating Margin %','')
INSERT INTO @RAWDATA VALUES(21,'Availability Factor','','','','Availability Factor','10 - Energy')
INSERT INTO @RAWDATA VALUES(22,'Consumption by Sector','','','','Consumption by Sector','10 - Energy')
INSERT INTO @RAWDATA VALUES(23,'Energy Production Distribution','','','','Energy Production Distribution','10 - Energy')
INSERT INTO @RAWDATA VALUES(24,'Performance Ratio','','','','Performance Ratio','10 - Energy')
INSERT INTO @RAWDATA VALUES(25,'Power Custs and Average Duration','','','','Power Custs and Average Duration','10 - Energy')
INSERT INTO @RAWDATA VALUES(26,'Production Costs','','','','Production Costs','10 - Energy')
INSERT INTO @RAWDATA VALUES(27,'Carrying Cost of Inventory','','','','Carrying Cost of Inventory','15 - Materials')
INSERT INTO @RAWDATA VALUES(28,'Customer Order Rate','','','','Customer Order Rate','15 - Materials')
INSERT INTO @RAWDATA VALUES(29,'Cycle Time: Dock to Stovk','','','','Cycle Time: Dock to Stovk','15 - Materials')
INSERT INTO @RAWDATA VALUES(30,'Demand Forecast (MAPE)','','','','Demand Forecast (MAPE)','15 - Materials')
INSERT INTO @RAWDATA VALUES(31,'Inventory Shrinkage','','','','Inventory Shrinkage','15 - Materials')
INSERT INTO @RAWDATA VALUES(32,'Percentage of Packaging Outsourced','','','','Percentage of Packaging Outsourced','15 - Materials')
INSERT INTO @RAWDATA VALUES(33,'Cycle Time','','','','Cycle Time','20 - Industrials')
INSERT INTO @RAWDATA VALUES(34,'Downtime','','','','Downtime','20 - Industrials')
INSERT INTO @RAWDATA VALUES(35,'Reject/Scrap','','','','Reject/Scrap','20 - Industrials')
INSERT INTO @RAWDATA VALUES(36,'Safety','','','','Safety','20 - Industrials')
INSERT INTO @RAWDATA VALUES(37,'Total Labor Costs','','','','Total Labor Costs','20 - Industrials')
INSERT INTO @RAWDATA VALUES(38,'Total Materials Cost','','','','Total Materials Cost','20 - Industrials')
INSERT INTO @RAWDATA VALUES(39,'Attrition/Retention','','','','Attrition/Retention','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(40,'Customer Lifetime Value','','','','Customer Lifetime Value','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(41,'Idle Time','','','','Idle Time','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(42,'Revenue/Customer','','','','Revenue/Customer','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(43,'Service Renewal Rates','','','','Service Renewal Rates','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(44,'Utilizations','','','','Utilizations','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(45,'Customer Engagement Score','','','','Customer Engagement Score','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(46,'Customer Testimonial Rating','','','','Customer Testimonial Rating','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(47,'Number of Customer Complaints','','','','Number of Customer Complaints','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(48,'Ontime/Product delivery','','','','Ontime/Product delivery','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(49,'Open Positions','','','','Open Positions','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(50,'Time to launch new products','','','','Time to launch new products','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(51,'Average Days Admitted','','','','Average Days Admitted','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(52,'Emergency Costs','','','','Emergency Costs','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(53,'Patient Satisfaction Score','','','','Patient Satisfaction Score','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(54,'Readmission Rates','','','','Readmission Rates','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(55,'Total Patients Admitted','','','','Total Patients Admitted','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(56,'Wait Times','','','','Wait Times','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(57,'Audit Cycle Times','','','','Audit Cycle Times','40 - Financials')
INSERT INTO @RAWDATA VALUES(58,'Burn Rates','','','','Burn Rates','40 - Financials')
INSERT INTO @RAWDATA VALUES(59,'Error Reporting and Reconciliations','','','','Error Reporting and Reconciliations','40 - Financials')
INSERT INTO @RAWDATA VALUES(60,'Net Profit Margin','','','','Net Profit Margin','40 - Financials')
INSERT INTO @RAWDATA VALUES(61,'Resource Utilization','','','','Resource Utilization','40 - Financials')
INSERT INTO @RAWDATA VALUES(62,'Working Captial','','','','Working Captial','40 - Financials')
INSERT INTO @RAWDATA VALUES(63,'# of Support Tickets','','','','# of Support Tickets','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(64,'Cash Runway','','','','Cash Runway','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(65,'Close sale ratio','','','','Close sale ratio','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(66,'Mean time to recover','','','','Mean time to recover','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(67,'On Time Delivery Rates','','','','On Time Delivery Rates','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(68,'Pipeline to close ratio','','','','Pipeline to close ratio','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(69,'Customer Churn rate','','','','Customer Churn rate','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(70,'Customers by region','','','','Customers by region','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(71,'Network operating costs','','','','Network operating costs','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(72,'Revenue growth by plan','','','','Revenue growth by plan','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(73,'Subscriber Aqc costs','','','','Subscriber Aqc costs','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(74,'Subscriber campaigns','','','','Subscriber campaigns','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(75,'Energy loss percentage','','','','Energy loss percentage','55 - Utilities')
INSERT INTO @RAWDATA VALUES(76,'OSHA Incident ratings','','','','OSHA Incident ratings','55 - Utilities')
INSERT INTO @RAWDATA VALUES(77,'Power supply expense per kWh','','','','Power supply expense per kWh','55 - Utilities')
INSERT INTO @RAWDATA VALUES(78,'Reliability','','','','Reliability','55 - Utilities')
INSERT INTO @RAWDATA VALUES(79,'Retail customer per reader','','','','Retail customer per reader','55 - Utilities')
INSERT INTO @RAWDATA VALUES(80,'System load factor','','','','System load factor','55 - Utilities')
INSERT INTO @RAWDATA VALUES(81,'Average commision per sale','','','','Average commision per sale','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(82,'Properties advertised','','','','Properties advertised','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(83,'Revenue per available room','','','','Revenue per available room','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(84,'Revenue per square foot','','','','Revenue per square foot','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(85,'Total Construction Costs','','','','Total Construction Costs','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(86,'Variance to asking cost','','','','Variance to asking cost','60 - Real Estate')
--INSERT SCRIPT - END

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

	SELECT @INDUSTRY1 = INDUSTRYNAME, @INDEX = idindex
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
		VALUES (@LEVELID1
			,@NAME1
			,@ISSYSTEMDEFINED
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

		SELECT @INDUSTRY2 = INDUSTRYNAME, @Index2 = idindex
		FROM @RAWDATA
		WHERE LEVEL2 = @NAME2

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
				AND LEVEL3 = ''

			--SELECT @NAME2
			INSERT INTO @FINALTABLE
			VALUES (
				@LEVELID2
				,@NAME2
				,@ISSYSTEMDEFINED
				,@LEVELID1
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
		WHERE LEVEL2 = @NAME2;

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

			SELECT @INDUSTRY3 = INDUSTRYNAME , @Index3 = idindex
			FROM @RAWDATA
			WHERE LEVEL3 = @NAME3

			DECLARE @LEVELID3 UNIQUEIDENTIFIER = NEWID()

			IF (@NAME3 <> '')
			BEGIN
				INSERT INTO @NODEDATAITEMASSOCIATION
				SELECT DISTINCT DENSE_RANK() OVER (
						ORDER BY DATAITEMNAME
						)
					,@LEVELID3
					--,CASE WHEN LEVEL4 <> '' THEN '' ELSE DATAITEMNAME END
					,DATAITEMNAME
				FROM @RAWDATA
				WHERE LEVEL3 = @NAME3
					AND LEVEL4 = ''

				--SELECT @NAME3
				INSERT INTO @FINALTABLE
				VALUES (
					@LEVELID3
					,@NAME3
					,@ISSYSTEMDEFINED
					,@LEVELID2
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
			WHERE LEVEL3 = @NAME3;

			DECLARE @INTIALCOUNT4 INT = 1
			DECLARE @LEVELCOUNT4 INT;

			SELECT @LEVELCOUNT4 = COUNT(*)
			FROM @LEVEL4

			WHILE (@LEVELCOUNT4 >= @INTIALCOUNT4)
			BEGIN
				PRINT '4' + @INTIALCOUNT4

				DECLARE @NAME4 VARCHAR(100)
				DECLARE @INDUSTRY4 VARCHAR(100)
				DECLARE @Index4 INT

				SELECT @NAME4 = NAME
				FROM @LEVEL4
				WHERE ID = @INTIALCOUNT4

				SELECT @INDUSTRY4 = INDUSTRYNAME,  @Index4 = idindex
				FROM @RAWDATA
				WHERE LEVEL4 = @NAME4

				DECLARE @LEVELID4 UNIQUEIDENTIFIER = NEWID()
				DECLARE @DATAITEM4 VARCHAR(MAX)

				IF (@NAME4 <> '')
					INSERT INTO @NODEDATAITEMASSOCIATION
					SELECT DISTINCT DENSE_RANK() OVER (
							ORDER BY DATAITEMNAME
							)
						,@LEVELID4
						--,CASE WHEN LEVEL4 <> '' THEN '' ELSE DATAITEMNAME END
						,DATAITEMNAME
					FROM @RAWDATA
					WHERE LEVEL4 = @NAME4

				--AND LEVEL4 = ''
				BEGIN
					INSERT INTO @FINALTABLE
					VALUES (
						@LEVELID4
						,@NAME4
						,@ISSYSTEMDEFINED
						,@LEVELID3
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
						, @Index4
						);
				END

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
END


INSERT INTO RM_NODE
SELECT ID
	,NODENAME
	,ISSYSTEMDEFINED
	,PARENTID
	,KPIITYPEID
	,ISNEWNODE
	,CASE WHEN INDUSTRYID = @EMPTYGUID THEN NULL ELSE INDUSTRYID END
	,IDINDEX
FROM @FINALTABLE
WHERE NODENAME <> ''
	AND KPIITYPEID = @KPITYPE
	AND INDUSTRYID IS NOT NULL
	AND NOT EXISTS (SELECT NAME FROM RM_Node WHERE Name = NODENAME AND KPITypeId = @KPITYPE) 
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
INNER JOIN @FINALTABLE F ON F.ID = N.NODEID AND F.INDUSTRYID IS NOT NULL
WHERE DataItemName <> ''



SELECT COUNT(*)
FROM RM_Node WHERE KPITypeId = @KPITYPE