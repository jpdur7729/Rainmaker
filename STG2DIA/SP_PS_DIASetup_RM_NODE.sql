-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-03-01 14:30:27 jpdur"
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

     -- At that top level the name is obviously unique for the given hierarchy 
     -- INSERT INTO RM_NODE (ID,Name,ParentNodeID,KPITypeID,IsSystemDefined,Sequence)
     -- 	     select NEWID(),Name,null,@HierarchyID,@IsSystemDefined,SortOrder from NodeDef 
     -- 	     WHERE HierarchyID = @HierarchyID

     -- -------------------------------------------------------------
     -- Merge to be preferred even if currently supposedly not used
     -- At least a simple way to update the Sequence data
     -- -------------------------------------------------------------
     merge into RM_NODE
     using (
     	     select Name,null as ParentNodeID,@HierarchyID as KPITypeID,
	     	    @IsSystemDefined as IsSystemDefined,SortOrder as Sequence
	     from NodeDef 
	     WHERE HierarchyID = @HierarchyID
     ) x
	 -- testing null = null does not work ==> hence this approach with a random unique identifier
     on RM_NODE.Name = x.Name and x.KPITypeID = RM_NODE.KPITypeID and coalesce(RM_NODE.ParentNodeID,'83126602-5B41-405B-ACB2-868FDDF49A29') = coalesce(x.ParentNodeID,'83126602-5B41-405B-ACB2-868FDDF49A29')
     --when MATCHED then
     --	  update SET Sequence = x.Sequence
     when NOT MATCHED then 	  
     	  INSERT (ID,Name,ParentNodeID,KPITypeID,IsSystemDefined,Sequence)
	  VALUES (NEWID(),x.Name,x.ParentNodeID,x.KPITypeID,x.IsSystemDefined,x.Sequence) ;

     -- Update the STG table i.e. NodeDef with the RM_NODE_ID which have been generated accordingly
     merge into NodeDef
     using (
     	   select ID,KPITypeID,Name from RM_NODE where KPITypeID = @HierarchyID and ParentNodeID is null
     ) x
     on x.Name = NodeDef.Name and x.KPITypeID = NodeDef.HierarchyID
     when matched then
     	  UPDATE set RM_NODE_ID = x.ID;

END
GO

-- Cleanup
-- truncate table RM_NODE

-- EXEC STG_DIA_Populate_RM_NODE_Hierarchy 'Profit Loss'

