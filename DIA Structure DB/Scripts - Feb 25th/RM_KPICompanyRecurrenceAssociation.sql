CREATE TABLE [dbo].[RM_KPICompanyRecurrenceAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICompanyConfigurationId] UNIQUEIDENTIFIER NOT NULL,
	[StartDate] DATETIME2 NOT NULL,
	[EndDate] DATETIME2 NULL,
	[CollectionPeriodId] UNIQUEIDENTIFIER NOT NULL,
	[KpiCategoryId] UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT [PK_RM_KPICompanyRecurrenceAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY ([KPICompanyConfigurationId]) REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RMX_CollectionPeriod_CollectionPeriodId] FOREIGN KEY ([CollectionPeriodId]) REFERENCES [dbo].[RMX_CollectionPeriod] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RMX_KpiCategory_KpiCategoryId] FOREIGN KEY ([KpiCategoryId]) REFERENCES [dbo].[RMX_KpiCategory] ([Id]) ON DELETE CASCADE
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyRecurrenceAssociation_CollectionPeriodId] ON [dbo].[RM_KPICompanyRecurrenceAssociation] ([CollectionPeriodId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyRecurrenceAssociation_KPICompanyConfigurationId] ON [dbo].[RM_KPICompanyRecurrenceAssociation] ([KPICompanyConfigurationId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyRecurrenceAssociation_KpiCategoryId] ON [dbo].[RM_KPICompanyRecurrenceAssociation] ([KpiCategoryId]) ON [PRIMARY]
GO
