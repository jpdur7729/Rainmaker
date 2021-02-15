-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-01-04 15:56:46 jpdur"
-- ------------------------------------------------------------------------------

-- List of Hierarchies
if exists (select * from dbo.sysobjects where id = object_id(N'HierarchyList') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table HierarchyList
GO

create table HierarchyList(

ID     	     varchar(56)	NOT NULL PRIMARY KEY,
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
Name	     varchar(50)  	NOT NULL, -- ParentDataPoint ID
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX HierarchyList_Unique on HierarchyList(Name)
GO

-- List of Industries
if exists (select * from dbo.sysobjects where id = object_id(N'IndustryList') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table IndustryList
GO

create table IndustryList(

ID     	     varchar(56)	NOT NULL PRIMARY KEY,
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
Name	     varchar(50)  	NOT NULL, -- ParentDataPoint ID
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX IndustryList_Unique on IndustryList(Name)
GO

-- List of Companies
if exists (select * from dbo.sysobjects where id = object_id(N'CompanyList') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table CompanyList
GO

create table CompanyList(

ID     	     varchar(56)	NOT NULL PRIMARY KEY,
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
Name	     varchar(50)  	NOT NULL, -- ParentDataPoint ID
IndustryID   varchar(36)	NOT NULL  -- Industry ID
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX CompanyList_Unique on CompanyList(Name,IndustryID)
GO

-- Hierarchies based on Nodes
if exists (select * from dbo.sysobjects where id = object_id(N'Hierarchies') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Hierarchies
GO

create table Hierarchies(

LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
ParentNodeDefID varchar(36)  	  NOT NULL, -- ParentDataPoint ID
NodeDefID       varchar(36)  	  NOT NULL  -- DataPoint ID
-- Top level is defined with ParentDPD_ID = DPD_ID
-- That way a top level can be added
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX Hierarchies_Unique on Hierarchies(NodeDefID,ParentNodeDefID)
GO
