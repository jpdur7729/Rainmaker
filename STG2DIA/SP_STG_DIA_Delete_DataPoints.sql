/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-18 20:12:54 jpdur"
   ------------------------------------------------------------------------------ */

-- Objective is to upload all the datapoints corresponding to a series/Collection i.e.
-- for a Hierarchy/Industry/Company and a Date
-- v1 By default // Monthly- Draft - Financials ==> To be improved in future version
-- based on the E004 model where FinalLeaves are by definition L1(No children) + L2

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Delete_DataPoints] ( @WorkflowID as varchar(36))
as
BEGIN

	-- Prepare the characteristics of the backup
	declare @BatchID   as varchar(36) = NEWID()
	declare @Timestamp as datetime    = getdate()

	-- Read the intermediate tables fr9om top to bottom
	-- then delete them accordingly from Bottom to Top
	-- All the extra precautions union xxx coalesce... are just to prevent the null situation and some uncontrolled delete

	select * into #CollectionNode           from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node            where WorkflowID = coalesce(@WorkflowID,'ZZZ') 
	select * into #CollectionDataItem       from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem        where KPICollectionNodeID      in (select ID from #CollectionNode	     union select NEWID())	 
	select * into #CollectionDimension	from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension	      where KPICollectionDataItemID  in (select ID from #CollectionDataItem  union select NEWID())
	select * into #CollectionBatchDimension from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension where KPICollectionDimensionID in (select ID from #CollectionDimension union select NEWID())

	-- Save the data which is about to be deleted
	insert into Backup_Collection_Batch_Dimension select @BatchID,@Timestamp,* from #CollectionBatchDimension
	insert into Backup_Collection_Dimension       select @BatchID,@Timestamp,* from #CollectionDimension     
	insert into Backup_Collection_DataItem        select @BatchID,@Timestamp,* from #CollectionDataItem      
	insert into Backup_Collection_Node            select @BatchID,@Timestamp,* from #CollectionNode          

	-- Delete the data in the corresponding table
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension where ID in (select ID from #CollectionBatchDimension union select NEWID())
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension	     where ID in (select ID from #CollectionDimension      union select NEWID())
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem	     where ID in (select ID from #CollectionDataItem       union select NEWID())
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node            where ID in (select ID from #CollectionNode           union select NEWID())

END
GO
