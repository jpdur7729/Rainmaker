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
--select ~ IsChecked as NewChecked,* from RM_NodeIndustryAssociation where KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') )
--and NodeId in (select ID from RM_Node where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows'))

---- Enough for all the Nodes as displayed on Industry Templates --> Does not affect the Data Item (corrected manually) 
--Update RM_NodeIndustryAssociation set IsChecked = ~ IsChecked where ID in (
--select ID from RM_NodeIndustryAssociation where KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') )
--and NodeId in (select ID from RM_Node where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows'))
--)

select * from RM_KPICompanyConfiguration where 
KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)')) 
and CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing')

select * from RM_KPICompanyConfigNodeAssociation where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows')
and KPICompanyConfigurationID in (
select ID from RM_KPICompanyConfiguration where 
KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)')) 
and CompanyID in (select ID from RM_Company where InvCompanyName = 'Calico Marketing')
)
and NodeId in (
select NodeId from RM_NodeIndustryAssociation where KPIIndustryTemplateID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID in (select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)') )
and NodeId in (select ID from RM_Node where KPITypeID in (select ID from RMX_KpiType where name = 'Cashflows'))
and IsChecked = 0
)

-- For Andean Luxury Fabrics delete all entered DataPoints
-- select * from RM_KPI_Collection_Batch_Dimension where KPICollectionBatchID in (select * from RM_KPI_Collection_Batch)

-- List of all KPICollectionBatchID for a given Company/KPI
-- Can be filtered by Date (Reporting Date) and Scenario (select ID from RM_ClassType where Name = "Actuals")
select * from RM_KPI_Collection_Batch where 
CompanyID in (select ID from RM_Company where InvCompanyName = 'Andean Luxury Fabrics')
and KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and ID in (select KPICollectionBatchID from RM_KPI_Collection_Batch_Dimension)

select * from RM_Workflow where ID = '053527C0-0876-420C-B57E-ACDA02BB1057'

select count(*) from RM_KPI_Collection_Batch where WorkflowID = '053527C0-0876-420C-B57E-ACDA02BB1057'
select count(*) from RM_WorkflowDocument where WorkflowID = '053527C0-0876-420C-B57E-ACDA02BB1057'
select count(*) from RM_WorkflowStatusHistory where WorkflowID = '053527C0-0876-420C-B57E-ACDA02BB1057'
select * from RM_WorkflowStatusHistory where WorkflowID = '053527C0-0876-420C-B57E-ACDA02BB1057'
select * from RMX_WorkflowStatus -- where WorkflowID = '053527C0-0876-420C-B57E-ACDA02BB1057'

select * from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing')

select * from RM_KPICompanyConfigNodeAssociation 
where KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing'))

select count(*) from RM_KPICompanyConfigNodeAssociation where NodeID = '827319A1-CE6E-4EFF-B6C8-AB254081AB29'
and KPICompanyConfigurationID = '0B1E4792-5936-43EB-A3B1-08D8E7BB2A96'

