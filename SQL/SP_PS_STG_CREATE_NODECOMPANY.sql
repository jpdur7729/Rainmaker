-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 15:04:45 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- ---------------------------------------------------------
-- Create node at the Company level "SubCategory2 or 3" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_NODECOMPANY](@LevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @ParentLevelName as varchar(100),
       @SortOrder as integer,@LevelNumber as integer)
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
-- set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
set @CompanyID = (select ID from CompanyList where Name = @CompanyName)

merge into NodeDefCompany using (
      select @LevelName as Name, @IndustryID as IndustryID, @HierarchyID as HierarchyID, @CompanyID as CompanyID,@ParentLevelName as ParentLevelName
      ) x
      on x.IndustryID = NodeDefCompany.IndustryID and x.HierarchyID = NodeDefCompany.HierarchyID and x.CompanyID = NodeDefCompany.CompanyID
      	 and x.Name = NodeDefCompany.Name and x.ParentLevelName = NodeDefCompany.ParentLevelName
      when not matched then
       insert (ID,LastUser,createdAt,updatedAt,Name,Level,CompanyID,IndustryID,HierarchyID,SortOrder,ParentLevelName)
       values (NEWID(),'JPDUR',getdate(),getdate(),x.Name,@LevelNumber,x.CompanyID,x.IndustryID,x.HierarchyID,@SortOrder,x.ParentLevelName) 
      WHEN MATCHED THEN
       UPDATE set SortOrder = @SortOrder;

END
GO
