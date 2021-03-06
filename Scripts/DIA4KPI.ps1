# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-20 16:01:35 jpdur"
# ------------------------------------------------------------------------------

# --------------------------------------------------------------------
# List of Extracts to be performed to generate the DIA spreadsheets
# Run the SQL as part of the process against the local DB 
# --------------------------------------------------------------------
# Generate the log in order to see if all has been working as expected

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD","OB")]  $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [switch] $Keep,
    [Parameter(Mandatory=$false)] [string] $From, # From date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $To = "2100-01-01",   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix = "" #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# ------------------------------------------------------------------
# Step 0 - Get the Full Path (<==> pwd) and the required parameters# ------------------------------------------------------------------
# ------------------------------------------------------------------

# ------------------------------------------------------------------------------
# It is assumed that it is launched from a directory where the KPI files are 
# The structure being Data/XXX/KPI/SC where 
# XXX is the Company Name 
# KPI is the KPI
# SC is the Scenario
# ------------------------------------------------------------------------------
$FullPath = (Get-Location).Path

# Extract the SC i.e. the latest directory
$index = $FullPath.LastIndexOf('\')
$Scenario = $FullPath.substring($index+1,$FullPath.length - $index -1)

# Extract the KPI i.e. the latest directory
$FullPath = $FullPath.substring(0,$index)
$index = $FullPath.LastIndexOf('\')
$HierarchyName = $FullPath.substring($index+1,$FullPath.length - $index -1)

# Convert the Hierarchy Name to Hierarchy Code
$Hierarchy = ConvertHierarchyName2Code $HierarchyName

# Extract the Company Name i.e. the latest directory
$FullPath = $FullPath.substring(0,$index)
$index = $FullPath.LastIndexOf('\')
$Company = $FullPath.substring($index+1,$FullPath.length - $index -1)

# Extract the From Date i.e. the earliest Date for whch we have data
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"
$ListFiles = Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*_*.*"} | Sort-Object -Property Name 
"Initial File with Data :" + $ListFiles[0].Name

# We extract the data for the file whose name has been identified
$Data = ExtractCharacteristics -FileName $ListFiles[0].Name
$From = $Data.Year+"-"+$Data.Month+"-01"

"Key parameters about to be used "
"--------------------------------"
"KPI      : " + $HierarchyName + " i.e. " + $Hierarchy
"Company  : " + $Company + " with Prefix " + $Prefix+$Company
"Scenario : " + $Scenario
"Hierarchy: " + $Hierarchy
"From     : " + $From

# ----------------------------------------------------------------
# In order to check if the nb of lines is changing through time
# Visual checks is that number of lines is always increasing 
# nothing is written at that stage
# ----------------------------------------------------------------
EvolutionStructure -Company $Company -Scenario $Scenario -Hierarchy $Hierarchy

# !!!!!! to have a quicker testing path

# -----------------------------------------
# Message Poppup documentation 
# https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/windows-scripting/x83z1d9f(v=vs.84)?redirectedfrom=MSDN
# -----------------------------------------
"Check Popup to continue ..."
$wshell = New-Object -ComObject Wscript.Shell
$result = $wshell.Popup("Check lines",0,"Done",0x1 + 0x20)

# If cancel is chosen then the script is stopped
if ($result -ne 1) {
    exit
}

# ------------------------------------------------------------------------------
# Part 1 - Extract all the needed data and store it into the local SQL database
# ------------------------------------------------------------------------------

# ---------------------------------------------------------------------
# Determine the structure to be used based on the latest file provided 
# It assumes that the number of lines provided always increase
# ---------------------------------------------------------------------
$Script       = "Struct_"+$Company+"_"+$Hierarchy+".sql"
$UploadScript = "Upload_"+$Script

$LogFile      = "SQLStructure.log"
rm -Force $LogFile -ErrorAction SilentlyContinue > $null

# -KeepResult "Yes" to keep the intermediate xlsx file // -KeepResult "No" or nothing to delete it
DetermineStructure -Hierarchy $Hierarchy -Scenario $Scenario -Prefix $Prefix -Action "runSQL" -Script $Script -UploadScript $UploadScript -DatabaseInstance $DatabaseInstance -Database $Database -LogFile $LogFile -KeepResult "Yes"

# If the logFile has been created - the review it
if ( ($LogFile -ne "") -and (Test-Path $LogFile) ) {
    cat $LogFile
} else {
    "No data in "+$LogFile
}

# Execute the script which has been generated
sqlcmd -S ($DatabaseInstance) -d ($Database) -i ($Script) > $null

" -----------------------------------------------------"
"  Structure has been uploaded into local SQL database "
" -----------------------------------------------------"

# --------------------------------------------------------------------------------------
# Part 2 - Extract the data and create/Execute the scripts to store all the DataPoints
# --------------------------------------------------------------------------------------
$LogFile      = "SQLDataPoints.log"
rm -Force $LogFile -ErrorAction SilentlyContinue > $null

# ExtractData.ps1 -Company $Company -Hierarchy $Hierarchy -Scenario $Scenario -From 2018-05-01 -To 2018-12-01 -Prefix $Prefix -LogFile $LogFile
ExtractData.ps1 -Company $Company -Hierarchy $Hierarchy -Scenario $Scenario -From $From -To $To -Prefix $Prefix -LogFile $LogFile

# If the logFile has been created - the review it
if ( ($LogFile -ne "") -and (Test-Path $LogFile) ) {
    cat $LogFile
} else {
    "No data in "+$LogFile
}

"  Data has been stored into local SQL database "
" -------------------------------------------------"
"Results DIA spreadsheets are about to be generated"

# Execute the script which has been generated
sqlcmd -S ($DatabaseInstance) -d ($Database) -i "DataResults.sql" > $null

# --------------------------------------------------------------------------------------
# Part 3 - Extract the data and create/Execute the scripts to store all the DataPoints
# --------------------------------------------------------------------------------------

# Create the DIA spreadsheets - same parameters as ExtractData - OLD Version
# CreateDIASpreadsheets -Company $Company -Hierarchy $Hierarchy -Scenario $Scenario -From $From -To $To -Prefix $Prefix 

# New process to create the Full XLAddin Histiry Spreadsheet
CreateHistory 

# That way the module is only used as part of the script and no afterwards
# Remove-Module RainmakerLib
