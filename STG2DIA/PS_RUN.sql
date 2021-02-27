-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 16:10:47 jpdur"
-- ------------------------------------------------------------------------------

-- All the steps in order to move the data from staging area to DIA 

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- 0) Setup assumed to be made in RM_NODE at the top level for Profit and loss in that case
-- EXEC STG_DIA_Populate_RM_NODE_Hierarchy 'Profit Loss'
-- insert RMX_CollectionRecurrence (Name) VALUES ('Monthly')
-- insert RMX_ValueType (Name) VALUES ('Default')
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- -- 1) RM_Node 
-- EXEC STG_DIA_Populate_RM_NODE 'Profit Loss','Industry 3','TestCo'

-- -- 2) RM_KPIIndustryTemplate
-- EXEC STG_DIA_RM_KPIIndustryTemplate 'Industry 3'

-- -- 3) RM_NodeIndustryAssociation] 
-- EXEC STG_DIA_RM_NodeIndustryAssociation 'Industry 3'

-- -- 4) RM_KPICompanyConfiguration
-- EXEC STG_DIA_RM_KPICompanyConfiguration 'Industry 3','TestCo'

-- -- 5) RM_KPICompanyConfigNodeAssociation
-- EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation 'Profit Loss','Industry 3','TestCo'

-- -- 6) RM_DataItem
-- EXEC STG_DIA_Populate_RM_DataItem 'Profit Loss','Industry 3','TestCo'

-- -- 7) RM_KPICompanyConfigNodeDataItemAssociation
-- EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation 'Profit Loss','Industry 3','TestCo'

