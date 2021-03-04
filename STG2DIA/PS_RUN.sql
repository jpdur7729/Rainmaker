-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 17:02:58 jpdur"
-- ------------------------------------------------------------------------------

-- All the steps in order to move the data from staging area to DIA 

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- 0) Setup assumed to be made in RM_NODE at the top level for Profit and loss in that case
-- EXEC STG_DIA_Populate_RM_NODE_Hierarchy 'Income Statement'
-- No sequence added ==> To be verified // Not Null as part of the RM_NODE table definition
-- insert RMX_CollectionRecurrence (Name) VALUES ('Monthly')
-- insert RMX_ValueType (Name) VALUES ('Default')
-- insert RMX_BatchStatus (Name) VALUES ('Default')
-- insert RM_ClassType (Name) VALUES ('Default')
-- insert RMX_CollectionPeriod (Name) VALUES ('Monthly')
-- insert RM_Workflow (Name) VALUES ('Default')
-- insert RM_Attribute (Name) VALUES ('Default')
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- -- 1) RM_Node 
-- EXEC STG_DIA_Populate_RM_NODE 'Income Statement','Industry 3','TestCo'

-- -- 2) RM_KPIIndustryTemplate
-- EXEC STG_DIA_RM_KPIIndustryTemplate 'Industry 3'

-- -- 3) RM_NodeIndustryAssociation] 
-- EXEC STG_DIA_RM_NodeIndustryAssociation 'Industry 3'

-- -- 4) RM_KPICompanyConfiguration
-- EXEC STG_DIA_RM_KPICompanyConfiguration 'Industry 3','TestCo'

-- -- 5) RM_KPICompanyConfigNodeAssociation
-- EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation 'Income Statement','Industry 3','TestCo'

-- -- 6) RM_DataItem
-- EXEC STG_DIA_Populate_RM_DataItem 'Income Statement','Industry 3','TestCo'

-- -- 7) RM_KPICompanyConfigNodeDataItemAssociation
-- EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation 'Income Statement','Industry 3','TestCo'

------------------------------------------------------------------------------
-- Uploading the actual values/datapoint
------------------------------------------------------------------------------
-- -- 8) RM_KPI_Collection_Batch
EXEC STG_DIA_Populate_RM_KPI_Collection_Batch 'Income Statement','Industry 3','TestCo','31-Oct-2020','Actual'

-- -- 9) RM_KPI_Collection_Node
EXEC STG_DIA_Populate_RM_KPI_Collection_Node 'Income Statement','Industry 3','TestCo'

-- -- 10) RM_KPI_Collection_DataItem
EXEC STG_DIA_Populate_RM_KPI_Collection_DataItem 'Income Statement','Industry 3','TestCo'

-- -- 12) RM_KPI_Collection_Dimension
EXEC STG_DIA_Populate_RM_KPI_Collection_Dimension 'Income Statement','Industry 3','TestCo'

-- -- 13) RM_KPI_Collection_Batch_Dimension
EXEC STG_DIA_Populate_RM_KPI_Collection_Batch_Dimension 'Income Statement','Industry 3','TestCo','31-Oct-2020','Actual'
