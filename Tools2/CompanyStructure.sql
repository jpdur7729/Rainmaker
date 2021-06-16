-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-06-16 10:52:59 jpdur"
-- -------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Add in to the Company the current/new Company
-- Extra precaution --> The name of the industry is assumed to be unique to prevent issues
-- Not in that table as it is actually inherited from Investran
-- ----------------------------------------------------------------------------------------
-- RM_IsActive is to be set to 1 in order for the Company to appear in the system
-- ----------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_Populate_CompanyStructure] (@HierarchyName as varchar(100), @IndustryName as varchar(255), @CompanyName as varchar(255))
as
BEGIN

-- Flag at the NodeDefIndustry levels what needs to be a DataPoint
EXEC STG_DIA_Adjust_2layers @HierarchyName,@IndustryName,@CompanyName

-- Deploy the data for that New Company in RM_KPI_Node and RM_DataItem
EXEC STG_DIA_Populate_RM_KPI_NODE @HierarchyName,@IndustryName,@CompanyName

-- Deploy the Data for RM_DataItem
EXEC STG_DIA_Populate_RM_DataItem @HierarchyName,@IndustryName,@CompanyName

-- Create the KPI_IND_Template
EXEC STG_DIA_Populate_RM_KPI_IND_Template @IndustryName

-- Create the Template/the Recurrence data And immediately adds the Actuals Scenario Daa 
EXEC STG_DIA_Populate_RM_KPI_CMP_Template @IndustryName, @CompanyName, '1-Jan-2019',36

-- Required only to add the none Actual scenario which is added by default 
EXEC STG_DIA_Populate_RM_KPI_CMP_RecurrenceScenarioAssociation @IndustryName, @CompanyName

-- Clear the structure to simplify the import process 
EXEC PS_Clear_CompanyStructure @HierarchyName,@IndustryName,@CompanyName

-- Create the Node Industry Association 
EXEC STG_DIA_RM_KPI_IND_NodeAssociation @HierarchyName,@IndustryName

-- IND NodeDataItemAssociation -- Should be Empty Except for Cash and LDC/NAV legacy Structures
EXEC STG_DIA_Populate_RM_KPI_IND_NodeDataItemAssociation @HierarchyName,@IndustryName

-- CMP_NodeAssociation
EXEC STG_DIA_RM_KPI_CMP_NodeAssociation @HierarchyName,@IndustryName,@CompanyName

-- CMP NodeDataItemAssociation
EXEC STG_DIA_Populate_RM_KPI_CMP_NodeDataItemAssociation @HierarchyName,@IndustryName,@CompanyName

END
GO

-- EXEC PS_Populate_CompanyStructure 'Income Statement','Warehousing and Storage (493)','G006'

-- EXEC PS_Populate_CompanyStructure 'Income Statement','Telecommunications (517)','G011'
-- EXEC PS_Populate_CompanyStructure 'Balance Sheet','Telecommunications (517)','G011'

-- EXEC PS_Populate_CompanyStructure 'Income Statement','Utilities (221)','F0004'
-- EXEC PS_Populate_CompanyStructure 'Balance Sheet','Utilities (221)','F0004'

--EXEC PS_Clear_CompanyStructure 'Income Statement','Warehousing and Storage (493)','G006'
--EXEC STG_DIA_RM_KPI_IND_NodeAssociation 'Income Statement','Warehousing and Storage (493)'
--EXEC STG_DIA_Populate_RM_KPI_IND_NodeDataItemAssociation 'Income Statement','Warehousing and Storage (493)'
--EXEC STG_DIA_RM_KPI_CMP_NodeAssociation 'Income Statement','Warehousing and Storage (493)','G006'
--EXEC STG_DIA_Populate_RM_KPI_CMP_NodeDataItemAssociation 'Income Statement','Warehousing and Storage (493)','G006'

---- Test the CMP_NodeAssociation table
--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Income Statement')
--and KPICompanyTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID in (select ID from CompanyList where Name = 'G006'))

---- Test the CMP_NodeDataItemAssociation table
--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeDataItemAssociation where NodeAssociationID in (
--select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Income Statement')
--and KPICompanyTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID in (select ID from CompanyList where Name = 'G006'))
--)

---- Only select the available nodes
--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Income Statement')
--and KPIIndustryTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_Template where IndustryID in (select ID from IndustryList where Name = 'Warehousing and Storage (493)'))

-- EXEC STG_DIA_Upload_DataPoints 'Income Statement' ,'Warehousing and Storage (493)','G006','Actuals','31-Oct-2020'
EXEC STG_DIA_UPDATE_DataPoints 'Income Statement' ,'Warehousing and Storage (493)','G006','Actuals','31-Jan-2019'

---- select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node where KPITypeID = @KPITypeID and WorkflowID = @WorkflowID 
--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem
--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension
--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension


--(1 row affected)

--(1 row affected)

--(1 row affected)

--(1 row affected)

--(1 row affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(0 rows affected)

--(1906 rows affected)

--(1906 rows affected)

--(1906 rows affected)

--(1294 rows affected)

--(1294 rows affected)

--(1294 rows affected)

--(1294 rows affected)

--(1294 rows affected)

--(1294 rows affected)

--(24 rows affected)

--(9 rows affected)

--(9 rows affected)

--(9 rows affected)

--Completion time: 2021-04-20T06:18:25.6407307-04:00

select count(*) from Backup_Collection_Batch_Dimension where Timestamp > getdate() -1
select count(*) from Backup_Collection_Dimension       where Timestamp > getdate() -1
select count(*) from Backup_Collection_DataItem        where Timestamp > getdate() -1
select count(*) from Backup_Collection_Node            where Timestamp > getdate() -1


--select * from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Balance Sheet')
--and KPIIndustryTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_Template where IndustryID in (select ID from IndustryList where Name = 'Warehousing and Storage (493)'))

select * from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Balance Sheet')
 and KPICompanyTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID in (select ID from CompanyList where Name = 'G006'))

select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Balance Sheet')
 and KPICompanyTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID in (select ID from CompanyList where Name = 'G006'))
 and ParentNodeAssociationId is null

select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation where KPITypeId in (select ID from HierarchyList where Name = 'Balance Sheet')
 and KPICompanyTemplateID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID in (select ID from CompanyList where Name = 'G006'))
 and ParentNodeAssociationId in (
'AD03D473-F152-4161-B5D0-53B42C87CD57',
'07ECE713-95B6-443A-9A3E-6E5818C047D9',
'96C3CD0E-597F-47CC-99A0-AE00640485FE')
