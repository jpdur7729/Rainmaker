/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-10 07:54:30 jpdur"
   ------------------------------------------------------------------------------ */

-- @StartCollectionDate 
CREATE   PROCEDURE [dbo].[STG_DIA_Populate_RM_Workflow] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
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

-- -- NO In the case of generic functioning then this is Company Level 2 which needs to be added 
-- -- Final Leaves are the ones to be entered 
-- -- No need to upload anything else ==> To be checked as part of the XL Addin

-- CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_DataItem_L2] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
-- as
-- BEGIN

--       declare @HierarchyID as nvarchar(36)
--       -- Alias KPITypeID
--       set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

--       declare @IndustryID as nvarchar(36)
--       declare @KPIIndustryTemplateID as varchar(36)
--       set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
--       set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

--       declare @CompanyID as nvarchar(36)
--       declare @KPICompanyConfigurationID as nvarchar(36)
--       -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
--       set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
--       set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @CompanyID )

--       declare @Description as nvarchar(50)
--       set @Description = 'Created by STG_DIA_Populate_RM_DataItem /'+@HierachyName+'/'+@IndustryName

--       -- Create the default value for RM_DataItem
--       declare @IsDebit as BIT
--       set @IsDebit = 1
--       declare @IsSystemDefined as BIT
--       set @IsSystemDefined = 0
--       declare @IsAggregate as BIT
--       set @IsAggregate = 1
--       declare @IsActive as BIT
--       set @IsActive = 1
--       declare @Scale as integer
--       set @Scale = 2

--       -- Store the value type ID needed
--       declare  @ValueTypeID as varchar(36) =  (select ID from RainmakerLDCJP_OAT.dbo.RMX_ValueType where Name = 'Numeric') as ValueTypeID

--       -- Process all the final Leaves for the Hierarchy/Industry/Company
--       select * into #ListNodesDataItemNames from (
--       	     select ID,Name,RM_DataItemID from NodeDef         where HierarchyID = @HierarchyID
-- 	     union 
--       	     select ID,Name,RM_DataItemID from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
-- 	     union 
--       	     select ID,Name,RM_DataItemID from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
--       ) tmp

