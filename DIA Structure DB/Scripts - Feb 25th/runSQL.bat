@echo off 
rem -------------------------------------------------------------------------
rem                  Author    : FIS - JPD
rem                  Time-stamp: "2021-02-26 07:09:06 jpdur"
rem -------------------------------------------------------------------------

rem ------------------------------------------------------------------------------------------------
rem https://stackoverflow.com/questions/51516530/running-multiple-sql-files-in-microsoft-sql-server
rem ------------------------------------------------------------------------------------------------
rem DESKTOP-9CUFF1O\JPDURANDEAU
rem DIA
rem sa
rem resn0_gesl0

SET SQLCMD=sqlcmd -S DESKTOP-9CUFF1O\JPDURANDEAU -d DIA -U sa -P resn0_gesl0

rem for all files 
rem for %%d in (*.sql) do %SQLCMD% -i%%d

rem for only the file received as parameter
%SQLCMD% -i %1
