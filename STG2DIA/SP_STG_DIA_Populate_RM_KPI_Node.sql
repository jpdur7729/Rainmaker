-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-16 14:48:41 jpdur"
-- ------------------------------------------------------------------------------

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ---------------------------------------------------------------------------------
-- Populate the RM_KPI_NODE table for all NodeDef / NodeDefIndustry / NodeDefCompany
-- and update into the NodeDefTable the RM_NODE to have the exact value of the 
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_NODE] ( @HierarchyName as varchar(100), @IndustryName as varchar(100), @CompanyName as varchar(100))
as
BEGIN

      -- Extract the key Data
      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList  where Name = @IndustryName )
      set @CompanyID   = (select ID from CompanyList   where Name = @CompanyName)

      -- Any points manipulated is assumed to not be a system-defined one 
      declare @IsSystemDefined as BIT
      set @IsSystemDefined = 0

      -- Update for all nodes the FullPath in order to have an easy way to identify/recognise different elements
      -- Important to be able that the nodes can be managed accordingly
      update NodeDef         set FullPath = dbo.PS_UniqueTreeName(ID) where FullPath is null and HierarchyID = @HierarchyID                                                            
      update NodeDefIndustry set FullPath = dbo.PS_UniqueTreeName(ID) where FullPath is null and HierarchyID = @HierarchyID and IndustryID = @IndustryID                              
      update NodeDefCompany  set FullPath = dbo.PS_UniqueTreeName(ID) where FullPath is null and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID   

      -- Create an Intermediate Table to do the extract in one go with all the Nodes
      select * into #ListNodesDataItemNames from (
      	     select ID,Name,RM_NODE_ID from NodeDef         where HierarchyID = @HierarchyID
	     -- Extra condition to eliminate superfluous TopNode which have been defined for Other Industry/Companies
	     	      		   	     		 and ID in (select ParentNodeDefID from Hierarchies where NodeDefID in (select ID from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID))
	     union
	     -- Crucial to add that test on the Port if not the item is selected as a node because it is a parent of the
	     -- NodeDef flagged as P
      	     select ID,Name,RM_NODE_ID from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID and Port <> 'D'
	     union
	     -- Eliminate the Port Nodes as they are created to store the data not to describe the structure
      	     select ID,Name,RM_NODE_ID from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and Port <> 'P'
      ) tmp

      -- Eliminate all the Nodes which do not appear iun Hierarchies as being a ParentNodeDefID
      -- That way all the Final Leaves are droppped 
      select * into #ListNodesNames from
      	     (select * from #ListNodesDataItemNames where ID in (select ParentNodeDefID from Hierarchies)) tmp

      -- Debug
      select 'KPI-Node',* from #ListNodesNames

      -- To prevent any issues Select the data from RM_KPI_Node
      select * into #KPIListNodes
      from DIARM_KPI_Node KPINode
      where CreatedOn <> '01-Jan-1900'

      -- Keep and store the DateTime to be used to flag all records
      declare @CurrentDateTime as datetime = getdate() 

      -- Now that we have the list of names let's process the RM_KPI_NODE table
      merge into #KPIListNodes as KPIListNodes
      using ( select distinct Name from #ListNodesNames ) ListNodes
      on KPIListNodes.Name = ListNodes.Name
      when not MATCHED THEN
      	   INSERT VALUES (NEWID(),ListNodes.Name,@IsSystemDefined,'JPD - Script',@CurrentDateTime);

	  -- select * from #KPIListNodes 
	  -- select * from #KPIListNodes where Name in (select distinct Name from #ListNodesNames)
	  -- select * from #KPIListNodes where CreatedOn = @CurrentDateTime

      -- Update the list of Nodes accordingly
      merge into #ListNodesNames ListNodes
      using #KPIListNodes KPIListNodes
      on KPIListNodes.Name = ListNodes.Name
      when MATCHED THEN
      	   UPDATE SET RM_NODE_ID = KPIListNodes.ID;

	 -- select 'KPIListNodes',* from #KpiListNodes where CreatedOn = @CurrentDateTime

      -- Insert the new records into the RM_KPI_Node table flagged because they all have 
      -- the same CreatedOn value 
      INSERT INTO DIARM_KPI_Node 
      select * from #KPIListNodes where CreatedOn = @CurrentDateTime

      -- ---------------------------------------------------------------------------
      -- Update the various NodeDef/NodeDefIndustry,NodeDefCompany tables with the
      -- correct value of RM_NODE_ID obtained
      -- ---------------------------------------------------------------------------
      merge into NodeDef NodeDef
      using #ListNodesNames ListNodes
      on NodeDef.ID = ListNodes.ID
      when MATCHED then
      	   update set RM_NODE_ID = ListNodes.RM_NODE_ID;
      merge into NodeDefIndustry NodeDef
      using #ListNodesNames ListNodes
      on NodeDef.ID = ListNodes.ID
      when MATCHED then
      	   update set RM_NODE_ID = ListNodes.RM_NODE_ID;
      merge into NodeDefCompany NodeDef
      using #ListNodesNames ListNodes
      on NodeDef.ID = ListNodes.ID
      when MATCHED then
      	   update set RM_NODE_ID = ListNodes.RM_NODE_ID;
			 
END
GO

