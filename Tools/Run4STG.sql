USE [RainmakerLDCJP_OATSTG]
select * from CompanyList
select * from IndustryList where name like '%314%'

-- Patch the tables to fire the XL-Addin
-- EXEC STG_Patch_RM_KPI_Collection_Node 'Income Statement','Textile Product Mills (314)','Calico Marketing','01-Jul-2020','Actuals'

select * from NodeDef -- where TBP = 1
select * from NodeDefIndustry where TBP = 1
select * from NodeDefCompany where TBP = 1

-- NodeDefIndustry for all but Other
select distinct Name from NodeDefIndustry where Name <> 'Other'
select count(*) from NodeDefIndustry where Name <> 'Other'
-- update NodeDefIndustry set TBP = 1 where Name <> 'Other'

-- Added the 1st level of Nodes and check if visible at the Industry Level
EXEC STG_DIA_Populate_RM_NODE_partial 'Income Statement','Textile Product Mills (314)','Calico Marketing'
EXEC STG_DIA_RM_NodeIndustryAssociation_partial 'Income Statement','Textile Product Mills (314)','Calico Marketing'

-- Add the 2 Other and see the results // Manage duplicate Names at Node Level
update NodeDefIndustry set TBP = 1 where Name = 'Other'
EXEC STG_DIA_Populate_RM_NODE_partial 'Income Statement','Textile Product Mills (314)','Calico Marketing'
EXEC STG_DIA_RM_NodeIndustryAssociation_partial 'Income Statement','Textile Product Mills (314)','Calico Marketing'

-- Nothing at the Company Level for Calico
select * from NodeDefCompany where CompanyID in (select ID from CompanyList where Name = 'Andean Luxury Fabrics')
select * from NodeDefCompany where CompanyID in (select ID from CompanyList where Name = 'Calico Marketing')

-- Let's try adding the NodeDefCompany via RM_Node partial and RM_NodeIndustryAssociation partial
update NodeDefCompany set TBP = 1 where CompanyID in (select ID from CompanyList where Name = 'Andean Luxury Fabrics')

-- Populate the list of Nodes Accordingly
EXEC STG_DIA_Populate_RM_NODE_partial 'Income Statement','Textile Product Mills (314)','Andean Luxury Fabrics'
EXEC STG_DIA_RM_NodeIndustryAssociation_partial 'Income Statement','Textile Product Mills (314)','Andean Luxury Fabrics'

-- Restore the Correct Name in the list of data Items
-- update NodeDefCompany set Name = substring(Name,4,len(Name)-3) where Name like 'LF:%'
-- Alter table NodeDefCompany add RM_DataItemID uniqueidentifier;

-- Populate the DataItem with the Final Leaves
EXEC STG_DIA_Populate_RM_DataItem_partial 'Income Statement','Textile Product Mills (314)','Andean Luxury Fabrics'
-- And now associate the Final Leaves with the Corresponding Nodes 
EXEC STG_DIA_Populate_RM_NodeDataItemAssociation 'Income Statement','Textile Product Mills (314)','Andean Luxury Fabrics'

-- Create the Top Level Nodes for Cash Flows
EXEC PS_STG_CREATE_NODE 'Cashflows from Financing Activities' , 'Cashflows' , 4      
EXEC PS_STG_CREATE_NODE 'Cashflows from Investing Activities' , 'Cashflows' , 3      
EXEC PS_STG_CREATE_NODE 'Change in NWC' , 'Cashflows' , 2      
EXEC PS_STG_CREATE_NODE 'EBITDA (incl. Exceptionals)' , 'Cashflows' , 1      
EXEC PS_STG_CREATE_NODE 'Other cashflows' , 'Cashflows' , 5      

-- Insert the Top Nodes 





