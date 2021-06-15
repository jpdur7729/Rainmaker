# ------------------------------------------------------------------------------
#                     Author    : F2 - JPD
#                     Time-stamp: "2021-06-01 16:18:12 jpdur"
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Company = "G011",
    [Parameter(Mandatory=$false)] [string] $Hierarchy = "Income Statement",
    [Parameter(Mandatory=$false)] [string] $CollectionDate = "2021-01-01",
    [Parameter(Mandatory=$false)] [string] $Scenario = "Actuals",
    [Parameter(Mandatory=$false)] [string] $ResultFile = "ResultGenerate.xlsx",
    [Parameter(Mandatory=$false)] [ValidateSet("DataOnly","All")] [string] $Action = "All",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# Access the module to extract the Corresponding Industry 
$Industry = GetIndustry -Company $Company -DatabaseInstance $DatabaseInstance -Database $Database

# Delete the file
rm $ResultFile -ErrorAction SilentlyContinue

# Create the list i.e. array of the queries
$listqueries = @()

# -----------------------------------------------------
# Old versions of the query which have not been updated
# -----------------------------------------------------

# # Query1
# $query = "EXEC DISPLAY_HIERARCHY_ROOT 'Profit Loss'"
# $data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance  -Database $Database -Query $query | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
# $listqueries += $query

# # Query2
# $query2 = "EXEC DISPLAY_HIERARCHY_INDUSTRY 'Profit Loss','Industry 3'"
# $data_query2 = Invoke-DbaQuery -SqlInstance $DatabaseInstance  -Database $Database -Query $query2 | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
# $listqueries += $query2

# # Query3
# $query3 = "EXEC PS_STG_DISPLAY_HIERARCHY_INDUSTRY_COMPANY 'Income Statement' , 'Telecommunications (517)' , 'G011' "
$query3 = "EXEC PS_STG_DISPLAY_HIERARCHY_INDUSTRY_COMPANY '"+$Hierarchy+"' , '"+$Industry+"' , '"+$Company+"' "
$data_query3 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $Database -Query $query3 | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
$listqueries += $query3

# # Query4
# $query4 = "EXEC DISPLAY_HIERARCHY_INDUSTRY_DATA 'Profit Loss','Industry 3','TestCo','Actual','31-Oct-20'"
# $query4 = "EXEC PS_STG_DISPLAY_COLLECTION_DATA 'Income Statement' , 'Telecommunications (517)' , 'G011' , 'Actuals' , '31-Oct-19' "
# $data_query4 = Invoke-DbaQuery -SqlInstance $DatabaseInstance  -Database $Database -Query $query4 | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
# $listqueries += $query4

# ---------------------------------------------------------------------------
# Display the results. Data is always the 1st tab just in case to ease reread
# ---------------------------------------------------------------------------

# $data_query4 | Export-Excel -AutoSize -AutoFilter -WorksheetName "Data"         $ResultFile

if ($Action -eq "All") {
    # $data_query1 | Export-Excel -AutoSize -AutoFilter -WorksheetName "PL" $ResultFile
    # $data_query2 | Export-Excel -AutoSize -AutoFilter -WorksheetName "PL-Industry3" $ResultFile
    $data_query3 | Export-Excel -AutoSize -AutoFilter -WorksheetName "Structure"    $ResultFile
    $listqueries | Export-Excel -Show -AutoSize -WorksheetName Query $ResultFile
}

# That way the module is only used as part of the script and no afterwards
Remove-Module RainmakerLib
