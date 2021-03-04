# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-03-04 14:47:07 jpdur"
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Result = "ResultsDisplay.xlsx",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA",
    [Parameter(Mandatory=$false)] [ValidateSet("StructureOnly","DataPointOnly","All")] [string] $Scope = "StructureOnly",
    [Parameter(Mandatory=$false)] [ValidateSet("Level1Only","Industry","All")] [string] $Level = "All",
    [Parameter(Mandatory=$false)] [string] $HierarchyName  = "Income Statement",
    [Parameter(Mandatory=$false)] [string] $IndustryName = "Industry 3",
    [Parameter(Mandatory=$false)] [string] $CompanyName = "TestCo",
    [Parameter(Mandatory=$false)] [string] $Scenario = "Actual",
    [Parameter(Mandatory=$false)] [string] $CollectionDate = "31-Oct-2020"
)

# Inspired from https://mcpmag.com/articles/2018/07/10/check-for-locked-file-using-powershell.aspx?m=1
# Alternative https://stackoverflow.com/questions/24992681/powershell-check-if-a-file-is-locked
# --------------------------------------------------------
# Given an absolute path - checks that the file is locked 
# --------------------------------------------------------
function Test-FileLock {
    param (
	[parameter(Mandatory=$true)][string]$Path
    )

    $oFile = New-Object System.IO.FileInfo $Path

    # If it does not exist --> No FileLock
    if ((Test-Path -Path $Path) -eq $false) {
	return $false
    }

    # Test if it is possible to open
    try {
	$oStream = $oFile.Open([System.IO.FileMode]::Open, [System.IO.FileAccess]::ReadWrite, [System.IO.FileShare]::None)

	if ($oStream) {
	    $oStream.Close()
	}
	return $false
    } catch {
	# file is locked by a process.
	return $true
    }
}

# --------------------------------------------
# No Execution if the $Result file is blocked
# --------------------------------------------
# Test Dashboard.xlsx
if (Test-FileLock ($Exec_Dir+"\"+$Result)) {
    Write-Host "Close $Result in order to allow execution"
    exit
}

# Delete the file
rm $Result -ErrorAction SilentlyContinue

# Create the list i.e. array of the queries
$listqueries = @()

# Query1
$query = "EXEC PS_STG_DISPLAY_HIERARCHY_ROOT '$HierarchyName'"
$data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $DataBase -Query $query | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
$listqueries += $query

# Query2
$query2 = "EXEC PS_STG_DISPLAY_HIERARCHY_INDUSTRY '$HierarchyName','$IndustryName'"
$data_query2 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $DataBase -Query $query2 | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
$listqueries += $query2

# Query3
$query3 = "EXEC PS_STG_DISPLAY_HIERARCHY_INDUSTRY_COMPANY '$HierarchyName','$IndustryName','$CompanyName'"
$data_query3 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $DataBase -Query $query3 | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
$listqueries += $query3

# Query4
# $query4 = "EXEC PS_STG_DISPLAY_HIERARCHY_INDUSTRY_DATA '$HierarchyName','$IndustryName','$CompanyName','$Scenario','$CollectionDate'"
$query4 = "EXEC PS_STG_DISPLAY_COLLECTION_DATA '$HierarchyName','$IndustryName','$CompanyName','$Scenario','$CollectionDate'"
$data_query4 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $DataBase -Query $query4 | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors
$listqueries += $query4

# Display the results
$data_query1 | Export-Excel -AutoSize -AutoFilter -WorksheetName "Level1"            $Result
$data_query2 | Export-Excel -AutoSize -AutoFilter -WorksheetName "Level1-Industry"   $Result
$data_query3 | Export-Excel -AutoSize -AutoFilter -WorksheetName "Full Structure"    $Result
$data_query4 | Export-Excel -AutoSize -AutoFilter -WorksheetName "Data"              $Result
$listqueries | Export-Excel -Show -AutoSize -WorksheetName Query                     $Result
