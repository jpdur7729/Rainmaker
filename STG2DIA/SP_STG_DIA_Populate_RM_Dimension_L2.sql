/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-03-22 09:22:10 jpdur"
   ------------------------------------------------------------------------------ */

-- 2021-03-22 JPD   Attempt to link Nodes as NodeDef+NodeDefIndustry
-- 	      	    DataItem as CompanyLevel1
-- 	      	    Attribute/Dimension as CompanyLevel2

-- Aim is to populate RM_Attribute and RM_Attribute Group
--     	     	      L2               L1 - Name GA:L1.Name


CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_Dimension_L2] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- 1st Stage populate RM_AttribureGroup (ID is used to defie RM_Attribute)
      merge into RainmakerLDCJP_OAT.dbo.RM_AttributeGroup Target
      using (
      	    select RM_NODE_ID ID,'GA:'+Name as Name,1 as IsConfirmed,
	    	   'create by STG_DIA_Populate_RM_Dimension_L2' as ChangedBy,getdate() as ChangedOn,0 as IsSystemDefined
      	    from NodeDefCompany
	    where HierarchyID = @HierarchyID and CompanyID = @CompanyID and IndustryID = @IndustryID
	    	  and level = 1
		  and ID in (select ParentNodeDefID from Hierarchies) -- just to be sure that there are level 2 data
      ) x
      on x.ID = Target.ID
      when not matched then
      	   INSERT (ID,Name,IsConfirmed,ChangedBy,ChangedOn,IsSystemDefined)
	   VALUES (x.ID,x.Name,x.IsConfirmed,x.ChangedBy,x.ChangedOn,x.IsSystemDefined)
      when matched then
      	   UPDATE set IsConfirmed = x.IsConfirmed;

      -- 2nd Stage populate RM_Attribure with the L2 information
      merge into RainmakerLDCJP_OAT.dbo.RM_Attribute Target
      using (
      	    select NC2.RM_NODE_ID as ID,NC2.Name as Name,NC1.RM_NODE_ID as AttributeGroupID
      	    from NodeDefCompany NC2, Hierarchies H, NodeDefCompany NC1
	    	 where NC2.HierarchyID = @HierarchyID and NC2.CompanyID = @CompanyID and NC2.IndustryID = @IndustryID
	    	       and NC2.level = 2
		       and H.NodeDefID = NC2.ID and NC1.ID = H.ParentNodeDefID
      ) x
      on x.ID = Target.ID
      when NOT MATCHED then
      	   INSERT (ID,Name,AttributeGroupID)
	   VALUES (x.ID,x.Name,x.AttributeGroupID) ;

      -- 3rd Stage populate RM_AttribureGroupIndustryAssociation with the L1 information
      merge into RainmakerLDCJP_OAT.dbo.RM_AttributeGroupIndustryAssociation Target
      using (
      	    select NEWID() as ID,RM_NODE_ID AttributeGroupID,@IndustryID as IndustryID
      	    from NodeDefCompany
	    where HierarchyID = @HierarchyID and CompanyID = @CompanyID and IndustryID = @IndustryID
	    	  and level = 1
		  and ID in (select ParentNodeDefID from Hierarchies) -- just to be sure that there are level 2 data
      ) x
      on x.AttributeGroupId = Target.AttributeGroupId and x.IndustryID = Target.IndustryID
      when NOT MATCHED then
      	   INSERT (ID,AttributeGroupID,IndustryID)
	   VALUES (x.ID,AttributeGroupID,x.IndustryID) ;
      

END
GO

