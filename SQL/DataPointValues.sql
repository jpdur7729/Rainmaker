-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-02-15 15:28:08 jpdur"
-- ------------------------------------------------------------------------------

-- Storage of the values associated to a given DataPoint

if exists (select * from dbo.sysobjects where id = object_id(N'DataPointValues') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table DataPointValues
GO

create table DataPointValues(

LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------         -- Standard Header
DataPointID   varchar(36)  	  NOT NULL, -- DataPoint ID
Scenario      varchar(10)	  NOT NULL, -- The scenario Budget/Actual/Forecast etc...
DataPointDate date	 	  NOT NULL, -- The date associated to the data point
NumValue      float               , -- Numerical Value i.e.usually Amount
PctValue      decimal(12,8)	  , -- For % value
TxtValue      varchar(10),	   -- For Text Value

 PRIMARY KEY (DataPointID,Scenario,DataPointDate)
)

-- -- Test Insert
-- insert into DataPointValues (LastUser,createdAt,updatedAt,DataPointID,Scenario,DataPointDate,NumValue )values ('JPDUR',getdate(),getdate(),NEWID(),'Actual','30-Nov-2020',12500.75)

-- -- Test Check Data
-- select * from DataPointValues

if exists (select * from dbo.sysobjects where id = object_id(N'DataPointMapping') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table DataPointMapping
GO

create table DataPointMapping(

ID     	     varchar(36)	NOT NULL PRIMARY KEY, -- the UID
LastUser     varchar(15)	NOT NULL, -- Last user who accessed the data
createdAt    datetime 		not null, -- Sequelize managed fields
updatedAt    datetime 		not null, -- Sequelize managed fields
-------------------------       -- Standard Header
NodeDefID    varchar(36)  	NOT NULL, -- NodeDef (Generic/Industry or Company) ID
CompanyID    varchar(36)	NOT NULL  -- Company ID
)

-- Add constraints so that there is only 1 value per date
CREATE UNIQUE INDEX DataPointMapping_Unique on DataPointMapping(NodeDefID,CompanyID)
GO
