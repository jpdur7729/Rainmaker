/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-11 08:30:43 jpdur"
   ------------------------------------------------------------------------------ */

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_IND_NodeDaItemAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_Template where IndustryID = @IndustryID )

      -- Process all the final Leaves for the Hierarchy/Industry/Company
      select * into #ListNodesDataItemNames from (
      	     -- select ID as STGID,Name,NEWID() as RM_DataItemID from NodeDef         where HierarchyID = @HierarchyID
	     -- union 
      	     select ID as STGID,Name,           RM_DataItemID from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
      ) tmp

      -- Eliminate all the Nodes which are a parent --> we only get the FinalLeaves
      select NEWID() as ID,*,NEWID() as NodeAssociationID
      	     into #FinalLeaves0 from
      	     (select * from #ListNodesDataItemNames where STGID not in (select ParentNodeDefID from Hierarchies)) tmp

	-- We add the link with the Parent Node using Hierarchies 
	-- add the full path of the parent in order to identify the data
	select *,dbo.PS_UniqueTreeName(ParentSTGID) as ParentPath into #FinalLeaves from (
	  select fl0.*,h.ParentNodeDefID as ParentSTGID from #FinalLeaves0 fl0,Hierarchies h 
	  where h.NodeDefID = fl0.STGID
	) tmp
	  
      -- At the industry level - Except for cash flows usually empty
      if EXISTS(select * from #FinalLeaves) begin

      	 -- Mark all existing information as UnChecked
	 update RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeDataItemAssociation
	 set IsChecked = 0
	 where NodeAssociationID in (
	       select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeAssociation
	       	      where KPITypeID = @HierarchyID and KPIIndustryTemplateID = @KPIIndustryTemplateID
	       union
	        -- Do NOT delete. It guarantees that if there is no data in KINA, nothing is updated 
	       select NEWID()
	 )

      	 -- Set the link with the RM_KPI_IND_NodeAssociation... The link with RM_DataItemID already exists
      	 merge into #FinalLeaves fl
	 using (
	       select KINA.ID,Kina.FullPath,fl.ParentPath
	       	      from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeAssociation KINA,#FinalLeaves fl
	       	      where KINA.KPITypeID = @HierarchyID and KPIIndustryTemplateID = @KPIIndustryTemplateID
		      	    and KINA.Description = fl.ParentPath
	 ) x
	 on fl.ParentPath = x.ParentPath
	 when matched then
	      update set NodeAssociationID = x.ID;

	 -- We reset to Ischecked all existing Records
	 merge into RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeDataItemAssociation KINDA
	 using (
		select ID,DataItemID,NodeAssociationID from #FinalLeaves
	 ) x
	 on x.DataItemID = KINDA.DataItemID and x.NodeAssociationID = KINDA.NodeAssociationID
	 when MATCHED then
	      UPDATE Set IsChecked = 1
	 when not matched then
	      INSERT (  ID,  NodeAssociationID,  DataItemID,IsChecked,  Sequence,CreatedBy ,CreatedOn)
	      VALUES (x.ID,x.NodeAssociationID,x.DataItemID,1        ,x.Sequence,'ScriptJP',getdate())
         ;
     
      end 

END
GO

