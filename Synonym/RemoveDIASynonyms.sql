-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-06 11:39:42 jpdur"
-- ------------------------------------------------------------------------------

-- ---------------------------------------------------------------
-- Renove all the DIA synonyms which have been previosuly created
-- ---------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Remove_DIA_Synonyms] 
as
BEGIN

	declare @name as varchar(100)
	declare @SqlText as varchar(300)

	DECLARE db_cursor CURSOR FOR 
	SELECT Name FROM sys.synonyms WHERE Name like 'DIA%'

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @name  

	WHILE @@FETCH_STATUS = 0  
	BEGIN
	
	       -- for each synonym drop it 
      	       SET @SqlText = 'DROP SYNONYM '+@name 
      	       EXEC (@sqlText)

      	       FETCH NEXT FROM db_cursor INTO @name 
	END 

	CLOSE db_cursor  
	DEALLOCATE db_cursor 

END
GO
