-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-22 09:53:55 jpdur"
-- ------------------------------------------------------------------------------

-- Add the Top Node in RM_NodeIndustryAssociation

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_NodeIndustryAssociation_L1] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100), @CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      declare @KPIIndustryTemplateID as varchar(36)
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      -- If we insert TOP level then we want to uncheck all the existing Nodes for that Industry/Hierarchy
      Update RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation set IsChecked = 0 where ID in (
      	     select ID from RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation where KPIIndustryTemplateID = @KPIIndustryTemplateID
	     	    and NodeId in (select ID from RainmakerLDCJP_OAT.dbo.RM_Node where KPITypeID = @HierarchyID))

      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1

      -- ----------------------------------------------------------------------------------------
      -- We add the Level 1 nodes from RM_Node associated to the Company -- NOT THE FINAL VERSION
      -- ----------------------------------------------------------------------------------------
      merge into RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation RM_NIA
      using (
      	    Select NC.RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
	    	   NC.Name as NodeAlias,1 as Weight,NC.SortOrder as Sequence 
			   from NodeDefCompany NC
			   where NC.HierarchyID = @HierarchyID 
			   	 and NC.level = 1
				 and NC.IndustryId = @IndustryID
				 and NC.CompanyId = @CompanyID
	  ) x
      on
      x.NodeID = RM_NIA.NodeId and x.KPIIndustryTemplateID = RM_NIA.KPIIndustryTemplateID 
      when NOT MATCHED THEN
          INSERT (NodeId,KPIIndustryTemplateId,NodeAlias,Weight,Sequence,IsChecked)
	  VALUES(x.NodeID,x.KPIIndustryTemplateId,x.NodeAlias,x.Weight,x.Sequence,@IsChecked)
      when matched then
	   UPDATE set IsChecked = @IsChecked--,Sequence = x.Sequence
	   ;


END
GO

