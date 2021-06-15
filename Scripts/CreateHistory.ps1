# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-15 11:18:49 jpdur"
# ------------------------------------------------------------------------------


param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $From , # From date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $To ,   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

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

# If To and From are not indicated they are being extracted by default
if ($From.length -eq 0) {
    
    # Extract the From Date i.e. the earliest Date for whch we have data
    $Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"
    $ListFiles = Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*_*.*"} | Sort-Object -Property Name 
    "Initial File with Data :" + $ListFiles[0].Name

    # We extract the data for the file whose name has been identified
    $Data = ExtractCharacteristics -FileName $ListFiles[0].Name
    $From = $Data.Year+"-"+$Data.Month+"-01"

}

# If To and To are not indicated they are being extracted by default
if ($To.length -eq 0) {
    
    # Extract the To Date i.e. the earliest Date for whch we have data
    $Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"
    $ListFiles = Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*_*.*"} | Sort-Object -Property Name -Descending
    "Initial File with Data :" + $ListFiles[0].Name

    # We extract the data for the file whose name has been identified
    $Data = ExtractCharacteristics -FileName $ListFiles[0].Name
    $To = $Data.Year+"-"+$Data.Month+"-01"

}

# To simplify testing and processing for the To Date we force the day to be the last day of the month
$DateExtract = LastDayofMonth -Year $To.substring(0,4) -Month $To.substring(5,2) 
$To = $DateExtract.ToString("yyyy-MM-dd")

# Access the module to extract the Corresponding Industry 
$Industry = GetIndustry -Company ($Prefix+$Company) -DatabaseInstance $DatabaseInstance -Database $Database

# Standardise the Hierarchy based on the Code Received 
$HierarchyName = DecodeHierarchyCode -HierarchyCode $Hierarchy

# Standardise the Scenario based on the Code Received 
$ScenarioName = DecodeScenarioCode -ScenarioCode $Scenario

# Transform the Date in order to check against the extracted date 
if ($From -eq "") {$FromDate = $null} else { $FromDate = [datetime]::ParseExact($From,"yyyy-MM-dd", $null) }
if ($To   -eq "") {$ToDate   = $null} else { $ToDate   = [datetime]::ParseExact($To  ,"yyyy-MM-dd", $null) }

# Pattern to extract all data
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

"Key parameters about to be used "
"--------------------------------"
"KPI     : " + $HierarchyName + " i.e. " + $Hierarchy
"Company : " + $Company + " with Prefix " + $Prefix+$Company
"Scenario: " + $Scenario
"From    : " + $From
"To      : " + $To


# Name of the Global File to be created with all the DataPoints
$GlobalFile = "DIG_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_"+$From.substring(0,7)+"_"+$To.substring(0,7)+".xlsx"

# By default delete GlobalFile
rm -Force $GlobalFile -ErrorAction SilentlyContinue > $null

# --------------------------------------------------------------------------------
# Process all files corresponding to the given pattern in the current directory
# filter out the DIA_*.xlsx files or more generally DIX_* 
# which may or may not have been created and may exist in the directory
# --------------------------------------------------------------------------------
Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*.*"} |
  Foreach-Object {

      # Extract from the file Name the period considered
      $Data = ExtractCharacteristics -FileName $_.Name
      # ata = Extract-Year-Month($_.Name)
      $DateExtract = LastDayofMonth -Year $Data.Year -Month $Data.Month

      # Check that the date is in the required period
      if (($DateExtract -ge $FromDate) -and ($DateExtract -le $ToDate)) {

	  # Name of the intermediate file
	  $ResultFile = "DIX" + $_.Name.substring(3,$_.Name.length - 3)

	  # Extract the datapoints availalbe from the local database
	  # EXEC PS_STG_DISPLAY_COLLECTION_DATA 'Balance Sheet' , 'Telecommunications (517)' , 'G011' , 'Actuals' , '31-May-18' 
	  $ExtractCmd  = "EXEC PS_STG_DISPLAY_COLLECTION_DATA '"+$HierarchyName+"' , '"+$Industry+"' , '"+$Company+"' , '"+$ScenarioName+"' , '"+$DateExtract.ToString("dd-MMM-yyyy")+"'"
	  # To force the @CoalesceValue and distinguish between 0.0 and NULL
	  $ExtractCmd += " ,-0.12345 "
	  # $ExtractCmd
	  $ExtractData = Invoke-DbaQuery -SqlInstance localhost -Database $Database -Query $ExtractCmd | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors

	  # Created the extracted data in a spreadsheet 
	  $ExtractData | Select-Object -Property Level1,IndustryLevel,CompanyLevel1,CompanyLevel2,Amount |
	    Export-Excel -AutoSize -AutoFilter -WorksheetName "Data" $ResultFile

	  # To verify that all the dates are processed as expected
	  $DateExtract.ToString("dd-MMM-yyyy")
	  
	  # Reread that spreadsheet in order to create the DIA spreadsheet
	  CreateHistoryXLAddinFormat -Keep -Source $ResultFile -Prefix $Prefix -StartCollectionDate $From -EndCollectionDate $To -Result $GlobalFile > $null
      }
  }

# That way the module is only used as part of the script and no afterwards
Remove-Module RainmakerLib
