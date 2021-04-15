# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-04-15 10:26:30 jpdur"
# ------------------------------------------------------------------------------


# v0 - Simple call to all files sharing the same Company/Hierarchy/Scenario
# v1 - Add the filter to specify only the required period for better control
# v2 - Create 2 scripts // Script = Data into the STG Table // + UpoadScript 


param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Company = "004",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("PL","AC","CF")] [string] $Hierarchy = "PL",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]      [string] $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [string] $Script = "DataResults.sql",
    [Parameter(Mandatory=$false)] [string] $UploadScript = "UploadDataResults.sql",
    [Parameter(Mandatory=$false)] [string] $From , # From date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $To = "2100-01-01",   # To  date in yyyy-mm-dd format 
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Execution is done from the directory of the script ==> relative paths are thus possible
cd $Exec_Dir

# Extract from FileName the Year/Month needed actualy all the components
# returns an object with all the identified components of the name
function Extract-Year-Month($FileName) {
    
    # Use only # as separators
    $str = $FileName.replace('_','#').replace(' ','XYZ')
    
    $firstLastPattern = "^(?<BatchNumber>\w+)#(?<Company>\w+)#(?<Hierarchy>\w+)#(?<Scenario>\w+)#(?<Year>\w+)#(?<Month>\w+)#(?<FIS>\w+)#(?<DataStr>\w+)#(?<Encoded>\w+)#(?<CreationDate>\w+)#(?<UnknownNumber>\w+).(?<extension>\w+)"
    $str |
      Select-String -Pattern $firstLastPattern |
      Foreach-Object {
	  # here we access the groups by name instead of by index
	  # $BatchNumber, $Output, $Number1, $FIS, $Company, $Year, $Month, $Hierarchy, $Scenario, $CreationDate, $UnknownNumber, $extension = $_.Matches[0].Groups['BatchNumber', 'Output', 'Number1', 'FIS', 'Company', 'Year', 'Month', 'Hierarchy', 'Scenario', 'CreationDate', 'UnknownNumber', 'extension'].Value
	  # 002_004_PL_AC_2020_07_FIS_Data_Encoded_20210315_170913.xlsx
	  $BatchNumber, $Company, $Hierarchy, $Scenario, $Year, $Month, $FIS, $DataStr, $Encoded, $CreationDate, $UnknownNumber, $extension = $_.Matches[0].Groups['BatchNumber', 'Company', 'Hierarchy', 'Scenario', 'Year', 'Month', 'FIS', 'DataStr', 'Encoded', 'CreationDate', 'UnknownNumber', 'extension'].Value
	  [PSCustomObject] @{
              Hierarchy = $Hierarchy
              Company  = $Company.replace('XYZ',' ')
	      # Number1 = $Number1
	      # FIS = $FIS
              Scenario = $Scenario
	      Year = $Year
	      Month = $Month
              Extension = $extension
	  }
      }
}

# Return a Date which is the last day of the month received
function LastDayofMonth($Year,$Month) {

    # Process the Month and Year and convert them to integer
    $Month = [int]$Month
    $Year  = [int]$Year

    # Determine last day of the month by going to the 1 day of following month 
    if ($Month -eq 12) {
	$Month = 1
	$Year++}
    else{
	$Month++
    }

    # Format the Month
    $MonthStr = "{0:00}" -f $Month
    $DateString = "$Year-$MonthStr-01"

    # Change the string to date in order to be able to later choose the right format
    $DateasDate = [datetime]::ParseExact($DateString,"yyyy-MM-dd", $null)
    $DateasDate = $DateasDate.addDays(-1)

    # Return the calculated dates
    return $DateasDate
}

# Pattern to extract all data
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# Prepare the Parameters to have the actual name 
switch($Hierarchy)
{
    'PL' {$HierarchyName = "Income Statement"}
    'CF' {$HierarchyName = "Cashflows"}
    # 'PL' {$Hierarchy = "Profit Loss"}
    'BS' {$HierarchyName = "Balance Sheet"}
}
# Normalise the Scenario
switch($Scenario)
{
    'AC' {$ScenarioName = "Actuals"}
    'BD' {$ScenarioName = "Budget"} 
}

# Extract the Industry for the given company 
$query1 = "select Name from IndustryList where ID in (select IndustryID from CompanyList where Name = '"+$Prefix+$Company+"')"
$data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $Database -Query $query1

# Error message or confirmation if needed
if ($data_query1 -eq $null) {
    "Company:" + $Company +" is not known"
}
else {
    "Company " + $Company +" belongs to the industry " + $data_query1.Name
}

# Keep the industry
$IndustryName = $data_query1.Name

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

# Process all files corresponding to the given pattern
Get-ChildItem -Path $Exec_Dir -Filter $Pattern |
  Foreach-Object {

      # Extract from the file Name the period considered
      $Data = Extract-Year-Month($_.Name)
      $DateExtract = LastDayofMonth $Data.Year $Data.Month

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
	  ./Normalise -Database DIA2 -Source $_.Name -Scope "DataPointOnly" -HierarchyLevel "Company" -Action GenerateSQLScript -Script $TempFile -Prefix $Prefix > $null

	  # Append to the desired result file
	  cat ($TempFile) >> ($Script)

	  # Delete intermediate file
	  rm ($TempFile)
      }
  }

# Debug Display the resulting script
# cat ($Script)

