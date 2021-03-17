USE [RainmakerLDCJP_OAT]
select * from RM_KPI_Collection_Batch_Dimension where KPICollectionDimensionId = 'B2FAABE8-48B9-4FD2-8415-18F14E926374'
select * from RM_KPI_Collection_Batch where Id = 'C29FD9BE-E23D-4791-2AC8-08D8E53217E2'
-- The IDs of the 2 reference Companies
select ID,InvCompanyName from RM_Company where InvCompanyName in ('Calico Marketing','Andean Luxury Fabrics')
select * from RM_Company where RM_IsActive = 0 order by InvCompanyName
-- Update RM_Company set RM_IsActive = 1, InvIndustry = (select InvIndustry from RM_Company where InvCompanyName = 'Calico Marketing') where InvCompanyName = 'De La Renta Enterprises'
select * from RM_Company where InvIndustry = (select InvIndustry from RM_Company where InvCompanyName = 'Calico Marketing')

-- Check Calico vs. Andean for DataPoint related tables
select * from RM_KPI_Collection_Batch where CompanyId in (select ID from RM_Company where InvCompanyName in ('Calico Marketing','Andean Luxury Fabrics'))
-- Only Batch is in Draft mode select * from RMX_BatchStatus (Held/Posted/Draft)
select * from RM_KPI_Collection_Batch where CompanyId in (select ID from RM_Company where InvCompanyName in ('Calico Marketing'))
-- WorkflowStatus in Pending Review despite the fact there is no point mode select * from RMX_WorkflowStatus // Not Started - Pending Review
-- update RM_workflow set WorkflowStatusID = (select ID from RMX_WorkflowStatus where Name = 'Not Started') where ID = '8B5E9702-F1D5-4739-AA80-D7B7E7F4B173'
-- select ID,Name  from RMX_WorkflowStatus // should apply to an instance of a workflow -- is stored in the rm_workflow table ???
-- which is the place where a generic workflow is defined ???? ==> weird to say the least. 
-- Ad-hoc table to monitor the status of a worflow INSTAMCE status i.e. the ID  i.e Company/Date/KPI etc...
select * from RM_workflow where ID = '8B5E9702-F1D5-4739-AA80-D7B7E7F4B173'

-- For Andean // many workflows populated all of them with the Pending Review status (As the 1st one is ...) ==> consequence of the previous observations
select * from RM_KPI_Collection_Batch where 
	CompanyId in (select ID from RM_Company where InvCompanyName in ('Andean Luxury Fabrics'))
	and WorkflowID in (select id from RM_workflow where WorkflowStatusId IN (select ID from RMX_WorkflowStatus where Name = 'Pending Review'))

-- Delete the KPI Collection Batch for Calico 
select * from RM_KPI_Collection_Batch where CompanyId in (select ID from RM_Company where InvCompanyName in ('Calico Marketing'))
-- delete from RM_KPI_Collection_Batch where CompanyId in (select ID from RM_Company where InvCompanyName in ('Calico Marketing'))

-- Select a few tables to know what is associated to KPI Collection Batch for De La Renta Enterprises
select * from RM_KPI_Collection_Batch where CompanyId in (select ID from RM_Company where InvCompanyName in ('De La Renta Enterprises'))
select * from RM_workflow where CompanyId in (select ID from RM_Company where InvCompanyName in ('De La Renta Enterprises'))
select * from RM_KPICompanyConfiguration where CompanyId in (select ID from RM_Company where InvCompanyName in ('De La Renta Enterprises'))
select * from RM_KPICompanyConfiguration where CompanyId in (select ID from RM_Company where InvCompanyName in ('Calico Marketing'))

-- Chain of tables to finally go to the dataPoint 
-- KPI Collection Node == Add the nodes
-- KPI Collection DataItem == Add the DataItem
-- KPI Collection Dimemsion == Add the Dimensions
-- -- -- -- -- -- -- 
-- KPI Collection_Batch_Dimension == Where the values are stored link between KPI Collect Batch -- KPI Collection Dimension

-- STEP A -- Collection Node 
-- Add the nodes in the RM_Node table and prepare a subtree of nodes to be populated for Calico
-- Andean vs. Calico for Collection Node
select * from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Andean Luxury Fabrics'))
-- Currently Identical
select * from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing'))
-- delete from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing'))

-- KPI Collection Node and equivalent are not created BEFORE THE 1st ATTEMPT TO run the XL Addin 
-- But the data appears ready to launch THE XLAddin as it appears in the drop down
select * from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'De La Renta Enterprises'))

select * from RM_Workflow -- Not Created ?? for De La Renta 
select distinct(workflowID) from RM_KPI_Collection_Node

-- STEP B -- Collection DataItem
-- Add the nodes in the RM_Node table and prepare a subtree of nodes to be populated for Calico
select * from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing')))
--delete from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
--select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing')))

select * from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Andean Luxury Fabrics')))

