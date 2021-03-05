-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 14:50:15 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Workflow] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
@CollectionDate as date,@ScenarioName as varchar(100))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @KPICompanyConfigurationID = (select ID from RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- Extra Parameters or Default Value
      declare @ScenarioTypeID as nvarchar(36)
      set @ScenarioTypeID = (select ID from RM_ClassType where Name = @ScenarioName)
      declare @BatchStatusID as nvarchar(36)
      -- set @BatchStatusID = (select ID from RMX_BatchStatus where Name = 'Default')
      set @BatchStatusID = (select ID from RMX_BatchStatus where Name = 'Draft')
      declare @CollectionPeriodID as nvarchar(36)
      set @CollectionPeriodID = (select ID from RMX_CollectionPeriod where Name = 'Monthly')
      declare @WorkflowStatusID as nvarchar(36)
      set @WorkflowStatusID = (select ID from RMX_WorkflowStatus where Name = 'Not Started')

      -- Create the Category ID
      declare @KPICategoryID as nvarchar(36)
      set @KPICategoryID = (select ID from RMX_KPICategory where Name in (
      	  select case when IsFinancial = 1
	  	      then 'Financials'
		      else 'Non-Financials'
		 end as Name
	  	 from RMX_KPIType
		 where ID = @HierarchyID
      ))

      -- Merge into the Table
      merge into RM_Workflow as RW
      using (
      	    select @KPICategoryID as KPICategoryID, @CollectionDate as EffectiveDate,
	    	   @WorkflowStatusID  as WorkflowStatusID , @CompanyID as CompanyID
      ) x
      on x.KPICategoryID = RW.KPICategoryID and x.CompanyID = RW.CompanyID
      	 and x.EffectiveDate = RW.EffectiveDate and x.WorkflowStatusID = RW.WorkflowStatusID
      when NOT MATCHED then
      	   INSERT (ID,KPICategoryID,EffectiveDate,WorkflowStatusID,CompanyID,StatusDate)
	   VALUES (NEWID(),x.KPICategoryID,x.EffectiveDate,x.WorkflowStatusID,x.CompanyID,getdate());

END
GO

