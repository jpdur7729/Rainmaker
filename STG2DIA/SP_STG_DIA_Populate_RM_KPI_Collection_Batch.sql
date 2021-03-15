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
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- Extra Parameters or Default Value
      declare @ScenarioTypeID as nvarchar(36)
      set @ScenarioTypeID = (select ID from RainmakerLDCJP_OAT.dbo.RM_ClassType where Name = @ScenarioName)

      declare @BatchStatusID as nvarchar(36)
      -- set @BatchStatusID = (select ID from RMX_BatchStatus where Name = 'Default')
      set @BatchStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_BatchStatus where Name = 'Draft')
      declare @CollectionPeriodID as nvarchar(36)
      set @CollectionPeriodID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_CollectionPeriod where Name = 'Monthly')

      declare @WorkflowStatusID as nvarchar(36)
      set @WorkflowStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_WorkflowStatus where Name = 'Pending Review')

      -- Create the Category ID
      declare @KPICategoryID as nvarchar(36)
      set @KPICategoryID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_KPICategory where Name in (
      	  select case when IsFinancial = 1
	  	      then 'Financials'
		      else 'Non-Financials'
		 end as Name
	  	 from RainmakerLDCJP_OAT.dbo.RMX_KPIType
		 where ID = @HierarchyID
      ))

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select ID from RainmakerLDCJP_OAT.dbo.RM_Workflow
      	  	      		where CompanyID = @CompanyID and EffectiveDate = @CollectionDate
				      and WorkflowStatusID = @WorkflowStatusID
				      and KPICategoryID = @KPICategoryID)
      
      -- Merge into the Table
      merge into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch as KCB
      using (
      	    select @HierarchyID as KPITypeID, @CollectionDate as ReportingDate,
	    	   @WorkflowID as WorkflowID, @CompanyID as CompanyID,
		   @CollectionPeriodID as CollectionPeriodID, @BatchStatusID as BatchStatusID,
		   @ScenarioTypeID as ScenarioTypeID
      ) x
      on x.KPITypeID = KCB.KPITypeID and x.WorkflowID = KCB.WorkflowID and x.CompanyID = KCB.CompanyID
      	 and x.ReportingDate = KCB.ReportingDate and x.ScenarioTypeID = KCB.ScenarioTypeID
      when NOT MATCHED then
      	   INSERT (KPITypeID,ReportingDate,CompanyID,CollectionPeriodID,WorkflowID,ScenarioTypeID,BatchStatusID,CreatedOn,CreatedBy,AsOfDate)
	   VALUES (x.KPITypeID,x.ReportingDate,x.CompanyID,x.CollectionPeriodID,x.WorkflowID,x.ScenarioTypeID,x.BatchStatusID,getdate(),'JeanPierre Durandeau',getdate()) ;

END
GO

