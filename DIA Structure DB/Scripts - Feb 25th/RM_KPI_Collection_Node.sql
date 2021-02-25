CREATE TABLE [dbo].[RM_KPI_Collection_Node]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[WorkflowId] UNIQUEIDENTIFIER NOT NULL,
	[NodeId] UNIQUEIDENTIFIER NOT NULL,
	[ParentKPICollectionNodeId] UNIQUEIDENTIFIER NULL,
	[KpiTypeId] UNIQUEIDENTIFIER NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPI_Collection_Node] PRIMARY KEY CLUSTERED ([Id]), 
	CONSTRAINT [FK_RM_KPI_Collection_Node_RM_KPI_Collection_Node_ParentKPICollectionNodeId] FOREIGN KEY ([ParentKPICollectionNodeId]) REFERENCES dbo.[RM_KPI_Collection_Node] ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_Node_RM_Node_NodeId] FOREIGN KEY ([NodeId]) REFERENCES [dbo].[RM_Node] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Node_RM_Workflow_WorkflowId] FOREIGN KEY ([WorkflowId]) REFERENCES [dbo].[RM_Workflow] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Node_RMX_KpiType_KpiTypeId] FOREIGN KEY ([KpiTypeId]) REFERENCES [dbo].[RMX_KpiType] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Node_NodeId] ON dbo.[RM_KPI_Collection_Node] ([NodeId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Node_ParentKPICollectionNodeId] ON dbo.[RM_KPI_Collection_Node] ([ParentKPICollectionNodeId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Node_WorkflowId] ON dbo.[RM_KPI_Collection_Node] ([WorkflowId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Node_KpiTypeId] ON dbo.[RM_KPI_Collection_Node] ([KpiTypeId])
GO
