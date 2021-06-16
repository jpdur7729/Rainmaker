-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-16 09:31:35 jpdur"
-- ------------------------------------------------------------------------------

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ---------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_IND_Template6] ( @IndustryName as varchar(100) )
as
BEGIN

      declare @IndustryID as nvarchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )

      -- By default IsConfirmed 1
      declare @IsConfirmed as BIT
      set @IsConfirmed = 1
      
      -- Step 1 we just add 1 line for each industry 
      merge into DIARM_KPI_IND_Template
      using (
      	    Select @IndustryID as IndustryId 
	  ) x
      on
      x.IndustryID = DIARM_KPI_IND_Template.IndustryID
      when NOT MATCHED THEN
          INSERT (  IndustryID, IsConfirmed,CreatedBy       ,CreatedOn)
	  VALUES (x.IndustryID,@IsConfirmed,'Via Script JPD',getdate());

END
GO

