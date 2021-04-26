-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-26 13:32:39 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- -----------------------------------------------------------------------------------------------------
-- Modified on April 26th in order to reflect the situation Revenue,Direct,A,B and Revenue,Indirect,A,B
-- Without Handling the GrandParent the node B was created twice for both the Direct and Indirect route
-- -----------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------
-- Create node at the Company level "SubCategory2 or 3" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_NODECOMPANY](@LevelName as varchar(250),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @ParentLevelName as varchar(250),
       @SortOrder as integer,@LevelNumber as integer,
       @GrandParentLevelName as varchar(250))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName)

merge into NodeDefCompany using (
      select @LevelName as Name, @IndustryID as IndustryID, @HierarchyID as HierarchyID, @CompanyID as CompanyID,@ParentLevelName as ParentLevelName,@GrandParentLevelName as GrandParentLevelName
      ) x
      on x.IndustryID = NodeDefCompany.IndustryID and x.HierarchyID = NodeDefCompany.HierarchyID and x.CompanyID = NodeDefCompany.CompanyID
      	 and x.Name = NodeDefCompany.Name and x.ParentLevelName = NodeDefCompany.ParentLevelName
	 and x.GrandParentLevelName = NodeDefCompany.GrandParentLevelName
      when not matched then
       insert (ID     ,LastUser,createdAt,updatedAt,  Name,       Level,  CompanyID,  IndustryID,  HierarchyID, SortOrder,  ParentLevelName,  GrandParentLevelName)
       values (NEWID(),'JPDUR' ,getdate(),getdate(),x.Name,@LevelNumber,x.CompanyID,x.IndustryID,x.HierarchyID,@SortOrder,x.ParentLevelName,x.GrandParentLevelName) 
      WHEN MATCHED THEN
       UPDATE set SortOrder = @SortOrder;

END
GO
