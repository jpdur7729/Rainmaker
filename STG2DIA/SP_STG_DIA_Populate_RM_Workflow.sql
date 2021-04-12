/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-09 17:19:21 jpdur"
   ------------------------------------------------------------------------------ */

-- @StartCollectionDate 
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_Workflow] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
@StartCollectionDate as date,@ScenarioName as varchar(100),
-- Parameters in order to know if the RM_Workflow is created or no
@WorkflowID as varchar(36) OUTPUT,@NewWorkflow as int OUTPUT)
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      -- Create the WorkflowStatusID
      declare @WorkflowStatusID as nvarchar(36)
      set @WorkflowStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_WorkflowStatus where Name = 'Pending Review')

      -- Create the Category ID
      declare @KPICategoryID as nvarchar(36)
      set @KPICategoryID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_KPICategory where Name = 'Financials')

      -- To Capture the result of the import 
      declare @IDTable  table (                                
      	      [ID] [nvarchar](36) NOT NULL
      )

      -- Create the newID to detect if this an old or a new record
      declare @NEWWorkflowID as varchar(36) = NEWID() 

      -- Merge into the Table
      merge into RainmakerLDCJP_OAT.dbo.RM_Workflow as RW
      using (
      	    select @KPICategoryID as KPICategoryID, @StartCollectionDate as EffectiveDate,
	    	   @WorkflowStatusID  as WorkflowStatusID , @CompanyID as CompanyID
      ) x
      on x.KPICategoryID = RW.KPICategoryID and x.CompanyID = RW.CompanyID
      	 and x.EffectiveDate = RW.EffectiveDate and x.WorkflowStatusID = RW.WorkflowStatusID
      when NOT MATCHED then
      	   INSERT (ID            ,  KPICategoryID,  EffectiveDate,  WorkflowStatusID,  CompanyID,StatusDate,Name      ,ChangedBy)
	   VALUES (@NEWWorkflowID,x.KPICategoryID,x.EffectiveDate,x.WorkflowStatusID,x.CompanyID,getdate() ,'workflow','JeanPierre Durandeau')
      when MATCHED then
      	   UPDATE set Name = 'workflow'
	   OUTPUT inserted.ID into @IDTable;

     -- Let's capture the 2 parameters
     set @WorkflowID = (select ID from @IDTable)
     set @NewWorkflow = (select case when @WorkflowID = @NEWWorkflowID then 1 else 0 end)


END
GO

