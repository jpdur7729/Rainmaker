USE [RainmakerLDCJP_OATSTG]
select * from CompanyList
select * from IndustryList where name like '%314%'

-- Patch the tables to fire the XL-Addin
-- EXEC STG_Patch_RM_KPI_Collection_Node 'Income Statement','Textile Product Mills (314)','Calico Marketing','01-Jul-2020','Actuals'

-- Add field 
-- ALTER TABLE NodeDefIndustry ADD RM_DataItemID   UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID();

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

-- Once the NodeIndustryAssociation has been updated ==> from the script perspective 
-- the KPICompanyConfigNodeAssociation needs to be updated and then completed with 
-- the NodeDefCompany for non terminal leaves

-- Same approach with Calico Marketing and Income Statement up to the Industry Level
EXEC PS_STG_CREATE_NODE 'Cost of Sales' , 'Income Statement' , 2      
EXEC PS_STG_CREATE_NODE 'Depreciation' , 'Income Statement' , 5      
EXEC PS_STG_CREATE_NODE 'Exceptional items' , 'Income Statement' , 4      
EXEC PS_STG_CREATE_NODE 'Finance Costs' , 'Income Statement' , 6      
EXEC PS_STG_CREATE_NODE 'Overheads' , 'Income Statement' , 3      
EXEC PS_STG_CREATE_NODE 'Revenue' , 'Income Statement' , 1      
EXEC PS_STG_CREATE_NODE 'Tax' , 'Income Statement' , 7      
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Cost of Sales' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Depreciation' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Exceptional items' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Finance Costs' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Overheads' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Revenue' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Tax' , 'Income Statement'   
EXEC PS_STG_CREATE_NODEINDUSTRY 'Cost of sales' , 'Income Statement' , 'Textile Product Mills (314)' , 'Cost of Sales' , 4  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Depreciation' , 'Income Statement' , 'Textile Product Mills (314)' , 'Depreciation' , 11  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Exceptional Costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Exceptional items' , 10  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Exceptional Revenue' , 'Income Statement' , 'Textile Product Mills (314)' , 'Exceptional items' , 9  
EXEC PS_STG_CREATE_NODEINDUSTRY 'HR' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 5  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Interest - Bank' , 'Income Statement' , 'Textile Product Mills (314)' , 'Finance Costs' , 12  
EXEC PS_STG_CREATE_NODEINDUSTRY 'IT' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 7  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Marketing' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 6  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 8  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Revenue' , 3  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Product' , 'Income Statement' , 'Textile Product Mills (314)' , 'Revenue' , 2  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Services' , 'Income Statement' , 'Textile Product Mills (314)' , 'Revenue' , 1  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Tax' , 'Income Statement' , 'Textile Product Mills (314)' , 'Tax' , 13  
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cost of Sales' , 'Cost of sales' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Depreciation' , 'Depreciation' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Exceptional items' , 'Exceptional Costs' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Exceptional items' , 'Exceptional Revenue' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Finance Costs' , 'Interest - Bank' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'HR' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'IT' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'Marketing' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'Other' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Revenue' , 'Other' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Revenue' , 'Product' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Revenue' , 'Services' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Tax' , 'Tax' , 'Income Statement' , 'Textile Product Mills (314)' 

-- Insert the Top Nodes 
EXEC STG_DIA_Populate_RM_NODE_Top 'Income Statement'
EXEC STG_DIA_RM_NodeIndustryAssociation_Top 'Income Statement','Textile Product Mills (314)'
EXEC STG_DIA_Populate_RM_NODE_Industry 'Income Statement','Textile Product Mills (314)'
EXEC STG_DIA_RM_NodeIndustryAssociation_Industry 'Income Statement','Textile Product Mills (314)'

-- Insert the Company Nodes - For Ecuador Clothing
EXEC STG_DIA_RM_KPICompanyConfigNodeAssociation_Company 'Income Statement','Textile Product Mills (314)' , 'Ecuador Clothing'

