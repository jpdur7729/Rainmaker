-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 15:44:39 jpdur"
-- ------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- This an ugly patch to create the needed data and see if from that point onwards
-- the XL Addin can actually start populating the data
-- --------------------------------------------------------------------------------
-- !!!!!!!  ONLY USE FOR TESTING !!!!!!!!
-- INSERT WITHOUT CHECKING IF THE INFORMATION IS ALREADY THERE 
-- --------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_Patch_RM_KPI_Collection_Node ] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) ,
@CollectionDate as date,@ScenarioName as varchar(100))
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      declare @WorkflowStatusID as nvarchar(36)
      set @WorkflowStatusID = (select ID from RainmakerLDCJP_OAT.dbo.RMX_WorkflowStatus where Name = 'Pending Review')

      -- Extra WorkflowID
      declare @WorkflowID as nvarchar(36)
      set @WorkflowID = (select ID from RainmakerLDCJP_OAT.dbo.RM_Workflow where CompanyID = @CompanyID and EffectiveDate = @CollectionDate and WorkflowStatusID = @WorkflowStatusID)

      -- Get the Data for Andean and then Patch them accordingly for the received company (assume to be in the right industry etc...)
      declare @RefCompanyID as nvarchar(36)
      declare @RefKPICompanyConfigurationID as nvarchar(36)
      set @RefCompanyID   = (select ID from CompanyList where Name = 'Andean Luxury Fabrics' )
      set @RefKPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @RefCompanyID )
      -- declare @RefWorkflowID as nvarchar(36)
      -- set @RefWorkflowID = (select ID from RainmakerLDCJP_OAT.dbo.RM_Workflow where CompanyID = @RefCompanyID and EffectiveDate = @CollectionDate and WorkflowStatusID = @WorkflowStatusID)

      -- Get into an intermediate table the data from Andean
      select N.Name,NEWID() as NewID,NEWID() as NewParentKPICollectionNodeId,
      	     KCN.*
      	     into #InterTable
      	     from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node KCN,RainmakerLDCJP_OAT.dbo.RM_Node N
      where WorkflowID = '053527C0-0876-420C-B57E-ACDA02BB1057' -- Hard coded for the time being 
	    and KCN.NodeID = N.ID
	    -- order by KCN.sequence

      -- Replace the IDs for those corresponding to the new company into the #InterTable
      update #InterTable set WorkflowID = @WorkflowID

      -- Process the Top Nodes for which there is No ParentKPICollectionNodeId
      Update #InterTable set NewParentKPICollectionNodeId = null where ParentKPICollectionNodeId is null 

      -- Update the NewParentKPICollectionNodeID into the Intermediate Table
      merge into #InterTable
      using (
      	    select t1.ParentKPICollectionNodeID,t2.NewID
	    from #InterTable t1,#InterTable t2
	    where t1.ParentKPICollectionNodeID = t2.ID
	    	  and t1.ParentKPICollectionNodeID is not null
      ) x
      on
	x.ParentKPICollectionNodeID = #InterTable.ParentKPICollectionNodeID
      when matched then
      	   update set NewParentKPICollectionNodeID = x.NewID ;

     -- Debug
     -- select * from #InterTable

     -- Insert into the Collection_Node table
     INSERT INTO RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
     select NewID,WorkflowID,NodeID,NewParentKPICollectionNodeID,KPITypeID,Sequence 
	 from #InterTable

     -- Next Step patch the data into KPI_Collection_DataItem
     -- 1st extract the data that will be used 
     select NEWID() as NewID,NEWID() as NewKPICollectionNodeID,*
     	    into #InterTableDataItem
     	    from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem
     	    	 where KPICollectionNodeID in (select ID from #InterTable)

     merge into #InterTableDataItem target
     using (
     	   select ID,NewID from #InterTable
     ) x
     on x.ID = target.KPICollectionNodeID
	 when matched then
     update set NewKPICollectionNodeID = x.NewID;

     -- Add the data into the table 
     insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem
     select NewID,NewKPICollectionNodeID,DataItemId,Sequence from #InterTableDataItem

     -- Next Step patch the data into KPI_Collection_DataItem
     -- 1st extract the data that will be used

     -- Next Step patch the data into KPI_Collection_Dimension
     -- 1st extract the data that will be used based on ther reference i.e. Andean
     select NEWID() as NewID,NEWID() as NewKPICollectionDataItemID,*
     	    into #InterTableDimension
     	    from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension
     	    	 where KPICollectionDataItemID in (select ID from #InterTableDataItem)

     merge into #InterTableDimension target
     using (
     	   select ID,NewID from #InterTableDataItem
     ) x
     on x.ID = target.KPICollectionDataItemID
	 when matched then 
     update set NewKPICollectionDataItemID = x.NewID;

     -- Insert into the Collection_Dimension 
     insert into RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension
     select NewID,NewKPICollectionDataItemID,AttributeID,ParentKPICollectionDimensionID,Sequence from #InterTableDimension
     
     
END
GO

