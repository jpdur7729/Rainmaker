-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 17:02:58 jpdur"
-- ------------------------------------------------------------------------------
use [RainmakerLDCJP_OAT]

-- DECLARE @SearchStr nvarchar(100) = 'B2FAABE8-48B9-4FD2-8415-18F14E926374' -- Collection_Dimension
-- DECLARE @SearchStr nvarchar(100) = '93C3AA5A-A522-EB11-8187-005056AB4D1B' -- De La Renta Enterprises Company ID 
-- DECLARE @SearchStr nvarchar(100) = '401FAAB8-5BBF-43C9-2794-08D8E7A5CE48' -- De La Renta Enterprises KPI Configuration ID 
-- DECLARE @SearchStr nvarchar(100) = 'A2E695A0-15B8-498F-ABDD-1DAC38CF98D6' -- Calico Marketing KPI Configuration ID 
-- DECLARE @SearchStr nvarchar(100) = 'F07C5F37-6327-44B3-D46D-08D8E2E2D6B4' -- AmazonWebSite DataItem ID 
-- DECLARE @SearchStr nvarchar(100) = '59CCA678-AC9D-415D-9A4E-11700005B1BB' -- DataItem ID  for a LF:... to be deleted 
-- DECLARE @SearchStr nvarchar(100) = 'A2E695A0-15B8-498F-ABDD-1DAC38CF98D6' -- Calico KPICompanyConfiguration ID 
-- DECLARE @SearchStr nvarchar(100) = '827319A1-CE6E-4EFF-B6C8-AB254081AB29' -- NodeId in KPICompanyConfigurationNodeAssociation] ID 
-- DECLARE @SearchStr nvarchar(100) = 'CASH POSITION BALANCE - BEGINNING' -- Data for TopNode Cashflows 
-- DECLARE @SearchStr nvarchar(100) = 'CBA3FCCE-DD23-4751-AAA6-2E55C1AA1A7A' -- Data for TopNode Cashflows // NodeID
-- DECLARE @SearchStr nvarchar(100) = '1C317846-6286-EB11-818F-005056AB4D1B' -- Data for TopNode Cashflows // NodeID
-- DECLARE @SearchStr nvarchar(100) = '053527C0-0876-420C-B57E-ACDA02BB1057' -- Workflow ID
DECLARE @SearchStr nvarchar(100) = '4488608B-FC86-EB11-818F-005056AB4D1B' -- Node ID ?



DECLARE @Results TABLE (ColumnName nvarchar(370), ColumnValue nvarchar(3630))

SET NOCOUNT ON

DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110)
SET  @TableName = ''
SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''')

WHILE @TableName IS NOT NULL

BEGIN
    SET @ColumnName = ''
    SET @TableName = 
    (
        SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
        FROM     INFORMATION_SCHEMA.TABLES
        WHERE         TABLE_TYPE = 'BASE TABLE'
	    AND	   TABLE_NAME like '%RM%'
            AND    QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
            AND    OBJECTPROPERTY(
                    OBJECT_ID(
                        QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
                         ), 'IsMSShipped'
                           ) = 0
    )

    WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)

    BEGIN
        SET @ColumnName =
        (
            SELECT MIN(QUOTENAME(COLUMN_NAME))
            FROM     INFORMATION_SCHEMA.COLUMNS
            WHERE         TABLE_SCHEMA    = PARSENAME(@TableName, 2)
                AND    TABLE_NAME    = PARSENAME(@TableName, 1)
                AND    DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar', 'int', 'decimal','uniqueidentifier')
                AND    QUOTENAME(COLUMN_NAME) > @ColumnName
        )

        IF @ColumnName IS NOT NULL

        BEGIN
            INSERT INTO @Results
            EXEC
            (
                'SELECT ''' + @TableName + '.' + @ColumnName + ''', LEFT(' + @ColumnName + ', 3630) 
                FROM ' + @TableName + ' (NOLOCK) ' +
                ' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
            )
        END
    END    
END

SELECT ColumnName, ColumnValue FROM @Results
