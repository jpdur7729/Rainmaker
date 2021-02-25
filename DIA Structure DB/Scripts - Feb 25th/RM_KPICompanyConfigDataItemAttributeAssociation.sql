CREATE TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[KPICompanyConfigTemplateId] UNIQUEIDENTIFIER NOT NULL,
	[KPICompanyConfigNodeDataItemAssociationId] UNIQUEIDENTIFIER NOT NULL,
	[AttributeGroupId] UNIQUEIDENTIFIER NOT NULL,
	[ParentAttributeGroupId] UNIQUEIDENTIFIER NOT NULL,
	[IsChecked] BIT NOT NULL,
	[IsMandatory] BIT NOT NULL,
	[Sequence] INT NOT NULL DEFAULT (0),
	CONSTRAINT [PK_RM_KPICompanyConfigDataItemAttributeAssociation] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY ([AttributeGroupId]) REFERENCES [dbo].[RM_AttributeGroup] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_KPICompanyConfigNodeDataItemAssociation_KPICompanyConfigNodeDataItemAssoc~] FOREIGN KEY ([KPICompanyConfigNodeDataItemAssociationId]) REFERENCES [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_KPICompanyConfiguration_KPICompanyConfigTemplateId] FOREIGN KEY ([KPICompanyConfigTemplateId]) REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id]) ON DELETE CASCADE
)
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigDataItemAttributeAssociation_AttributeGroupId] ON [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] ([AttributeGroupId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigDataItemAttributeAssociation_KPICompanyConfigNodeDataItemAssociationId] ON [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] ([KPICompanyConfigNodeDataItemAssociationId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_RM_KPICompanyConfigDataItemAttributeAssociation_KPICompanyConfigTemplateId] ON [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] ([KPICompanyConfigTemplateId]) ON [PRIMARY]
GO
