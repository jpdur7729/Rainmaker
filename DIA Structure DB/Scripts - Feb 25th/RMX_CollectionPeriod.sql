﻿CREATE TABLE [dbo].[RMX_CollectionPeriod]
(
	[Id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
	[Name] NVARCHAR(50) NULL,
	ShortName NVARCHAR(10) NULL,
	CONSTRAINT PK_RMX_CollectionPeriod PRIMARY KEY CLUSTERED ([Id]) 
)
