-- ------------------------------------------------------------------------------
--		       Author	 : FIS - JPD
--		       Time-stamp: "2021-02-27 08:26:30 jpdur"
-- ------------------------------------------------------------------------------

-- Temporary version provided by JP to be replaced accordingly

CREATE TABLE [dbo].[RM_KPIIndustryTemplate]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[IndustryId] UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT PK_RM_KPIIndustryTemplate PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPIIndustryTemplate_IndustryId] FOREIGN KEY ([IndustryId]) REFERENCES [dbo].[RM_Industry] ([Id])
)
