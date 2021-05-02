# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-05-02 09:28:19 jpdur"
# ------------------------------------------------------------------------------

# --------------------------------------------------------------------
# List of Extracts to be performed to generate the DIA spreadsheets
# Run the SQL as part of the process against the local DB 
# --------------------------------------------------------------------
# Generate the log in order to see if all has been working as expected

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]  $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [switch] $Keep,
    [Parameter(Mandatory=$false)] [string] $From = "2018-05-01", # From date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $To = "2100-01-01",   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix = "G" #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# ------------------------------------------------------------------
# Step 0 - Get the Full Path (<==> pwd) and the required parameters# ------------------------------------------------------------------
# ------------------------------------------------------------------

# ------------------------------------------------------------------------------
# It is assumed that it is launched from a directory where the KPI files are 
# The structure being Data/XXX/KPI where 
# XXX is the Company Name 
# KPI is the KPI
# ------------------------------------------------------------------------------
$FullPath = (Get-Location).Path

# Extract the KPI i.e. the latest directory
$index = $FullPath.LastIndexOf('\')
$HierarchyName = $FullPath.substring($index+1,$FullPath.length - $index -1)

# Convert the Hierarchy Name to Hierarchy Code
$Hierarchy = ConvertHierarchyName2Code $HierarchyName

# Extract the Company Name i.e. the latest directory
$FullPath = $FullPath.substring(0,$index)
$index = $FullPath.LastIndexOf('\')
$Company = $FullPath.substring($index+1,$FullPath.length - $index -1)

"Key parameters about to be used "
"--------------------------------"
"KPI     : " + $HierarchyName + " i.e. " + $Hierarchy
"Company : " + $Company + " with Prefix " + $Prefix+$Company
"Scenario: " + $Scenario 

# ----------------------------------------------------------------
# In order to check if the nb of lines is changing through time
# Visual checks is that number of lines is always increasing 
# nothing is written at that stage
# ----------------------------------------------------------------
EvolutionStructure -Company $Company -Scenario $Scenario -Hierarchy $Hierarchy

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

DetermineStructure -Hierarchy $Hierarchy -Scenario $Scenario -Prefix $Prefix -Action "runSQL" -Script $Script -UploadScript $UploadScript -DatabaseInstance $DatabaseInstance -Database $Database -LogFile $LogFile

# If the logFile has been created - the review it
if ( ($LogFile -ne "") -and (Test-Path $LogFile) ) {
    cat $LogFile
} else {
    "No data in "+$LogFile
}

# --------------------------------------------------------------------------------------
# Part 2 - Extract the data and create/Execute the scripts to store all the DataPoints
# --------------------------------------------------------------------------------------
$LogFile      = "SQLDataPoints.log"

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

# --------------------------------------------------------------------------------------
# Part 3 - Extract the data and create/Execute the scripts to store all the DataPoints
# --------------------------------------------------------------------------------------

# Create the DIA spreadsheets - same parameters as ExtractData 
CreateDIASpreadsheets -Company $Company -Hierarchy $Hierarchy -Scenario $Scenario -From $From -To $To -Prefix $Prefix 

# That way the module is only used as part of the script and no afterwards
# Remove-Module RainmakerLib
