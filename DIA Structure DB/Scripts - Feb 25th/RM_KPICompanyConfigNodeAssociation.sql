CREATE TABLE [dbo].[RM_KPICompanyConfigNodeAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICompanyConfigurationId] UNIQUEIDENTIFIER NOT NULL,
	[NodeId] UNIQUEIDENTIFIER NOT NULL,
	[IsChecked] BIT NOT NULL DEFAULT ((0)),
	[KpiTypeId] UNIQUEIDENTIFIER NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[Weight] [int] NOT NULL DEFAULT ((0)),
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPICompanyConfigNodeAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICompanyConfigNodeAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY ([KPICompanyConfigurationId]) REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyConfigNodeAssociation_RMX_KpiType_KpiTypeId] FOREIGN KEY ([KpiTypeId]) REFERENCES [dbo].[RMX_KpiType] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigNodeAssociation_KPICompanyConfigurationId] ON [dbo].[RM_KPICompanyConfigNodeAssociation] ([KPICompanyConfigurationId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigNodeAssociation_NodeId] ON [dbo].[RM_KPICompanyConfigNodeAssociation] ([NodeId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigNodeAssociation_KpiTypeId] ON [dbo].[RM_KPICompanyConfigNodeAssociation] ([KpiTypeId]) ON [PRIMARY]
GO