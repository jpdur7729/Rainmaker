/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-03-22 10:38:30 jpdur"
   ------------------------------------------------------------------------------ */

-- 2021-03-18 JPD Similarities and differencies with DIA_Populate_RM_NodeDataItemAssociation to be highlighted 

-- 2021-03-22 JPD   Attempt to link Nodes as NodeDef+NodeDefIndustry
-- 	      	    DataItem as CompanyLevel1
-- 	      	    Attribute/Dimension as CompanyLevel2

-- v2 
-- 2021-03-22 JPD   Attempt to link Nodes as NodeDef+NodeDefIndustry
-- 	      	    DataItem as CompanyLevel1
-- 	      	    Attribute/Dimension as CompanyLevel2

-- v3 
-- 2021-03-22 JPD   Attempt to link Nodes as NodeDef+NodeDefIndustry
-- 	      	    Node as CompanyLevel1 if there is a level 2
-- 	      	    DataItem as CompanyLevel2 + Final Node at Level 1

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation_v3] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
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

      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1

      -- -----------------------------------------------------------------------------------------------
      -- By default if we run the process, we uncheck all the DataItem of the subset which are checked
      -- and will recheck accordingly as we process the data
      -- -----------------------------------------------------------------------------------------------

      -- Identify the relevant node that we want to process 
      select * into #RelevantNodes
      from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation 
      	   where KPITypeID = @HierarchyID and KPICompanyConfigurationID = @KPICompanyConfigurationID

      -- Uncheck all these prexisting nodes for that Hierarchy/Company
      update RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeDataItemAssociation
      	     set IsChecked = 0
      	     where KPICompanyConfigNodeAssociationId in (select ID From #RelevantNodes)

      -- Select * the Final Leaves
      select * into #FinalLeaves from (
      	     select NC2.*,NC1.RM_NODE_ID as ParentNodeID from NodeDefCompany NC2, Hierarchies H, NodeDefCompany NC1
	     	    where NC2.level = 2 and NC2.HierarchyID = @HierarchyID and NC2.IndustryID = @IndustryID and NC2.CompanyID = @CompanyID
		    	  and H.NodeDefID = NC2.ID and NC1.ID = H.ParentNodeDefID
      	     union
      	     select NC.*,NI.RM_NODE_ID as ParentNodeID from NodeDefCompany NC, Hierarchies H, NodeDefIndustry NI
	     	    where NC.level = 1 and NC.HierarchyID = @HierarchyID and NC.IndustryID = @IndustryID and NC.CompanyID = @CompanyID
      	       	    	  and NC.ID not in (select ParentNodeDefID from Hierarchies)
			  and H.NodeDefID = NC.ID and NI.ID = H.ParentNodeDefID

      ) as tmp 	

	  -- select * from #FinalLeaves

      select * into #NewAssociation from (
      	   select NEWID() as NEWID,FL.Name,FL.RM_DataItemID as DataItemID,
		  	  FL.ParentLevelName as ParentIndustryName,
			  FL.RM_Node_ID as ParentNodeID,
	                  KCNA.ID as KPICompanyConfigNodeAssociationID,
			  @KPICompanyConfigurationID as KPICompanyConfigurationID,
      	     	     	  @IsChecked as IsChecked,FL.SortOrder as Sequence,@KPIIndustryTemplateID as KPIIndustryTemplateID
			  from #FinalLeaves FL, RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation KCNA
			  where KCNA.KPITypeID = @HierarchyID and KCNA.KPICompanyConfigurationID = @KPICompanyConfigurationID
			  	and KCNA.NodeID = FL.ParentNodeID
			  
  
      ) as tmp

	  -- select * from #NewAssociation


      -- -- 1st party of union final leaves whse parent is at the Industry Level
      -- 	  select * into #NewAssociation from (
      -- select NEWID() as ID,NC1.Name,NC1.RM_DataItemID as DataItemID,
      -- 						NI.Name as ParentIndustryName,NI.RM_Node_ID as ParentNodeID,
      -- 	                    KCNA.ID as KPICompanyConfigNodeAssociationID,
      -- 						@KPICompanyConfigurationID as KPICompanyConfigurationID,
      -- 	     	     	@IsChecked as IsChecked,NC1.SortOrder as Sequence,@KPIIndustryTemplateID as KPIIndustryTemplateID
      -- 	     from NodeDefCompany NC1 ,Hierarchies h,NodeDefIndustry NI,
      -- 	     	      RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation KCNA
      -- 	     where NC1.IndustryId = @IndustryID and NC1.CompanyID = @CompanyID and NC1.HierarchyID = @HierarchyID
      -- 	     	   and h.NodeDefID = NC1.ID and NI.ID = h.ParentNodeDefId
      -- 		           and NC1.level = 1 
      -- 		           and KCNA.NodeID = NI.RM_NODE_ID
      -- 		           and KCNA.KPITypeID = @HierarchyID and KCNA.KPICompanyConfigurationID = @KPICompanyConfigurationID
      -- 	  ) as tmp

       -- Step 4 - Finally Ready to merge into RM_KPICompanyConfigNodeDataItemAssociation
       merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeDataItemAssociation as Target
       using (
       	    select * from #NewAssociation
       ) x
       on x.KPICompanyConfigurationID = Target.KPICompanyConfigurationID
       	 and x.KPICompanyConfigNodeAssociationID = Target.KPICompanyConfigNodeAssociationID
       	 and x.DataItemID = Target.DataItemID
       when NOT MATCHED then
       	   INSERT (ID,KPICompanyConfigurationID,KPICompanyConfigNodeAssociationID,DataItemID,Sequence,IsChecked)
       	   VALUES (x.NEWID,x.KPICompanyConfigurationID,x.KPICompanyConfigNodeAssociationID,x.DataItemID,x.Sequence,@IsChecked) 
       when MATCHED then
       	    UPDATE set IsChecked = @IsChecked,Sequence = x.Sequence;
 
END
GO

