CREATE TABLE [dbo].[RM_KPICompanyConfiguration]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPIIndustryTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[CreatedBy] NVARCHAR(50) NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[IsConfirmed] BIT NOT NULL DEFAULT ((0)),
	[CompanyId] UNIQUEIDENTIFIER NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[CollectionRecurrenceId] UNIQUEIDENTIFIER NOT NULL DEFAULT ('00000000-0000-0000-0000-000000000000'),
	[NoOfRecurrences] INT NOT NULL DEFAULT ((0)),
	[StartDate] DATETIME2 NOT NULL DEFAULT ('0001-01-01T00:00:00.0000000')
	CONSTRAINT [PK_RM_KPICompanyConfiguration] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICompanyConfiguration_RM_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[RM_Company] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyConfiguration_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY ([KPIIndustryTemplateId]) REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyConfiguration_RMX_CollectionRecurrence_CollectionRecurrenceId] FOREIGN KEY ([CollectionRecurrenceId]) REFERENCES [dbo].[RMX_CollectionRecurrence] ([Id]) ON DELETE CASCADE
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfiguration_KPIIndustryTemplateId] ON [dbo].[RM_KPICompanyConfiguration] ([KPIIndustryTemplateId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfiguration_CompanyId] ON [dbo].[RM_KPICompanyConfiguration] ([CompanyId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfiguration_CollectionRecurrenceId] ON [dbo].[RM_KPICompanyConfiguration] ([CollectionRecurrenceId]) ON [PRIMARY]
GO