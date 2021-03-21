-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-21 09:19:19 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPIIndustryTemplate] ( @IndustryName as varchar(100) )
as
BEGIN

      declare @IndustryID as nvarchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )

      -- By default IsConfirmed 1
      declare @IsConfirmed as BIT
      set @IsConfirmed = 1
      
      -- Step 1 we just add 1 line for each industry 
      merge into RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate
      using (
      	    Select @IndustryID as IndustryId 
	  ) x
      on
      x.IndustryID = RM_KPIIndustryTemplate.IndustryID
      when NOT MATCHED THEN
          INSERT (IndustryID,IsConfirmed,ChangedBy,ChangedOn)
	  VALUES(x.IndustryID,@IsConfirmed,'Via Script',getdate());

END
GO

