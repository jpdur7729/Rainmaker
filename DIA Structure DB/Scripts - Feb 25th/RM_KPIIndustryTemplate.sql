-- ------------------------------------------------------------------------------
--		       Author	 : FIS - JPD
--		       Time-stamp: "2021-02-27 08:26:30 jpdur"
-- ------------------------------------------------------------------------------

-- Temporary version provided by JP to be replaced accordingly
-- Not modified i.e. this JPD's definition ==> Usage to be clarified

CREATE TABLE [dbo].[RM_KPIIndustryTemplate]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[IndustryId] UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT PK_RM_KPIIndustryTemplate PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPIIndustryTemplate_IndustryId] FOREIGN KEY ([IndustryId]) REFERENCES [dbo].[RM_Industry] ([Id])
)

-- /****** Object:  Table [dbo].[RM_KPIIndustryTemplate]    Script Date: 3/4/2021 4:01:23 AM ******/
-- SET ANSI_NULLS ON
-- GO

-- SET QUOTED_IDENTIFIER ON
-- GO

-- CREATE TABLE [dbo].[RM_KPIIndustryTemplate](
-- 	[Id] [uniqueidentifier] NOT NULL,
-- 	[IndustryId] [uniqueidentifier] NOT NULL,
-- 	[IsConfirmed] [bit] NOT NULL,
-- 	[ChangedBy] [nvarchar](50) NULL,
-- 	[ChangedOn] [datetime2](7) NOT NULL,
--  CONSTRAINT [PK_RM_KPIIndustryTemplate] PRIMARY KEY CLUSTERED 
-- (
-- 	[Id] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
-- ) ON [PRIMARY]
-- GO

-- ALTER TABLE [dbo].[RM_KPIIndustryTemplate] ADD  DEFAULT (newsequentialid()) FOR [Id]
-- GO


