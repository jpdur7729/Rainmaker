/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-13 08:37:47 jpdur"
   ------------------------------------------------------------------------------ */

-- Objective is to upload all the datapoints corresponding to a series/Collection i.e.
-- for a Hierarchy/Industry/Company and a Date
-- v1 By default // Monthly- Draft - Financials ==> To be improved in future version
-- based on the E004 model where FinalLeaves are by definition L1(No children) + L2

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Approach: Extract the list of Nodes based on
-- 1) RM_KPICompanyConfigNodeAssociation
-- and then filtered via RM_Node in order to know the different level of the nodes via Top/L1/L2/L3
-- 2) RM_KPICompanyConfigNodeDataItemAssociation
-- 3) Dimension step is de facto skipped as Dimensions are not currently used
-- 4) Get the data value -- Link with the data copied as part of the staging -->
--    main isse as we have to remap it back to the data in the staging area
--    only possible mapping is actually based on the name (assumed to be unique so no big deal)
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Mapping currently relies on the fact that the RM_DataItemID is found in NodeDefCompany
-- 	 where NC.RM_DataItemID = l.DataItemID
-- i.e the ID in RM_DataItem is stored in NodeDefCompany as DataItemId
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- What about the reuse ??? --> It would imply that the remapping has to be done each time the process
-- is executed. Only condition so that we can remap for each company as the DataItem can be reused for
-- different companies at different places within the structure
-- TBC with Orange and the DataPpoints created initially for Teleline
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- --> Difficulty in order to link to the DataPoints if the creation of the industry/company
-- has not been made through the staging area ==> Mapping is lost ???
-- How to be able to properly identify if the name is not unique (or an easy identifier) 
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Upload_DataPoints] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
@ScenarioName as varchar(100), @CollectionDate as date)
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
      declare @KPICompanyTemplateID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyTemplateID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID = @CompanyID )

      -- Determine the StartMonthCollectionDate
      declare @StartMonthCollectionDate as date 
      set @StartMonthCollectionDate = DATEADD(DAY, 1, EOMONTH(@CollectionDate, -1))

      -- Determine the Workflow ID - created if required 
      declare @WorkflowID  as nvarchar(36)
      declare @NewWorkflow as int
      EXEC STG_DIA_Populate_RM_Workflow @HierarchyName, @IndustryName, @CompanyName, @StartMonthCollectionDate, @ScenarioName, @WorkflowID OUTPUT,@NewWorkflow OUTPUT

	  -- Capture the KPICollectionBatchID - create it if necessary
      declare @KPICollectionBatchID  as nvarchar(36)
      declare @NewKPICollectionBatch as int
      EXEC STG_DIA_Populate_RM_KPI_Collection_Batch @HierarchyName,@IndustryName,@CompanyName,
						    @CollectionDate,@ScenarioName,
						    -- OUTPUT Parameters 
						    @KPICollectionBatchID OUTPUT,@NewKPICollectionBatch OUTPUT

	 -- --------------------------------------------------------------------------
         -- Step 0 Delete all the structure for the given batch --> Insert directly
	 -- --------------------------------------------------------------------------
	 EXEC STG_DIA_Delete_DataPoints @WorkflowID
	 
	 -- -------------------------------------------------
         -- Step 1 CMP_NodeAssociation -> Collection_Node
	 -- -------------------------------------------------

	  -- Extract based on the company config the list of Nodes to be processed
	  select *,NEWID() as KPICollectionNodeID
	  	 into #ListNodes
	  from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation
	  where KPICompanyTemplateID = @KPICompanyTemplateID and isChecked = 1

	  -- Create the list where the parents have been addead accordingly
	  select * into #ListNodesWithParents from (
	  	 select l1.*,lp.KPICollectionNodeID as KPIParentCollectionNodeID
		 	from #ListNodes l1,#ListNodes lp
			where l1.ParentNodeAssociationID = lp.ID
			      and l1.ParentNodeAssociationID is not null 
	         union
		 -- Sort out the top level where the parent is null
		 select l1.*,null as KPIParentCollectionNodeID
		 	from #ListNodes l1 where ParentNodeAssociationID is null
	  ) tmp
	  
	  -- Now insert into the destination table step by step if not ==> reference fails
	  insert into  RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
	  	 select KPICollectionNodeID as ID,@WorkflowID as WorkflowID,NodeID,KPIParentCollectionNodeID,@HierarchyID as KPITypeID,Sequence from #ListNodesWithParents
		 
	 -- -------------------------------------------------------------
         -- Step 2 CMP_NodeDataItemAssociation -> Collection_DataItems 
	 -- -------------------------------------------------------------

	 -- Select all the DataItems which have been selected 
	 select * into #ListDataItems
	 	from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeDataItemAssociation
	 	where NodeAssociationID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation where KPICompanyTemplateID = @KPICompanyTemplateID and isChecked = 1)
		      and IsChecked = 1

         -- To that list we add the KPICollectionNodeId by leveraging the presviously created table #ListNodes
	 select NEWID() as KPICollectionDataItemID,* into #ListDataItemsLinked from
	 ( select
	       l.*,ln.KPICollectionNodeID from #ListDataItems l, #ListNodes ln
	        where ln.ID = l.NodeAssociationID
	 ) as tmp

	 -- Insert into the RM_KPI_Collection_DataItem
	 insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem
	 	select KPICollectionDataItemID,KPICollectionNodeID,DataItemId,Sequence from #ListDataItemsLinked
	 
	 -- -------------------------------------------------------------
         -- Step 3 Collection_Dimension (Dimension Not used)
	 -- -------------------------------------------------------------
	 
	 -- As we do not use Attributes/Dimensions
	 select NEWID() as KPICollectionDimensionID,l.* into #ListDimension from #ListDataItemsLinked l

	 -- Insert the records accordingly
	 insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension
	 	select KPICollectionDimensionID,KPICollectionDataItemID,null as AttributeID, null as ParentKPICollectionDimensionID, 0 as Sequence from #ListDimension

	 -- -------------------------------------------------------------
         -- Step 4 Add the DataPoints into Collection_Batch_Dimension
	 -- -------------------------------------------------------------

	 -- Extract the Full Path for the Data in #ListDataItemsLinked
	 select *,dbo.STG_DIA_FullPathName(KPICollectionDimensionID) as FullPath into #ListDimensionWithPath from #ListDimension

	 -- Now we need to use the join with the relevant Data from NodeDef Tables
         select * into #ListNodesDataItemNames from (
      	     -- the longest category first
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefIndustry' as Category from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefCompany'  as Category from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDef'         as Category from NodeDef         where HierarchyID = @HierarchyID
         ) tmp

	 -- We now create the list which will join based on the FullPath
	 select *,convert(decimal(18,7),0.0) as Value into #ListDimensionWithValue from (
	 	select lp.*,ln.STGID from #ListDimensionWithPath lp,#ListNodesDataItemNames ln
		where lp.FullPath = ln.FullPath	
	 ) tmp

	 -- select *,dbo.PS_STG_GetDataPointValue_Num(STGID, @CompanyID, @ScenarioName, @CollectionDate) from #ListDimensionWithValue

	 -- Capture the Data Points into the taable
	 update #ListDimensionWithValue set Value = convert(decimal(18,7),dbo.PS_STG_GetDataPointValue_Num(STGID, @CompanyID, @ScenarioName, @CollectionDate))
	 
	 -- Upload the KPI_Collection_Batch_Dimension with the values captured
	 -- Id	KPICollectionBatchId	KPICollectionDimensionId	EffectiveDate	Amount	Percentage	Ratio
	 insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension
		select NEWID() as ID,@KPICollectionBatchID as KPICollectionBatchID, KPICollectionDimensionID,
		       @CollectionDate as EffectiveDate,Value as Amount,null as Percentage,null as Ratio
		       from #ListDimensionWithValue









