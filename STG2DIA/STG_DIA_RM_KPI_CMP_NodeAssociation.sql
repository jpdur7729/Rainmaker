-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-20 11:09:06 jpdur"
-- ------------------------------------------------------------------------------

-- Add the Node in RM_KPI_CMP_NodeAssociation
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_KPI_CMP_NodeAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100),@CompanyName as varchar(100))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )

      declare @KPIIndustryTemplateID as varchar(36)
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_Template where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyTemplateID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyTemplateID = (select ID
      	  			       from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template
      				       where CompanyID = @CompanyID
				       	     and KPIIndustryTemplateID = @KPIIndustryTemplateID
      )
      
      -- Defined Default value IsChecked
      declare @IsChecked as BIT
      set @IsChecked = 1
      
      -- We process in one go for the different layer ie.e NodeDef amd NodeDefIndustry
      select * into #ListNodesDataItemNames from (
      	     -- the longest category first
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefIndustry' as Category from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDefCompany'  as Category from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
	     union 
      	     select ID as STGID,Name,RM_NODE_ID,FullPath,SortOrder as Sequence,'NodeDef'         as Category from NodeDef         where HierarchyID = @HierarchyID
      ) tmp

      -- We filter the nodes only leveraging Hierarchies and dropping Final Leaves and the Nodes
      -- especially at top level who are NOT in the hierarchy of the company
      select NEWID() as ID,*,NEWID() as ParentNodeAssociationID into #ListNodesNames from
--      	     (select * from #ListNodesDataItemNames where STGID in (select ParentNodeDefID from Hierarchies)) tmp
      	     (select * from #ListNodesDataItemNames where STGID in (select ParentNodeDefID from Hierarchies where NodeDefID in (select STGID from #ListNodesDataItemNames))) tmp

      -- ----------------------------------------------------------------------------------------------------------
      -- Unchecked all possible nodes that may have existed previously ==> No delete by principle if some are used
      -- ----------------------------------------------------------------------------------------------------------
      Update RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation set IsChecked = 0
      	     where KPICompanyTemplateID = @KPICompanyTemplateID
	     	          and KPITypeID = @HierarchyID

      -- Update the #ListNodesBames in order to be able to reflect the parent ID
      update #ListNodesNames set ParentNodeAssociationID = null where Category = 'NodeDef'

	  -- select '#ListNodesNames',count(*) from #ListNodesNames
	  -- select * from #ListNodesNames

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

	-- print @KPICompanyTemplateID
    -- print @HierarchyID

	--select ID,ParentNodeAssociationID,RM_Node_ID as NodeID,@IsChecked as IsChecked,
	-- 	@HierarchyID as KPITypeID,@KPICompanyTemplateID as KPICompanyTemplateID,
	--	FullPath as Description,Name as NodeAlias,Sequence,1 as Weight, 
	--	'Script JPD' as CreatedBy,getdate() as CreatedOn,Category
	-- from #ListNodesNames


      -- Add the Nodes accordingly
      merge into RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation KCNA
      using (
         select ID,ParentNodeAssociationID,RM_Node_ID as NodeID,@IsChecked as IsChecked,
	 	@HierarchyID as KPITypeID,@KPICompanyTemplateID as KPICompanyTemplateID,
		FullPath as Description,Name as NodeAlias,Sequence,1 as Weight, 
		'Script JPD' as CreatedBy,getdate() as CreatedOn
	 from #ListNodesNames 
      ) x
      on x.Description = KCNA.Description AND KCNA.KPICompanyTemplateID = x.KPICompanyTemplateID and KCNA.KPITypeID = x.KPITypeID
      when matched then
      	   update set IsChecked = 1
      when not matched then
      	   insert (  ID,  ParentNodeAssociationID,  NodeID,  IsChecked,  KPITypeID,  KPICompanyTemplateID,  Description,  NodeAlias,  Sequence,  Weight,  CreatedBy,  CreatedOn)
	   values (x.ID,x.ParentNodeAssociationID,x.NodeID,x.IsChecked,x.KPITypeID,x.KPICompanyTemplateID,x.Description,x.NodeAlias,x.Sequence,x.Weight,x.CreatedBy,x.CreatedOn);

END
GO