-- For The company Only 
select * from RM_KPICompanyConfigNodeDataItemAssociation 
where 
-- KPICompanyConfigurationID = '0B1E4792-5936-43EB-A3B1-08D8E7BB2A96'
-- add for the KPIType
KPICompanyConfigNodeAssociationId in (select ID from RM_KPICompanyConfigNodeAssociation 
where KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing')))

select * from RM_DataItem where Name like 'EC:%'

select * from RM_NodeDataItemAssociation 

select * from RM_KPICompanyConfigNodeDataItemAssociation 
where KPICompanyConfigNodeAssociationId in (select ID from RM_KPICompanyConfigNodeAssociation 
where KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing')))

select * from RM_DataItem where ID = '82E49016-B35D-47C0-7D8A-08D8AC7FC84D'

select * from RM_KPICompanyConfigNodeAssociation where NodeId = '4488608B-FC86-EB11-818F-005056AB4D1B'

-- 1st level is there (Total Expenses // Total Revenues inherited)
select RM_Node.Name,RM_NOde.Sequence,KCNA.* from RM_KPICompanyConfigNodeAssociation KCNA, RM_Node
where KCNA.KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing'))
and isChecked = 1
and RM_Node.ID = KCNA.NodeID and Rm_Node.ParentNodeId is null order by KCNA.Sequence

-- 2nd level
select RMG.Name,RMG.Sequence,RMI.Sequence,RMI.Name,KCNA.* from RM_KPICompanyConfigNodeAssociation KCNA, RM_Node as RMI, RM_Node RMG
where KCNA.KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing'))
and isChecked = 1
and RMI.ID = KCNA.NodeID and RMI.ParentNodeId is not null
and RMG.ID = RMI.ParentNodeId and RMG.Name not like 'Total%'
order by RMG.Sequence,RMI.Sequence 

-- 3rd level
select RMG.Name,RMG.Sequence,RMI.Sequence,RMI.Name,RMC.Name,
	KCNA.* from RM_KPICompanyConfigNodeAssociation KCNA, RM_Node as RMC,RM_Node as RMI, RM_Node RMG
where KCNA.KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')
and KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing'))
and isChecked = 1
and RMC.ID = KCNA.NodeID and RMC.ParentNodeId is not null
and RMI.ID = RMC.ParentNodeId and RMI.ParentNodeId is not null
and RMG.ID = RMI.ParentNodeId and RMG.Name not like 'Total%'
order by RMG.Sequence,RMI.Sequence,RMC.Sequence

select * from RM_KPICompanyConfigNodeAssociation where NodeID = 'AC517C57-CE87-EB11-818F-005056AB4D1B'
select * from RM_Node where ID = 'AC517C57-CE87-EB11-818F-005056AB4D1B'

select * from RM_KPICompanyConfigNodeDataItemAssociation

-- Level 1 of NodeDefCompany
select * from RM_NODE where ID in (select rm_NODE_ID FROM RainmakerLDCJP_OATSTG.dbo.NodeDefCompany where level = 1 
                                             and CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing')
                                             and HierarchyID in (select ID from RMX_KpiType where name = 'Income Statement'))
											 
-- Check if NodeDefCompany level 1 are not reflected in the IndustryNodeAssociation
-- Industry level at RM_Node
select * from RM_NODE where ID in (
select ParentNodeId from RM_NODE where ID in (select rm_NODE_ID FROM RainmakerLDCJP_OATSTG.dbo.NodeDefCompany where level = 1 
                                             and CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing')
                                             and HierarchyID in (select ID from RMX_KpiType where name = 'Income Statement')))

-- Check if NodeDefCompany level 1 are not reflected in the IndustryNodeAssociation
-- Check if NodeDefCompany level 1 are reflected in the CompanyConfigNodeAssociation
select * from RM_KPICompanyConfigNodeAssociation where NodeID in (select ID from RM_NODE where ID in (select rm_NODE_ID FROM RainmakerLDCJP_OATSTG.dbo.NodeDefCompany where level = 1 
                                             and CompanyID in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing')
                                             and HierarchyID in (select ID from RMX_KpiType where name = 'Income Statement')))


select * from RM_KPICompanyConfigNodeDataItemAssociation where KPICompanyConfigNodeAssociationID = 'CB59E42F-E387-EB11-818F-005056AB4D1B'
select * from RainmakerLDCJP_OATSTG.dbo.NodeDefCompany where RM_NODE_ID = 'AC517C57-CE87-EB11-818F-005056AB4D1B'

select ID from RM_Industry where InvIndustryName = 'Textile Product Mills (314)'
select * from RM_DataItem where ID in (
select DataItemID from RM_KPICompanyConfigNodeDataItemAssociation where KPICompanyConfigNodeAssociationID = 'CB59E42F-E387-EB11-818F-005056AB4D1B')

-- CHeck on Ok
--select * into #IncomeStatement from (
--select * from RM_KPICompanyConfigNodeAssociation where KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID 
--in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing'))
--and KPITypeID in (select ID from RMX_KpiType where name = 'Income Statement')) as tmp
select t1.*,t2.* from #IncomeStatement t1,RM_Node t2 where t1.NodeId = t2.ID and t2.ParentNodeId is null


select x1.*,t2.Name,t3.Name,x2.* from #IncomeStatement x1,#IncomeStatement x2,RM_Node t2 ,RM_Node t3 
where x1.NodeId = t2.ID and t2.ParentNodeId is null and t2.Name not like 'Total%' and t3.ParentNodeID = t2.ID and x2.NodeId = t3.ID
order by t2.sequence,t3.sequence

select n1.Name,n2.Name,n3.Name,x1.*,x2.*,x3.* from #IncomeStatement x1,#IncomeStatement x2,#IncomeStatement x3,RM_Node n1 ,RM_Node n2 ,RM_Node n3
where x1.NodeId = n1.ID and n1.ParentNodeId is null and n1.Name not like 'Total%'
and n2.ParentNodeID = n1.ID and x2.NodeId = n2.ID 
and n3.ParentNodeID = n2.ID and x3.NodeId = n3.ID
order by n1.sequence,n2.sequence,n3.sequence


--select * into #BalanceSheet from (
--select * from RM_KPICompanyConfigNodeAssociation where KPICompanyConfigurationID in (select ID from RM_KPICompanyConfiguration where CompanyID 
--in (select ID from RM_Company where InvCompanyName = 'Ecuador Clothing'))
--and KPITypeID in (select ID from RMX_KpiType where name = 'Balance Sheet')) as tmp

select x1.*,t2.Name,t3.Name,x2.* from #BalanceSheet x1,#BalanceSheet x2,RM_Node t2 ,RM_Node t3 
where x1.NodeId = t2.ID and t2.ParentNodeId is null  and t3.ParentNodeID = t2.ID and x2.NodeId = t3.ID
order by t2.sequence,t3.sequence

select n1.Name,n2.Name,n3.Name,x1.*,x2.*,x3.* from #BalanceSheet x1,#BalanceSheet x2,#BalanceSheet x3,RM_Node n1 ,RM_Node n2 ,RM_Node n3
where x1.NodeId = n1.ID and n1.ParentNodeId is null 
and n2.ParentNodeID = n1.ID and x2.NodeId = n2.ID 
and n3.ParentNodeID = n2.ID and x3.NodeId = n3.ID
order by n1.sequence,n2.sequence,n3.sequence

select * from RM_KPICompanyConfigNodeDataItemAssociation where KPICompanyConfigNodeAssociationId in (

select x3.ID from #BalanceSheet x1,#BalanceSheet x2,#BalanceSheet x3,RM_Node n1 ,RM_Node n2 ,RM_Node n3
where x1.NodeId = n1.ID and n1.ParentNodeId is null 
and n2.ParentNodeID = n1.ID and x2.NodeId = n2.ID 
and n3.ParentNodeID = n2.ID and x3.NodeId = n3.ID)

select * from RM_DataItem where ID in (
select DataItemID from RM_KPICompanyConfigNodeDataItemAssociation where KPICompanyConfigNodeAssociationId in (

select x3.ID from #BalanceSheet x1,#BalanceSheet x2,#BalanceSheet x3,RM_Node n1 ,RM_Node n2 ,RM_Node n3
where x1.NodeId = n1.ID and n1.ParentNodeId is null 
and n2.ParentNodeID = n1.ID and x2.NodeId = n2.ID 
and n3.ParentNodeID = n2.ID and x3.NodeId = n3.ID))


-- order by n1.sequence,n2.sequence,n3.sequence

--select * from RM_KPICompanyConfigDataItemAttributeAssociation where ID in (
--select DataItemID from RM_KPICompanyConfigNodeDataItemAssociation where KPICompanyConfigNodeAssociationId in (

--select x3.ID from #BalanceSheet x1,#BalanceSheet x2,#BalanceSheet x3,RM_Node n1 ,RM_Node n2 ,RM_Node n3
--where x1.NodeId = n1.ID and n1.ParentNodeId is null 
--and n2.ParentNodeID = n1.ID and x2.NodeId = n2.ID 
--and n3.ParentNodeID = n2.ID and x3.NodeId = n3.ID))

-- update 
select * from RM_Company where InvCompanyName like '%004%'
-- update RM_Company set InvCompanyName = 'X'+InvCompanyName where InvCompanyName = '004'
select * from RM_KPIIndustryTemplate