-- OLD PART TO BE DELETED at some point 
      -- -- Part 1 Create the Final Leaves intermediate table
      -- select * into #FinalLeaves from (
      -- 	     select * from NodeDefCompany where level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
      -- 	     union 
      -- 	     select * from NodeDefCompany where level = 1 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
      -- 	     	      and ID not in (select ParentNodeDefID from Hierarchies) 
      -- ) as tmp

      -- -- Part 2 create the list of the RM_NODE_ID for the Parents of the FinalLeaves
      -- select * into #ParentNodeIdLIST from (
      -- 	     select NC.RM_Node_ID as ParentNodeID,FL.*
      -- 	     	    from NodeDefCompany NC,Hierarchies,#FinalLeaves FL
      -- 	     	    where Hierarchies.NodeDefID = FL.ID and NC.ID = Hierarchies.ParentNodeDefID and FL.level = 2
      -- 	     union 	    	
      -- 	     select NI.RM_Node_ID as ParentNodeID,FL.*
      -- 	     	    from NodeDefIndustry NI,Hierarchies,#FinalLeaves FL
      -- 	     	    where Hierarchies.NodeDefID = FL.ID and NI.ID = Hierarchies.ParentNodeDefID and FL.level = 1
      -- ) as tmp

      -- 	  select @HierarchyID as KPITypeID,@WorkflowID as WorkflowID,@KPICollectionBatchID as KPICollectionBatchID,* from #ParentNodeIdLIST 
      -- 	  RETURN

      -- -- Extract the list of the KPICollectionNodeID for the Parent of DataItem ID
      -- select * into #KPIParentCollectionNode from (
      -- 	     select KCN.ID as KPICollectionNodeIDParentDataItem, PL.* 
      -- 		        from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node KCN,#ParentNodeIdLIST PL
      -- 	     	    where KCN.NodeID = PL.ParentNodeID and KPITypeID = @HierarchyID and WorkflowID = @WorkflowID
      -- 	  ) as tmp

      -- 	  select 'KPIParentCollectionNode',* from #KPIParentCollectionNode 

      -- 	  --RETURN

      -- -- Extract the list of the IDs from Collection_DataItem
      -- select * into #KPICollectionNodeDataItem from (
      -- 	     select KCDI.ID as KPICollectionNodeDataItemID,KCN.*
      -- 	     	    from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem KCDI,#KPIParentCollectionNode KCN
      -- 	     	    where KCDI.DataItemID = KCN.RM_DataItemID and KCDI.KPICollectionNodeID = KCN.KPICollectionNodeIDParentDataItem
      -- ) as tmp

      -- 	  select 'KPICollectionNodeDataItem ',* from #KPICollectionNodeDataItem 

      -- -- Extract the list of the IDs from Collection_Dimension
      -- select * into #KPICollectionDimension from (
      -- 	     select KCDI.ID as KPICollectionDimensionID,KCNDI.*
      -- 	     	    from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem KCDI,#KPICollectionNodeDataItem KCNDI
      -- 	     	    where KCDI.KPICollectionNodeID = KCNDI.KPICollectionNodeDataItemID
      -- ) as tmp

      -- 	 select @KPICollectionBatchID as CollectionBatchID,* from #KPICollectionDimension

      -- -- Extract the list of the IDs from Collection_Batch_Dimension
      -- select * into #KPICollectionBatchDimension from (
      -- 	     select KCBD.ID as KPICollectionBatchDimensionID,KCD.*
      -- 	     from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension KCBD,#KPICollectionDimension KCD
      -- 	      where KCBD.KPICollectionDimensionID = KCD.KPICollectionDimensionID
      -- 	     	   and KPICollectionBatchID = @KPICollectionBatchID
      -- 		   and EffectiveDate = @CollectionDate
      -- ) as tmp 

      -- -- Extract the data from the KPI_Collection_Batch_Dimension
      -- select * from #KPICollectionBatchDimension

END
GO

