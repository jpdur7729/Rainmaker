-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-28 09:26:14 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @KPICompanyConfigurationID = (select ID from RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1

      -- -------------------------------------------------------------------------------------------
      -- Create a temporary table with all the final leaves for a given Hierarchy/Industry/Company
      -- These are all the level1 when there is no level 2 and all level 2 for the company
      -- -------------------------------------------------------------------------------------------
      select * into #FinalLeaves from (
      	     select Name as FinalLeaveName,ID,SortOrder from NodeDefCompany where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 2
      	     	    union
      	     select Name as FinalLeaveName,ID,SortOrder from NodeDefCompany where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 1
      	     and ID not in (select ParentNodeDefID from Hierarchies)
      ) as tmp

	  -- select * from #FinalLeaves

	  -- Step 1 bringing the records from RM_KPICompanyConfigNodeAssociation
      select ParentNodeDefID,FinalLeaveName,SortOrder
      	     into #ParentFinalLeaves
      from Hierarchies,#FinalLeaves
      	   where Hierarchies.NodeDefID = #FinalLeaves.ID

      -- Get the corresponding RM_NODES ID from NodeDefCompany or NodeDefIndustry
      select * into #ListParentNodes from (
      	     select RM_NODE_ID,FinalLeaveName,#ParentFinalLeaves.SortOrder as SortOrder from NodeDefCompany,#ParentFinalLeaves where NodeDefCompany.ID = #ParentFinalLeaves.ParentNodeDefID 
	     	    union
      	     select RM_NODE_ID,FinalLeaveName,#ParentFinalLeaves.SortOrder as SortOrder from NodeDefIndustry,#ParentFinalLeaves where NodeDefIndustry.ID = #ParentFinalLeaves.ParentNodeDefID 
      ) as tmp

	  -- Select * from #ListParentNodes where FinalLeaveName like 'T%' 
	  
      -- Step 2 gets the extract from RM_KPICompanyConfigNodeAssociation
      select KPICompanyConfigurationID, ID as KPICompanyConfigNodeAssociationID, FinalLeaveName, SortOrder
      	     into #List_KCCNDataItemAssoc
      from RM_KPICompanyConfigNodeAssociation as R_KCCNA,#ListParentNodes
      	   where R_KCCNA.NodeId = #ListParentNodes.RM_NODE_ID

	  -- Select * from #List_KCCNDataItemAssoc where FinalLeaveName like 'T%' 

      -- Step 3 from RM_DataItem gets the ID coresponding to the FinalLeaveName
      select #List_KCCNDataItemAssoc.*, RM_DataItem.ID as DataItemID
      	     into #ReadyToMerge
      from #List_KCCNDataItemAssoc, RM_DataItem
      	   where RM_DataItem.IndustryID = @IndustryID and RM_DataItem.KPITypeID = @HierarchyID
	   	 and #List_KCCNDataItemAssoc.FinalLeaveName = RM_DataItem.Name

      -- select count(*) as ListNBRecs from #List_KCCNDataItemAssoc
      -- select count(*) as ReadyNBRecs from #ReadyToMerge

      -- Step 4 - Finally Ready to merge into RM_KPICompanyConfigNodeDataItemAssociation
      merge into RM_KPICompanyConfigNodeDataItemAssociation as Target
      using (
      	    select * from #ReadyToMerge
      ) x
      on x.KPICompanyConfigurationID = Target.KPICompanyConfigurationID
      	 and x.KPICompanyConfigNodeAssociationID = Target.KPICompanyConfigNodeAssociationID
      	 and x.DataItemID = Target.DataItemID
      when NOT MATCHED then
      	   INSERT (KPICompanyConfigurationID,KPICompanyConfigNodeAssociationID,DataItemID,Sequence,IsChecked)
	   VALUES (x.KPICompanyConfigurationID,x.KPICompanyConfigNodeAssociationID,x.DataItemID,x.SortOrder,@IsChecked) ;
 
END
GO

