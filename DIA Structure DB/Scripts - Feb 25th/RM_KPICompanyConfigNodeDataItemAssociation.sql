CREATE TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICompanyConfigurationId] UNIQUEIDENTIFIER NOT NULL,
	[KPICompanyConfigNodeAssociationId] UNIQUEIDENTIFIER NOT NULL,
	[DataItemId] UNIQUEIDENTIFIER NOT NULL,
	[IsChecked] BIT NOT NULL,
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPICompanyConfigNodeDataItemAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_DataItem_DataItemId] FOREIGN KEY ([DataItemId]) REFERENCES [dbo].[RM_DataItem] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_KPICompanyConfigNodeAssociation_KPICompanyConfigNodeAssociationId] FOREIGN KEY ([KPICompanyConfigNodeAssociationId]) REFERENCES [dbo].[RM_KPICompanyConfigNodeAssociation] ([Id]),
	CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY ([KPICompanyConfigurationId]) REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigNodeDataItemAssociation_DataItemId] ON [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ([DataItemId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigNodeDataItemAssociation_KPICompanyConfigurationId] ON [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ([KPICompanyConfigurationId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigNodeDataItemAssociation_KPICompanyConfigNodeAssociationId] ON [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ([KPICompanyConfigNodeAssociationId]) ON [PRIMARY]
GO
