-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-02 14:58:10 jpdur"
-- ------------------------------------------------------------------------------

-- ---------------------------------------------------------
-- Display root Hierarchy for IncomeStatement/Balance Sheet
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_DISPLAY_HIERARCHY_ROOT](@HierarchyName as varchar(100))
as
BEGIN

declare @HierarchyID as varchar(36)
set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

-- Debug check Data
-- select @HierarchyID,@HierarchyName

-- List the Tree for Hierarchies one level
select hl.Name as 'Hierarchy',n1.Name as 'Level1'--,n1.SortOrder
       from Hierarchies H1, NodeDef n1, HierarchyList hl
       where H1.ParentNodeDefID = @HierarchyID and hl.ID = @HierarchyID
	   and H1.NodeDefID = n1.ID
       order by n1.SortOrder

END 
GO

