-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-07 07:04:56 jpdur"
-- ------------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- Create a unique View to handle all Nodes irespectively of their place
-- in the hierarchy - Handy to move recursively from one node to the next
-- -------------------------------------------------------------------------
-- Initially used in the recursive function to create unique name of a node
-- -------------------------------------------------------------------------
create or alter VIEW NodeListView
as
     select ID as NodeDefID,Name from NodeDef
     	    union 
     select ID as NodeDefID,Name from NodeDefIndustry
            union 
     select ID as NodeDefID,Name from NodeDefCompany
GO
