-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-21 11:25:18 jpdur"
-- ------------------------------------------------------------------------------

-- Add the NodeDefIndustry in RM_NodeIndustryAssociation

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_NodeIndustryAssociation_Industry] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      -- declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      declare @KPIIndustryTemplateID as varchar(36)
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1

      -- -----------------------------------------------------------------------------------------------------------
      -- By default we recheck all the nodes from the hierarchy ==> Should be the desired objective most of the time
      -- -----------------------------------------------------------------------------------------------------------

       -- We add the nodes from RM_Node associated to the Industry
       merge into RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation RM_NIA
       using (
       	    Select RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
       	    	   Name as NodeAlias,1 as Weight,SortOrder as Sequence 
       			   from NodeDefIndustry 
       			   where IndustryId = @IndustryID  and HierarchyID = @HierarchyID
       	  ) x
       on
       x.NodeID = RM_NIA.NodeId and x.KPIIndustryTemplateID = RM_NIA.KPIIndustryTemplateID
       when NOT MATCHED THEN
           INSERT (NodeId,KPIIndustryTemplateId,NodeAlias,Weight,Sequence,IsChecked)
       	  VALUES(x.NodeID,x.KPIIndustryTemplateId,x.NodeAlias,x.Weight,x.Sequence,@IsChecked)
       when matched then
	    update set IsChecked = @IsChecked
	;

END
GO

