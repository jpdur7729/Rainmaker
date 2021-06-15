# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-14 13:26:33 jpdur"
# ------------------------------------------------------------------------------


# v0 - Simple call to all files sharing the same Company/Hierarchy/Scenario
# v1 - Add the filter to specify only the required period for better control
# v2 - Create 2 scripts // Script = Data into the STG Table // + UpoadScript 
# --------------------------------------------------------------------------------------
# v3 - 2021-06-09 - Create script in order to process if no DataPoints at Company Level
# --------------------------------------------------------------------------------------


param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Company = "004",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("PL","BS","CF")] [string] $Hierarchy = "PL",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]      [string] $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $Script = "DataResults.sql",
    [Parameter(Mandatory=$false)] [string] $UploadScript = "UploadDataResults.sql",
    [Parameter(Mandatory=$false)] [string] $LogFile,
    [Parameter(Mandatory=$false)] [string] $From , # From date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $To = "2100-01-01",   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# Pattern to extract all data - Old Naming Convention
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"
# # New Naming Convention 2021-06-09
# $Pattern = "*_"+$Company+"_*_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# Access the module to extract the Corresponding Industry 
$Industry = GetIndustry -Company ($Prefix+$Company) -DatabaseInstance $DatabaseInstance -Database $Database

# Standardise the Hierarchy based on the Code Received 
$HierarchyName = DecodeHierarchyCode -HierarchyCode $Hierarchy

# Standardise the Scenario based on the Code Received 
$ScenarioName = DecodeScenarioCode -ScenarioCode $Scenario

"After Decode Hierachy"

# Transform the Date in order to check against the extracted date 
if ($From -eq "") {$FromDate = $null} else { $FromDate = [datetime]::ParseExact($From,"yyyy-MM-dd", $null) }
if ($To   -eq "") {$ToDate   = $null} else { $ToDate   = [datetime]::ParseExact($To  ,"yyyy-MM-dd", $null) }

# Delete the destination file where the script will be created
rm ($Script) -ErrorAction SilentlyContinue

# Delete if it exists the previous script
rm ./STGUpload.sql -ErrorAction SilentlyContinue

# Create the upload script cmd file 
rm ($UploadScript) -ErrorAction SilentlyContinue
touch ($UploadScript)

"Before Loop"
$Pattern

# ------------------------------------------------------------------------------------
# Process all files corresponding to the given pattern in the current directory
# eliminate any DIA or DIX spreadsheets that might have been created by previous runs
# ------------------------------------------------------------------------------------
Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*.*"} |
  Foreach-Object {

      # Extract from the file Name the period considered
      $Data = ExtractCharacteristics -FileName $_.Name
      # ata = Extract-Year-Month($_.Name)
      $DateExtract = LastDayofMonth -Year $Data.Year -Month $Data.Month

      # Debug and check what is happening
      $_.Name
      $DateExtract.ToString("MMM-yyyy")

      # Check that the date is in the required period
      if (($DateExtract -ge $FromDate) -and ($DateExtract -le $ToDate)) {

	  # Information message
	  Write-Host "Process for date:",$DateExtract.ToString("MMM-yyyy")
	  
	  # Create the SQL command to upload data from STG
	  $UploadCmd  = "STG_DIA_Upload_DataPoints '"+$HierarchyName+"','"+$IndustryName+"','"
	  $UploadCmd += $Prefix+$Company+"','"+$ScenarioName+"','"
	  $UploadCmd += $DateExtract.ToString('dd-MMM-yyyy')+"'"

	  # Append to file
	  $UploadCmd >> STGUpload.sql

	  # EXEC STG_DIA_Upload_DataPoints 'Income Statement' ,'Wood Product Manufacturing (321)','G004','Actuals','31-Oct-2019'
	  $UploadScriptCmd = "EXEC STG_DIA_Upload_DataPoints '" +$HierarchyName+ "' ,'" + $IndustryName + "','" + $Prefix+$Company + "','" + $ScenarioName + "','" + $DateExtract.ToString('dd-MMM-yyyy')+"'"
	  $UploadScriptCmd >> ($UploadScript)
	  
	  # Create a temporary file to generate the SQL script
	  $TempFile = New-TemporaryFile
	  
	  # Run the standard batch and redirects the output to null
	  Normalise -Database $Database -Source $_.Name -Scope DataPointOnly -HierarchyLevel Company -Action runSQL -Script $TempFile -Keep -Prefix $Prefix -LogFile $LogFile > $null

	  # Append to the desired result file
	  cat ($TempFile) >> ($Script)

	  # Delete intermediate file
	  rm ($TempFile)
      }
  }

# Debug Display the resulting script
# cat ($Script)

# That way the module is only used as part of the script and no afterwards
Remove-Module RainmakerLib
