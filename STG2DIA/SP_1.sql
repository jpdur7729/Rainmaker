-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 08:44:40 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[SP_RM_KPIIndustryTemplate] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

      -- Assume to be system defined for that part
      -- while any other levels are assumed to be User-defined
      declare @IsSystemDefined as BIT
      set @IsSystemDefined = 0

      -- Step 1 we add the Industry Nodes - Add only the needed nodes via MERGe 
      --INSERT INTO RM_NODE (ID,Name,ParentNodeID,KPITypeID,IsSystemDefined)
      merge into RM_NODE
      using (
      	    Select NI.RM_NODE_ID as RMNodeID, NI.Name as Name,RM_NODE.ID as ParentNodeID,@HierarchyID as KPITypeID
	    	   from NodeDefIndustry NI,NodeDef N, Hierarchies H, RM_NODE 
	     	   where H.NodeDefID = NI.ID and H.ParentNodeDefID = N.ID
	     	   	 and RM_NODE.ParentNodeId is null and RM_NODE.KPITypeID = @HierarchyID and RM_NODE.Name = N.Name
			 and NI.IndustryID = @IndustryID and NI.HierarchyID = @HierarchyID
      ) x
      on
      x.Name = RM_NODE.Name and x.ParentNodeID = RM_NODE.ParentNodeID and x.KPITypeID = RM_NODE.KPITypeID
      when NOT MATCHED THEN
          INSERT (ID,Name,ParentNodeID,KPITypeID,IsSystemDefined)
	  	 VALUES(x.RMNodeID,x.Name,x.ParentNodeID,x.KPITypeID,@isSystemDefined) ;

      -- Step 2: We add the Company Level 1 IF there is a company level 2 and for these we add them in RM_NODE
      Select NC.NAME as Name,NI.RM_NODE_ID as ParentNodeID,@HierarchyID as KPITypeID from (select * from NodeDefCompany NC 
						where NC.level = 1 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
							and Name in (select ParentLevelName from NodeDefCompany NC 
								where NC.level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID)) NC,
								NodeDefIndustry NI,Hierarchies H
		where H.NodeDefID = NC.ID and H.ParentNodeDefID = NI.ID 
			 
END
GO

