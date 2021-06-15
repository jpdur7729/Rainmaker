-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-06 12:11:35 jpdur"
-- ------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------------
-- Create the lists of all the sysnonyms which are required to move data from STG to DIA
-- -------------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_Create_DIA_Synonyms] (@DBName as varchar(100) = 'RainmakerLDCJP_OAT') 
as
BEGIN

	-- ---------------------------------------------------------------------------------------
	-- In order to guarantee consistency we 1st delete - if they exist - all DIAxxx sysnonyms
	-- ---------------------------------------------------------------------------------------
	EXEC STG_DIA_Remove_DIA_Synonyms

	-- Define all the synonyms
	EXEC STG_DIA_Define_Synonym 'RMX_BatchStatus', @DBName
	EXEC STG_DIA_Define_Synonym 'RMX_CollectionPeriod', @DBName
	EXEC STG_DIA_Define_Synonym 'RMX_CollectionRecurrence', @DBName
	EXEC STG_DIA_Define_Synonym 'RMX_KPICategory', @DBName
	EXEC STG_DIA_Define_Synonym 'RMX_KPIType', @DBName
	EXEC STG_DIA_Define_Synonym 'RMX_ValueType', @DBName
	EXEC STG_DIA_Define_Synonym 'RMX_WorkflowStatus', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_ClassType', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_DataItem', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_CMP_NodeAssociation', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_CMP_NodeDataItemAssociation', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_CMP_RecurrenceAssociation', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_CMP_RecurrenceScenarioAssociation', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_CMP_Template', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_Collection_Batch', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_Collection_Batch_Dimension', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_Collection_DataItem', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_Collection_Dimension', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_Collection_Node', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_IND_NodeAssociation', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_IND_NodeDataItemAssociation', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_IND_Template', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_KPI_Node', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_Workflow', @DBName
	EXEC STG_DIA_Define_Synonym 'RM_WorkflowStatusHistory', @DBName

END
GO

-- EXEC STG_Create_DIA_Synonyms
-- select * from sys.synonyms



