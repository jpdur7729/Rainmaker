-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-02-27 08:35:49 jpdur"
-- -------------------------------------------------------------------------

-- ------------------------------------------------------------------------------
-- Insert into RM_Node the top level elements as required
-- This is supposed to be already existing when processing the remaining levels
-- i.e. creating a company and creating an industry
-- ------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_NODE_Hierarchy] (@HierarchyName as varchar(100))
as
BEGIN

     declare @HierarchyID as nvarchar(36)
     set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

     -- Assume to be system defined for that part
     -- while any other levels are assumed to be User-defined
     declare @IsSystemDefined as BIT
     set @IsSystemDefined = 1

     INSERT INTO RM_NODE (ID,Name,ParentNodeID,KPITypeID,IsSystemDefined)
     	     select NEWID(),Name,null,@HierarchyID,@IsSystemDefined from NodeDef 
	     WHERE HierarchyID = @HierarchyID


END
GO

-- Cleanup
-- truncate table RM_NODE

EXEC STG_DIA_Populate_RM_NODE_Hierarchy 'Profit Loss'

