/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-15 15:08:27 jpdur"
   ------------------------------------------------------------------------------ */

-- Objective is to upload all the datapoints corresponding to a series/Collection i.e.
-- for a Hierarchy/Industry/Company and a Date
-- v1 By default // Monthly- Draft - Financials ==> To be improved in future version
-- based on the E004 model where FinalLeaves are by definition L1(No children) + L2

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Delete_Workflow] ( @WorkflowID as varchar(36))
as
BEGIN

	-- Delete the DataPoints
	EXEC STG_DIA_Delete_DataPoints @WorkflowID

	-- Delete the Status History for the Workflow
	delete from RainmakerLDCJP_OAT.dbo.RM_WorkflowStatusHistory where WorkflowID = @WorkflowID

	-- Delete the KPICollectionBatchID
	delete from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch where WorkflowID = @WorkflowID

	-- Delete from the workfow table finally
	delete from RainmakerLDCJP_OAT.dbo.RM_Workflow where ID = @WorkflowID

END
GO
