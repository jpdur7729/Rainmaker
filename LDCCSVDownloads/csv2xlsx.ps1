# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-04-12 17:17:45 jpdur"
# ------------------------------------------------------------------------------

# Convert csv files to xlsx from LDCCSVDownloads to LDCDownloads
param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $DestDirectory = "g:/Rainmaker/LDCDownloads", # Destination Directory and key parameter
    [Parameter(Mandatory=$false)] [ValidateSet(",","|")] [string] $Delimiter = "|",
    [Parameter(Mandatory=$true)]  [string] $Company, #Required
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Filter to access only a subset of files
$filter = "*_"+$Company+"_*.csv"

# New FileName Example for company 004   : 002_004_PL_AC_2020_05_FIS_SortOrder_Encoded_20210315_170838
# Old FileName Example for company TestCo: 6_Output_1_FIS-SortOrder_TestCo_2020_10_PL_AC_20210108 2203
# The magic 1 line conversion from csv to xlsx
# Import-Csv -Path (".\"+$FileName+".csv") -Delimiter $Delimiter | Export-Excel -Show -AutoSize -WorksheetName Query ($FileName+".xlsx")

# ----------------------------------------------------------------------------------
# loop through all csv files and convert them into xlsx which is then copied to the 
# reference directory 
# ----------------------------------------------------------------------------------
Get-ChildItem -filter $filter | Foreach-Object {

    #Destination file with extension
    $Filename_Process     = $_.Name
    $Filename_NoExtension = $_.BaseName

    # Convert to xlsx
    Import-Csv -Path (".\"+$Filename_Process) -Delimiter $Delimiter | Export-Excel -AutoSize -WorksheetName Query ($Filename_NoExtension+".xlsx")

    # move files to DestDirectory overwriting the previous version
    mv -Force ($Filename_NoExtension+".xlsx") $DestDirectory
}

# Move to the dest Directory and mv all the Order file to the Order Directory
cd ($DestDirectory)
mv -Force *Order*.xlsx Order

# Restore back to the initial directory
cd ($Exec_Dir)
