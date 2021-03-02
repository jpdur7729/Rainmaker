-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-02 07:15:19 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_Batch_Dimension] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100),
@CollectionDate as date,@Scenario as varchar(100))
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

      -- Extra Parameters or Default Value
      declare @ScenarioTypeID as nvarchar(36)
      set @ScenarioTypeID = (select ID from RM_ClassType where Name = 'Default')

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select top 1 ID from RM_Workflow)

      -- Extra AttributeID
      declare @AttributeID as nvarchar(36)
      set @AttributeID = (select ID from RM_Attribute where Name = 'Default')

      -- Determine KPICollectionBatchID
      declare @KPICollectionBatchID as nvarchar(36)
      set @KPICollectionBatchID = (select ID from RM_KPI_Collection_Batch
      	  where KPITypeID = @HierarchyID and WorkflowID = @WorkflowID
	  	and CompanyID = @CompanyID and ReportingDate = @CollectionDate
		and ScenarioTypeID = @ScenarioTypeID)

     select 'ID',@KPICollectionBatchID

     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- Create intermediate table using only STG data with the DataPoints Value
     -- to be used accordingly
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     select * into #ExtractNodesValues from (
select Hierarchy,Level1,IndustryLevel,CompanyLevel1,coalesce(CompanyLevel2,'') as CompanyLevel2,coalesce(AmountL2,AmountL1) as Amount
     -- ,SOL1,SOL2,SOL3,SortOrderCL2
     ,coalesce(NodeDefID2,NodeDefID1) as NodeDefID
from
       (select hlist.Name as 'Hierarchy',n2.Name as 'Level1',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,
	   h4.NodeDefID as NodeDefID,
	   dbo.PS_STG_GetDataPointValue_Num(n4.ID, @CompanyID, @Scenario, @CollectionDate) as AmountL1,
	   n4.ID as NodeDefID1
       -- n2.SortOrder as SOL1,n3.SortOrder as SOL2,n4.SortOrder as SOL3
       from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist
       where hlist.ID = @HierarchyID 
	   and h2.ParentNodeDefID = @HierarchyID
       	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
       	   and h3.ParentNodeDefID = h2.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
       	   and h4.ParentNodeDefID = h3.NodeDefID
       	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID and n4.level = 1)
	   Extract1
left join
     (	select n5.Name as CompanyLevel2,n5.SortOrder as SortOrderCL2, h5.ParentNodeDefID as ParentNodeDefID,
     	       dbo.PS_STG_GetDataPointValue_Num(n5.ID, @CompanyID, @Scenario, @CollectionDate) as AmountL2,
	       n5.ID as NodeDefID2

	       from Hierarchies h5, NodeDefCompany n5
       	   where n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2)
	   Extract2
      on Extract2.ParentNodeDefID = Extract1.NodeDefID
) as tmp

-- Check Contents
select * into #Extract2 from (select case WHEN CompanyLevel2 = '' then CompanyLevel1 else CompanyLevel2 end as Name,Amount,NodeDefID from #ExtractNodesValues) as tmp

--select count(*) from (select distinct Name from #Extract2) as tmp
--select * from #Extract2

-- Similar approach used for Collection_DataItem
select * into #Extract_Collection_DataItem from (
	select RM_DataItem.ID as DataItemID,
	       KCN.ID as KPICollectionNodeID,
	       #Extract2.Amount
	from #Extract2,RM_DataItem,Hierarchies H,NodeDefIndustry NI,RM_KPI_Collection_Node KCN
	where RM_DataItem.KPITypeID = @HierarchyID and RM_DataItem.IndustryID = @IndustryID
	      and #Extract2.Name = RM_DataItem.Name --and #FinalLeaves.level = 1
	      and H.NodeDefID = #Extract2.NodeDefID and H.ParentNodeDefID = NI.ID 
	      and KCN.NodeID = NI.RM_NODE_ID
	      and KCN.KPITypeID = @HierarchyID and KCN.WorkflowID = @WorkflowID
union
	select RM_DataItem.ID as DataItemID,
	       KCN.ID as KPICollectionNodeID,
	       #Extract2.Amount
	from #Extract2,RM_DataItem,Hierarchies H,NodeDefCompany NC,RM_KPI_Collection_Node KCN
	where RM_DataItem.KPITypeID = @HierarchyID and RM_DataItem.IndustryID = @IndustryID
	      and #Extract2.Name = RM_DataItem.Name --and #FinalLeaves.level = 1
	      and H.NodeDefID = #Extract2.NodeDefID and H.ParentNodeDefID = NC.ID 
	      and KCN.NodeID = NC.RM_NODE_ID
	      and KCN.KPITypeID = @HierarchyID and KCN.WorkflowID = @WorkflowID
) as tmp

select * from #Extract_Collection_DataItem

-- Create the data ready to be inserted
select * into #Result from (
select @KPICollectionBatchID as KPICollectionBatchID,KCD.ID as KPICollectionDimensionID,@CollectionDate as EffectiveDate,Extract.Amount
from #Extract_Collection_DataItem Extract, RM_KPI_Collection_DataItem KCDI, RM_KPI_Collection_Dimension KCD
where KCDI.KPICollectionNodeID = Extract.KPICollectionNodeID
and KCDI.DataItemID = Extract.DataItemID
and KCD.KPICollectionDataItemID = KCDI.ID ) as tmp


merge into RM_KPI_Collection_Batch_Dimension KCBD
using (
select * from #Result
) x
on x.KPICollectionBatchID = KCBD.KPICollectionBatchID and x.KPICollectionDimensionID = KCBD.KPICollectionDimensionID and x.EffectiveDate = KCBD.EffectiveDate
when not Matched THEN
     INSERT (ID,KPICollectionBatchID,KPICollectionDimensionID,EffectiveDate,Amount) 
     VALUES (NEWID(),x.KPICollectionBatchID,x.KPICollectionDimensionID,x.EffectiveDate,x.Amount)
     ;
-- when MATCHED then
--      UPDATE set Amount = x.Amount ;

END
GO

