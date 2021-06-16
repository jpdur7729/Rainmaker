/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-06-16 11:05:41 jpdur"
   ------------------------------------------------------------------------------ */

-- Usually empty except for Cash or the legacy LDC/NAV structure for BS and PL
-- ---------------------------------------------------------------------------------
-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ---------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPI_IND_NodeDataItemAssociation] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from DIARM_KPI_IND_Template where IndustryID = @IndustryID )

      -- Select the only Nodes which will be DataItem at the Industry Level 
      select NEWID() as ID,ID as STGID,Name,RM_DataItemID,SortOrder as Sequence
      	     into #FinalLeaves0 from NodeDefIndustry
	     where HierarchyID = @HierarchyID and IndustryID = @IndustryID and Port = 'D'

	-- We add the link with the Parent Node using Hierarchies 
	-- add the full path of the parent in order to identify the data
	select *,dbo.PS_UniqueTreeName(ParentSTGID) as ParentPath into #FinalLeaves from (
	  select fl0.*,h.ParentNodeDefID as ParentSTGID from #FinalLeaves0 fl0,Hierarchies h 
	  where h.NodeDefID = fl0.STGID
	) tmp
	  
      -- At the industry level - Except for cash flows usually empty
      if EXISTS(select * from #FinalLeaves) begin

      	 -- Mark all existing information as UnChecked
	 update DIARM_KPI_IND_NodeDataItemAssociation
	 set IsChecked = 0
	 where NodeAssociationID in (
	       select ID from DIARM_KPI_IND_NodeAssociation
	       	      where KPITypeID = @HierarchyID and KPIIndustryTemplateID = @KPIIndustryTemplateID
	       union
	        -- Do NOT delete. It guarantees that if there is no data in KINA, nothing is updated 
	       select NEWID()
	 )

	 -- Process to extract only the UniqueParent
	 select *,NEWID() as NodeAssociationID into #FinalLeavesUParent from (select distinct ParentPath from #FinalLeaves) tmp      	 -- Set the link with the RM_KPI_IND_NodeAssociation... The link with RM_DataItemID already exists

         -- Set the link with the RM_KPI_IND_NodeAssociation... The link with RM_DataItemID already exists
	 merge into #FinalLeavesUParent fl
	 using (
	       select KINA.ID,fl.ParentPath
	       	      from DIARM_KPI_IND_NodeAssociation KINA,#FinalLeavesUParent fl
	       	      where KINA.KPITypeID = @HierarchyID and KPIIndustryTemplateID = @KPIIndustryTemplateID
		      	    and KINA.Description = fl.ParentPath
	 ) x
	 on fl.ParentPath = x.ParentPath
	 when matched then
	      update set NodeAssociationID = x.ID;

	-- Associate the NodeAssociationID to all the FinalLeaves
	select * into #FinalLeaves2 from (select fl.*,flu.NodeAssociationID from #FinalLeaves fl, #FinalLeavesUParent flu where fl.ParentPath = flu.ParentPath) tmp

	-- Debug
	select * from #FinalLeaves2 

         -- We reset to Ischecked all existing Records
	 merge into DIARM_KPI_IND_NodeDataItemAssociation KINDA
	 using (
		select ID,RM_DataItemID as DataItemID,NodeAssociationID,Sequence from #FinalLeaves2
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