-- STEP C -- Collection Dimension
-- Add the nodes in the RM_Node table and prepare a subtree of nodes to be populated for Calico
select * from RM_KPI_Collection_Dimension where KPICollectionDataItemID in (
select ID from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing'))))
--delete from RM_KPI_Collection_Dimension where KPICollectionDataItemID in (
--select ID from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
--select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing'))))

select * from RM_KPI_Collection_Dimension where KPICollectionDataItemID in (
select ID from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Andean Luxury Fabrics'))))

-- Compare RM_KPICompanyConfigNodeAssociation similar contents -- when is it populated ??
select * from RM_KPICompanyConfigNodeAssociation where KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration
where CompanyID in (select ID from RM_Company where InvCompanyName= 'Andean Luxury Fabrics'))
select * from RM_KPICompanyConfigNodeAssociation where KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration
where CompanyID in (select ID from RM_Company where InvCompanyName= 'Ecuador Clothing'))

-- Patch select * from RM_KPICompanyConfigNodeAssociation for Ecuador Clothing
select * from RM_KPICompanyConfigNodeAssociation where KPICompanyConfigurationID = '0B1E4792-5936-43EB-A3B1-08D8E7BB2A96'
and KPITypeID in (select ID from RMX_KPIType where Name = 'Income Statement')
-- IsChecked is by default set to 1 for all of them ==> Let's try to put it to 0 accordingly 

select * from RM_Node where KPITypeID in (select ID from RMX_KPIType where Name = 'Income Statement')

----------- Linking DataItem to Nodes --------------------------
select * from RM_DataItem where Name = 'AmazonWebSite' -- F07C5F37-6327-44B3-D46D-08D8E2E2D6B4
select * from RM_NodeDataItemAssociation where DataItemID = 'F07C5F37-6327-44B3-D46D-08D8E2E2D6B4'
-- select * from RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') 
select * from RM_NodeIndustryAssociation where ID = '9D0EEB84-FDAF-47E1-8712-EB8A08A2B74F'

-- All LF% DataItem are deleted 
-- Check what can be found in KPICompany
select * from RM_KPICompanyConfiguration where CompanyID in (select ID From RM_Company where InvCompanyName = 'Calico Marketing')
select * from RM_KPICompanyConfigNodeAssociation 
where KPICompanyConfigurationId = 'A2E695A0-15B8-498F-ABDD-1DAC38CF98D6'
and KPITypeID in (select ID from RMX_KpiType where Name = 'Income Statement')

-- select * from RM_Node where ParentNOdeID is null and KPITypeID in (select ID from RMX_KPIType where Name = 'Cashflows')
-- select * from RM_NODE where Name = 'CASH POSITION BALANCE - BEGINNING'
select * from RM_NODE where ParentNodeID is null and IsSystemDefined = 0
update RM_NODE set IsSystemDefined =  1 where ParentNodeID is null and IsSystemDefined = 0
update RM_NODE set IsSystemDefined =  0 where ID in (
select RM_NODE_ID from RainmakerLDCJP_OATSTG.dbo.NodeDef where HierarchyID in (select ID from RainmakerLDCJP_OATSTG.dbo.HierarchyList where Name = 'Cashflows')
)

select * from RM_NODE where ParentNodeID is null and IsSystemDefined = 0

select * from RMX_KPIType where ID = '192CEC9C-780A-4E82-AA50-FA07EACEB306'
select * from RM_NODE where Name = 'FINANCIALS'
select * from RM_NODE where Name = 'CASH POSITION BALANCE - BEGINNING'
select * from RM_Node where ID = 'CEA3FBD9-D9DB-4213-B270-DFFFECBC63B4'
select * from RM_Node where ParentNodeID = 'CEA3FBD9-D9DB-4213-B270-DFFFECBC63B4'
select * from RM_Node where ParentNodeID = '34FF9C3C-6DA7-4C63-A581-5171E7DC69BE'

select * from RM_NodeIndustryAssociation where NodeId = 'CBA3FCCE-DD23-4751-AAA6-2E55C1AA1A7A'

select * from RM_KPIIndustryTemplate where ID in (
select KPIIndustryTemplateID from RM_NodeIndustryAssociation where NodeId = 'CBA3FCCE-DD23-4751-AAA6-2E55C1AA1A7A')

select * from RM_NodeIndustryAssociation where NodeID in (select RM_NODE_ID from Node where Hierarchy in (select ID from RMX_KpiType where Name = 'Cashflows') )


select * from RM_NodeIndustryAssociation where NodeID = 'CBA3FCCE-DD23-4751-AAA6-2E55C1AA1A7A'
select * from RM_KPI_Collection_Node where NodeID = 'CBA3FCCE-DD23-4751-AAA6-2E55C1AA1A7A'

-- In order to extract from NodeIndustryAssociation for a Given Industry and KPI/Hierarchy
select * from RM_NodeIndustryAssociation where KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') )
and NodeId in (select ID from RM_Node where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows'))
select ~ IsChecked as NewChecked,* from RM_NodeIndustryAssociation where KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') )
and NodeId in (select ID from RM_Node where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows'))

-- Enough for all the Nodes as displayed on Industry Templates --> Does not affect the Data Item (corrected manually) 
Update RM_NodeIndustryAssociation set IsChecked = ~ IsChecked where ID in (
select ID from RM_NodeIndustryAssociation where KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') )
and NodeId in (select ID from RM_Node where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows'))
)


