# ------------------------------------------------------------------------------
#                     Author    : F2 - JPD
#                     Time-stamp: "2021-01-12 10:26:06 jpdur"
# ------------------------------------------------------------------------------

# Convert csv files to xlsx from LDCCSVDownloads to LDCDownloads

# Destination Directory and key parameter
$DestDirectory = "g:/Rainmaker/LDCDownloads"
$filter = "*.csv"
$Delimiter = "|"

# $FileName = "6_Output_1_FIS-SortOrder_TestCo_2020_10_PL_AC_20210108 2203"
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
