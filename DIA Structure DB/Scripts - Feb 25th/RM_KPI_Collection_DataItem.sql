CREATE TABLE [dbo].[RM_KPI_Collection_DataItem]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICollectionNodeId] UNIQUEIDENTIFIER NOT NULL,
	[DataItemId] UNIQUEIDENTIFIER NOT NULL,
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPI_Collection_DataItem] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_DataItem_RM_DataItem_DataItemId] FOREIGN KEY ([DataItemId]) REFERENCES [dbo].[RM_DataItem] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_DataItem_RM_KPI_Collection_Node_KPICollectionNodeId] FOREIGN KEY ([KPICollectionNodeId]) REFERENCES dbo.[RM_KPI_Collection_Node] ([Id])
)
GO

CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_DataItem_DataItemId] ON dbo.[RM_KPI_Collection_DataItem] ([DataItemId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_DataItem_KPICollectionNodeId] ON dbo.[RM_KPI_Collection_DataItem] ([KPICollectionNodeId]) 
GO
