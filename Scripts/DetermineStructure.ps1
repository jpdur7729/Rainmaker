# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-14 13:25:52 jpdur"
# ------------------------------------------------------------------------------


# v0 - Simple call to all files sharing the same Company/Hierarchy/Scenario
# v1 - Add the filter to specify only the required period for better control
# v2 - Create 2 scripts // Script = Data into the STG Table // + UpoadScript 


param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    # [Parameter(Mandatory=$false)] [string] $Company = "004",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("PL","BS","CF")] [string] $Hierarchy = "PL",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]      [string] $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $LogFile,
    [Parameter(Mandatory=$false)] [ValidateSet("runSQL","GenerateSQLScript")] [string] $Action = "GenerateSQLScript",
    [Parameter(Mandatory=$false)] [string] $Script = "DataResults.sql",
    [Parameter(Mandatory=$false)] [string] $UploadScript = "UploadDataResults.sql",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("Yes","No")]     [string] $KeepResult = "No", # Yes to keep for Debug the Result.xlsx file
    # [Parameter(Mandatory=$false)] [string] $From , # From date in yyyy-mm-dd format 
    # [Parameter(Mandatory=$false)] [string] $To = "2100-01-01",   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# ------------------------------------------------------------------ 
# In the current directory - find the most recent file. 
# That is the one used to create/update the structure accordingly 
# ------------------------------------------------------------------ 
# eliminate any DIA or DIX spreadsheets that might have been created by previous runs
# ------------------------------------------------------------------------------------
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# # New Naming convention 2021-06-09
# $Pattern = "*_"+$Company+"_*_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

$ListFiles = Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*.*"} | Sort-Object -Property Name -Descending

# File to be processed 
"Structure extracted from :" + $ListFiles[0].Name

# We call Normalise in order to execute the structure accordingl 
Normalise -Database $Database -Source ($ListFiles[0].Name) -Scope "StructureOnly" -HierarchyLevel "Company" -Action GenerateSQLScript -Prefix $Prefix -Script $Script -UploadScript $UploadScript -LogFile $LogFile > $null

# We just visualise the UploadScript
# cat $UploadScript

# We eliminate the intermediate file
if ($KeepResult -eq "No") {
    rm "Results.xlsx" -ErrorAction SilentlyContinue
}
