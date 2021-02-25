rem https://stackoverflow.com/questions/51516530/running-multiple-sql-files-in-microsoft-sql-server
rem ------------------------------------------------------------------------------------------------
rem DESKTOP-9CUFF1O\JPDURANDEAU
rem DIA
rem sa
rem resn0_gesl0

SET SQLCMD=sqlcmd -S DESKTOP-9CUFF1O\JPDURANDEAU -d DIA -U sa -P resn0_gesl0
for %%d in (*.sql) do %SQLCMD% -i%%d
