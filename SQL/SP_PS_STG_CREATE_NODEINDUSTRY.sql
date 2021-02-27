-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:07:13 jpdur"
-- ------------------------------------------------------------------------------

-- ---------------------------------------------------------
-- Create node at the Industry level "SubCategory1" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_NODEINDUSTRY](@LevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),
       @ParentLevelName as varchar(100),
       @SortOrder as integer = 0,
       @LevelNumber as integer = 1)
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

merge into NodeDefIndustry using (
      select @LevelName as Name, @IndustryID as IndustryID, @HierarchyID as HierarchyID, @ParentLevelName as ParentLevelName
      ) x
      on x.IndustryID = NodeDefIndustry.IndustryID and x.HierarchyID = NodeDefIndustry.HierarchyID
            and x.Name = NodeDefIndustry.Name and x.ParentLevelName = NodeDefIndustry.ParentLevelName 
      when not matched then
      	   -- New column(s) added in order to guarantee the integration with DIA
      	   insert (ID,LastUser,createdAt,updatedAt,Name,IndustryID,HierarchyID,SortOrder,ParentLevelName)
      	   values (NEWID(),'JPDUR',getdate(),getdate(),x.Name,x.IndustryID,x.HierarchyID,@SortOrder,x.ParentLevelName) 
      WHEN MATCHED THEN
      UPDATE set SortOrder = @SortOrder;

END
GO
