-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-04-20 06:43:43 jpdur"
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
EXEC PS_Clear_CompanyStructure 'Income Statement','Warehousing and Storage (493)','G006'

-- Create the Node Industry Association 
EXEC STG_DIA_RM_KPI_IND_NodeAssociation @HierarchyName,@IndustryName

-- IND NodeDataItemAssociation -- Should be Empty Except for Cash 
EXEC STG_DIA_Populate_RM_KPI_IND_NodeDataItemAssociation @HierarchyName,@IndustryName

-- CMP_NodeAssociation
EXEC STG_DIA_RM_KPI_CMP_NodeAssociation @HierarchyName,@IndustryName,@CompanyName

-- CMP NodeDataItemAssociation
EXEC STG_DIA_Populate_RM_KPI_CMP_NodeDataItemAssociation @HierarchyName,@IndustryName,@CompanyName

END
GO

-- EXEC PS_Populate_CompanyStructure 'Income Statement','Warehousing and Storage (493)','G006'

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