--       -- Eliminate all the Nodes which are a parent --> we only get the FinalLeaves
--       select * into #FinalLeaves from
--       	     (select * from #ListNodesDataItemNames where ID not in (select ParentNodeDefID from Hierarchies)) tmp

--       -- To prevent any issues Select the data from RM_DataItem
--       select * into #KPIListDataItem
--       from RainmakerLDCJP_OAT.dbo.RM_DataItem
--       where CreatedOn > '01-Apr-2021'

--       -- Update the list of DataItems accordingly
--       merge into #FinalLeaves fl
--       using #KPIListDataItem KPIListDataItem
--       on KPIListDataItem.Name = fl.Name
--       when MATCHED THEN
--       	   UPDATE SET RM_DataItemID = KPIListDataItem.ID;

--       -- Keep and store the DateTime to be used to flag all records
--       declare @CurrentDateTime as datetime = getdate() 

--       -- Now that we have the list of names let's process the copy RM_DataItem table
--       merge into #KPIDataItem as KPIDataItem
--       using #FinalLeaves fl
--       on KPIDataItem.Name = fl.Name
--       when not MATCHED THEN
--       	   INSERT (Id     , IndustryId, KPITypeId,   IsDebit, IsAggregate, Scale, ValueTypeId,CreatedBy,CreatedOn,Description,Name,IsSystemDefined,IsActive)
-- 	   VALUES (NEWID(),@IndustryID,@HIerarchyID,@IsDebit,@IsAggregare,@Scale,@ValueTypeID,

--       -- In case RM_DataItemID has not been populated // should only be called once and on the initial envt
--       -- the definition of NodeDefCompany has been modified accordingly 
--       update NodeDefCompany set RM_DataItemID = NEWID() where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and RM_DataItemID is null

--       -- 	  -- -------------------------------------------------------------------------------------------
--       -- -- Create a temporary table with all the final leaves for a given Hierarchy/Industry/Company
--       -- -- These are all the level1 when there is no level 2 and all level 2 for the company
--       -- -- -------------------------------------------------------------------------------------------
--       select * into #FinalLeaves from (
--       	     select Name,RM_DataItemID,ID,RM_NODE_ID,level from NodeDefCompany 
-- 					where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 2
--        	     	    union
--        	     select Name,RM_DataItemID,ID,RM_NODE_ID,level from NodeDefCompany 
-- 			        where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 1
--        				and ID not in (select ParentNodeDefID from Hierarchies)
--       ) as tmp

--       -- 	  select * from #FinalLeaves

--       --  -- Create the list of Unique Names with the ID that will be used to create RM_DataItem and Dim_RM_DataItem
--       --  select * into #FinalLeavesUniqueID from (select top 1 NEWID() as RM_DataItemID,Name from #FinalLeaves) as tmp
--       --  delete from #FinalLeavesUniqueID

--       --  -- Populate the structure with all the distinct Names 
--       --  merge into #FinalLeavesUniqueID Target
--       --  using (
--       --  	  select distinct Name from #FinalLeaves
--       --  ) x
--       --  	  on x.Name = Target.Name 
--       --  	  when not matched then 
--       --  	       insert VALUES (NEWID(),x.name) ;
      
--       -- Name unicity IS NO LONGER a key criteria at least in that series of test
--       merge into RainmakerLDCJP_OAT.dbo.RM_DataItem RM_DI
--       using (
--       	    select RM_DataItemID,Name,
-- 	    	   @IndustryID as IndustryID,@HierarchyID as KPITypeID,@IsDebit as IsDebit,@IsAggregate as IsAggregate,@Scale as Scale,
-- 			   @Description as Description,
-- 	    	   (select ID from RainmakerLDCJP_OAT.dbo.RMX_ValueType where Name = 'Numeric') as ValueTypeID
-- 	    from #FinalLeaves
-- 	    -- where level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID 
--       ) x
--       on x.RM_DataItemID = RM_DI.ID
--       WHEN NOT MATCHED then
--       	   INSERT (ID,IndustryID,KPITypeID,IsDebit,IsAggregate,Scale,ValueTypeID,Name,Description,createdOn,IsActive)
-- 	   VALUES (x.RM_DataItemID,x.IndustryID,x.KPITypeID,x.IsDebit,x.IsAggregate,x.Scale,x.ValueTypeID,x.Name,x.Description,getdate(),@IsActive) ;
      
--       -- Name unicity IS NO LONGER a key criteria at least in that series of test
--       merge into RainmakerLDCJP_OAT.dbo.Dim_RM_DataItem RM_DI
--       using (
--       	    select RM_DataItemID,Name,
-- 	    	   @IndustryID as IndustryID,@HierarchyID as KPITypeID,@IsDebit as IsDebit,@IsAggregate as IsAggregate,@Scale as Scale,
-- 		   @Description as Description,
-- 	    	   (select ID from RainmakerLDCJP_OAT.dbo.RMX_ValueType where Name = 'Numeric') as ValueTypeID,
-- 		   -- Add the InvIndustryID and the InvIndustryName
-- 		   (select InvIndustryID   from RainmakerLDCJP_OAT.dbo.RM_Industry where ID = @IndustryID) as InvIndustryID,
-- 		   (select InvIndustryName from RainmakerLDCJP_OAT.dbo.RM_Industry where ID = @IndustryID) as InvIndustryName
-- 	    from NodeDefCompany
-- 	    where level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID 
--       ) x
--       on x.Name = RM_DI.DataItemName and x.IndustryID = RM_DI.IndustryID and x.KPITypeId = RM_DI.KPITypeID
--       WHEN NOT MATCHED then
--       	   INSERT (DataItemID,IndustryID,KPITypeName,KPITypeID,IsDebit,IsAggregate,Scale,ValueTypeName,ValueTypeID,DataItemName,DataItemDescription,IsSystemDefined,IsActive,InvIndustryID,InvIndustryName)
-- 	   VALUES (x.RM_DataItemID,x.IndustryID,@HierarchyName,x.KPITypeID,x.IsDebit,x.IsAggregate,x.Scale,'Numeric',x.ValueTypeID,x.Name,x.Description,@IsSystemDefined,@IsActive,x.InvIndustryID,x.InvIndustryName) ;

-- END
-- GO

