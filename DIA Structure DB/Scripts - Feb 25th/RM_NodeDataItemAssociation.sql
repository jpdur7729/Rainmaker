CREATE TABLE [dbo].[RM_NodeDataItemAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[DataItemId] UNIQUEIDENTIFIER NOT NULL,
	[NodeIndustryAssociationId] UNIQUEIDENTIFIER NOT NULL,
	[KPIIndustryTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[IsChecked] BIT NOT NULL,
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_NodeDataItemAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_DataItem_DataItemId] FOREIGN KEY ([DataItemId]) REFERENCES [dbo].[RM_DataItem] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY ([KPIIndustryTemplateId]) REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_NodeIndustryAssociation_NodeIndustryAssociationId] FOREIGN KEY ([NodeIndustryAssociationId]) REFERENCES [dbo].[RM_NodeIndustryAssociation] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_NodeDataItemAssociation_DataItemId] ON [dbo].[RM_NodeDataItemAssociation] ([DataItemId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_NodeDataItemAssociation_KPIIndustryTemplateId] ON [dbo].[RM_NodeDataItemAssociation] ([KPIIndustryTemplateId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_NodeDataItemAssociation_NodeIndustryAssociationId] ON [dbo].[RM_NodeDataItemAssociation] ([NodeIndustryAssociationId]) ON [PRIMARY]
GO
