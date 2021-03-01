-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 15:44:39 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_Node ] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
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

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select top 1 ID from RM_Workflow)

      -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      -- 2 stages: 1 Insert the nodes with their description/sequence // No ParentKPICollectionNodeID
      --           2 Add the link with the parent record
      -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      -- Step 1+2 for NodeDef 
      merge into RM_KPI_Collection_Node KCN
      using (
      	    select @WorkflowID as WorkflowID, RM_NODE_ID as NodeID,
	    	   null as ParentKPICollectionNodeId,@HierarchyID as KPITypeID,SortOrder as Sequence
      	    from NodeDef where HierarchyID = @HierarchYID
      ) x
      on x.WorkflowID = KCN.WorkflowID and x.KPITypeID = KCN.KPITypeID and x.NodeID = KCN.NodeID
      when NOT MATCHED then
      	   INSERT (ID,WorkflowID,NodeID,ParentKPICollectionNodeId,KPITypeID,Sequence)
	   VALUES (NEWID(),x.WorkflowID,x.NodeID,x.ParentKPICollectionNodeId,x.KPITypeID,x.Sequence) ;

      -- Step 1+2 for NodeDefIndustry 
      merge into RM_KPI_Collection_Node KCN
      using (
      	    select @WorkflowID as WorkflowID, NI.RM_NODE_ID as NodeID,
	    	   KCN.ID as ParentKPICollectionNodeId,@HierarchyID as KPITypeID,NI.SortOrder as Sequence
      	    from NodeDefIndustry NI,NodeDef NH,Hierarchies H,RM_KPI_Collection_Node KCN
	    where NI.HierarchyID = @HierarchYID and NI.IndustryID = @IndustryID
	    	  and H.NodeDefID = NI.ID and H.ParentNodeDefID = NH.ID
		  and NH.RM_NODE_ID = KCN.NodeID 
      ) x
      on x.WorkflowID = KCN.WorkflowID and x.KPITypeID = KCN.KPITypeID and x.NodeID = KCN.NodeID
      when NOT MATCHED then
      	   INSERT (ID,WorkflowID,NodeID,ParentKPICollectionNodeId,KPITypeID,Sequence)
	   VALUES (NEWID(),x.WorkflowID,x.NodeID,x.ParentKPICollectionNodeId,x.KPITypeID,x.Sequence) ;

      -- Step 1+2 for NodeDefCompany --> Suppressing the FinalLeaves from NodeDefCompany
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

      -- select 'Final',* from #FinalLeaves
      
      select * into #FilteredNodeDefCompany from (
      	     select * from NodeDefCompany
	     where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
	     	   and ID not in (select ID From #FinalLeaves)
      ) as tmp

      -- select 'Filtered',* from #FilteredNodeDefCompany 

      -- A priori we only have left level=1 elements at NodeDefCompany
      merge into RM_KPI_Collection_Node KCN
      using (
      	    select @WorkflowID as WorkflowID, NC.RM_NODE_ID as NodeID,
	    	   KCN.ID as ParentKPICollectionNodeId,@HierarchyID as KPITypeID,NC.SortOrder as Sequence
      	    from #FilteredNodeDefCompany NC,NodeDefIndustry NI,Hierarchies H,RM_KPI_Collection_Node KCN
	    where NC.HierarchyID = @HierarchYID and NC.IndustryID = @IndustryID
	    	  and H.NodeDefID = NC.ID and H.ParentNodeDefID = NI.ID
		  and NI.RM_NODE_ID = KCN.NodeID 
      ) x
      on x.WorkflowID = KCN.WorkflowID and x.KPITypeID = KCN.KPITypeID and x.NodeID = KCN.NodeID
      when NOT MATCHED then
      	   INSERT (ID,WorkflowID,NodeID,ParentKPICollectionNodeId,KPITypeID,Sequence)
	   VALUES (NEWID(),x.WorkflowID,x.NodeID,x.ParentKPICollectionNodeId,x.KPITypeID,x.Sequence) ;

END
GO

