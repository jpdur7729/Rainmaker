-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-16 11:42:14 jpdur"
-- ------------------------------------------------------------------------------

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ---------------------------------------------------------------------------------
-- Flag with Port = 'P' at the NodeDefIndustry levels the nodes which are actually
-- DataItems to be taken into account 
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Adjust_2layers] ( @HierarchyName as varchar(100), @IndustryName as varchar(100), @CompanyName as varchar(100))
as
BEGIN

      -- Extract the key Data
      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList  where Name = @IndustryName )
      set @CompanyID   = (select ID from CompanyList   where Name = @CompanyName)

      -- Identify for the Hierachy/Industry/Company the current situations
      update NodeDefIndustry set Port = 'D' where ID in (
      	     select ID from NodeDefIndustry where ID in (
	     	    select ParentNodeDefID from Hierarchies where NodeDefID in (
		    	   select ID from NodeDefCompany where Port = 'P' and CompanyID = @CompanyID
			   	     	  		       and IndustryID = @IndustryID
							       and HierarchyID = @HierarchyID
							       	   	       )
							)
							) 

END
GO
