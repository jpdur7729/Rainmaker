/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-03-22 10:05:45 jpdur"
   ------------------------------------------------------------------------------ */

-- 2021-03-07 JPD - Potentially a quicker approach as it seems that this is purely a copy
-- 	      	    of RM_Node from KPITypeID = @HierarchyID
-- 		    Just relevant because of the actual structure of RM_Node
-- 2021-03-18 JPD   Necessary to maintain the structure. It is the copy made 1st at NodeIndustryAssociation
-- 	      	    and then on a simmilar approach at the Company level
--		    To be linked with the creation of the datapoints

-- v2 
-- 2021-03-22 JPD   Attempt to link Nodes as NodeDef+NodeDefIndustry
-- 	      	    DataItem as CompanyLevel1
-- 	      	    Attribute/Dimension as CompanyLevel2

-- v3 
-- 2021-03-22 JPD   Attempt to link Nodes as NodeDef+NodeDefIndustry
-- 	      	    Node as CompanyLevel1 if there is a level 2
-- 	      	    DataItem as CompanyLevel2 + Final Node at Level 1


CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation_Company_v2] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
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

      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1
      
      -- -------------------------------------------------------------------------------------------------------------
      -- For that to work, the main idea is to first be able to cleanup the existing data or insert only if needed
      -- But any way then the first step is to unchecked all the existing data
      -- As a result when treating the different nodes (creation if they do not ezxist // checked back if they exist)
      -- Other nodes are left unchecked and thus should not be used
      -- -------------------------------------------------------------------------------------------------------------
      update RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation
      	     set IsChecked = 0
	     where KPITypeID = @HierarchyID and KPICompanyConfigurationID = @KPICompanyConfigurationID 

      -- ---------------------------------------------------------------
      -- Process the full set of Nodes i.e. excluding the Final Leaves
      -- ---------------------------------------------------------------

      -- Step 1: Ckeck that the specific Level1 Nodes are associated
      merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation RM_KCCNA
      using (
	    -- coalesce just in order to sort some initialisation setup issue
      	    -- select ID as RMNodeID, coalesce(Sequence,1) as Sequence,1 as Weight,
	    -- 	   @HierarchyID as KPITypeID, @KPICompanyConfigurationID as KPICompanyConfigurationID
 	    -- 	   from RainmakerLDCJP_OAT.dbo.RM_Node
	    -- 	   where ParentNodeId is null and KPITypeID = @HierarchyID
	    -- Prefered option is to do it with NodeDef as it provides the same data + the actual sequence
	    select RM_NODE_ID as RMNodeID,SortOrder as Sequence,1 as Weight,
	    	   @HierarchyID as KPITypeID, @KPICompanyConfigurationID as KPICompanyConfigurationID
		   From NodeDef where HierarchyID = @HierarchyID

      ) x
      on
      x.RMNodeID = RM_KCCNA.NodeID and x.KPICompanyConfigurationID = RM_KCCNA.KPICompanyConfigurationID
      when NOT MATCHED THEN
          INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence,IsChecked)
	  	 VALUES(x.KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence,@IsChecked)
      when MATCHED THEN
	   Update set IsChecked = @IsChecked,sequence = x.Sequence ;
		 
		 
      -- Step 2: Add the Industry Level
      merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation RM_KCCNA
      using (
	    Select NI.RM_NODE_ID as RMNodeID, NI.SortOrder as Sequence, 1 as Weight,
	    	   @HierarchyID as KPITypeID, @KPICompanyConfigurationID as KPICompanyConfigurationID
	    	   		    	      from NodeDefIndustry NI 
						where HierarchyID = @HierarchyID and IndustryID = @IndustryID 
      ) x
      on
      x.RMNodeID = RM_KCCNA.NodeID and x.KPICompanyConfigurationID = RM_KCCNA.KPICompanyConfigurationID
      when NOT MATCHED THEN
          INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence,IsChecked)
	  	 VALUES(x.KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence,@IsChecked) 
      when MATCHED THEN
	   Update set IsChecked = @IsChecked,Sequence = x.Sequence;


      -- Step 3: CompanyLevel1 if not Final Leaves
      -- -------------------------------------------------------------------
      -- Step we add the Company Nodes i.e. Level 1 if there is a Level 2
      -- The RM_NODE_ID is actually the ID within the RM_NODE tabe
      -- -------------------------------------------------------------------
      merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation RM_KCCNA
      using (
	    Select NC.RM_NODE_ID as RMNodeID, NC.SortOrder as Sequence, 1 as Weight,
	    	   @HierarchyID as KPITypeID, @KPICompanyConfigurationID as KPICompanyConfigurationID
	    	   		    	      from NodeDefCompany NC 
						where NC.level = 1 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
							and NC.ID in (select ParentNodeDefID from Hierarchies)
      ) x
      on
      x.RMNodeID = RM_KCCNA.NodeID and x.KPICompanyConfigurationID = RM_KCCNA.KPICompanyConfigurationID
      when NOT MATCHED THEN
          INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence,IsChecked)
	  	 VALUES(x.KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence,@IsChecked)
      when MATCHED THEN
	   Update set IsChecked = @IsChecked,Sequence = x.Sequence;
      

END
GO

