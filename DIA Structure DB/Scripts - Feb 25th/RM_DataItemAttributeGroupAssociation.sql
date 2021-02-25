CREATE TABLE [dbo].[RM_DataItemAttributeGroupAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPIIndustryTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[NodeDataItemAssociationId] UNIQUEIDENTIFIER NOT NULL,
	[AttributeGroupId] UNIQUEIDENTIFIER NOT NULL,
	[ParentId] UNIQUEIDENTIFIER NOT NULL,
	[IsChecked] BIT NOT NULL,
	[IsMandatory] BIT NOT NULL,
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_DataItemAttributeGroupAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY ([AttributeGroupId]) REFERENCES [dbo].[RM_AttributeGroup] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY ([KPIIndustryTemplateId]) REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_NodeDataItemAssociation_NodeDataItemAssociationId] FOREIGN KEY ([NodeDataItemAssociationId]) REFERENCES [dbo].[RM_NodeDataItemAssociation] ([Id])
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_DataItemAttributeGroupAssociation_AttributeGroupId] ON [dbo].[RM_DataItemAttributeGroupAssociation] ([AttributeGroupId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_DataItemAttributeGroupAssociation_NodeDataItemAssociationId] ON [dbo].[RM_DataItemAttributeGroupAssociation] ([NodeDataItemAssociationId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_DataItemAttributeGroupAssociation_KPIIndustryTemplateId] ON [dbo].[RM_DataItemAttributeGroupAssociation] ([KPIIndustryTemplateId]) ON [PRIMARY]
GO
