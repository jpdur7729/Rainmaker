@echo off 
rem -------------------------------------------------------------------------
rem                  Author    : FIS - JPD
rem                  Time-stamp: "2021-03-04 06:32:53 jpdur"
rem -------------------------------------------------------------------------

rem ------------------------------------------------------------------------------------------------
rem https://stackoverflow.com/questions/51516530/running-multiple-sql-files-in-microsoft-sql-server
rem ------------------------------------------------------------------------------------------------
rem DESKTOP-9CUFF1O\JPDURANDEAU
rem DIA2

SET SQLCMD=sqlcmd -S DESKTOP-9CUFF1O\JPDURANDEAU -d DIA2

@echo on

rem Create the standard Stored Procedures
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_DataItem.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPI_Collection_Batch.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPI_Collection_Batch_Dimension.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPI_Collection_DataItem.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPI_Collection_Dimension.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPI_Collection_Node.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPICompanyConfigNodeAssociation.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPICompanyConfigNodeDataItemAssociation.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPICompanyConfiguration.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_KPIIndustryTemplate.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_NODE.sql
%SQLCMD% -i STG2DIA\SP_STG_DIA_Populate_RM_NodeIndustryAssociation.sql

rem Create some specific Stored Procedures to be commented
%SQLCMD% -i STG2DIA\SP_STG_DIA_DeployStructure.sql

rem A specific SP in order to link with existing KPI Structure
%SQLCMD% -i STG2DIA\SP_PS_DIASetup_RM_NODE.sql

rem Not to be used
rem %SQLCMD% -i STG2DIA\PS_DIASetup_CleanupStructure.sql
rem %SQLCMD% -i STG2DIA\PS_RUN.sql
