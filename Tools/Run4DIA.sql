USE [RainmakerLDCJP_OAT]
select * from RM_KPI_Collection_Batch_Dimension where KPICollectionDimensionId = 'B2FAABE8-48B9-4FD2-8415-18F14E926374'
select * from RM_KPI_Collection_Batch where Id = 'C29FD9BE-E23D-4791-2AC8-08D8E53217E2'
-- The IDs of the 2 reference Companies
select ID,InvCompanyName from RM_Company where InvCompanyName in ('Calico Marketing','Andean Luxury Fabrics')

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

-- STEP B -- Collection DataItem
-- Add the nodes in the RM_Node table and prepare a subtree of nodes to be populated for Calico
select * from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing')))

select * from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Andean Luxury Fabrics')))

-- STEP C -- Collection Dimension
-- Add the nodes in the RM_Node table and prepare a subtree of nodes to be populated for Calico
select * from RM_KPI_Collection_Dimension where KPICollectionDataItemID in (
select ID from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing'))))

select * from RM_KPI_Collection_Dimension where KPICollectionDataItemID in (
select ID from RM_KPI_Collection_DataItem where KPICollectionNodeID in (
select ID from RM_KPI_Collection_Node where workflowID in (select ID from RM_Workflow where CompanyID in (select ID from RM_Company where InvCompanyName = 'Andean Luxury Fabrics'))))




