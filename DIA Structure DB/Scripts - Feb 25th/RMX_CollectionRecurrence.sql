﻿CREATE TABLE [dbo].[RMX_CollectionRecurrence]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[Name] NVARCHAR(50) NULL,
	CONSTRAINT [PK_RMX_CollectionRecurrence] PRIMARY KEY CLUSTERED ([Id])
)
