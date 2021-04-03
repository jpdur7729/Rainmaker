# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-04-03 16:56:27 jpdur"
# ------------------------------------------------------------------------------


# v0 - Simple call to all files sharing the same Company/Hierarchy/Scenario
# v1 - Add the filter to specify only the required period for better control


param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Company = "004",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("PL","AC","CF")] [string] $Hierarchy = "PL",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]      [string] $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $Script = "DataResults.sql",
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Execution is done from the directory of the script ==> relative paths are thus possible
cd $Exec_Dir

# Pattern to extract all data
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# Delete the destination file where the script will be created
rm ($Script)

# Process all files corresponding to the given pattern
Get-ChildItem -Path $Exec_Dir -Filter $Pattern |
Foreach-Object {

    # Run the standard batch
    ./Normalise -Database DIA2 -Source $_.Name -Scope "DataPointOnly" -HierarchyLevel "Company" -Action GenerateSQLScript -Script Inter1.sql -Prefix $Prefix

    # Append to the desired result file
    $From = Get-Content -Path Inter1.sql
    Add-Content -Path ($Script) -Value $From

    # Delete intermediate file
    rm Inter1.sql

}

cat ($Script)