-- Add the company information as per the Structure Script - read from the spreadsheet
EXEC PS_STG_CREATE_NODE 'Cost of Sales' , 'Income Statement' , 2      
EXEC PS_STG_CREATE_NODE 'Depreciation' , 'Income Statement' , 5      
EXEC PS_STG_CREATE_NODE 'Exceptional items' , 'Income Statement' , 4      
EXEC PS_STG_CREATE_NODE 'Finance Costs' , 'Income Statement' , 6      
EXEC PS_STG_CREATE_NODE 'Overheads' , 'Income Statement' , 3      
EXEC PS_STG_CREATE_NODE 'Revenue' , 'Income Statement' , 1      
EXEC PS_STG_CREATE_NODE 'Tax' , 'Income Statement' , 7      
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Cost of Sales' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Depreciation' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Exceptional items' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Finance Costs' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Overheads' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Revenue' , 'Income Statement'   
EXEC PS_STG_LINK_GENERIC 'Income Statement' , 'Tax' , 'Income Statement'   
EXEC PS_STG_CREATE_NODEINDUSTRY 'Cost of sales' , 'Income Statement' , 'Textile Product Mills (314)' , 'Cost of Sales' , 4  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Depreciation' , 'Income Statement' , 'Textile Product Mills (314)' , 'Depreciation' , 11  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Exceptional Costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Exceptional items' , 10  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Exceptional Revenue' , 'Income Statement' , 'Textile Product Mills (314)' , 'Exceptional items' , 9  
EXEC PS_STG_CREATE_NODEINDUSTRY 'HR' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 5  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Interest - Bank' , 'Income Statement' , 'Textile Product Mills (314)' , 'Finance Costs' , 12  
EXEC PS_STG_CREATE_NODEINDUSTRY 'IT' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 7  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Marketing' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 6  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Overheads' , 8  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Revenue' , 3  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Product' , 'Income Statement' , 'Textile Product Mills (314)' , 'Revenue' , 2  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Services' , 'Income Statement' , 'Textile Product Mills (314)' , 'Revenue' , 1  
EXEC PS_STG_CREATE_NODEINDUSTRY 'Tax' , 'Income Statement' , 'Textile Product Mills (314)' , 'Tax' , 13  
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Cost of Sales' , 'Cost of sales' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Depreciation' , 'Depreciation' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Exceptional items' , 'Exceptional Costs' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Exceptional items' , 'Exceptional Revenue' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Finance Costs' , 'Interest - Bank' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'HR' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'IT' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'Marketing' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Overheads' , 'Other' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Revenue' , 'Other' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Revenue' , 'Product' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Revenue' , 'Services' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_LINK_GENERIC_INDUSTRY 'Tax' , 'Tax' , 'Income Statement' , 'Textile Product Mills (314)' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Agency - exceptionals' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Exceptional Revenue' , '18' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Agency Revenue' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' , '4' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Bank borrowings' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Interest - Bank' , '21' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Cost of sales - special projects' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '7' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Croudies' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '11' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Croudies' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '8' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Depreciation charge on property, plant and equipment' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Depreciation' , '20' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Finance' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' , '16' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Management' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'HR' , '12' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Office Costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'HR' , '13' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Offline' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' , '3' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Online' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' , '2' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Operations Staff' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '10' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Operations Staff' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '5' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '6' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' , '9' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Sales & Marketing' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Marketing' , '14' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Serpico Tech Excpetional costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Exceptional Costs' , '19' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Special Projects Overheads' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' , '17' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Tech Costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'IT' , '15' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:TECH FEES' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Services' , '1' , '1' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:UK Corporation tax on profits for the year' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Tax' , '22' , '1' 

