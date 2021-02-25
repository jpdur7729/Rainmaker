CREATE TABLE [dbo].[RM_KPI_Collection_Batch]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KpiTypeId] UNIQUEIDENTIFIER NOT NULL,
	[ReportingDate] DATETIME2 NOT NULL,
	[CompanyId] UNIQUEIDENTIFIER NOT NULL,
	[CollectionPeriodId] UNIQUEIDENTIFIER NOT NULL,
	[BatchStatusId] UNIQUEIDENTIFIER NOT NULL,
	[WorkflowId] UNIQUEIDENTIFIER NOT NULL,
	[CreatedBy] NVARCHAR(50) NULL,
	[CreatedOn] DATETIME2 NOT NULL,
	[ScenarioTypeId] UNIQUEIDENTIFIER NOT NULL,
	[AsOfDate] DATETIME2 NULL,
	CONSTRAINT [PK_RM_KPI_Collection_Batch] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[RM_Company] ([Id]),
	CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_Workflow_WorkflowId] FOREIGN KEY ([WorkflowId]) REFERENCES [dbo].[RM_Workflow] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_BatchStatus_BatchStatusId] FOREIGN KEY ([BatchStatusId]) REFERENCES dbo.[RMX_BatchStatus] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_CollectionPeriod_CollectionPeriodId] FOREIGN KEY ([CollectionPeriodId]) REFERENCES [dbo].[RMX_CollectionPeriod] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_KpiType_KpiTypeId] FOREIGN KEY ([KpiTypeId]) REFERENCES dbo.[RMX_KpiType] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_ClassType_ScenarioTypeId] FOREIGN KEY ([ScenarioTypeId]) REFERENCES [dbo].[RM_ClassType] ([Id]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_BatchStatusId] ON dbo.[RM_KPI_Collection_Batch] ([BatchStatusId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_CollectionPeriodId] ON dbo.[RM_KPI_Collection_Batch] ([CollectionPeriodId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_CompanyId] ON dbo.[RM_KPI_Collection_Batch] ([CompanyId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_KpiTypeId] ON dbo.[RM_KPI_Collection_Batch] ([KpiTypeId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_WorkflowId] ON dbo.[RM_KPI_Collection_Batch] ([WorkflowId])
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPI_Collection_Batch_ScenarioTypeId] ON [dbo].[RM_KPI_Collection_Batch] ([ScenarioTypeId])
GO
