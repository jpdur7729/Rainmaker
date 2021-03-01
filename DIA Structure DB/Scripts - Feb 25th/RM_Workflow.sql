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
	Name varchar(100)
	CONSTRAINT [PK_RM_Workflow] PRIMARY KEY CLUSTERED ([Id]),
)
