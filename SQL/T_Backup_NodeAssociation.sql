-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-20 10:31:59 jpdur"
-- ------------------------------------------------------------------------------

-- use [RainmakerLDCJP_OATSTG]

-- ------------------------------------------------------------------------------
-- Creation of the 3 NodeDefs Table (NodeDef/NodeDefIndustry/NodeDefCompany)
-- ------------------------------------------------------------------------------

-- Recreate the Backup tables - 1 For each of the KPI_Collection_xxx Tables
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_IND_NodeAssociation') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_IND_NodeAssociation
GO
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_CMP_NodeAssociation') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_CMP_NodeAssociation
GO
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_IND_NodeDataItemAssociation') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_IND_NodeDataItemAssociation
GO
if exists (select * from dbo.sysobjects where id = object_id(N'Backup_CMP_NodeDataItemAssociation') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table Backup_CMP_NodeDataItemAssociation
GO

-- Create the Backup Tables
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_IND_NodeAssociation         from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeAssociation        ) tmp
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_IND_NodeDataItemAssociation from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_IND_NodeDataItemAssociation) tmp
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_CMP_NodeAssociation         from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeAssociation        ) tmp
select NEWID() as BatchID,getdate() as Timestamp,* into Backup_CMP_NodeDataItemAssociation from (select TOP 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_CMP_NodeDataItemAssociation) tmp

-- Empty the tables accordingly
truncate table Backup_IND_NodeAssociation        
truncate table Backup_IND_NodeDataItemAssociation
truncate table Backup_CMP_NodeAssociation        
truncate table Backup_CMP_NodeDataItemAssociation

-- Verification that the newly created tables are empty
select count(*) from Backup_IND_NodeAssociation        
select count(*) from Backup_IND_NodeDataItemAssociation
select count(*) from Backup_CMP_NodeAssociation        
select count(*) from Backup_CMP_NodeDataItemAssociation
