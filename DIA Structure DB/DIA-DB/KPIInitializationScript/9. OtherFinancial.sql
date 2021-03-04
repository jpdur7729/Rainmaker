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
DECLARE @KPITYPE UNIQUEIDENTIFIER = '5FF41E39-363F-4FB5-A51E-F423DBC15469'
DECLARE @ISSYSTEMDEFINED BIT = 1;
DECLARE @ISNEWNODE BIT = 0;
DECLARE @CREATEDBY NVARCHAR(1000) = 'PAVANAKUMAR.KATTA';
DECLARE @CREATEDON DATETIME = GETDATE();
DECLARE @ISACTIVE BIT = 1;
DECLARE @EMPTYGUID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000';

--INSERT SCRIPT - BEGIN
INSERT INTO @RAWDATA VALUES(1,'MSCI World Energy Index - Fundamentals - Dividend Yield','','','','GICS - Energy - MSCI World Energy Index - Fundamentals - Dividend Yield','10 - Energy')
INSERT INTO @RAWDATA VALUES(2,'MSCI World Energy Index - Fundamentals - P/BV','','','','GICS - Energy - MSCI World Energy Index - Fundamentals - P/BV','10 - Energy')
INSERT INTO @RAWDATA VALUES(3,'MSCI World Energy Index - Fundamentals - P/E','','','','GICS - Energy - MSCI World Energy Index - Fundamentals - P/E','10 - Energy')
INSERT INTO @RAWDATA VALUES(4,'MSCI World Energy Index - Fundamentals - P/E Forward','','','','GICS - Energy - MSCI World Energy Index - Fundamentals - P/E Forward','10 - Energy')
INSERT INTO @RAWDATA VALUES(5,'MSCI World Energy Index - Gross Returns (1 Month)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (1 Month)','10 - Energy')
INSERT INTO @RAWDATA VALUES(6,'MSCI World Energy Index - Gross Returns (1 Year)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (1 Year)','10 - Energy')
INSERT INTO @RAWDATA VALUES(7,'MSCI World Energy Index - Gross Returns (3 Month)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (3 Month)','10 - Energy')
INSERT INTO @RAWDATA VALUES(8,'MSCI World Energy Index - Gross Returns (3 Year)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (3 Year)','10 - Energy')
INSERT INTO @RAWDATA VALUES(9,'MSCI World Energy Index - Gross Returns (5 Year)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (5 Year)','10 - Energy')
INSERT INTO @RAWDATA VALUES(10,'MSCI World Energy Index - Gross Returns (10 Year)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (10 Year)','10 - Energy')
INSERT INTO @RAWDATA VALUES(11,'MSCI World Energy Index - Gross Returns (YTD)','','','','GICS - Energy - MSCI World Energy Index - Gross Returns (YTD)','10 - Energy')
INSERT INTO @RAWDATA VALUES(12,'MSCI USA Materials - Fundamentals - Dividend Yield','','','','GICS - Materials - MSCI USA Materials - Fundamentals - Dividend Yield','15 - Materials')
INSERT INTO @RAWDATA VALUES(13,'MSCI USA Materials - Fundamentals - P/BV','','','','GICS - Materials - MSCI USA Materials - Fundamentals - P/BV','15 - Materials')
INSERT INTO @RAWDATA VALUES(14,'MSCI USA Materials - Fundamentals - P/E','','','','GICS - Materials - MSCI USA Materials - Fundamentals - P/E','15 - Materials')
INSERT INTO @RAWDATA VALUES(15,'MSCI USA Materials - Fundamentals - P/E Forward','','','','GICS - Materials - MSCI USA Materials - Fundamentals - P/E Forward','15 - Materials')
INSERT INTO @RAWDATA VALUES(16,'MSCI USA Materials - Gross Returns (1 Month)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (1 Month)','15 - Materials')
INSERT INTO @RAWDATA VALUES(17,'MSCI USA Materials - Gross Returns (1 Year)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (1 Year)','15 - Materials')
INSERT INTO @RAWDATA VALUES(18,'MSCI USA Materials - Gross Returns (3 Month)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (3 Month)','15 - Materials')
INSERT INTO @RAWDATA VALUES(19,'MSCI USA Materials - Gross Returns (3 Year)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (3 Year)','15 - Materials')
INSERT INTO @RAWDATA VALUES(20,'MSCI USA Materials - Gross Returns (5 Year)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (5 Year)','15 - Materials')
INSERT INTO @RAWDATA VALUES(21,'MSCI USA Materials - Gross Returns (10 Year)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (10 Year)','15 - Materials')
INSERT INTO @RAWDATA VALUES(22,'MSCI USA Materials - Gross Returns (YTD)','','','','GICS - Materials - MSCI USA Materials - Gross Returns (YTD)','15 - Materials')
INSERT INTO @RAWDATA VALUES(23,'MSCI USA Industrials - Fundamentals - Dividend Yield','','','','GICS - Industrials - MSCI USA Industrials - Fundamentals - Dividend Yield','20 - Industrials')
INSERT INTO @RAWDATA VALUES(24,'MSCI USA Industrials - Fundamentals - P/BV','','','','GICS - Industrials - MSCI USA Industrials - Fundamentals - P/BV','20 - Industrials')
INSERT INTO @RAWDATA VALUES(25,'MSCI USA Industrials - Fundamentals - P/E','','','','GICS - Industrials - MSCI USA Industrials - Fundamentals - P/E','20 - Industrials')
INSERT INTO @RAWDATA VALUES(26,'MSCI USA Industrials - Fundamentals - P/E Forward','','','','GICS - Industrials - MSCI USA Industrials - Fundamentals - P/E Forward','20 - Industrials')
INSERT INTO @RAWDATA VALUES(27,'MSCI USA Industrials - Gross Returns (1 Month)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (1 Month)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(28,'MSCI USA Industrials - Gross Returns (1 Year)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (1 Year)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(29,'MSCI USA Industrials - Gross Returns (3 Month)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (3 Month)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(30,'MSCI USA Industrials - Gross Returns (3 Year)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (3 Year)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(31,'MSCI USA Industrials - Gross Returns (5 Year)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (5 Year)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(32,'MSCI USA Industrials - Gross Returns (10 Year)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (10 Year)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(33,'MSCI USA Industrials - Gross Returns (YTD)','','','','GICS - Industrials - MSCI USA Industrials - Gross Returns (YTD)','20 - Industrials')
INSERT INTO @RAWDATA VALUES(34,'MSCI USA Consumer Discr - Fundamentals - Dividend Yield','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - Dividend Yield','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(35,'MSCI USA Consumer Discr - Fundamentals - P/BV','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - P/BV','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(36,'MSCI USA Consumer Discr - Fundamentals - P/E','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - P/E','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(37,'MSCI USA Consumer Discr - Fundamentals - P/E Forward','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Fundamentals - P/E Forward','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(38,'MSCI USA Consumer Discr - Gross Returns (1 Month)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (1 Month)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(39,'MSCI USA Consumer Discr - Gross Returns (1 Year)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (1 Year)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(40,'MSCI USA Consumer Discr - Gross Returns (3 Month)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (3 Month)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(41,'MSCI USA Consumer Discr - Gross Returns (3 Year)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (3 Year)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(42,'MSCI USA Consumer Discr - Gross Returns (5 Year)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (5 Year)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(43,'MSCI USA Consumer Discr - Gross Returns (10 Year)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (10 Year)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(44,'MSCI USA Consumer Discr - Gross Returns (YTD)','','','','GICS - Consumer Discretionary - MSCI USA Consumer Discr - Gross Returns (YTD)','25 - Consumer Discretionary')
INSERT INTO @RAWDATA VALUES(45,'MSCI World Consumer Staples - Fundamentals - Dividend Yield','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - Dividend Yield','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(46,'MSCI World Consumer Staples - Fundamentals - P/BV','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - P/BV','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(47,'MSCI World Consumer Staples - Fundamentals - P/E','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - P/E','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(48,'MSCI World Consumer Staples - Fundamentals - P/E Forward','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Fundamentals - P/E Forward','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(49,'MSCI World Consumer Staples - Gross Returns (1 Month)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (1 Month)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(50,'MSCI World Consumer Staples - Gross Returns (1 Year)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (1 Year)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(51,'MSCI World Consumer Staples - Gross Returns (3 Month)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (3 Month)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(52,'MSCI World Consumer Staples - Gross Returns (3 Year)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (3 Year)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(53,'MSCI World Consumer Staples - Gross Returns (5 Year)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (5 Year)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(54,'MSCI World Consumer Staples - Gross Returns (10 Year)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (10 Year)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(55,'MSCI World Consumer Staples - Gross Returns (YTD)','','','','GICS - Consumer Staples - MSCI World Consumer Staples - Gross Returns (YTD)','30 - Consumer Staples')
INSERT INTO @RAWDATA VALUES(56,'MSCI World Healthcare - Fundamentals - Dividend Yield','','','','GICS - Healthcare - MSCI World Healthcare - Fundamentals - Dividend Yield','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(57,'MSCI World Healthcare - Fundamentals - P/BV','','','','GICS - Healthcare - MSCI World Healthcare - Fundamentals - P/BV','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(58,'MSCI World Healthcare - Fundamentals - P/E','','','','GICS - Healthcare - MSCI World Healthcare - Fundamentals - P/E','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(59,'MSCI World Healthcare - Fundamentals - P/E Forward','','','','GICS - Healthcare - MSCI World Healthcare - Fundamentals - P/E Forward','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(60,'MSCI World Healthcare - Gross Returns (1 Month)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (1 Month)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(61,'MSCI World Healthcare - Gross Returns (1 Year)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (1 Year)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(62,'MSCI World Healthcare - Gross Returns (3 Month)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (3 Month)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(63,'MSCI World Healthcare - Gross Returns (3 Year)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (3 Year)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(64,'MSCI World Healthcare - Gross Returns (5 Year)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (5 Year)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(65,'MSCI World Healthcare - Gross Returns (10 Year)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (10 Year)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(66,'MSCI World Healthcare - Gross Returns (YTD)','','','','GICS - Healthcare - MSCI World Healthcare - Gross Returns (YTD)','35 - Healthcare')
INSERT INTO @RAWDATA VALUES(67,'MSCI World Financials - Fundamentals - Dividend Yield','','','','GICS - Financials - MSCI World Financials - Fundamentals - Dividend Yield','40 - Financials')
INSERT INTO @RAWDATA VALUES(68,'MSCI World Financials - Fundamentals - P/BV','','','','GICS - Financials - MSCI World Financials - Fundamentals - P/BV','40 - Financials')
INSERT INTO @RAWDATA VALUES(69,'MSCI World Financials - Fundamentals - P/E','','','','GICS - Financials - MSCI World Financials - Fundamentals - P/E','40 - Financials')
INSERT INTO @RAWDATA VALUES(70,'MSCI World Financials - Fundamentals - P/E Forward','','','','GICS - Financials - MSCI World Financials - Fundamentals - P/E Forward','40 - Financials')
INSERT INTO @RAWDATA VALUES(71,'MSCI World Financials - Gross Returns (1 Month)','','','','GICS - Financials - MSCI World Financials - Gross Returns (1 Month)','40 - Financials')
INSERT INTO @RAWDATA VALUES(72,'MSCI World Financials - Gross Returns (1 Year)','','','','GICS - Financials - MSCI World Financials - Gross Returns (1 Year)','40 - Financials')
INSERT INTO @RAWDATA VALUES(73,'MSCI World Financials - Gross Returns (3 Month)','','','','GICS - Financials - MSCI World Financials - Gross Returns (3 Month)','40 - Financials')
INSERT INTO @RAWDATA VALUES(74,'MSCI World Financials - Gross Returns (3 Year)','','','','GICS - Financials - MSCI World Financials - Gross Returns (3 Year)','40 - Financials')
INSERT INTO @RAWDATA VALUES(75,'MSCI World Financials - Gross Returns (5 Year)','','','','GICS - Financials - MSCI World Financials - Gross Returns (5 Year)','40 - Financials')
INSERT INTO @RAWDATA VALUES(76,'MSCI World Financials - Gross Returns (10 Year)','','','','GICS - Financials - MSCI World Financials - Gross Returns (10 Year)','40 - Financials')
INSERT INTO @RAWDATA VALUES(77,'MSCI World Financials - Gross Returns (YTD)','','','','GICS - Financials - MSCI World Financials - Gross Returns (YTD)','40 - Financials')
INSERT INTO @RAWDATA VALUES(78,'MSCI USA Info Tech - Fundamentals - Dividend Yield','','','','GICS - Information Technology - MSCI USA Info Tech - Fundamentals - Dividend Yield','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(79,'MSCI USA Info Tech - Fundamentals - P/BV','','','','GICS - Information Technology - MSCI USA Info Tech - Fundamentals - P/BV','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(80,'MSCI USA Info Tech - Fundamentals - P/E','','','','GICS - Information Technology - MSCI USA Info Tech - Fundamentals - P/E','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(81,'MSCI USA Info Tech - Fundamentals - P/E Forward','','','','GICS - Information Technology - MSCI USA Info Tech - Fundamentals - P/E Forward','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(82,'MSCI USA Info Tech - Gross Returns (1 Month)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (1 Month)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(83,'MSCI USA Info Tech - Gross Returns (1 Year)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (1 Year)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(84,'MSCI USA Info Tech - Gross Returns (3 Month)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (3 Month)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(85,'MSCI USA Info Tech - Gross Returns (3 Year)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (3 Year)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(86,'MSCI USA Info Tech - Gross Returns (5 Year)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (5 Year)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(87,'MSCI USA Info Tech - Gross Returns (10 Year)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (10 Year)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(88,'MSCI USA Info Tech - Gross Returns (YTD)','','','','GICS - Information Technology - MSCI USA Info Tech - Gross Returns (YTD)','45 - Information Technology')
INSERT INTO @RAWDATA VALUES(89,'MSCI USA Communication Services - Fundamentals - Dividend Yield','','','','GICS - Communication Services - MSCI USA Communication Services - Fundamentals - Dividend Yield','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(90,'MSCI USA Communication Services - Fundamentals - P/BV','','','','GICS - Communication Services - MSCI USA Communication Services - Fundamentals - P/BV','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(91,'MSCI USA Communication Services - Fundamentals - P/E','','','','GICS - Communication Services - MSCI USA Communication Services - Fundamentals - P/E','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(92,'MSCI USA Communication Services - Fundamentals - P/E Forward','','','','GICS - Communication Services - MSCI USA Communication Services - Fundamentals - P/E Forward','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(93,'MSCI USA Communication Services - Gross Returns (1 Month)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (1 Month)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(94,'MSCI USA Communication Services - Gross Returns (1 Year)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (1 Year)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(95,'MSCI USA Communication Services - Gross Returns (3 Month)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (3 Month)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(96,'MSCI USA Communication Services - Gross Returns (3 Year)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (3 Year)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(97,'MSCI USA Communication Services - Gross Returns (5 Year)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (5 Year)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(98,'MSCI USA Communication Services - Gross Returns (10 Year)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (10 Year)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(99,'MSCI USA Communication Services - Gross Returns (YTD)','','','','GICS - Communication Services - MSCI USA Communication Services - Gross Returns (YTD)','50 - Communication Services')
INSERT INTO @RAWDATA VALUES(100,'MSCI USA Utilities - Fundamentals - Dividend Yield','','','','GICS - Utilities - MSCI USA Utilities - Fundamentals - Dividend Yield','55 - Utilities')
INSERT INTO @RAWDATA VALUES(101,'MSCI USA Utilities - Fundamentals - P/BV','','','','GICS - Utilities - MSCI USA Utilities - Fundamentals - P/BV','55 - Utilities')
INSERT INTO @RAWDATA VALUES(102,'MSCI USA Utilities - Fundamentals - P/E','','','','GICS - Utilities - MSCI USA Utilities - Fundamentals - P/E','55 - Utilities')
INSERT INTO @RAWDATA VALUES(103,'MSCI USA Utilities - Fundamentals - P/E Forward','','','','GICS - Utilities - MSCI USA Utilities - Fundamentals - P/E Forward','55 - Utilities')
INSERT INTO @RAWDATA VALUES(104,'MSCI USA Utilities - Gross Returns (1 Month)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (1 Month)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(105,'MSCI USA Utilities - Gross Returns (1 Year)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (1 Year)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(106,'MSCI USA Utilities - Gross Returns (3 Month)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (3 Month)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(107,'MSCI USA Utilities - Gross Returns (3 Year)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (3 Year)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(108,'MSCI USA Utilities - Gross Returns (5 Year)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (5 Year)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(109,'MSCI USA Utilities - Gross Returns (10 Year)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (10 Year)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(110,'MSCI USA Utilities - Gross Returns (YTD)','','','','GICS - Utilities - MSCI USA Utilities - Gross Returns (YTD)','55 - Utilities')
INSERT INTO @RAWDATA VALUES(111,'MSCI World Real Estate - Fundamentals - Dividend Yield','','','','GICS - Real Estate - MSCI World Real Estate - Fundamentals - Dividend Yield','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(112,'MSCI World Real Estate - Fundamentals - P/BV','','','','GICS - Real Estate - MSCI World Real Estate - Fundamentals - P/BV','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(113,'MSCI World Real Estate - Fundamentals - P/E','','','','GICS - Real Estate - MSCI World Real Estate - Fundamentals - P/E','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(114,'MSCI World Real Estate - Fundamentals - P/E Forward','','','','GICS - Real Estate - MSCI World Real Estate - Fundamentals - P/E Forward','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(115,'MSCI World Real Estate - Gross Returns (1 Month)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (1 Month)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(116,'MSCI World Real Estate - Gross Returns (1 Year)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (1 Year)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(117,'MSCI World Real Estate - Gross Returns (3 Month)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (3 Month)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(118,'MSCI World Real Estate - Gross Returns (3 Year)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (3 Year)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(119,'MSCI World Real Estate - Gross Returns (5 Year)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (5 Year)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(120,'MSCI World Real Estate - Gross Returns (10 Year)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (10 Year)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(121,'MSCI World Real Estate - Gross Returns (YTD)','','','','GICS - Real Estate - MSCI World Real Estate - Gross Returns (YTD)','60 - Real Estate')
INSERT INTO @RAWDATA VALUES(122,'DIRECT ENTRY','EBITDA','Adjustment to EBIT','','','')
INSERT INTO @RAWDATA VALUES(123,'DIRECT ENTRY','EBITDA','Adjustment to EBITDA','','','')
INSERT INTO @RAWDATA VALUES(124,'DIRECT ENTRY','EBITDA','Adjustment to EBT','','','')
INSERT INTO @RAWDATA VALUES(125,'DIRECT ENTRY','EBITDA','Gross Interest Expense','','','')
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