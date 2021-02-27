-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 08:49:31 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_KPIIndustryTemplate] ( @IndustryName as varchar(100) )
as
BEGIN

      declare @IndustryID as nvarchar(36)

      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )

      -- Step 1 we just add 1 line for each industry 
      merge into RM_KPIIndustryTemplate
      using (
      	    Select @IndustryID as IndustryId 
	  ) x
      on
      x.IndustryID = RM_KPIIndustryTemplate.IndustryID
      when NOT MATCHED THEN
          INSERT (IndustryID) VALUES(x.IndustryID);

END
GO

