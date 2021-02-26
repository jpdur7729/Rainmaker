-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-02-26 06:21:08 jpdur"
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
