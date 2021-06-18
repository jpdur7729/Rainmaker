-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-16 14:49:22 jpdur"
-- ------------------------------------------------------------------------------

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ---------------------------------------------------------------------------------
-- Here the initial assumption was that DataItem only at the NodeDefCompanyLevel --> To be revisited 
-- ---------------------------------------------------------------------------------
-- Add the Node in RM_KPI_IND_NodeAssociation
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_KPI_IND_NodeAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )

      declare @KPIIndustryTemplateID as varchar(36)
      set @KPIIndustryTemplateID  = (select ID from DIARM_KPI_IND_Template where IndustryID = @IndustryID )

      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1
      
      -- We process in one go for the different layer ie.e NodeDef and NodeDefIndustry
      select * into #ListNodesDataItemNames from (
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDef' as Category from NodeDef         where HierarchyID = @HierarchyID
	     	     -- Extra condition to eliminate superfluous TopNode which have been defined for Other Industry/Companies
	     	      and ID in (select ParentNodeDefID from Hierarchies where NodeDefID in (select ID from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID))

	     union
	     -- If Port = 'D' then this Node at the Industry level is actually a DataItem
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefIndustry' as Category from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID and Port <> 'D'
      ) tmp

	  
      -- We filter the nodes only leveraging Hierarchies and dropping Final Leaves
      select NEWID() as ID,*,NEWID() as ParentNodeAssociationID into #ListNodesNamesFull from
      	     (select * from #ListNodesDataItemNames where STGID in (select ParentNodeDefID from Hierarchies)) tmp

      -- ----------------------------------------------------------------------------------------------------------
      -- Unchecked all possible nodes that may have existed previously ==> No delete by principle if some are used
      -- ----------------------------------------------------------------------------------------------------------
      Update DIARM_KPI_IND_NodeAssociation set IsChecked = 0
      	     where KPIIndustryTemplateID = @KPIIndustryTemplateID
	     	           and KPITypeID = @HierarchyID

      -- Update the #ListNodesBames in order to be able to reflect the parent ID
      update #ListNodesNamesFull set ParentNodeAssociationID = null where Category = 'NodeDef'

      -- ----------------------------------------------------------------------------------
      -- Delete from #ListNodesNames the Nodes - actually at TopLevel - which are not used
      -- we only select the used Top Level Nodes // Where clause is a bit restrictive
      -- ----------------------------------------------------------------------------------
      -- To be tested with more complex structures. Modified on 2021-06-16 with the Port modifications
      -- select * into #ListNodesNames from (select * from #ListNodesNamesFull where Category = 'NodeDefIndustry'
      -- 	       	    		    	     	 or STGID in (select ParentNodeDefID from Hierarchies where NodeDefID in (select STGID from #ListNodesNamesFull))) tmp
      select * into #ListNodesNames from #ListNodesNamesFull

	  -- select '#ListNodesNames',count(*) from #ListNodesNames  
      -- select '#ListNodesNamesFull',count(*) from #ListNodesNamesFull

      -- Debug
      select 'KPI-IND-NodeAssociation',* from #ListNodesNames

      -- Update the list with the reference of the parent
      merge into #ListNodesNames LNM
      using (
      	    select l1.ID as ID, l2.ID as ParentNodeAssociationID
	    from #ListNodesNames l1, Hierarchies h, #ListNodesNames l2
	    where l1.STGID = h.NodeDefID and l2.STGID = h.ParentNodeDefID 
      ) x
      on x.ID = LNM.ID
      when matched then
      	   update set ParentNodeAssociationID = x.ParentNodeAssociationID;

      -- Add the Nodes accordingly in 2 steps 
      merge into DIARM_KPI_IND_NodeAssociation KINA
      using (
         select ID,ParentNodeAssociationID,RM_Node_ID as NodeID,@IsChecked as IsChecked,
	 	@HierarchyID as KPITypeID,@KPIIndustryTemplateID as KPIIndustryTemplateID,
		FullPath as Description,Name as NodeAlias,Sequence,1 as Weight, 
		'Script JPD' as CreatedBy,getdate() as CreatedOn
	 from #ListNodesNames
		-- where Category = 'NodeDef'
      ) x
      on x.Description = coalesce(KINA.Description,'ZZZ') and KINA.KPIIndustryTemplateID = x.KPIIndustryTemplateID and KINA.KPITypeID = x.KPITypeID
      when matched then
      	   update set IsChecked = 1
      when not matched then
      	   insert (  ID,  ParentNodeAssociationID,  NodeID,  IsChecked,  KPITypeID,  KPIIndustryTemplateID,  Description,  NodeAlias,  Sequence,  Weight,  CreatedBy,  CreatedOn)
	       values (x.ID,x.ParentNodeAssociationID,x.NodeID,x.IsChecked,x.KPITypeID,x.KPIIndustryTemplateID,x.Description,x.NodeAlias,x.Sequence,x.Weight,x.CreatedBy,x.CreatedOn);

END
GO

