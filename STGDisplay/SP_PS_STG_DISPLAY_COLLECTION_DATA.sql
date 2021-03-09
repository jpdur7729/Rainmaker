-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-02 14:58:23 jpdur"
-- ------------------------------------------------------------------------------

-- -----------------------------------------------------------------
-- Display Hierarchy for IncomeStatement/Balance Sheet + Industry
-- -----------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_DISPLAY_COLLECTION_DATA]
(@HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
@Scenario as varchar(100),@DateValue as date)
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
-- set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
set @CompanyID = (select ID from CompanyList where Name = @CompanyName)

select Hierarchy,Level1,IndustryLevel,CompanyLevel1,coalesce(CompanyLevel2,'') as CompanyLevel2,coalesce(AmountL2,AmountL1) as Amount
     ,SOL1,SOL2,SOL3,SortOrderCL2
from
       (select hlist.Name as 'Hierarchy',n2.Name as 'Level1',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,
	   h4.NodeDefID as NodeDefID,
	   dbo.PS_STG_GetDataPointValue_Num(n4.ID, @CompanyID, @Scenario, @DateValue) as AmountL1,
       n2.SortOrder as SOL1,n3.SortOrder as SOL2,n4.SortOrder as SOL3
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
     	       dbo.PS_STG_GetDataPointValue_Num(n5.ID, @CompanyID, @Scenario, @DateValue) as AmountL2

	       from Hierarchies h5, NodeDefCompany n5
       	   where n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2)
	   Extract2

      on Extract2.ParentNodeDefID = Extract1.NodeDefID

order by SOL1,SOL2,SOL3,SortOrderCL2

END
GO
