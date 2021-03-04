-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 07:03:38 jpdur"
-- ------------------------------------------------------------------------------

-- All the steps in order to move the data from staging area to DIA 

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_DeployStructure] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- 0) Setup assumed to be made in RM_NODE at the top level for Profit and loss in that case
-- EXEC STG_DIA_Populate_RM_NODE_Hierarchy 'Income Statement'
-- No sequence added ==> To be verified // Not Null as part of the RM_NODE table definition
-- insert RMX_CollectionRecurrence (Name) VALUES ('Monthly')
-- insert RMX_ValueType (Name) VALUES ('Default')
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- 1) RM_Node 
EXEC STG_DIA_Populate_RM_NODE @HierarchyName,@IndustryName,@CompanyName

-- 2) RM_KPIIndustryTemplate
EXEC STG_DIA_RM_KPIIndustryTemplate @IndustryName

-- 3) RM_NodeIndustryAssociation] 
EXEC STG_DIA_RM_NodeIndustryAssociation @IndustryName

-- 4) RM_KPICompanyConfiguration
EXEC STG_DIA_RM_KPICompanyConfiguration @IndustryName,@CompanyName

-- 5) RM_KPICompanyConfigNodeAssociation
EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation @HierarchyName,@IndustryName,@CompanyName

-- 6) RM_DataItem
EXEC STG_DIA_Populate_RM_DataItem @HierarchyName,@IndustryName,@CompanyName

-- 7) RM_KPICompanyConfigNodeDataItemAssociation
EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation @HierarchyName,@IndustryName,@CompanyName

END
GO

-- EXEC STG_DIA_DeployStructure 'Income Statement','Industry 3','TestCo'
