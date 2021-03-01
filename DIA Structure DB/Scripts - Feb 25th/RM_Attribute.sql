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
	Name varchar(100)
	CONSTRAINT [PK_RM_Attribute] PRIMARY KEY CLUSTERED ([Id]),
)
