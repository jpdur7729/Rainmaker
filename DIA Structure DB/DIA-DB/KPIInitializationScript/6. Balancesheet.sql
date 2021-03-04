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
DECLARE @KPITYPE UNIQUEIDENTIFIER = '0F39AA09-EFE5-4524-B1DA-7169E2E11E6D'
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @ISNEWNODE BIT = 0;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @ISACTIVE BIT = 1;
DECLARE @EMPTYGUID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';

--INSERT SCRIPT - BEGIN
INSERT INTO @RAWDATA VALUES(1,'Total Assets','Current Assets','Cash Assets','Bank and Cash on Hand','Bank & Cash in hand','')
INSERT INTO @RAWDATA VALUES(2,'Total Assets','Current Assets','Short Term Investments','','Short Term Stock Investments','')
INSERT INTO @RAWDATA VALUES(3,'Total Assets','Current Assets','Accounts Receivable','Sales Revenue Receivable','Sales Revenue Receivable','')
INSERT INTO @RAWDATA VALUES(4,'Total Assets','Current Assets','Accounts Receivable','Interests Receivable','Accrued Interest Income','')
INSERT INTO @RAWDATA VALUES(5,'Total Assets','Current Assets','Accounts Receivable','Interests Receivable','Cash Interest Receivable','')
INSERT INTO @RAWDATA VALUES(6,'Total Assets','Current Assets','Accounts Receivable','Interests Receivable','Dividend Receivable','')
INSERT INTO @RAWDATA VALUES(7,'Total Assets','Current Assets','Accounts Receivable','Interests Receivable','Trade Receivables','')
INSERT INTO @RAWDATA VALUES(8,'Total Assets','Current Assets','Accounts Receivable','Debtors Receivable','Intergroup Debtors Receivables','')
INSERT INTO @RAWDATA VALUES(9,'Total Assets','Current Assets','Accounts Receivable','Debtors Receivable','Receivable - Other Debtors','')
INSERT INTO @RAWDATA VALUES(10,'Total Assets','Current Assets','Accounts Receivable','Debtors Receivable','Trade Debtors Receivable','')
INSERT INTO @RAWDATA VALUES(11,'Total Assets','Current Assets','Accounts Receivable','Trading Working Capital','Trading Working Capital','')
INSERT INTO @RAWDATA VALUES(12,'Total Assets','Current Assets','Accounts Receivable','Intercompany Receivables','Intercompany Receivables','')
INSERT INTO @RAWDATA VALUES(13,'Total Assets','Current Assets','Accounts Receivable','Other Accounts Receivable','Other Accounts Receivable','')
INSERT INTO @RAWDATA VALUES(14,'Total Assets','Current Assets','Current Inventory','','Current Inventory','')
INSERT INTO @RAWDATA VALUES(15,'Total Assets','Current Assets','Current Asset Accruals','Accrued Revenue','Accrued Income','')
INSERT INTO @RAWDATA VALUES(16,'Total Assets','Current Assets','Current Asset Accruals','Prepaid Expenses','Prepayments of Expenses','')
INSERT INTO @RAWDATA VALUES(17,'Total Assets','Non-Current Assets','Long Term Investments at Cost','Long Term Investment Purchases','Long Term Investment Purchases Cash','')
INSERT INTO @RAWDATA VALUES(18,'Total Assets','Non-Current Assets','Long Term Investments at Cost','Long Term Investment Purchases','Long Term Investment Purchases Cost Adjustments','')
INSERT INTO @RAWDATA VALUES(19,'Total Assets','Non-Current Assets','Long Term Investments at Cost','Long Term Investment Accretions','Long Term Investment Accretion','')
INSERT INTO @RAWDATA VALUES(20,'Total Assets','Non-Current Assets','Long Term Investments FMV','Long Term Investment Adjustments','Long Term Investment Change in FMV','')
INSERT INTO @RAWDATA VALUES(21,'Total Assets','Non-Current Assets','Long Term Assets','Long Term Asset Adjustments','Long Term Assets','')
INSERT INTO @RAWDATA VALUES(22,'Total Assets','Other Assets','Deferred Other Assets','','Deferred Other Assets','')
INSERT INTO @RAWDATA VALUES(23,'Total Assets','Other Assets','Deferred Other Assets','Deferred Taxes','Deferred Taxes','')
INSERT INTO @RAWDATA VALUES(24,'Total Assets','Other Assets','Intangible Assets','Intangible Asset Adjustments','Intangible Asset Adjustments','')
INSERT INTO @RAWDATA VALUES(25,'Total Assets','Other Assets','Intangible Assets','Intangible Asset Adjustments','Intangible Assets - Software Development','')
INSERT INTO @RAWDATA VALUES(26,'Total Assets','Other Assets','Fixed Assets','Fixed Assets Adjustments','Fixed Assets - Adjustments','')
INSERT INTO @RAWDATA VALUES(27,'Total Assets','Other Assets','Fixed Assets','Fixed Assets Adjustments','Fixed Assets - Computer Equipment','')
INSERT INTO @RAWDATA VALUES(28,'Total Assets','Other Assets','Fixed Assets','Fixed Assets Adjustments','Fixed Assets - Fixtures and Fittings','')
INSERT INTO @RAWDATA VALUES(29,'Total Assets','Other Assets','Fixed Assets','Fixed Assets Adjustments','Fixed Assets - Office Equipment','')
INSERT INTO @RAWDATA VALUES(30,'Total Assets','Other Assets','Fixed Assets','Fixed Assets Adjustments','Fixed Assets - Plant and Equipment','')
INSERT INTO @RAWDATA VALUES(31,'Total Assets','Other Assets','Fixed Assets','Hardware Fixed Asset Closing Adjust','Hardware Depreciations','')
INSERT INTO @RAWDATA VALUES(32,'Total Assets','Other Assets','Tangible Assets','Tangible Asset Adjustments','Tangible Asset Adjustments','')
INSERT INTO @RAWDATA VALUES(33,'Total Assets','Other Assets','Lease Assets','Lease Asset Adjustments','Lease Assets','')
INSERT INTO @RAWDATA VALUES(34,'Total Assets','Other Assets','Capitalized Expenditures','Other Capex Expenditures','Other Capex Spending','')
INSERT INTO @RAWDATA VALUES(35,'Total Assets','Other Assets','Capitalized Expenditures','Infrastructure Capex Spend','Infrastructure Capex Spend','')
INSERT INTO @RAWDATA VALUES(36,'Total Assets','Other Assets','Capitalized Expenditures','Capex Special Project Spending','Capex Special Project Spending','')
INSERT INTO @RAWDATA VALUES(37,'Total Assets','Other Assets','Capitalized Expenditures','Capex Project Spend Adjustments','Capex Project Spend Adjustments','')
INSERT INTO @RAWDATA VALUES(38,'Total Assets','Other Assets','Capitalized Expenditures','Development Costs','Capex Development Costs','')
INSERT INTO @RAWDATA VALUES(39,'Total Assets','Other Assets','Capitalized Expenditures','Goodwill','Goodwill Expenditures','')
INSERT INTO @RAWDATA VALUES(40,'Total Liabilities','Current Liabilities','Current Accounts Payable','Interest Expenses Payable','Interest Accrual','')
INSERT INTO @RAWDATA VALUES(41,'Total Liabilities','Current Liabilities','Current Accounts Payable','Other Expenses Payable','Expense Payable - Corporation Tax','')
INSERT INTO @RAWDATA VALUES(42,'Total Liabilities','Current Liabilities','Current Accounts Payable','Other Expenses Payable','Expense Payable - Credit Card','')
INSERT INTO @RAWDATA VALUES(43,'Total Liabilities','Current Liabilities','Current Accounts Payable','Other Expenses Payable','VAT Expenses Payable','')
INSERT INTO @RAWDATA VALUES(44,'Total Liabilities','Current Liabilities','Current Accounts Payable','Notes Payable','Notes Payable','')
INSERT INTO @RAWDATA VALUES(45,'Total Liabilities','Current Liabilities','Current Liability Accruals','Current Accrued Expenses','Current Expense Accruals','')
INSERT INTO @RAWDATA VALUES(46,'Total Liabilities','Long Term Liabilities','Long Term Credit Facility Notes','LT Credit Facility Note Borrowings','LT Credit Facility Borrowings','')
INSERT INTO @RAWDATA VALUES(47,'Total Liabilities','Long Term Liabilities','Long Term Credit Facility Notes','LT Credit Facility Note Borrowings','PIK Borrowings','')
INSERT INTO @RAWDATA VALUES(48,'Total Liabilities','Long Term Liabilities','Long Term Credit Facility Notes','LT Credit Facility Note Repayments','LT Credit Facility Repayments','')
INSERT INTO @RAWDATA VALUES(49,'Total Liabilities','Long Term Liabilities','Long Term Credit Facility Notes','LT Credit Facility Note Repayments','PIK Repayments','')
INSERT INTO @RAWDATA VALUES(50,'Total Liabilities','Long Term Liabilities','Other Long Term Obligations','Other LT Obligations','Other Long Term Liabilites','')
INSERT INTO @RAWDATA VALUES(51,'Total Equity','Owners Equity','Common Equity','Common Stock','Share Capital - ordinary shares','')
INSERT INTO @RAWDATA VALUES(52,'Total Equity','Owners Equity','Common Equity','Common Stock','Share premium','')
INSERT INTO @RAWDATA VALUES(53,'Total Equity','Owners Equity','Common Equity','Paid in Capital Common Stock','Paid in Capital Common Stock','')
INSERT INTO @RAWDATA VALUES(54,'Total Equity','Owners Equity','Preferred Equity','Preferred Stock','Preference share dividend','')
INSERT INTO @RAWDATA VALUES(55,'Total Equity','Owners Equity','Preferred Equity','Preferred Stock','Share Capital - preference shares','')
INSERT INTO @RAWDATA VALUES(56,'Total Equity','Owners Equity','Preferred Equity','Paid in Capital Preferred Stock','Paid in Capital Preferred Stock','')
INSERT INTO @RAWDATA VALUES(57,'Total Equity','Owners Equity','Reserves','Capital Contribution Reserves','Capital Contribution Reserve','')
INSERT INTO @RAWDATA VALUES(58,'Total Equity','Owners Equity','Reserves','Other Reserves','Other Capital reserves','')
INSERT INTO @RAWDATA VALUES(59,'Total Equity','Owners Equity','Other Equity','Other Comprehensive Income','Other comprehensive income','')
INSERT INTO @RAWDATA VALUES(60,'Total Equity','Owners Equity','Other Equity','Translation Difference','Translation Difference','')
INSERT INTO @RAWDATA VALUES(61,'Total Equity','Retained Earnings','Prior Years Retained Earnings','PY RE Brought Forward','Retained earnings brought forward','')
INSERT INTO @RAWDATA VALUES(62,'Total Equity','Retained Earnings','Current Year Earnings','Current Year RE Adjustments','Current Year Net Income','')
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