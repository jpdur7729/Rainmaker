-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-12 12:00:20 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_Batch] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
@CollectionDate as date,@ScenarioName as varchar(100),
-- OUTPUT Parameters 
@KPICollectionBatchID as varchar(36) OUTPUT,  @NewKPICollectionBatch as int OUTPUT)
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_Template where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID = @CompanyID )

      -- Extra Parameters or Default Value
      declare @ScenarioTypeID as nvarchar(36)
      set @ScenarioTypeID = (select ID from RainmakerLDCJP_OAT.dbo.RM_ClassType where Name = @ScenarioName)

      declare @BatchStatusID as nvarchar(36)
      -- set @BatchStatusID = (select ID from RMX_BatchStatus where Name = 'Default')
      set @BatchStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_BatchStatus where Name = 'Draft')
      declare @CollectionPeriodID as nvarchar(36)
      set @CollectionPeriodID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_CollectionPeriod where Name = 'Monthly')

      --declare @WorkflowStatusID as nvarchar(36)
      --set @WorkflowStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_WorkflowStatus where Name = 'Pending Review')

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

	  -- Determine the StartMonthCollectionDate
      declare @StartMonthCollectionDate as date 
      set @StartMonthCollectionDate = DATEADD(DAY, 1, EOMONTH(@CollectionDate, -1))

      -- Standard way to capture the Workflow
      declare @WorkflowID as nvarchar(36)
	  declare @NewWorkflow as int 
	  EXEC STG_DIA_Populate_RM_Workflow @HierarchyName, @IndustryName, @CompanyName, @StartMonthCollectionDate, @ScenarioName, @WorkflowID OUTPUT,@NewWorkflow OUTPUT
	  	   
      --set @WorkflowID = (select ID from RainmakerLDCJP_OAT.dbo.RM_Workflow
      --	  	      		where CompanyID = @CompanyID and EffectiveDate = @CollectionDate
				  --    and WorkflowStatusID = @WorkflowStatusID
				  --    and KPICategoryID = @KPICategoryID)

      -- To Capture the result of the merge
      declare @IDTable  table (                                
      	      [ID] [nvarchar](36) NOT NULL
      )
      
      -- The ID in order to identify whether the record has been created or not
      declare @NEWKPICollectionBatchID as varchar(36) = NEWID()
      
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
      	   INSERT (ID,  KPITypeID,  ReportingDate,  CompanyID,  CollectionPeriodID,  WorkflowID,  ScenarioTypeID,  BatchStatusID,CreatedOn,CreatedBy             ,AsOfDate)
	   VALUES (@NEWKPICollectionBatchID  ,x.KPITypeID,x.ReportingDate,x.CompanyID,x.CollectionPeriodID,x.WorkflowID,x.ScenarioTypeID,x.BatchStatusID,getdate(),'JeanPierre Durandeau',getdate())
      when MATCHED then
      	   update set CreatedBy = 'Jean-Pierre Durandeau'
      OUTPUT inserted.ID into @IDTable;
	   
     -- Let's capture the 2 parameters
     set @KPICollectionBatchID  = (select ID from @IDTable)
     set @NewKPICollectionBatch = (select case when @KPICollectionBatchID = @NEWKPICollectionBatchID then 1 else 0 end)

END
GO

