-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 16:20:31 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_DataItem] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
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

      declare @WorkflowStatusID as nvarchar(36)
      set @WorkflowStatusID = (select ID from RMX_WorkflowStatus where Name = 'Not Started')

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select ID from RM_Workflow where CompanyID = @CompanyID and EffectiveDate = @CollectionDate and WorkflowStatusID = @WorkflowStatusID)

      -- -------------------------------------------------------------------------------------------
      -- Create a temporary table with all the final leaves for a given Hierarchy/Industry/Company
      -- These are all the level1 when there is no level 2 and all level 2 for the company
      -- -------------------------------------------------------------------------------------------
      select * into #FinalLeaves from (
      	     select * from NodeDefCompany where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 2
      	     	    union
      	     select * from NodeDefCompany where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 1
      	     and ID not in (select ParentNodeDefID from Hierarchies)
      ) as tmp

      -- Add All Final Leaves level 2
      merge into RM_KPI_Collection_DataItem KCDI
      using(
	select RM_DataItem.ID as DataItemID,
	       KCN.ID as KPICollectionNodeID,
	       #FinalLeaves.SortOrder as Sequence
	from #FinalLeaves,RM_DataItem,Hierarchies H,NodeDefCompany NC,RM_KPI_Collection_Node KCN
	where RM_DataItem.KPITypeID = @HierarchyID and RM_DataItem.IndustryID = @IndustryID
	      and #FinalLeaves.Name = RM_DataItem.Name and #FinalLeaves.level = 2
	      and H.NodeDefID = #FinalLeaves.ID and H.ParentNodeDefID = NC.ID 
	      and KCN.NodeID = NC.RM_NODE_ID
	      and KCN.KPITypeID = @HierarchyID and KCN.WorkflowID = @WorkflowID
      ) x
      on x.KPICollectionNodeID = KCDI.KPICollectionNodeID and x.DataItemID = KCDI.DataItemID
      when NOT MATCHED then
      	   INSERT (ID,KPICollectionNodeID,DataItemID,Sequence)
	   VALUES (NEWID(),x.KPICollectionNodeID,x.DataItemID,x.Sequence) ;

	-- Add All final Leaves level 1
      merge into RM_KPI_Collection_DataItem KCDI
      using(
	select RM_DataItem.ID as DataItemID,
	       KCN.ID as KPICollectionNodeID,
	       #FinalLeaves.SortOrder as Sequence
	from #FinalLeaves,RM_DataItem,Hierarchies H,NodeDefIndustry NI,RM_KPI_Collection_Node KCN
	where RM_DataItem.KPITypeID = @HierarchyID and RM_DataItem.IndustryID = @IndustryID
	      and #FinalLeaves.Name = RM_DataItem.Name and #FinalLeaves.level = 1
	      and H.NodeDefID = #FinalLeaves.ID and H.ParentNodeDefID = NI.ID 
	      and KCN.NodeID = NI.RM_NODE_ID
	      and KCN.KPITypeID = @HierarchyID and KCN.WorkflowID = @WorkflowID
      ) x
      on x.KPICollectionNodeID = KCDI.KPICollectionNodeID and x.DataItemID = KCDI.DataItemID
      when NOT MATCHED then
      	   INSERT (ID,KPICollectionNodeID,DataItemID,Sequence)
	   VALUES (NEWID(),x.KPICollectionNodeID,x.DataItemID,x.Sequence) ;

	   
END
GO

