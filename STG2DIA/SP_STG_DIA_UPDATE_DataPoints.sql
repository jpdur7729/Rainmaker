/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-20 12:06:21 jpdur"
   ------------------------------------------------------------------------------ */

-- We assume that the Collection_Batch_Dimension has been populated
-- Let's udate the data accordingly
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_UPDATE_DataPoints] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
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

	 -- ---------------------------------------------------
	 -- Update the Collection_Batch_Dimension Table 
	 -- ---------------------------------------------------
	 
	 -- Identify the DataItems i.e. Final Leaves to be used and capture the values
         select * into #ListNodesDataItemNames from (
      	     -- the longest category first
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefIndustry' as Category from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefCompany'  as Category from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDef'         as Category from NodeDef         where HierarchyID = @HierarchyID
         ) tmp

	 -- We keep only the Final Leaves of the full list of Leaves
         select *,convert(decimal(18,7),0.0) as Value into #ListDataItemsWithValues from (select * from #ListNodesDataItemNames where STGID not in (select ParentNodeDefID from Hierarchies)) tmp
	 update #ListDataItemsWithValues set Value = convert(decimal(18,7),dbo.PS_STG_GetDataPointValue_Num(STGID, @CompanyID, @ScenarioName, @CollectionDate))

	 select * from #ListDataItemsWithValues

	 -- Identify the Data in Collection_Batch_Dimension in order to identify the records to be updated
	 select * into #ListCollectionNodes     from (select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node            where KPITypeID = @HierarchyID and WorkflowID = @WorkflowID                )  tmp
	 select * into #ListCollectionDataItem  from (select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem        where KPICollectionNodeID      in (select ID from #ListCollectionNodes    )) tmp
	 select * into #ListCollectionDimension from (select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension       where KPICollectionDataItemID  in (select ID from #ListCollectionDataItem )) tmp
	 select * into #ListCollectionValues    from (select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension where KPICollectionDimensionID in (select ID from #ListCollectionDimension)) tmp

	 -- We add the fullpath to all the data previously Identified
	 select *,dbo.STG_DIA_FullPathName(KPICollectionDimensionID) as FullPath into #UpdatedList from #ListCollectionValues

	 -- We now update the list with the selectted list
	 merge into #UpdatedList updlist
	 using (
	       select FullPath,Value from #ListDataItemsWithValues
	 ) x
	 on x.FullPath = updlist.FullPath
	 when matched then
	      update set Amount = x.Value;

	 select * from #UpdatedList

	 -- We now update the RM_KPI_Collection_Batch_Dimension
	  merge into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension KCBD
	  using #UpdatedList x
	  on x.ID = KCBD.ID
	  when matched then
	       update set Amount = x.Amount;


	 -- -- We now create the list which will join based on the FullPath
	 -- select *,convert(decimal(18,7),0.0) as Value into #ListDimensionWithValue from (
	 -- 	select lp.*,ln.STGID from #ListDimensionWithPath lp,#ListNodesDataItemNames ln
	 -- 	where lp.FullPath = ln.FullPath	
	 -- ) tmp

	 -- -- select *,dbo.PS_STG_GetDataPointValue_Num(STGID, @CompanyID, @ScenarioName, @CollectionDate) from #ListDimensionWithValue

	 -- -- Capture the Data Points into the taable
	 -- update #ListDimensionWithValue set Value = convert(decimal(18,7),dbo.PS_STG_GetDataPointValue_Num(STGID, @CompanyID, @ScenarioName, @CollectionDate))
	 
	 -- -- Upload the KPI_Collection_Batch_Dimension with the values captured
	 -- -- Id	KPICollectionBatchId	KPICollectionDimensionId	EffectiveDate	Amount	Percentage	Ratio
	 -- insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension
	 -- 	select NEWID() as ID,@KPICollectionBatchID as KPICollectionBatchID, KPICollectionDimensionID,
	 -- 	       @CollectionDate as EffectiveDate,Value as Amount,null as Percentage,null as Ratio
	 -- 	       from #ListDimensionWithValue

END
GO







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




