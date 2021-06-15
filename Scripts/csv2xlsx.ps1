# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-10 15:53:16 jpdur"
# ------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------
# Modified on June 9th 2021 in order to take into account the new naming convention 
# ----------------------------------------------------------------------------------

# Convert csv files to xlsx from Current Directory to Default g:/Rianmaker/Data
param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $DestDirectory = "g:/Rainmaker/Data", # Destination Directory and key parameter
    [Parameter(Mandatory=$false)] [ValidateSet(",","|")] [string] $Delimiter = "|",
    [Parameter(Mandatory=$true)]  [string] $Company, #Required
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# Filter to access only a subset of files
$filter = "*_"+$Company+"_*.csv"

# Initial FileName Example for company 004   : 004_PL_AC_2020_05_FIS_SortOrder_Encoded_20210315_170838.csv
# The magic 1 line conversion from csv to xlsx
# Import-Csv -Path (".\"+$FileName+".csv") -Delimiter $Delimiter | Export-Excel -Show -AutoSize -WorksheetName Query ($FileName+".xlsx")

# Create all the different directories needed 
md -Force ($DestDirectory+"/"+$Company)                        
md -Force ($DestDirectory+"/"+$Company+"/Balance Sheet")       
md -Force ($DestDirectory+"/"+$Company+"/Balance Sheet/AC")    
md -Force ($DestDirectory+"/"+$Company+"/Balance Sheet/BD")    
md -Force ($DestDirectory+"/"+$Company+"/Balance Sheet/OB")    
md -Force ($DestDirectory+"/"+$Company+"/Income Statement")    
md -Force ($DestDirectory+"/"+$Company+"/Income Statement/AC") 
md -Force ($DestDirectory+"/"+$Company+"/Income Statement/BD") 
md -Force ($DestDirectory+"/"+$Company+"/Income Statement/OB") 

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

    # Extract from the File Name the hierarchy in order to store it in the right directory
    $Data = ExtractCharacteristics -FileName $FileName_Process
    $HierarchyName = DecodeHierarchyCode -HierarchyCode $Data.Hierarchy

    # move files to DestDirectory overwriting the previous version
     mv -Force ($Filename_NoExtension+".xlsx") ($DestDirectory+"/"+$Company+"/"+$HierarchyName+"/"+$Data.Scenario)
}

