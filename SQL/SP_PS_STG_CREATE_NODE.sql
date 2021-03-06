-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-11 11:22:07 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- ---------------------------------------------------------
-- Create node at the Hierarchy/Generic level "Category" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_NODE](@LevelName as varchar(250),@HierarchyName as varchar(100),@SortOrder as integer = 0,@LevelNumber as integer = 1)
as
BEGIN

declare @HierarchyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

merge into NodeDef using (
      select @LevelName as Name,@LevelNumber as Level,@HierarchyID  as HierarchyID
      ) x
      on x.Name = NodeDef.Name and x.Level = NodeDef.Level and x.HierarchyID = NodeDef.HierarchyID
      WHEN NOT MATCHED THEN
      	   INSERT (ID,LastUser,createdAt,updatedAt,Name,Level,HierarchyID,SortOrder)
      	   VALUES (NEWID(),'JPDUR',getdate(),getdate(),x.Name,x.Level,x.HierarchyID,@SortOrder)
      WHEN MATCHED THEN
      	   UPDATE set SortOrder = @SortOrder;

END
GO
