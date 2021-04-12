-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-12 09:03:35 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_Node ] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) ,
@CollectionDate as date,@ScenarioName as varchar(100))
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
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID = @CompanyID )

      declare @WorkflowStatusID as nvarchar(36)
      set @WorkflowStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_WorkflowStatus where Name = 'Not Started')

      -- Extra WorkflowID
      declare @WorkflowID  as nvarchar(36)
      declare @NewWorkflow as int  -- 1 if New Workflow // 0 if Old workflow
      EXEC STG_DIA_Populate_RM_Workflow @HierarchyName,@IndustryName,@CompanyName,@CollectionDate,@ScenarioName
      -- Parameters in order to know if the RM_Workflow is created or no
      ,@WorkflowID OUTPUT,@NewWorkflow OUTPUT

      -- -------------------------------------------------------------------------
      -- Insert the nodes for all level in one go --> simpler and more efficient
      -- -------------------------------------------------------------------------
      -- We process in one go for the different layer ie.e NodeDef amd NodeDefIndustry
      select * into #ListNodesDataItemNames from (
      	     -- the longest category first
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefIndustry' as Category from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefCompany'  as Category from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDef'         as Category from NodeDef         where HierarchyID = @HierarchyID
      ) tmp

      -- We filter the nodes only leveraging Hierarchies and dropping Final Leaves
      select NEWID() as ID,*,NEWID() as ParentCollectionNodeID into #ListNodesNames from
      	     (select * from #ListNodesDataItemNames where ID in (select ParentNodeDefID from Hierarchies)) tmp

      -- Update the #ListNodesBames in order to be able to reflect the parent ID
      update #ListNodesNames set ParentCollectionNodeID = null where Category = 'NodeDef'

      -- Update the list with the reference of the parent
      merge into #ListNodesNames LNM
      using (
      	    select l1.ID as ID, l2.ID as ParentCollectionNodeID
	    from #ListNodesNames l1, Hierachies h, #ListNodesNames l2
	    where l1.STGID = h.NodeDefID and l2.STGID = h.ParentNodeDefID 
      ) x
      on x.ID = LNM.ID
      when matched then
      	   update set ParentCollectionNodeID = x.ParentCollectionNodeID;

     -- Add the nodes accordingly i.e insert if it is a new Workflow
     if (@NewWorkflow = 1) begin
     	INSERT into RainmakerLDCJP_OAT.dbo.RM_KPI_CollectionNode
           (  ID,  ParentCollectionNodeID,  NodeID,  KPITypeID,	WorkflowID,  Sequence)
	select ID,ParentCollectionNodeID,RM_Node_ID as NodeID,
      		@HierarchyID as KPITypeID,
      		@WorkflowID  as WorkflowID,
		Sequence
	 from #ListNodesName
	
     end
     
END
GO

