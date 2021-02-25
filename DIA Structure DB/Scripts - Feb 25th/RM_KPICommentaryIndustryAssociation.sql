CREATE TABLE [dbo].[RM_KPICommentaryIndustryAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPIIndustryTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[KPICommentaryId] UNIQUEIDENTIFIER NOT NULL,
	[OrderIndex] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPICommentaryIndustryAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICommentaryIndustryAssociation_RM_KPICommentary_KPICommentaryId] FOREIGN KEY ([KPICommentaryId]) REFERENCES [dbo].[RM_KPICommentary] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICommentaryIndustryAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY ([KPIIndustryTemplateId]) REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id]) ON DELETE CASCADE
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICommentaryIndustryAssociation_KPICommentaryId] ON [dbo].[RM_KPICommentaryIndustryAssociation] ([KPICommentaryId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICommentaryIndustryAssociation_KPIIndustryTemplateId] ON [dbo].[RM_KPICommentaryIndustryAssociation] ([KPIIndustryTemplateId]) ON [PRIMARY]
GO
