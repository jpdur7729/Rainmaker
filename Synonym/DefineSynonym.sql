-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-06 11:40:29 jpdur"
-- ------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------
-- Create a simple synonym for all the tables used in the DIA database
-- That way it becomes easy to deploy without having to rename anything
-- by just adjusting the value of the synonyms the stored procedures can be ported from
-- one environment to the next
-- -------------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Define_Synonym] (@TableName as varchar(100), @DBName as varchar(100), @SchemaName as varchar(100) = 'dbo')
as
BEGIN

	Declare @DIATableName as varchar(120)
	set @DIATableName = 'DIA'+@TableName

	-- Define SYNONYM
	Declare @SqlText as varchar(300) = 'CREATE SYNONYM '+@DIATableName+' for ['+@DBName+'].['+@SchemaName+'].['+@TableName+']'
	print @SqlText

	-- Execute the creation of the synonym
	EXEC (@SqlText)

END
GO

