/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-06 10:21:15 jpdur"
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
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- Determine the StartMonthCollectionDate
      declare @StartMonthCollectionDate as date 
      set @StartMonthCollectionDate = DATEADD(DAY, 1, EOMONTH(@CollectionDate, -1))

      -- Determine the Workflow ID - currently supposed to have been created
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select ID from RainmakerLDCJP_OAT.dbo.RM_Workflow 
                     where CompanyID in (select ID from RainmakerLDCJP_OAT.dbo.RM_Company where InvCompanyName = @CompanyName) 
                          and KPICategoryID in (select ID from RainmakerLDCJP_OAT.dbo.RMX_KpiCategory where Name = 'Financials')
						  and EffectiveDate = @StartMonthCollectionDate)

      -- Capture the KPICollectionBatchID
      declare @KPICollectionBatchID as nvarchar(36)
      set @KPICollectionBatchID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch where ReportingDate = @CollectionDate
      	  and KPITypeID in (select ID from RainmakerLDCJP_OAT.dbo.RMX_KpiType where Name = @HierarchyName)
	  and CompanyID in (select ID from RainmakerLDCJP_OAT.dbo.RM_Company where InvCompanyName = @CompanyName) 
	  and ScenarioTypeId in (select ID from RainmakerLDCJP_OAT.dbo.RM_ClassType where Name = @ScenarioName)
	  and WorkflowID in (select ID from RainmakerLDCJP_OAT.dbo.RM_Workflow 
                          where CompanyID in (select ID from RainmakerLDCJP_OAT.dbo.RM_Company where InvCompanyName = @CompanyName) 
                          and KPICategoryID in (select ID from RainmakerLDCJP_OAT.dbo.RMX_KpiCategory where Name = 'Financials')
						  and EffectiveDate = @StartMonthCollectionDate)
	  and BatchStatusID in (select ID from RainmakerLDCJP_OAT.dbo.RMX_BatchStatus where Name = 'Draft')
	  and CollectionPeriodId in (select ID from RainmakerLDCJP_OAT.dbo.RMX_CollectionPeriod where Name = 'Monthly'))

	  -- Extract based on the company config the list of Nodes to be processed
	  select *,NEWID() as KPICollectionNodeID,NEWID() as KPIParentCollectionNodeID
	  	 into #ListNodes
	  from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation
	  where KPICompanyConfigurationID = @KPICompanyConfigurationID and isChecked = 1

	  -- Now let's process in fixed 3 stages, it should actually be a loop
	  select * into #TopNodes from #ListNodes where NodeID in (select ID from RainmakerLDCJP_OAT.dbo.RM_Node where ParentNodeId is null)
	  update #ListNodes set KPIParentCollectionNodeID = null where NodeId in (select NodeID from #TopNodes)

	  -- Let's process to the next level 
	  select l1.*,l0.KPICollectionNodeID as ActualParent into #Level1Nodes
	  	 from #ListNodes l1,RainmakerLDCJP_OAT.dbo.RM_Node r1 ,#TopNodes l0
	  where l1.NodeID = r1.ID and r1.ParentNodeID = l0.NodeID

	  merge into #ListNodes as target
	  using (
	  	select * from #Level1Nodes
	  ) x
	  on x.NodeID = target.NodeID
	  when matched then
	       update set KPIParentCollectionNodeID = x.ActualParent;

	  -- Let's process to the next level 
	  select l1.*,l0.KPICollectionNodeID as ActualParent into #Level2Nodes
	  	 from #ListNodes l1,RainmakerLDCJP_OAT.dbo.RM_Node r1 ,#Level1Nodes l0
	  where l1.NodeID = r1.ID and r1.ParentNodeID = l0.NodeID

	  merge into #ListNodes as target
	  using (
	  	select * from #Level2Nodes
	  ) x
	  on x.NodeID = target.NodeID
	  when matched then
	       update set KPIParentCollectionNodeID = x.ActualParent;

	  -- Let's process to the next level 
	  select l1.*,l0.KPICollectionNodeID as ActualParent into #Level3Nodes
	  	 from #ListNodes l1,RainmakerLDCJP_OAT.dbo.RM_Node r1 ,#Level2Nodes l0
	  where l1.NodeID = r1.ID and r1.ParentNodeID = l0.NodeID

	  merge into #ListNodes as target
	  using (
	  	select * from #Level3Nodes
	  ) x
	  on x.NodeID = target.NodeID
	  when matched then
	       update set KPIParentCollectionNodeID = x.ActualParent;

	  -- Now insert into the destination table step by step if not ==> reference fails
	  insert into  RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
	  	 select KPICollectionNodeID as ID,@WorkflowID as WorkflowID,NodeID,KPIParentCollectionNodeID,@HierarchyID as KPITypeID,Sequence from #ListNodes where NodeId in (select NodeId from #TopNodes)
          insert into  RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
	  	 select KPICollectionNodeID as ID,@WorkflowID as WorkflowID,NodeID,KPIParentCollectionNodeID,@HierarchyID as KPITypeID,Sequence from #ListNodes where NodeId in (select NodeId from #Level1Nodes)
          insert into  RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
	  	 select KPICollectionNodeID as ID,@WorkflowID as WorkflowID,NodeID,KPIParentCollectionNodeID,@HierarchyID as KPITypeID,Sequence from #ListNodes where NodeId in (select NodeId from #Level2Nodes)
          insert into  RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
	  	 select KPICollectionNodeID as ID,@WorkflowID as WorkflowID,NodeID,KPIParentCollectionNodeID,@HierarchyID as KPITypeID,Sequence from #ListNodes where NodeId in (select NodeId from #Level3Nodes)


	 -- Select all the DataItems which have been selected 
	 select * into #ListDataItems from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeDataItemAssociation
	 	where KPICompanyConfigurationID = @KPICompanyConfigurationID and isChecked = 1

         -- To that list we add the KPICollectionNodeId by leveraging the presviously created table #ListNodes
	 select NEWID() as KPICollectionDataItemID,* into #ListDataItemsLinked from
	 ( select
	       l.*,ln.KPICollectionNodeID from #ListDataItems l, #ListNodes ln
	        where ln.ID = l.KPICompanyConfigNodeAssociationID
	 ) as tmp

	 -- Insert into the RM_KPI_Collection_DataItem
	 insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem
	 	select KPICollectionDataItemID,KPICollectionNodeID,DataItemId,Sequence from #ListDataItemsLinked
	 
	 -- As we do not use Attributes/Dimensions
	 select NEWID() as KPICollectionDimensionID,l.* into #ListDimension from #ListDataItemsLinked l

	 -- Insert the records accordingly
	 insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension
	 	select KPICollectionDimensionID,KPICollectionDataItemID,null as AttributeID, null as ParentKPICollectionDimensionID, 0 as Sequence from #ListDimension

	 -- For the characteristics of the Batch - let's display the actual values that we are looking for
	 select  dbo.PS_STG_GetDataPointValue_Num(NC.ID, @CompanyID, @ScenarioName, @CollectionDate) as Value,l.*
	 	 into #ListDataItemsLinkedValue
	 	 from #ListDimension l, NodeDefCompany NC
	 where NC.RM_DataItemID = l.DataItemID

	 -- select * from #ListDataItemsLinkedValue

	 -- Upload the KPI_Collection_Batch_Dimension with the values captured
	 -- Id	KPICollectionBatchId	KPICollectionDimensionId	EffectiveDate	Amount	Percentage	Ratio
	 insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension
	 	select NEWID() as ID,@KPICollectionBatchID as KPICollectionBatchID, KPICollectionDimensionID,
		       @CollectionDate as EffectiveDate,Value as Amount,null as Percentage,null as Ratio
		       from #ListDataItemsLinkedValue


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

