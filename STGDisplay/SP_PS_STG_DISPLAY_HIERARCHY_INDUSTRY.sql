-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-03-01 11:09:41 jpdur"
-- ------------------------------------------------------------------------------

-- -----------------------------------------------------------------
-- Display Hierarchy for IncomeStatement/Balance Sheet + Industry
-- -----------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_DISPLAY_HIERARCHY_INDUSTRY](@HierarchyName as varchar(100),@IndustryName as varchar(100))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

---- Debug Check IDs have been captured
--select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID 

---- List the Tree for Hierarchies only the level just down without dynamic name of columns
select hlist.Name as 'Hierarchy',n1.Name as 'Level1',n3.Name as IndustryLevel
       from Hierarchies h1,  Hierarchies h3, NodeDef n1,  NodeDefIndustry n3, HierarchyList hlist
       where hlist.ID = @HierarchyID 
	   and h1.ParentNodeDefID = @HierarchyID
       	   and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID
       	   and h3.ParentNodeDefID = h1.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
order by n1.SortOrder,n3.SortOrder

END
GO
