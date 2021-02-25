CREATE TABLE [dbo].[RM_NodeIndustryAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[NodeId] UNIQUEIDENTIFIER NOT NULL,
	[KPIIndustryTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[IsChecked] BIT NOT NULL DEFAULT (0),
	[Description] NVARCHAR(500) NULL,
	[NodeAlias] NVARCHAR(150) NULL,
	[Weight] INT NOT NULL DEFAULT (0),
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_NodeIndustryAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_NodeIndustryAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY ([KPIIndustryTemplateId]) REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id]) ON DELETE CASCADE
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_NodeIndustryAssociation_KPIIndustryTemplateId] ON [dbo].[RM_NodeIndustryAssociation] ([KPIIndustryTemplateId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_NodeIndustryAssociation_NodeId] ON [dbo].[RM_NodeIndustryAssociation] ([NodeId]) ON [PRIMARY]
GO

