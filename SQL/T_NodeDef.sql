-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 14:31:12 jpdur"
-- ------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------
-- Creation of the 3 NodeDefs Table (NodeDef/NodeDefIndustry/NodeDefCompany)
-- ------------------------------------------------------------------------------

-- Storage of the nodes definition and hierarchies
if exists (select * from dbo.sysobjects where id = object_id(N'NodeDef') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table NodeDef
GO

create table NodeDef(

ID     	     varchar(36)	NOT NULL PRIMARY KEY, -- the UID
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
Name	      varchar(100)  	  NOT NULL, -- DataPoint ID
Level 	      integer		  NOT NULL, -- Level within a hierarchy
HierarchyID   varchar(100)	  NOT NULL,  -- Hierarchy definition
SortOrder     integer		  NOT NULL  DEFAULT 0,
-- Add this ID to make it unique to idetify the parent without ambiguity
RM_NODE_ID	UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX NodeDef_Unique on NodeDef(Name,Level,HierarchyID)
GO

-- -----------------------------------------------------------------------------------
-- Storage of the nodes definition at the Industry level - Assumed to be 1 level only
-- hence there is no level field
-- -----------------------------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'NodeDefIndustry') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table NodeDefIndustry
GO

create table NodeDefIndustry(

ID     	     varchar(36)	NOT NULL PRIMARY KEY, -- the UID
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
Name	      varchar(100)  	  NOT NULL, -- DataPoint ID
IndustryID    varchar(36)	  NOT NULL, -- Industry ID
HierarchyID   varchar(36)	  NOT NULL,  -- Hierarchy ID
SortOrder     integer		  NOT NULL  DEFAULT 0,
ParentLevelName varchar(100) 	  NOT NULL,
-- Add this ID to make it unique to idetify the parent without ambiguity
RM_NODE_ID	UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX NodeDefIndustry_Unique on NodeDefIndustry(Name,IndustryID,HierarchyID,ParentLevelName)
GO

-- Storage of the nodes definition at the Company level - Assumed to be 2 levels at most
if exists (select * from dbo.sysobjects where id = object_id(N'NodeDefCompany') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table NodeDefCompany
GO

create table NodeDefCompany(

ID     	     varchar(36)	NOT NULL PRIMARY KEY, -- the UID
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
Name	      varchar(100)  	  NOT NULL, -- DataPoint ID
Level 	      integer		  NOT NULL, -- Level within a hierarchy
CompanyID     varchar(36)	  NOT NULL, -- Company ID
IndustryID    varchar(36)	  NOT NULL, -- Industry ID
HierarchyID   varchar(36)	  NOT NULL,  -- Hierarchy ID
SortOrder     integer		  NOT NULL DEFAULT 0,
ParentLevelName varchar(100) 	  NOT NULL,
-- Add this ID to make it unique to idetify the parent without ambiguity
RM_NODE_ID	UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX NodeDefCompany_Unique on NodeDefCompany(Name,Level,CompanyID,IndustryID,HierarchyID,ParentLevelName)
GO

