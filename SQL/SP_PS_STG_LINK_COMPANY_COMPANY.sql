-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-26 14:08:33 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- -------------------------------------------------------------------------
-- 2021-04-26 Added reference to GrandParentLevel when selecting Level2 Node
-- -------------------------------------------------------------------------

-- Create link between Company level 1 and Company level 2
CREATE or ALTER PROCEDURE [dbo].[PS_STG_LINK_COMPANY_COMPANY](
       @TopLevelName as varchar(250),@BottomLevelName as varchar(250),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @GrandParentName as varchar(250)
       )
as
BEGIN

if @BottomLevelName is not null and len(@BottomLevelName) <> 0 begin 
      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
      -- set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID = (select ID from CompanyList where Name = @CompanyName)

      merge into Hierarchies using (
      	    select
	    (select ID from NodeDefCompany  where Name = @TopLevelName    and Level = 1 and ParentLevelName = @GrandParentName 	                                             and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as ParentNodeDefID,
	    (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 2 and ParentLevelName = @TopLevelName 	and GrandParentLevelName =  @GrandParentName and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as NodeDefID
	    ) x
	    on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
	    when not matched then
	    insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);
END

END
GO
