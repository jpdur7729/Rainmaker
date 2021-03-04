@echo off 
rem -------------------------------------------------------------------------
rem                  Author    : FIS - JPD
rem                  Time-stamp: "2021-03-04 06:18:18 jpdur"
rem -------------------------------------------------------------------------

rem ------------------------------------------------------------------------------------------------
rem https://stackoverflow.com/questions/51516530/running-multiple-sql-files-in-microsoft-sql-server
rem ------------------------------------------------------------------------------------------------
rem DESKTOP-9CUFF1O\JPDURANDEAU
rem DIA2

SET SQLCMD=sqlcmd -S DESKTOP-9CUFF1O\JPDURANDEAU -d DIA2

@echo on

rem Create the Tables for the Staging Area
%SQLCMD% -i SQL\T_NodeDef.sql
%SQLCMD% -i SQL\T_Hierarchies.sql
%SQLCMD% -i SQL\T_DataPointTables.sql

rem rem create the views in order to link with the RM_Company/RM_Industry/RM_Company/RMX_KPiType tables
rem rem only works assuming the existence of the referred table
rem %SQLCMD% -i SQL\V_CompanyList.sql
rem %SQLCMD% -i SQL\V_HierarchyList.sql
rem %SQLCMD% -i SQL\V_IndustryList.sql

rem create the different components for the Staging Ares stored Procedure to handle the structure
%SQLCMD% -i SQL\SP_PS_STG_CREATE_NODE.sql
%SQLCMD% -i SQL\SP_PS_STG_CREATE_NODECOMPANY.sql
%SQLCMD% -i SQL\SP_PS_STG_CREATE_NODEINDUSTRY.sql
%SQLCMD% -i SQL\SP_PS_STG_LINK_COMPANY_COMPANY.sql
%SQLCMD% -i SQL\SP_PS_STG_LINK_GENERIC.sql
%SQLCMD% -i SQL\SP_PS_STG_LINK_GENERIC_INDUSTRY.sql
%SQLCMD% -i SQL\SP_PS_STG_LINK_INDUSTRY_COMPANY.sql

rem create the different components for the Staging Ares stored Procedure to upload datapoints
%SQLCMD% -i SQL\SP_PS_STG_CREATE_DATAPOINT_internal.sql
%SQLCMD% -i SQL\SP_PS_STG_CREATE_DATAPOINT.sql
%SQLCMD% -i SQL\SP_PS_STG_ADD_DATAPOINT_VALUE.sql
%SQLCMD% -i SQL\SP_PS_STG_ADD_DATAPOINT_VALUE_COMPANYL12.sql

rem deploy the different stored procedure and function to display
rem FN_xxx for functiosn
%SQLCMD% -i STGDisplay\FN_PS_STG_GetDataPointID.sql
%SQLCMD% -i STGDisplay\FN_PS_STG_GetDataPointValue_Num.sql
%SQLCMD% -i STGDisplay\SP_PS_STG_DISPLAY_COLLECTION_DATA.sql
%SQLCMD% -i STGDisplay\SP_PS_STG_DISPLAY_HIERARCHY_INDUSTRY.sql
%SQLCMD% -i STGDisplay\SP_PS_STG_DISPLAY_HIERARCHY_INDUSTRY_COMPANY.sql
%SQLCMD% -i STGDisplay\SP_PS_STG_DISPLAY_HIERARCHY_ROOT.sql

rem ----------------------------------------------------------------------------------------
rem create the views in order to link with the RM_Company/RM_Industry/RM_Company/RMX_KPiType tables
rem only works assuming the existence of the referred table
rem ----------------------------------------------------------------------------------------
%SQLCMD% -i SQL\V_CompanyList.sql
%SQLCMD% -i SQL\V_HierarchyList.sql
%SQLCMD% -i SQL\V_IndustryList.sql
