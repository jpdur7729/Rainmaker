CREATE TABLE [dbo].[RM_KPICommentaryCompanyAssocation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICompanyConfigTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[KPICommentaryId] UNIQUEIDENTIFIER NOT NULL,
	[OrderIndex] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPICommentaryCompanyAssocation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICommentaryCompanyAssocation_RM_KPICommentary_KPICommentaryId] FOREIGN KEY ([KPICommentaryId]) REFERENCES [dbo].[RM_KPICommentary] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICommentaryCompanyAssocation_RM_KPICompanyConfiguration_KPICompanyConfigTemplateId] FOREIGN KEY ([KPICompanyConfigTemplateId]) REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id]) ON DELETE CASCADE
) 
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICommentaryCompanyAssocation_KPICommentaryId] ON [dbo].[RM_KPICommentaryCompanyAssocation] ([KPICommentaryId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICommentaryCompanyAssocation_KPICompanyConfigTemplateId] ON [dbo].[RM_KPICommentaryCompanyAssocation] ([KPICompanyConfigTemplateId]) 
GO