EXEC PS_STG_CREATE_NODECOMPANY 'EC:Advertising and Marketing' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Sales & Marketing' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Agency - exceptionals' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Agency - exceptionals' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Agency Revenue' , '3' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '5' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '5' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Other' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Bank borrowings' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Bank borrowings' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:CONTENT & CREATIVE' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Agency Revenue' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Content' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '3' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Content' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '3' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Content' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Other' , '3' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Depreciation charge on property, plant and equipment' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Depreciation charge on property, plant and equipment' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:DISPLAY & VIDEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Offline' , '3' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Display and Social' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '4' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Display and Social' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '4' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Display and Social' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Other' , '4' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:E-COMMERCE' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Offline' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:GMP' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:GMP' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Finance' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Management' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Office Costs' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '6' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Sales & Marketing' , '3' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Tech Costs' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:PAID SEARCH' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Offline' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:PPC' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:PPC' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:PPC' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Other' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Finance' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Management' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Office Costs' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Sales & Marketing' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Tech Costs' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Agency Revenue' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Croudies' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Operations Staff' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Other' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Serpico' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Cost of sales - special projects' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Serpico' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Special Projects Overheads' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:Serpico Tech Excpetional costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Serpico Tech Excpetional costs' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:SOCIAL' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Online' , '2' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:TECHNICAL WEBSITE OPTIMISATION' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:Online' , '1' , '2' 
EXEC PS_STG_CREATE_NODECOMPANY 'EC:UK Corporation tax on profits for the year' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'EC:UK Corporation tax on profits for the year' , '1' , '2' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Cost of sales' , 'EC:Cost of sales - special projects' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of Sales' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Cost of sales' , 'EC:Croudies' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of Sales' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Cost of sales' , 'EC:Operations Staff' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of Sales' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Cost of sales' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of Sales' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Depreciation' , 'EC:Depreciation charge on property, plant and equipment' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Depreciation' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Exceptional Costs' , 'EC:Serpico Tech Excpetional costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Exceptional items' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Exceptional Revenue' , 'EC:Agency - exceptionals' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Exceptional items' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'HR' , 'EC:Management' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Overheads' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'HR' , 'EC:Office Costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Overheads' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Interest - Bank' , 'EC:Bank borrowings' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Finance Costs' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'IT' , 'EC:Tech Costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Overheads' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Marketing' , 'EC:Sales & Marketing' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Overheads' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Other' , 'EC:Agency Revenue' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Revenue' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Other' , 'EC:Finance' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Overheads' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Other' , 'EC:Special Projects Overheads' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Overheads' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Product' , 'EC:Offline' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Revenue' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Product' , 'EC:Online' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Revenue' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Services' , 'EC:TECH FEES' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Revenue' 
EXEC PS_STG_LINK_INDUSTRY_COMPANY 'Tax' , 'EC:UK Corporation tax on profits for the year' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Tax' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Agency - exceptionals' , 'EC:Agency - exceptionals' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Exceptional Revenue' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Agency Revenue' , 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Agency Revenue' , 'EC:CONTENT & CREATIVE' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Agency Revenue' , 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Bank borrowings' , 'EC:Bank borrowings' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Interest - Bank' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Cost of sales - special projects' , 'EC:Serpico' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:Content' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:Display and Social' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:GMP' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:PPC' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Croudies' , 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Depreciation charge on property, plant and equipment' , 'EC:Depreciation charge on property, plant and equipment' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Depreciation' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Finance' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Finance' , 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Management' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'HR' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Management' , 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'HR' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Office Costs' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'HR' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Office Costs' , 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'HR' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Offline' , 'EC:DISPLAY & VIDEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Offline' , 'EC:E-COMMERCE' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Offline' , 'EC:PAID SEARCH' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Online' , 'EC:SOCIAL' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Online' , 'EC:TECHNICAL WEBSITE OPTIMISATION' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Product' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:Content' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:Display and Social' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:GMP' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:PPC' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Operations Staff' , 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Other' , 'EC:ANALYTICS' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Other' , 'EC:Content' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Other' , 'EC:Display and Social' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Other' , 'EC:PPC' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Other' , 'EC:SEO' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Cost of sales' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Sales & Marketing' , 'EC:Advertising and Marketing' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Marketing' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Sales & Marketing' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Marketing' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Sales & Marketing' , 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Marketing' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Serpico Tech Excpetional costs' , 'EC:Serpico Tech Excpetional costs' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Exceptional Costs' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Special Projects Overheads' , 'EC:Serpico' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Other' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Tech Costs' , 'EC:Other' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'IT' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:Tech Costs' , 'EC:Salaries' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'IT' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:TECH FEES' , '' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Services' 
EXEC PS_STG_LINK_COMPANY_COMPANY 'EC:UK Corporation tax on profits for the year' , 'EC:UK Corporation tax on profits for the year' , 'Income Statement' , 'Textile Product Mills (314)' , 'Ecuador Clothing' , 'Tax' 

EXEC STG_DIA_Populate_RM_NODE_Company 'Income Statement','Textile Product Mills (314)','Ecuador Clothing'

-- Create the DataItems for Ecuador Clothing accordingly 
EXEC STG_DIA_Populate_RM_DataItem_partial 'Income Statement','Textile Product Mills (314)','Ecuador Clothing'

-- Adjust Data Structure for long anonymised strings 
ALTER TABLE NodeDef ALTER COLUMN Name VARCHAR (250);
ALTER TABLE NodeDefIndustry ALTER COLUMN Name VARCHAR (250);
ALTER TABLE NodeDefCompany ALTER COLUMN Name VARCHAR (250);
ALTER TABLE NodeDefIndustry ALTER COLUMN ParentLevelName VARCHAR (250);
ALTER TABLE NodeDefCompany ALTER COLUMN ParentLevelName VARCHAR (250);

-- Insert the DataItem - Final Leaves - For Ecuador Clothing
EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation_Company 'Income Statement','Textile Product Mills (314)' , 'Ecuador Clothing'
EXEC STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation 'Income Statement','Textile Product Mills (314)','Ecuador Clothing'


select * from DataPointValues 


