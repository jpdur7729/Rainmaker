-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:08:37 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- ----------------------------------------------
-- Create link between Category and Subcategory 
-- ----------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_LINK_GENERIC](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100)
       )
as
BEGIN

declare @HierarchyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

merge into Hierarchies using (
      select @HierarchyID as ParentNodeDefID,
      -- select ID from NodeDef where Name = @BottomLevelName and level = "&$E$1&" and HierarchyID = @HierarchyID ') as NodeDefID)
      (select ID from NodeDef where Name = @BottomLevelName and HierarchyID = @HierarchyID) as NodeDefID
      ) x 
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID 
      when not matched then 
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);
      
END
GO
