-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:09:16 jpdur"
-- ------------------------------------------------------------------------------

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
