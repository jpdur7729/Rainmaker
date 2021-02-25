CREATE TABLE [dbo].[RM_KPI_Collection_Dimension]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICollectionDataItemId] UNIQUEIDENTIFIER NOT NULL,
	[AttributeId] UNIQUEIDENTIFIER NULL,
	[ParentKPICollectionDimensionId] UNIQUEIDENTIFIER NULL,
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPI_Collection_Dimension] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_AttributeGroup_AttributeId] FOREIGN KEY ([AttributeId]) REFERENCES [dbo].[RM_Attribute] ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_KPI_Collection_DataItem_KPICollectionDataItemId] FOREIGN KEY ([KPICollectionDataItemId]) REFERENCES dbo.[RM_KPI_Collection_DataItem] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_KPI_Collection_Dimension_ParentKPICollectionDimensionId] FOREIGN KEY ([ParentKPICollectionDimensionId]) REFERENCES dbo.[RM_KPI_Collection_Dimension] ([Id])
)
GO

CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Dimension_AttributeGroupId] ON dbo.[RM_KPI_Collection_Dimension] ([AttributeId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Dimension_KPICollectionDataItemId] ON dbo.[RM_KPI_Collection_Dimension] ([KPICollectionDataItemId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Dimension_ParentKPICollectionDimensionId] ON dbo.[RM_KPI_Collection_Dimension] ([ParentKPICollectionDimensionId]) 
GO

