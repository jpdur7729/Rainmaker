-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 09:32:01 jpdur"
-- ------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------
-- To be done after EXEC STG_DIA_RM_Populate KPICompanyConfigurationthe
-- Assumes that RM_KPICompanyConfiguration and RM_KPICompanyRecurrenceAssociation
-- have been populated 
-- if done a posterio no major problem such as "Call the Administrator" error 
-- ------------------------------------------------------------------------------------
-- This version will - if there is no record - add the Actuals for Financials and non-Financials
-- ------------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyRecurrenceScenarioAssociation] (
       @IndustryName as varchar(100),
       @CompanyName as varchar(100),
       @ScenarioName as varchar(100) = 'Actuals')
as
BEGIN

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      -- Identify the ID from RM_KPICompanyRecurrenceAssociation
      declare @KPICompanyConfigurationID as nvarchar(36)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where KPIIndustryTemplateID = @KPIIndustryTemplateID and CompanyID = @CompanyID)

      -- Select the data from RM_KPICompanyRecurrenceAssociation
      merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyRecurrenceScenarioAssociation as KCRSA
      using (
      	    select @KPICompanyConfigurationID as KPICompanyConfigurationID,
      	     	   ID as KPICompanyRecurrenceAssociationID,
	     	   (select ID from RainmakerLDCJP_OAT.dbo.RM_ClassType where Name = @ScenarioName) as ClassTypeID
      	    from RainmakerLDCJP_OAT.dbo.RM_KPICompanyRecurrenceAssociation
      	    where KPICompanyConfigurationID = @KPICompanyConfigurationID
      ) x
      on x.KPICompanyConfigurationID = KCRSA.KPICompanyConfigurationID
      	 and x.KPICompanyRecurrenceAssociationID = KCRSA.KPICompanyRecurrenceAssociationID
	 and x.ClassTypeID = KCRSA.ClassTypeID
      when not matched THEN
      	   INSERT (  KPICompanyConfigurationID,  KPICompanyRecurrenceAssociationID,  ClassTypeID)
	   Values (x.KPICompanyConfigurationID,x.KPICompanyRecurrenceAssociationID,x.ClassTypeID);
      
END
GO

