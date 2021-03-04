-- ------------------------------------------------------------------------------
--		       Author	 : FIS - JPD
--		       Time-stamp: "2021-03-01 13:56:03 jpdur"
-- ------------------------------------------------------------------------------

-- Temporary version provided by JP to be replaced accordingly
if exists (select * from dbo.sysobjects where id = object_id(N'RM_Attribute') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table RM_Attribute
GO

CREATE TABLE [dbo].[RM_Attribute]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	Name varchar(100),
	-- [AttributeGroupId] [uniqueidentifier] NOT NULL,
	CONSTRAINT [PK_RM_Attribute] PRIMARY KEY CLUSTERED ([Id]),
	-- CONSTRAINT [FK_RM_Attribute_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY([AttributeGroupId]) REFERENCES [dbo].[RM_AttributeGroup] ([Id])
)


-- ----------------------------------------
-- Version prvided by Kumar on 2021-03-04
-- ----------------------------------------

-- CREATE TABLE [dbo].[RM_Attribute](
-- 	[Id] [uniqueidentifier] NOT NULL,
-- 	[Name] [nvarchar](150) NULL,
-- 	[AttributeGroupId] [uniqueidentifier] NOT NULL,
--  CONSTRAINT [PK_RM_Attribute] PRIMARY KEY CLUSTERED 
-- (
-- 	[Id] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
-- ) ON [PRIMARY]
-- GO

-- ALTER TABLE [dbo].[RM_Attribute] ADD  DEFAULT (newsequentialid()) FOR [Id]
-- GO

-- ALTER TABLE [dbo].[RM_Attribute]  WITH CHECK ADD  CONSTRAINT [FK_RM_Attribute_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY([AttributeGroupId])
-- REFERENCES [dbo].[RM_AttributeGroup] ([Id])
-- ON DELETE CASCADE
-- GO

-- ALTER TABLE [dbo].[RM_Attribute] CHECK CONSTRAINT [FK_RM_Attribute_RM_AttributeGroup_AttributeGroupId]
-- GO


