-- ------------------------------------------------------------------------------
--		       Author	 : FIS - JPD
--		       Time-stamp: "2021-03-02 14:21:43 jpdur"
-- ------------------------------------------------------------------------------

-- Verify the Top Level//KPITypeID prexisting Nodes
select HierarchyList.Name as HierarchyName,RM_Node.*
       from RM_Node,HierarchyList
where ParentNOdeID is null and KPITypeId = HierarchyList.iD  order
by HierarchyName,Name

-- All Industry Level Nodes associated to Income Statement
select * from RM_Node
       where ParentNodeID in (select RM_NODE.ID
       	     from RM_Node,HierarchyList
	     where ParentNOdeID is null and KPITypeId = HierarchyList.iD
	     	   and HierarchyList.Name = 'Income Statement' )
order by sequence 

-- The first 2 levels of the tree 
select RTOP.Name as TopLevelName, RI.Name as IndustryName
       -- ,RTOP.Sequence,RI.Sequence
       from RM_Node RI, RM_Node RTOP, HierarchyList 
       	    where RI.ParentNodeID = RTOP.ID
       	    	  and RTOP.ParentNOdeID is null and RTOP.KPITypeId = HierarchyList.iD
	     	  and HierarchyList.Name = 'Income Statement' 
order by RTOP.sequence,RI.Sequence

-- The first 2 levels of the tree 
select RTOP.Name as TopLevelName, RI.Name as IndustryLevel
       -- ,RTOP.Sequence,RI.Sequence
       from RM_Node RI, RM_Node RTOP, HierarchyList 
       	    where RI.ParentNodeID = RTOP.ID
       	    	  and RTOP.ParentNOdeID is null and RTOP.KPITypeId = HierarchyList.iD
	     	  and HierarchyList.Name = 'Balance Statement' 
order by RTOP.sequence,RI.Sequence

-- | Balance Sheet     | Industry Level        | Sequence | Sequence |
-- |-------------------+-----------------------+----------+----------|
-- | Total Assets      | Current Assets        |       39 |       16 |
-- | Total Assets      | Non-Current Assets    |       39 |       21 |
-- | Total Assets      | Other Assets          |       39 |       39 |
-- | Total Liabilities | Current Liabilities   |       50 |       45 |
-- | Total Liabilities | Long Term Liabilities |       50 |       50 |
-- | Total Equity      | Owners Equity         |       62 |       60 |
-- | Total Equity      | Retained Earnings     |       62 |       62 |
