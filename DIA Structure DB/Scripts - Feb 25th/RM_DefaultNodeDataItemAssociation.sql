CREATE TABLE [dbo].[RM_DefaultNodeDataItemAssociation]
(
	[Id] UNIQUEIDENTIFIER NOT NULL,
	[DefaultNodeId] UNIQUEIDENTIFIER NOT NULL,
	[DataItemId] UNIQUEIDENTIFIER NOT NULL,
	[KpiTypeId] UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT [PK_RM_DefaultNodeDataItemAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RM_DataItem_DataItemId] FOREIGN KEY([DataItemId]) REFERENCES [dbo].[RM_DataItem] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RM_Node_NodeId] FOREIGN KEY([DefaultNodeId]) REFERENCES [dbo].[RM_Node] ([Id]),
	CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RMX_KpiType_KpiTypeId] FOREIGN KEY([KpiTypeId]) REFERENCES [dbo].[RMX_KpiType] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_DefaultNodeDataItemAssociation_DataItemId] ON [dbo].[RM_DefaultNodeDataItemAssociation] ([DataItemId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_DefaultNodeDataItemAssociation_KpiTypeId] ON [dbo].[RM_DefaultNodeDataItemAssociation] ([KpiTypeId]) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_DefaultNodeDataItemAssociation_NodeId] ON [dbo].[RM_DefaultNodeDataItemAssociation] ([DefaultNodeId]) 
GO