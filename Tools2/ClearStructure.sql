-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-06-16 10:08:20 jpdur"
-- -------------------------------------------------------------------------

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- -------------------------------------------------------------
-- Clear Structure if necessary to be able to reimport the data
-- -------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_Clear_CompanyStructure] (@HierarchyName as varchar(100), @IndustryName as varchar(255), @CompanyName as varchar(255))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from DIARM_KPI_IND_Template where IndustryID = @IndustryID )
      
      declare @CompanyID as nvarchar(36)
      declare @KPICompanyTemplateID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyTemplateID = (select ID from DIARM_KPI_CMP_Template where CompanyID = @CompanyID )

      -- Prepare the characteristics of the backup
      declare @BatchID   as varchar(36) = NEWID()
      declare @Timestamp as datetime    = getdate()
      
      -- Create the list of Nodes to be removed 
      select * into #ListINDNodes from (select * from DIARM_KPI_IND_NodeAssociation
      	     where KPITypeId = coalesce(@HierarchyID,'ZZZ')
      	     	   and KPIIndustryTemplateID = coalesce(@KPIIndustryTemplateID,'ZZZ')) tmp

      select * into #ListCMPNodes from (select * from DIARM_KPI_CMP_NodeAssociation
      	     where KPITypeId = coalesce(@HierarchyID,'ZZZ')
      	     	   and KPICompanyTemplateID = coalesce(@KPICompanyTemplateID,'ZZZ')) tmp

      -- Identify and save just in case the list of DataItem in both IND/CMP_NodeDataItemAssociation
      select * into #ListINDDataItem from (select * from DIARM_KPI_IND_NodeDataItemAssociation where NodeAssociationId in (select ID from #ListINDNodes)) tmp
      select * into #ListCMPDataItem from (select * from DIARM_KPI_CMP_NodeDataItemAssociation where NodeAssociationId in (select ID from #ListCMPNodes)) tmp
      
      -- Create a backup of the deleted data
      insert into Backup_IND_NodeAssociation	     select @BatchID,@Timestamp,* from #ListINDNodes
      insert into Backup_IND_NodeDataItemAssociation select @BatchID,@Timestamp,* from #ListINDDataItem
      insert into Backup_CMP_NodeAssociation	     select @BatchID,@Timestamp,* from #ListCMPNodes
      insert into Backup_CMP_NodeDataItemAssociation select @BatchID,@Timestamp,* from #ListCMPDataItem

      -- Delete the corresponding records for IND/CMP
      delete from DIARM_KPI_IND_NodeDataItemAssociation where ID in (select ID from #ListINDDataItem union select NEWID())
      delete from DIARM_KPI_CMP_NodeDataItemAssociation where ID in (select ID from #ListCMPDataItem union select NEWID())
      delete from DIARM_KPI_IND_NodeAssociation         where ID in (select ID from #ListINDNodes    union select NEWID())
      delete from DIARM_KPI_CMP_NodeAssociation         where ID in (select ID from #ListCMPNodes    union select NEWID())
	  
	  -- Verification 
      --select count(*) from #ListINDNodes
      --select count(*) from #ListINDDataItem
      --select count(*) from #ListCMPNodes
      --select count(*) from #ListCMPDataItem

END

GO
