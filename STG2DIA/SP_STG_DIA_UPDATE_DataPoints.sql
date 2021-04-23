/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-21 08:47:35 jpdur"
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

	 -- Prepare the mapping to be done 
	 DECLARE @tab table (ColNum int, Name varchar(200),ID varchar(36),FullPath varchar(1000),Category varchar(100))

	 -- Generate a table in order to process the mapping 
	 insert INTO @tab  
	 EXEC Mapping @HierarchyName, @IndustryName, @CompanyName, @StartMonthCollectionDate,@ScenarioName

	 -- Debug only - do not delete
	 select * from @Tab

	 select 'Nb Records',count(*) from #ListCollectionValues

	 -- We have now brought together the data
	 select * into #Step1 from (select lcv.*,lcd.KPICollectionNodeID,lcd.DataItemID from #ListCollectionValues lcv,#ListCollectionDimension lcdim,#ListCollectionDataItem lcd
	 	       	       	    	    where lcv.KPICollectionDimensionID = lcdim.ID and lcd.ID = lcdim.KPICollectionDataItemID) tmp

	 select 's1',* from #Step1

	 select * into #Step2 from (select Name as NameDataItem,s1.* from RainmakerLDCJP_OAT.dbo.RM_DataItem RDI,#Step1 s1 where s1.DataItemID = RDI.ID) tmp

	 select 's2',* from #Step2

	 select *,replicate('z',1500) as CompletePath into #Step3 from (select s2.*,tab.ColNum,tab.FullPath,tab.Category from #Step2 s2,@tab tab where s2.KPICollectionNodeID = tab.ID) tmp
	 update #Step3 set CompletePath = FullPath+'/'+NameDataItem

	 -- Now Step3 has the uniquely identified path corresponding to the value and we can
	 -- prepare a merge in order to 

	 -- We now update the list with the selectted list
	 merge into #Step3 updlist
	 using (
	       select FullPath,Value from #ListDataItemsWithValues
	 ) x
	 on x.FullPath = updlist.CompletePath
	 when matched then
	      update set Amount = x.Value;

	 select * from #Step3

	  -- We now update the RM_KPI_Collection_Batch_Dimension
	   merge into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension KCBD
	   using #Step3 x
	   on x.ID = KCBD.ID
	   when matched then
	        update set Amount = x.Amount;


-- Previous Version
	 -- -- We add the fullpath to all the data previously Identified
	 -- select *,dbo.STG_DIA_FullPathName(KPICollectionDimensionID) as FullPath into #UpdatedList from #ListCollectionValues

	 -- -- We now update the list with the selectted list
	 -- merge into #UpdatedList updlist
	 -- using (
	 --       select FullPath,Value from #ListDataItemsWithValues
	 -- ) x
	 -- on x.FullPath = updlist.FullPath
	 -- when matched then
	 --      update set Amount = x.Value;

	 -- select * from #UpdatedList

	 -- -- We now update the RM_KPI_Collection_Batch_Dimension
	 --  merge into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension KCBD
	 --  using #UpdatedList x
	 --  on x.ID = KCBD.ID
	 --  when matched then
	 --       update set Amount = x.Amount;

-- End Previous version 

END
GO
