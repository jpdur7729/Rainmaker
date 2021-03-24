/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-03-24 14:36:59 jpdur"
   ------------------------------------------------------------------------------ */

-- Objective is to upload all the datapoints corresponding to a series/Collection i.e.
-- for a Hierarchy/Industry/Company and a Date
-- v1 By default // Monthly- Draft - Financials ==> To be improved in future version
-- based on the E004 model where FinalLeaves are by definition L1(No children) + L2

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Delete_DataPoints] ( @WorkflowID as varchar(36))
as
BEGIN

	-- Read the intermediate tables fr9om top to bottom
	-- then delete them accordingly from Bottom to Top
	-- All the extra precautions union xxx coalesce... are just to prevent the null situation and some uncontrolled delete

	select * into #CollectionNode           from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node            where WorkflowID = coalesce(@WorkflowID,'ZZZ') 
	select * into #CollectionDataItem       from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem        where KPICollectionNodeID      in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node      union select NEWID())	 
	select * into #CollectionDimension	from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension	      where KPICollectionDataItemID  in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem  union select NEWID())
	select * into #CollectionBatchDimension from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension where KPICollectionDimensionID in (select ID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension union select NEWID())

	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension where ID in (select ID from #CollectionBatchDimension union select NEWID())
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension	     where ID in (select ID from #CollectionDimension      union select NEWID())
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem	     where ID in (select ID from #CollectionDataItem       union select NEWID())
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node            where ID in (select ID from #CollectionNode           union select NEWID())

END
GO
