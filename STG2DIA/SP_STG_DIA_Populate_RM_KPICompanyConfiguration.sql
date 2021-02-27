-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 09:32:01 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_KPICompanyConfiguration] ( @IndustryName as varchar(100),
@CompanyName as varchar(100))
as
BEGIN

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

      -- We add the nodes from RM_Node associated to the instrustry
      merge into RM_KPICompanyConfiguration RM_KCompConf
      using (
      select @KPIIndustryTemplateID as KPIIndustryTemplateID,@CompanyID as CompanyID,
      	     (select ID from RMX_CollectionRecurrence where Name= 'Monthly') as CollectionRecurrenceID
	  ) x
      on
      x.KPIIndustryTemplateID = RM_KCompConf.KPIIndustryTemplateID and x.CompanyID = RM_KCompConf.CompanyID
      when NOT MATCHED THEN
          INSERT (CreatedOn,KPIIndustryTemplateId,CompanyID,CollectionRecurrenceID)
	      VALUES (getdate(),x.KPIIndustryTemplateId,x.CompanyID,x.CollectionRecurrenceID) ;

END
GO

