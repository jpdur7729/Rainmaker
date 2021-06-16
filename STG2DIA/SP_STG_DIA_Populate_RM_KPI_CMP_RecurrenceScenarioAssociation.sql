/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-06-16 10:05:01 jpdur"
   ------------------------------------------------------------------------------ */

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ------------------------------------------------------------------------------------
-- To be done after EXEC STG_DIA_RM_Populate KPI_CMP_Template 
-- Assumes that RM_KPI_CMP_Template and RM_KPI_CMP_RecurrenceAssociation
-- have been populated 
-- if done a posterio no major problem such as "Call the Administrator" error 
-- ------------------------------------------------------------------------------------
-- This version will - if there is no record - add the Actuals for Financials and non-Financials
-- ------------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_CMP_RecurrenceScenarioAssociation] (
       @IndustryName as varchar(100),
       @CompanyName as varchar(100),
       @ScenarioName as varchar(100) = 'Actuals')
as
BEGIN

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from DIARM_KPI_IND_Template where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      -- Identify the ID from RM_KPI_CMP_Template
      declare @KPICompanyTemplateID as nvarchar(36)
      set @KPICompanyTemplateID = (select ID from DIARM_KPI_CMP_Template where KPIIndustryTemplateID = @KPIIndustryTemplateID and CompanyID = @CompanyID)

      -- Select the data from RM_KPI_CMP_RecurrenceAssociation
      merge into DIARM_KPI_CMP_RecurrenceScenarioAssociation as KCRSA
      using (
      	    select @KPICompanyTemplateID as KPICompanyTemplateID,
      	     	   ID as KPICompanyRecurrenceAssociationID,
	     	   (select ID from DIARM_ClassType where Name = @ScenarioName) as ClassTypeID
      	    from DIARM_KPI_CMP_RecurrenceAssociation
      	    where KPICompanyTemplateID = @KPICompanyTemplateID
      ) x
      on x.KPICompanyTemplateID = KCRSA.KPICompanyTemplateID
      	 and x.KPICompanyRecurrenceAssociationID = KCRSA.KPICompanyRecurrenceAssociationID
	 and x.ClassTypeID = KCRSA.ClassTypeID
      when not matched THEN
      	   INSERT (  KPICompanyTemplateID,  KPICompanyRecurrenceAssociationID,  ClassTypeID)
	   Values (x.KPICompanyTemplateID,x.KPICompanyRecurrenceAssociationID,x.ClassTypeID);
      
END
GO

