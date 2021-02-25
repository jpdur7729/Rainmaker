CREATE TABLE [dbo].[RM_KPI_Collection_Batch_Dimension]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICollectionBatchId] UNIQUEIDENTIFIER NOT NULL,
	[KPICollectionDimensionId] UNIQUEIDENTIFIER NOT NULL,
	[EffectiveDate] DATETIME2 NOT NULL,
	[Amount] DECIMAL (18, 7) NULL,
	[Percentage] DECIMAL (18, 7) NULL,
	[Ratio] DECIMAL (18, 7) NULL,
	CONSTRAINT [PK_RM_KPI_Collection_Batch_Dimension] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_Batch_Dimension_RM_KPI_Collection_Batch_KPICollectionBatchId] FOREIGN KEY ([KPICollectionBatchId]) REFERENCES dbo.[RM_KPI_Collection_Batch] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Batch_Dimension_RM_KPI_Collection_Dimension_KPICollectionDimensionId] FOREIGN KEY ([KPICollectionDimensionId]) REFERENCES dbo.[RM_KPI_Collection_Dimension] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_Dimension_KPICollectionBatchId] ON dbo.[RM_KPI_Collection_Batch_Dimension] ([KPICollectionBatchId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_Dimension_KPICollectionDimensionId] ON dbo.[RM_KPI_Collection_Batch_Dimension] ([KPICollectionDimensionId]) 
GO