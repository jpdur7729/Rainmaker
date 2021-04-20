/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-12 08:28:08 jpdur"
   ------------------------------------------------------------------------------ */

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_CMP_NodeDataItemAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_Template where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyTemplateID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyTemplateID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_Template where CompanyID = @CompanyID )

      -- Process all the final Leaves for the Hierarchy/Industry/Company
      select * into #ListNodesDataItemNames from (
      	     -- select ID as STGID,Name,NEWID() as RM_DataItemID,SortOrder as Sequence from NodeDef         where HierarchyID = @HierarchyID
	     -- union 
      	     select ID as STGID,Name,              RM_DataItemID,SortOrder as Sequence from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
	     union 
      	     select ID as STGID,Name,              RM_DataItemID,SortOrder as Sequence from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID
      ) tmp

      -- Eliminate all the Nodes which are a parent --> we only get the FinalLeaves
      select NEWID() as ID,* into #FinalLeaves0 from
      	     (select * from #ListNodesDataItemNames where STGID not in (select ParentNodeDefID from Hierarchies)) tmp

      -- We add the link with the Parent Node using Hierarchies 
      -- add the full path of the parent in order to identify the data
      select *,dbo.PS_UniqueTreeName(ParentSTGID) as ParentPath into #FinalLeaves from (
	  select fl0.*,h.ParentNodeDefID as ParentSTGID from #FinalLeaves0 fl0,Hierarchies h 
	  where h.NodeDefID = fl0.STGID
      ) tmp

	  -- select 'FinalLeaves',* from #FinalLeaves

      -- Mark all existing information as UnChecked
      update RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeDataItemAssociation
	set IsChecked = 0
	where NodeAssociationID in (
	      select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation
		      where KPITypeID = @HierarchyID and KPICompanyTemplateID = @KPICompanyTemplateID
	      union
	       -- Do NOT delete. It guarantees that if there is no data in KCNA, nothing is updated 
	      select NEWID()
	)

	-- Process to extract only the UniqueParent
	select *,NEWID() as NodeAssociationID into #FinalLeavesUParent from (select distinct ParentPath from #FinalLeaves) tmp

      -- Set the link with the RM_KPI_CMP_NodeAssociation... The link with RM_DataItemID already exists
      merge into #FinalLeavesUParent fl
	using (
	      select KCNA.ID,fl.ParentPath
		      from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation KCNA,#FinalLeavesUParent fl
		      where KCNA.KPITypeID = @HierarchyID and KPICompanyTemplateID = @KPICompanyTemplateID
		        and KCNA.Description = fl.ParentPath
	) x
	on fl.ParentPath = x.ParentPath
	when matched then
	     update set NodeAssociationID = x.ID;

	-- Associate the NodeAssociationID to all the FinalLeaves
	select * into #FinalLeaves2 from (select fl.*,flu.NodeAssociationID from #FinalLeaves fl, #FinalLeavesUParent flu where fl.ParentPath = flu.ParentPath) tmp

	-- We reset to Ischecked all existing Records
	merge into RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeDataItemAssociation KCNDA
	using (
		select ID,RM_DataItemID as DataItemID,NodeAssociationID,Sequence from #FinalLeaves2
	) x
	on x.DataItemID = KCNDA.DataItemID and x.NodeAssociationID = KCNDA.NodeAssociationID
	when MATCHED then
	     UPDATE Set IsChecked = 1
	when not matched then
	     INSERT (  ID,  NodeAssociationID,	DataItemID,IsChecked,  Sequence,CreatedBy ,CreatedOn)
	     VALUES (x.ID,x.NodeAssociationID,x.DataItemID,1	    ,x.Sequence,'ScriptJP',getdate())
      ;

END
GO

