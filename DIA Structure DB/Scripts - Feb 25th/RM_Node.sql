﻿CREATE TABLE [dbo].[RM_Node]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[Name] NVARCHAR(150) NULL,
	[IsSystemDefined] BIT NOT NULL,
	[ParentNodeId] UNIQUEIDENTIFIER NULL,
	[KPITypeId] UNIQUEIDENTIFIER NOT NULL,
	[IsNewNode] BIT NOT NULL DEFAULT (0),
	[IndustryId] UNIQUEIDENTIFIER NULL,
	[Sequence] INT NULL,
	CONSTRAINT [PK_RM_Node] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_Node_RMX_KpiType_KPITypeId] FOREIGN KEY ([KPITypeId]) REFERENCES [dbo].[RMX_KpiType] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_Node_RM_Node_ParentNodeId] FOREIGN KEY ([ParentNodeId]) REFERENCES [dbo].[RM_Node] ([Id]),
	CONSTRAINT [FK_RM_Node_RM_Industry_IndustryId] FOREIGN KEY ([IndustryId]) REFERENCES [dbo].[RM_Industry] ([Id])
)
GO

CREATE NONCLUSTERED INDEX [IX_RM_Node_KPITypeId] ON [dbo].[RM_Node] ([KPITypeId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_Node_ParentNodeId] ON [dbo].[RM_Node] ([ParentNodeId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_Node_IndustryId] ON [dbo].[RM_Node] ([IndustryId]) ON [PRIMARY]
GO