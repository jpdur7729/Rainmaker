-- ------------------------------------------------------------------------------
--		       Author	 : FIS - JPD
--		       Time-stamp: "2021-03-01 06:52:00 jpdur"
-- ------------------------------------------------------------------------------

-- Temporary version provided by JP to be replaced accordingly
if exists (select * from dbo.sysobjects where id = object_id(N'RM_Workflow') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table RM_Workflow
GO

CREATE TABLE [dbo].[RM_Workflow]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	Name varchar(100),
	[CompanyId] [uniqueidentifier] NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[KpiCategoryId] [uniqueidentifier] NOT NULL,
	[WorkflowStatusId] [uniqueidentifier] NOT NULL,
	[StatusDate] [datetime2](7) NOT NULL,
	[ChangedBy] [nvarchar](50) NULL,
	CONSTRAINT [PK_RM_Workflow] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_Workflow_RM_Company_CompanyId] FOREIGN KEY([CompanyId]) REFERENCES [dbo].[RM_Company] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_Workflow_RMX_KpiCategory_KpiCategoryId] FOREIGN KEY([KpiCategoryId]) REFERENCES [dbo].[RMX_KpiCategory] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_Workflow_RMX_WorkflowStatus_WorkflowStatusId] FOREIGN KEY([WorkflowStatusId]) REFERENCES [dbo].[RMX_WorkflowStatus] ([Id]) ON DELETE CASCADE
)

-- -- Definition provided by Kumar 2021-03-04
-- ALTER TABLE [dbo].[RM_Workflow] DROP CONSTRAINT [FK_RM_Workflow_RMX_WorkflowStatus_WorkflowStatusId]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] DROP CONSTRAINT [FK_RM_Workflow_RMX_KpiCategory_KpiCategoryId]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] DROP CONSTRAINT [FK_RM_Workflow_RM_Company_CompanyId]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] DROP CONSTRAINT [DF__RM_Workflow__Id__0B761ACA]
-- GO

-- /****** Object:  Table [dbo].[RM_Workflow]    Script Date: 3/4/2021 3:46:08 AM ******/
-- IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RM_Workflow]') AND type in (N'U'))
-- DROP TABLE [dbo].[RM_Workflow]
-- GO

-- /****** Object:  Table [dbo].[RM_Workflow]    Script Date: 3/4/2021 3:46:08 AM ******/
-- SET ANSI_NULLS ON
-- GO

-- SET QUOTED_IDENTIFIER ON
-- GO

-- CREATE TABLE [dbo].[RM_Workflow](
-- 	[Id] [uniqueidentifier] NOT NULL,
-- 	[Name] [nvarchar](150) NULL,
-- 	[CompanyId] [uniqueidentifier] NOT NULL,
-- 	[EffectiveDate] [datetime2](7) NOT NULL,
-- 	[KpiCategoryId] [uniqueidentifier] NOT NULL,
-- 	[WorkflowStatusId] [uniqueidentifier] NOT NULL,
-- 	[StatusDate] [datetime2](7) NOT NULL,
-- 	[ChangedBy] [nvarchar](50) NULL,
--  CONSTRAINT [PK_RM_Workflow] PRIMARY KEY CLUSTERED,
-- (
-- 	[Id] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
-- ) ON [PRIMARY]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] ADD  DEFAULT (newsequentialid()) FOR [Id]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_RM_Workflow_RM_Company_CompanyId] FOREIGN KEY([CompanyId])
-- REFERENCES [dbo].[RM_Company] ([Id])
-- ON DELETE CASCADE
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] CHECK CONSTRAINT [FK_RM_Workflow_RM_Company_CompanyId]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_RM_Workflow_RMX_KpiCategory_KpiCategoryId] FOREIGN KEY([KpiCategoryId])
-- REFERENCES [dbo].[RMX_KpiCategory] ([Id])
-- ON DELETE CASCADE
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] CHECK CONSTRAINT [FK_RM_Workflow_RMX_KpiCategory_KpiCategoryId]
-- GO

-- ALTER TABLE [dbo].[RM_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_RM_Workflow_RMX_WorkflowStatus_WorkflowStatusId] FOREIGN KEY([WorkflowStatusId])
-- REFERENCES [dbo].[RMX_WorkflowStatus] ([Id])
-- ON DELETE CASCADE
-- GO

-- ALTER TABLE [dbo].[RM_Workflow] CHECK CONSTRAINT [FK_RM_Workflow_RMX_WorkflowStatus_WorkflowStatusId]
-- GO


