# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-14 18:00:40 jpdur"
# ------------------------------------------------------------------------------


param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Company = "004",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("PL","BS","CF")] [string] $Hierarchy = "PL",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]      [string] $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $From , # From date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $To = "2100-01-01",   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# Access the module to extract the Corresponding Industry 
$Industry = GetIndustry -Company ($Prefix+$Company) -DatabaseInstance $DatabaseInstance -Database $Database
$CompanyName = $Prefix+$Company

# Standardise the Hierarchy based on the Code Received 
$HierarchyName = DecodeHierarchyCode -HierarchyCode $Hierarchy

# Standardise the Scenario based on the Code Received 
$ScenarioName = DecodeScenarioCode -ScenarioCode $Scenario

# Transform the Date in order to check against the extracted date 
if ($From -eq "") {$FromDate = $null} else { $FromDate = [datetime]::ParseExact($From,"yyyy-MM-dd", $null) }
if ($To   -eq "") {$ToDate   = $null} else { $ToDate   = [datetime]::ParseExact($To  ,"yyyy-MM-dd", $null) }

# Pattern to extract all data
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# Name of the Global File to be created with all the DataPoints
$GlobalFile = "DIG_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_"+$From.substring(0,7)+"_"+$To.substring(0,7)+".xlsx"

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

      # # Debug and check what is happening
      # $_.Name
      # $DateExtract.ToString("dd-MMM-yyyy")

      # Check that the date is in the required period
      if (($DateExtract -ge $FromDate) -and ($DateExtract -le $ToDate)) {

	  # Name of the intermediate file
	  $ResultFile = "DIX" + $_.Name.substring(3,$_.Name.length - 3)
	  $DIAFile    = "DIA" + $_.Name.substring(3,$_.Name.length - 3)

	  # Extract the datapoints availalbe from the local database
	  # EXEC PS_STG_DISPLAY_COLLECTION_DATA 'Balance Sheet' , 'Telecommunications (517)' , 'G011' , 'Actuals' , '31-May-18' 
	  $ExtractCmd  = "EXEC PS_STG_DISPLAY_COLLECTION_DATA '"+$HierarchyName+"' , '"+$Industry+"' , '"+$CompanyName+"' , '"+$ScenarioName+"' , '"+$DateExtract.ToString("dd-MMM-yyyy")+"'"
	  # To force the @CoalesceValue and distinguish between 0.0 and NULL
	  $ExtractCmd += " ,-0.12345 "
	  $ExtractData = Invoke-DbaQuery -SqlInstance localhost -Database $Database -Query $ExtractCmd | Select-Object * -ExcludeProperty RowError, RowState, Table, ItemArray, HasErrors

	  # Debug Data
          $DateExtract.ToString("dd-MMM-yyyy")
	  $DIAFile
	  # $ExtractCmd

	  # Created the extracted data in a spreadsheet 
	  $ExtractData | Select-Object -Property Level1,IndustryLevel,CompanyLevel1,CompanyLevel2,Amount |
	    Export-Excel -AutoSize -AutoFilter -WorksheetName "Data" $ResultFile

	  # Reread that spreadsheet in order to create the DIA spreadsheet
	  CreateXLAddinFormat -Keep -Source $ResultFile -Prefix $Prefix -StartCollectionDate $From > $null

	  # Analyse the ResultFile to determine if this is the 1st case
	  $Data = ExtractCharacteristics -FileName $ResultFile
	  if ( ($Data.Year+"-"+$Data.Month) -eq $From.substring(0,7) ) {
	      rm -Force $GlobalFile >$null
	      cp $DIAFile $GlobalFile
	  }
	  else {
	      # Add Columns to the Global Spreadsheet
	      AddColumns -Source $ResultFile -Prefix $Prefix -Column "Test Column"
	  }
	  
      }
  }

# That way the module is only used as part of the script and no afterwards
Remove-Module RainmakerLib
