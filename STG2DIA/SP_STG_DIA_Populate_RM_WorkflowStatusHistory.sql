/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-04-16 07:22:44 jpdur"
   ------------------------------------------------------------------------------ */

-- -----------------------------------------------------------------------------------------
-- Update/Create the Workflow Status History
-- -----------------------------------------------------------------------------------------
-- As this is supposed to work as part of the script just create
-- if not update the last record ==> Extra work required compared with initial version 
-- -----------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_WorkflowStatushistory] (@WorkflowID as varchar(36))
as
BEGIN

     declare @WorkflowStatusID as varchar(36) = (select WorkflowStatusId from RainmakerLDCJP_OAT.dbo.RM_Workflow where ID = @WorkflowID)

     -- Create or update RM_WorkflowStatusHistory
     -- Id	WorkflowId	WorkflowStatusId	Comments	CreatedOn	LastUpdatedOn	LastUpdatedBy
     merge into RainmakerLDCJP_OAT.dbo.RM_WorkflowStatusHistory stathist
     using (
     	   select @WorkflowID as WorkflowID,@WorkflowStatusID as WorkflowStatusID
     ) x
     on x.WorkflowID = stathist.WorkflowID
     when not matched then
     	  INSERT (Id     ,  WorkflowId,  WorkflowStatusId,Comments           ,CreatedOn,LastUpdatedOn,LastUpdatedBy)
     	  VALUES (NEWID(),x.WorkflowID,x.WorkflowStatusID,'Created by script',getdate(),getdate()    ,'JPD')
     when matched then
     	  update set WorkflowStatusID = @WorkflowStatusID, Comments = 'Updated by script', LastUpdatedOn = getdate(), LastUpdatedBy = 'JPD'
	 ; 
END
GO
