-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 14:50:15 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_Batch] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
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
      set @ScenarioTypeID = (select ID from RM_ClassType where Name = 'Default')
      declare @BatchStatusID as nvarchar(36)
      -- set @BatchStatusID = (select ID from RMX_BatchStatus where Name = 'Default')
      set @BatchStatusID = (select ID from RMX_BatchStatus where Name = 'Draft')
      declare @CollectionPeriodID as nvarchar(36)
      set @CollectionPeriodID = (select ID from RMX_CollectionPeriod where Name = 'Monthly')

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select top 1 ID from RM_Workflow)
      
      -- Merge into the Table
      merge into RM_KPI_Collection_Batch as KCB
      using (
      	    select @HierarchyID as KPITypeID, @CollectionDate as ReportingDate,
	    	   @WorkflowID as WorkflowID, @CompanyID as CompanyID,
		   @CollectionPeriodID as CollectionPeriodID, @BatchStatusID as BatchStatusID,
		   @ScenarioTypeID as ScenarioTypeID
      ) x
      on x.KPITypeID = KCB.KPITypeID and x.WorkflowID = KCB.WorkflowID and x.CompanyID = KCB.CompanyID
      	 and x.ReportingDate = KCB.ReportingDate and x.ScenarioTypeID = KCB.ScenarioTypeID
      when NOT MATCHED then
      	   INSERT (KPITypeID,ReportingDate,CompanyID,CollectionPeriodID,WorkflowID,ScenarioTypeID,BatchStatusID,CreatedOn)
	   VALUES (x.KPITypeID,x.ReportingDate,x.CompanyID,x.CollectionPeriodID,x.WorkflowID,x.ScenarioTypeID,x.BatchStatusID,getdate()) ;

END
GO

