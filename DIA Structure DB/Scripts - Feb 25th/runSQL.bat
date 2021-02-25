@echo off 
rem -------------------------------------------------------------------------
rem                  Author    : FIS - JPD
rem                  Time-stamp: "2021-02-25 17:10:57 jpdur"
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
for %%d in (*.sql) do %SQLCMD% -i%%d

rem for only the file received as parameter
rem %SQLCMD% -i %1
