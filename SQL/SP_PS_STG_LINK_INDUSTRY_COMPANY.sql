-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:08:46 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[PS_STG_LINK_INDUSTRY_COMPANY](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @GrandParentLevelName as varchar(100)
       )
as
BEGIN
declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

merge into Hierarchies using (
      select
      (select ID from NodeDefIndustry where Name = @TopLevelName		  and ParentLevelName = @GrandParentLevelName  and HierarchyID = @HierarchyID and IndustryID = @IndustryID )as ParentNodeDefID,
      (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 1 and ParentLevelName = @TopLevelName 	       and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as NodeDefID
      ) x
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
      when not matched then
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);

END
GO
