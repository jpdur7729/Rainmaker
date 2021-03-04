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
DECLARE @KPITYPE UNIQUEIDENTIFIER = '3A526188-BF41-4E0D-AC80-FB156BA76A01'
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @ISNEWNODE BIT = 0;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @ISACTIVE BIT = 1;
DECLARE @EMPTYGUID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';

--INSERT SCRIPT - BEGIN
INSERT INTO @RAWDATA VALUES(1,'Total Revenues','Revenues','Recurring Revenues','Product Subscriptions','Product Subscriptions','')
INSERT INTO @RAWDATA VALUES(2,'Total Revenues','Revenues','Recurring Revenues','Service Contracts','Service Contracts','')
INSERT INTO @RAWDATA VALUES(3,'Total Revenues','Revenues','Non-Recurring Revenues','Sales Revenue','Sales of Goods','')
INSERT INTO @RAWDATA VALUES(4,'Total Revenues','Revenues','Non-Recurring Revenues','Sales Revenue','Sales of Services','')
INSERT INTO @RAWDATA VALUES(5,'Total Revenues','Revenues','Non-Recurring Revenues','Sales Revenue','Sales of Subsidiaries','')
INSERT INTO @RAWDATA VALUES(6,'Total Revenues','Revenues','Non-Recurring Revenues','Sales Revenue','Other Sales Revenue','')
INSERT INTO @RAWDATA VALUES(7,'Total Revenues','Short Term Interest Income','ST Interest Income - Bank Balances','ST Interest Income','Short Term Interest Income - Bank','')
INSERT INTO @RAWDATA VALUES(8,'Total Revenues','Short Term Interest Income','ST Dividend Income - Brokerage','ST Dividend Income','Short Term Dividend Income - Brokerage','')
INSERT INTO @RAWDATA VALUES(9,'Total Revenues','Long Term Interest Income','Long Term Note Income','LT Note Income','Long Term Note Income','')
INSERT INTO @RAWDATA VALUES(10,'Total Revenues','Realized Gain or Loss','Realized Investment Gain or Loss','','Realized Gain or Loss on Investments','')
INSERT INTO @RAWDATA VALUES(11,'Total Revenues','Realized Gain or Loss','Realized F/X Gain or Loss','','Realized F/X Gain or Loss','')
INSERT INTO @RAWDATA VALUES(12,'Total Revenues','Unrealized Gain or Loss','Unrealized Investment Gain or Loss','','Unrealized Investment Gain or Loss','')
INSERT INTO @RAWDATA VALUES(13,'Total Revenues','Unrealized Gain or Loss','Unrealized F/X Gain or Loss','','Unrealized F/X Gain or Loss','')
INSERT INTO @RAWDATA VALUES(14,'Total Revenues','Other Income','Other Offset Income','','Offset Incomes','')
INSERT INTO @RAWDATA VALUES(15,'Total Revenues','Other Income','Other Fee Income','','Other Fee Income','')
INSERT INTO @RAWDATA VALUES(16,'Total Expenses','Cost of Goods Sold','COGS','Direct Sales Expense','Direct Sales Expenses','')
INSERT INTO @RAWDATA VALUES(17,'Total Expenses','SG&A','Sales Expenses','SG&A Other Cost of Sales','Other Cost of Sales','')
INSERT INTO @RAWDATA VALUES(18,'Total Expenses','SG&A','Sales Expenses','SG&A Other Costs','Other Costs','')
INSERT INTO @RAWDATA VALUES(19,'Total Expenses','SG&A','General Expenses','General Expense Overheads','General Expense Overheads','')
INSERT INTO @RAWDATA VALUES(20,'Total Expenses','SG&A','Administrative Expenses','','Administrative Expense Overheads','')
INSERT INTO @RAWDATA VALUES(21,'Total Expenses','SG&A','Overheads','Overhead Expenses','Employee Expenses','')
INSERT INTO @RAWDATA VALUES(22,'Total Expenses','SG&A','Overheads','Overhead Expenses','Insurance overheads','')
INSERT INTO @RAWDATA VALUES(23,'Total Expenses','SG&A','Overheads','Overhead Expenses','IT costs','')
INSERT INTO @RAWDATA VALUES(24,'Total Expenses','SG&A','Overheads','Overhead Expenses','Marketing Overheads','')
INSERT INTO @RAWDATA VALUES(25,'Total Expenses','SG&A','Overheads','Overhead Expenses','Other Overhead Costs','')
INSERT INTO @RAWDATA VALUES(26,'Total Expenses','SG&A','Overheads','Overhead Expenses','People Costs','')
INSERT INTO @RAWDATA VALUES(27,'Total Expenses','SG&A','Overheads','Overhead Expenses','Site Costs','')
INSERT INTO @RAWDATA VALUES(28,'Total Expenses','SG&A','Overheads','Overhead Expenses','Telecommunications Overheads','')
INSERT INTO @RAWDATA VALUES(29,'Total Expenses','SG&A','Variable Costs','Variable Cost Expenses','Distribution Costs','')
INSERT INTO @RAWDATA VALUES(30,'Total Expenses','Interest Expense','Financing Costs','Commitment Fees','Commitment Fees','')
INSERT INTO @RAWDATA VALUES(31,'Total Expenses','Interest Expense','Financing Costs','Interest Expenses','Interest Expenses','')
INSERT INTO @RAWDATA VALUES(32,'Total Expenses','Interest Expense','Financing Costs','Unused Line Fees','Unused Line Fees','')
INSERT INTO @RAWDATA VALUES(33,'Total Expenses','Interest Expense','Other Interest Expenses','Other Interest Expense Adjustments','Other Interest Expenses','')
INSERT INTO @RAWDATA VALUES(34,'Total Expenses','Depreciation and Amortization','Depreciation Expenses','','Depreciation Expenses','')
INSERT INTO @RAWDATA VALUES(35,'Total Expenses','Depreciation and Amortization','Amortization Expenses','','Amortization Expenses','')
INSERT INTO @RAWDATA VALUES(36,'Total Expenses','Taxes','Tax Expenses','','Tax Expenses','')
INSERT INTO @RAWDATA VALUES(37,'Total Expenses','Foreign Exchange','Foreign Exchange Translations','F/X Translation Expenses','F/X Translation','')
INSERT INTO @RAWDATA VALUES(38,'Total Expenses','Other Expenses','Other Expense Overheads','Other Expenses','Other Expenses','')
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