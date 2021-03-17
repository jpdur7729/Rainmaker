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
EXEC PS_STG_LINK_GENERIC 'Cashflows' , 'Cashflows from Financing Activities' , 'Cashflows'   
EXEC PS_STG_LINK_GENERIC 'Cashflows' , 'Cashflows from Investing Activities' , 'Cashflows'   
EXEC PS_STG_LINK_GENERIC 'Cashflows' , 'Change in NWC' , 'Cashflows'   
EXEC PS_STG_LINK_GENERIC 'Cashflows' , 'EBITDA (incl. Exceptionals)' , 'Cashflows'   
EXEC PS_STG_LINK_GENERIC 'Cashflows' , 'Other cashflows' , 'Cashflows'   
EXEC PS_STG_CREATE_NODEINDUSTRY 'Accrued income' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 14  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Capitalised R&D' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Investing Activities' , 16  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Cost of Sales' , 'Cashflows' , 'Textile Product Mills (314)' , 'EBITDA (incl. Exceptionals)' , 3  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Crown Creditors' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 12  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Deferred income' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 13  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Dividends paid' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 36  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Exceptional Items' , 'Cashflows' , 'Textile Product Mills (314)' , 'EBITDA (incl. Exceptionals)' , 5  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Fixed asset disposal' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Investing Activities' , 20  
EXEC PS_STG_CREATE_NODEINDUSTRY 'FX (Gain / (Loss)) on cash balances' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 33  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Growth capex' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Investing Activities' , 18  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Holdco Costs paid' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 34  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Increase / decrease in cash-like items' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 31  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Inventory' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 6  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Investments / Divestments' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Investing Activities' , 21  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Issuance / redemption of Equity' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 30  
EXEC PS_STG_CREATE_NODEINDUSTRY 'LDC Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 26  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Leases' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 22  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Maintenance capex' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Investing Activities' , 19  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Management Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 27  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Minority Interest paid' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 35  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 37  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other capitalised costs' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Investing Activities' , 17  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other debt' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 29  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other payables' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 11  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other PE Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 28  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other receivables' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 9  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Overheads' , 'Cashflows' , 'Textile Product Mills (314)' , 'EBITDA (incl. Exceptionals)' , 4  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Revenue' , 'Cashflows' , 'Textile Product Mills (314)' , 'EBITDA (incl. Exceptionals)' , 1  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Revenue deductions' , 'Cashflows' , 'Textile Product Mills (314)' , 'EBITDA (incl. Exceptionals)' , 2  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Senior Debt' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 23  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Subordinated Debt' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 24  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Tax paid' , 'Cashflows' , 'Textile Product Mills (314)' , 'Other cashflows' , 32  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Trade payables' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 10  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Trade receivables' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 8  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Trapped / ringfenced cash' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 15  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Vendor Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' , 'Cashflows from Financing Activities' , 25  
EXEC PS_STG_CREATE_NODEINDUSTRY 'WIP' , 'Cashflows' , 'Textile Product Mills (314)' , 'Change in NWC' , 7  
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Issuance / redemption of Equity' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'LDC Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Leases' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Management Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Other debt' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Other PE Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Senior Debt' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Subordinated Debt' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Financing Activities' , 'Vendor Loan Notes' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Investing Activities' , 'Capitalised R&D' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Investing Activities' , 'Fixed asset disposal' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Investing Activities' , 'Growth capex' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Investing Activities' , 'Investments / Divestments' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Investing Activities' , 'Maintenance capex' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cashflows from Investing Activities' , 'Other capitalised costs' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Accrued income' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Crown Creditors' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Deferred income' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Inventory' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Other payables' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Other receivables' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Trade payables' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Trade receivables' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'Trapped / ringfenced cash' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Change in NWC' , 'WIP' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'EBITDA (incl. Exceptionals)' , 'Cost of Sales' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'EBITDA (incl. Exceptionals)' , 'Exceptional Items' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'EBITDA (incl. Exceptionals)' , 'Overheads' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'EBITDA (incl. Exceptionals)' , 'Revenue' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'EBITDA (incl. Exceptionals)' , 'Revenue deductions' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'Dividends paid' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'FX (Gain / (Loss)) on cash balances' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'Holdco Costs paid' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'Increase / decrease in cash-like items' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'Minority Interest paid' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'Other' , 'Cashflows' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Other cashflows' , 'Tax paid' , 'Cashflows' , 'Textile Product Mills (314)' 

-- Insert the Top Nodes 
EXEC STG_DIA_Populate_RM_NODE_Top 'Cashflows'
EXEC STG_DIA_RM_NodeIndustryAssociation_Top 'Cashflows','Textile Product Mills (314)'
EXEC STG_DIA_Populate_RM_NODE_Industry 'Cashflows','Textile Product Mills (314)'
EXEC STG_DIA_RM_NodeIndustryAssociation_Industry 'Cashflows','Textile Product Mills (314)'





