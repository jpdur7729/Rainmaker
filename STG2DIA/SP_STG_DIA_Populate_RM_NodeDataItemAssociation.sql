-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 16:01:39 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_NodeDataItemAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
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

      -- Create the default value for RM_NodeDataItemAssociation
      declare @IsChecked as BIT
      set @IsCHecked = 1

      -- Select the Association using the data from RM_NodeIndustryAssociation, NodeDefCompany
      select * into #InterTable from (
      select NEWID() as ID,NC1.Name,NC1.RM_DataItemID as DataItemID,NIA.ID as NodeIndustryAssociationID,
      	     	     	@IsChecked as IsChecked,NC1.SortOrder as Sequence,@KPIIndustryTemplateID as KPIIndustryTemplateID
      	     from NodeDefCompany NC1 ,Hierarchies h,NodeDefIndustry NI,
	     	  RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation NIA
      	     where NC1.IndustryId = @IndustryID and NC1.CompanyID = @CompanyID and NC1.HierarchyID = @HierarchyID
      	     	   and RM_DataItemID in (select ID from RainmakerLDCJP_OAT.dbo.RM_DataItem)
		   and h.NodeDefID = NC1.ID and NI.ID = h.ParentNodeDefId
		   and NIA.NodeID = NI.RM_NODE_ID and NIA.KPIIndustryTemplateID = @KPIIndustryTemplateID
       union 
       select NEWID() as ID,NC1.Name,NC1.RM_DataItemID as DataItemID,NIA.ID as NodeIndustryAssociationID,
       		   @IsChecked as IsChecked,NC1.SortOrder as Sequence,@KPIIndustryTemplateID as KPIIndustryTemplateID
       	     from NodeDefCompany NC1 ,Hierarchies h,NodeDefCompany NC2,
       	     	  RainmakerLDCJP_OAT.dbo.RM_NodeIndustryAssociation NIA
       	     where NC1.IndustryId = @IndustryID and NC1.CompanyID = @CompanyID and NC1.HierarchyID = @HierarchyID
       	     	   and NC1.RM_DataItemID in (select ID from RainmakerLDCJP_OAT.dbo.RM_DataItem)
       		   and h.NodeDefID = NC1.ID and NC2.ID = h.ParentNodeDefId
       		   and NIA.NodeID = NC2.RM_NODE_ID and NIA.KPIIndustryTemplateID = @KPIIndustryTemplateID
	  ) as tmp

       -- Add the association within the link
       merge into RainmakerLDCJP_OAT.dbo.RM_NodeDataItemAssociation NDIA
       using (
	      select * from #InterTable
       ) x
       on NDIA.DataItemID = x.DataItemId and x.KPIIndustryTemplateID = NDIA.KPIIndustryTemplateID
       	 and x.NodeIndustryAssociationID = NDIA.NodeIndustryAssociationID
       when not matched then
       	   INSERT (ID,DataItemID,NodeIndustryAssociationID,KPIIndustryTemplateID,IsChecked,Sequence)
       	   Values (NEWID(),x.DataItemID,x.NodeIndustryAssociationID,x.KPIIndustryTemplateID,x.IsChecked,x.Sequence) ;

END
GO

