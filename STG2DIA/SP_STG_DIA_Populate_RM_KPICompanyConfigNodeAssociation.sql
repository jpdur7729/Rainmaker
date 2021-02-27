-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 16:01:41 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @KPICompanyConfigurationID = (select ID from RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- -------------------------------------------------------------------
      -- Step we add the Company Nodes i.e. Level 1 if there is a Level 2
      -- The RM_NODE_ID is actually the ID within the RM_NODE tabe
      -- -------------------------------------------------------------------
      merge into RM_KPICompanyConfigNodeAssociation RM_KCCNA
      using (
      	    Select NC.RM_NODE_ID as RMNodeID, NC.SortOrder as Sequence, 1 as Weight, @HierarchyID as KPITypeID
	    	   		    	      from (select * from NodeDefCompany NC 
						where NC.level = 1 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
							and Name in (select ParentLevelName from NodeDefCompany NC 
								where NC.level = 2 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID)) NC,
								NodeDefIndustry NI,Hierarchies H
		where H.NodeDefID = NC.ID and H.ParentNodeDefID = NI.ID
      ) x
      on
      x.RMNodeID = RM_KCCNA.NodeID
      when NOT MATCHED THEN
          INSERT (KPICompanyConfigurationID,NodeID,KPITypeID,Weight,Sequence)
	  	 VALUES(@KPICompanyConfigurationID,x.RMNodeID,x.KPITypeID,x.Weight,x.Sequence) ;

END
GO

