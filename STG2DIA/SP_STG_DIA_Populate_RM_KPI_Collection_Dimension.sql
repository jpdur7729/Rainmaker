-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 16:59:37 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_Collection_Dimension] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
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

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select top 1 ID from RM_Workflow)

      -- Extra AttributeID
      declare @AttributeID as nvarchar(36)
      set @AttributeID = (select ID from RM_Attribute where Name = 'Default')

      -- Insert the Data into RM_KPI_Collection_Dimension
      merge into RM_KPI_Collection_Dimension KCD
      using (
      	    select ID as KPICollectionDataItemId
	    from RM_KPI_Collection_DataItem
	    where KPICollectionNodeID in ( select ID from RM_KPI_Collection_Node
	    	  where WorkflowID = @WorkflowID and KPITypeID = @HierarchyID)
      )x
      on x.KPICollectionDataItemId = KCD.KPICollectionDataItemId
      when NOT MATCHED then
      	   INSERT (ID,KPICollectionDataItemId,AttributeID,ParentKPICollectionDimensionId)
	   VALUES (NEWID(),x.KPICollectionDataItemId,@AttributeID,null) ;

END
GO

