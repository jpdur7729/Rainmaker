CREATE TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICompanyConfigurationId] UNIQUEIDENTIFIER NOT NULL,
	[KPICompanyRecurrenceAssociationId] UNIQUEIDENTIFIER NOT NULL,
	[ClassTypeId] UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT [PK_RM_KPICompanyRecurrenceScenarioAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_ClassType_ClassTypeId] FOREIGN KEY ([ClassTypeId]) REFERENCES [dbo].[RM_ClassType] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY ([KPICompanyConfigurationId]) REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_KPICompanyRecurrenceAssociation_KPICompanyRecurrenceAssociationId] FOREIGN KEY ([KPICompanyRecurrenceAssociationId]) REFERENCES [dbo].[RM_KPICompanyRecurrenceAssociation] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyRecurrenceScenarioAssociation_ClassTypeId] ON [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] ([ClassTypeId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyRecurrenceScenarioAssociation_KPICompanyConfigurationId] ON [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] ([KPICompanyConfigurationId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyRecurrenceScenarioAssociation_KPICompanyRecurrenceAssociationId] ON [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] ([KPICompanyRecurrenceAssociationId]) ON [PRIMARY]
GO