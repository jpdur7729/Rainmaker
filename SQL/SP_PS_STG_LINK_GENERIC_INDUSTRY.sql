-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:08:28 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[PS_STG_LINK_GENERIC_INDUSTRY](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100)
       )
as
BEGIN
declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

merge into Hierarchies using (
      select
--      (select ID from NodeDef where Name = @TopLevelName and level = "&$E$1&" and HierarchyID = @HierarchyID  )as ParentNodeDefID,
      (select ID from NodeDef where Name = @TopLevelName and HierarchyID = @HierarchyID  )as ParentNodeDefID,
      (select ID from NodeDefIndustry where Name = @BottomLevelName and HierarchyID = @HierarchyID and IndustryID = @IndustryID and ParentLevelName = @TopLevelName) as NodeDefID
      ) x
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
      when not matched then
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);

END
GO

