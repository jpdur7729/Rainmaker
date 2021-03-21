/*  ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-03-21 12:58:26 jpdur"
   ------------------------------------------------------------------------------ */

-- 2021-03-07 JPD - Potentially a quicker approach as it seems that this is purely a copy
-- 	      	    of RM_Node from KPITypeID = @HierarchyID
-- 		    Just relevant because of the actual structure of RM_Node

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation_partial] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
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

      -- ---------------------------------------------------------------
      -- Process the full set of Nodes i.e. excluding the Final Leaves
      -- ---------------------------------------------------------------

      -- -- Step 1: Ckeck that the specific Level1 Nodes are associated
      -- merge into RM_KPICompanyConfigNodeAssociation RM_KCCNA
      -- using (
      -- 	    -- coalesce just in order to sort some initialisation setup issue
      -- 	    select ID as RMNodeID, coalesce(Sequence,1) as Sequence,1 as Weight, @HierarchyID as KPITypeID
      -- 	    from RM_Node
      -- 	    where ParentNodeId is null and KPITypeID = @HierarchyID
      -- ) x
      -- on
      -- x.RMNodeID = RM_KCCNA.NodeID
      -- when NOT MATCHED THEN
      --     INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence)
      -- 	  	 VALUES(@KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence) ;
		 
      -- Step 2: Add the Industry Level
       merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfigNodeAssociation RM_KCCNA
       using (
	    Select NI.RM_NODE_ID as RMNodeID, NI.SortOrder as Sequence, 1 as Weight, @HierarchyID as KPITypeID,
				@KPICompanyConfigurationID as KPICompanyConfigurationID--,@CompanyID as CompanyID
	    	   		    	      from NodeDefIndustry NI 
						where HierarchyID = @HierarchyID and IndustryID = @IndustryID
						      and TBP = 1
       ) x
       on
       x.RMNodeID = RM_KCCNA.NodeID
       when NOT MATCHED THEN
           INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence)
       	  	 VALUES(x.KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence) ;

      -- -- Step 3: CompanyLevel1 if not Final Leaves
      -- -- -------------------------------------------------------------------
      -- -- Step we add the Company Nodes i.e. Level 1 if there is a Level 2
      -- -- The RM_NODE_ID is actually the ID within the RM_NODE tabe
      -- -- -------------------------------------------------------------------
      -- merge into RM_KPICompanyConfigNodeAssociation RM_KCCNA
      -- using (
      -- 	    Select NC.RM_NODE_ID as RMNodeID, NC.SortOrder as Sequence, 1 as Weight, @HierarchyID as KPITypeID
      -- 	    	   		    	      from (select * from NodeDefCompany NC 
      -- 						where NC.level = 1 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
      -- 							and Name in (select ParentLevelName from NodeDefCompany NC 
      -- 								where NC.level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID)) NC,
      -- 								NodeDefIndustry NI,Hierarchies H
      -- 		where H.NodeDefID = NC.ID and H.ParentNodeDefID = NI.ID
      -- ) x
      -- on
      -- x.RMNodeID = RM_KCCNA.NodeID
      -- when NOT MATCHED THEN
      --     INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence)
      -- 	  	 VALUES(@KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence) ;
      

END
GO

