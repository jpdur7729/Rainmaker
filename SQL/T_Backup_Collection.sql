-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-18 20:07:54 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- ------------------------------------------------------------------------------
-- Creation of the 3 NodeDefs Table (NodeDef/NodeDefIndustry/NodeDefCompany)
-- ------------------------------------------------------------------------------

-- Recreate the Backup tables - 1 For each of the KPI_Collection_xxx Tables
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_Collection_Node') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_Collection_Node
GO
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_Collection_DataItem') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_Collection_DataItem
GO
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_Collection_Dimension') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_Collection_Dimension
GO
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_Collection_Batch_Dimension') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_Collection_Batch_Dimension
GO

-- Create the Backup Tables
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_Collection_Batch_Dimension from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Batch_Dimension) tmp
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_Collection_Dimension       from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension      ) tmp
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_Collection_DataItem        from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem       ) tmp
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_Collection_Node            from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node           ) tmp

-- Empty the tables accordingly
truncate table Backup_Collection_Batch_Dimension
truncate table Backup_Collection_Dimension      
truncate table Backup_Collection_DataItem       
truncate table Backup_Collection_Node           

-- Verification that the newly created tables are empty
select count(*) from Backup_Collection_Batch_Dimension
select count(*) from Backup_Collection_Dimension      
select count(*) from Backup_Collection_DataItem       
select count(*) from Backup_Collection_Node           
