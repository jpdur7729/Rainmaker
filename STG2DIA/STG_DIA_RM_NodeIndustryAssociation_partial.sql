-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 09:09:07 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_NodeIndustryAssociation_partial] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      declare @KPIIndustryTemplateID as varchar(36)
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      	    Select RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
	    	   Name as NodeAlias,1 as Weight,SortOrder as Sequence 
			   from NodeDefIndustry 
			   where IndustryId = @IndustryID and HierarchyID = @HierarchyID
			   	 and TBP = 1

      -- We add the nodes from RM_Node associated to the Industry
      merge into RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation RM_NIA
      using (
      	    Select RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
	    	   Name as NodeAlias,1 as Weight,SortOrder as Sequence 
			   from NodeDefIndustry 
			   where IndustryId = @IndustryID  and HierarchyID = @HierarchyID
			   	 and TBP = 1
	  ) x
      on
      x.NodeID = RM_NIA.NodeId
      when NOT MATCHED THEN
          INSERT (NodeId,KPIIndustryTemplateId,NodeAlias,Weight,Sequence)
	  VALUES(x.NodeID,x.KPIIndustryTemplateId,x.NodeAlias,x.Weight,x.Sequence);

      	    Select RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
	    	   Name as NodeAlias,1 as Weight,SortOrder as Sequence 
			   from NodeDefCompany 
			   where Level = 1 and IndustryId = @IndustryID and CompanyID = @CompanyID and HierarchyID = @HierarchyID
			   	 and TBP = 1
				 and Name in (select ParentLevelName from NodeDefCompany NC
				 where NC.level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID)

      -- We add the nodes from RM_Node associated to the company - not the final leaves
      merge into RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation RM_NIA
      using (
      	    Select RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
	    	   Name as NodeAlias,1 as Weight,SortOrder as Sequence 
			   from NodeDefCompany 
			   where Level = 1 and IndustryId = @IndustryID and CompanyID = @CompanyID and HierarchyID = @HierarchyID
			   	 and TBP = 1
				 and Name in (select ParentLevelName from NodeDefCompany NC
				 where NC.level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID)
	  ) x
      on
      x.NodeID = RM_NIA.NodeId
      when NOT MATCHED THEN
          INSERT (NodeId,KPIIndustryTemplateId,NodeAlias,Weight,Sequence)
	  VALUES(x.NodeID,x.KPIIndustryTemplateId,x.NodeAlias,x.Weight,x.Sequence);


END
GO

