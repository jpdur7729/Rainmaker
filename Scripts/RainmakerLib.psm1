# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-20 11:47:12 jpdur"
# ------------------------------------------------------------------------------


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Execute SQL but store in log not only the error but the name of query 
# if no $Log is indicated then the error message are displayed 
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function Invoke-DbaQueryLog ($SqlInstance, $Database,$Query,$Log) {

    # If no log file is indicated we execute the query directly
    if ( $Log -eq "") {
	Invoke-DbaQuery -SqlInstance $SqlInstance  -Database $Database -Query $Query 
    }
    else {
	# Execute the query. All errors/warning messages which come from SQL 
	# are actually sent back in stream 3 i.e. warning. 
	Invoke-DbaQuery -SqlInstance $SqlInstance  -Database $Database -Query $Query 3> inter.log

	# inter.log is only created and not empty if there is sonething to report
	# if that is the case we add the data to the $Log file with the contents of the query 
	if ( (Test-Path "inter.log") -and ( (Get-Item "inter.log").length -ne 0) ) {
	    $Query >> $Log
	    cat inter.log >> $Log
	}
    }
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Determine the Industry of the company 
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function GetIndustry {
    param(
	[Parameter(Mandatory=$true)]  [string] $Company,
	[Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
	[Parameter(Mandatory=$false)] [string] $Database = "DIA2"
    )

    # Extract the Industry for the given company 
    $query1 = "select Name from IndustryList where ID in (select IndustryID from CompanyList where Name = '"+$Company+"')"
    $data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $Database -Query $query1

    # Error message or confirmation if needed
    if ($data_query1 -eq $null) {
	Write-Host "Company:" + $Company +" is not known"
    }
    else {
	Write-Host "Company " + $Company +" belongs to the industry " + $data_query1.Name
    }

    # Return the name of the industry
    $data_query1.Name

}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Standardise name for the Hierarchy Code Received
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function DecodeHierarchyCode {

    param(
	[Parameter(Mandatory=$true)] [string] $HierarchyCode
    )

    switch($HierarchyCode)
    {
	'PL' {$Hierarchy = "Income Statement"}
	'CF' {$Hierarchy = "Cashflows"}
	# 'PL' {$Hierarchy = "Profit Loss"}
	'BS' {$Hierarchy = "Balance Sheet"}
    }

    # Return the Hierarchy
    $Hierarchy
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Convert Hierarchy Name to Hierarchy Code 
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function ConvertHierarchyName2Code {

    param(
	[Parameter(Mandatory=$true)] [string] $HierarchyName
    )

    switch($HierarchyName)
    {
	'Income Statement' {$HierarchyCode = "PL"}
	'Cashflows' {$HierarchyCode = "CF"}
	# 'Profit Loss' {$HierarchyCode = "PL"}
	'Balance Sheet' {$HierarchyCode = "BS"}
    }

    # Return the Hierarchy Code
    $HierarchyCode
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Standardise name for the Scenario Code Received
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function DecodeScenarioCode {

    param(
	[Parameter(Mandatory=$true)] [string] $ScenarioCode
    )

    switch($ScenarioCode)
    {
	'AC' {$Scenario = "Actuals"}
	'BD' {$Scenario = "Budget"}
	'OB' {$Scenario = "OBP"}
    }

    # Return the Scenario
    $Scenario
}

# ------------------------------------------------------------------------------------------------------------------------------------
# This is the NAV naming convention... used only temporarily ==> To be Deleted
# ------------------------------------------------------------------------------------------------------------------------------------
function ExtractCharacteristicsNAV($FileName) {
    
    # Use only # as separators
    $str = $FileName.replace('_','#').replace(' ','XYZ')
    
    $firstLastPattern = "^(?<BatchNumber>\w+)#(?<Company>\w+)#(?<Year>\w+)#(?<Month>\w+)#(?<Hierarchy>\w+)#(?<Scenario>\w+)#(?<NAV>\w+)#(?<Encoded>\w+)#(?<CreationDate>\w+)#(?<UnknownNumber>\w+).(?<extension>\w+)"
    $str |
      Select-String -Pattern $firstLastPattern |
      Foreach-Object {
	  # here we access the groups by name instead of by index
	  # $BatchNumber, $Output, $Number1, $FIS, $Company, $Year, $Month, $Hierarchy, $Scenario, $CreationDate, $UnknownNumber, $extension = $_.Matches[0].Groups['BatchNumber', 'Output', 'Number1', 'FIS', 'Company', 'Year', 'Month', 'Hierarchy', 'Scenario', 'CreationDate', 'UnknownNumber', 'extension'].Value
	  # Old Format: 002_004_PL_AC_2020_07_FIS_Data_Encoded_20210315_170913.xlsx
	  # New Format: INI_O011_2020_07_PL_AC_NAV_Encoded_20210608_114629.xlsx
	  $BatchNumber, $Company, $Year, $Month, $Hierarchy, $Scenario, $NAV, $Encoded, $CreationDate, $UnknownNumber, $extension = $_.Matches[0].Groups['BatchNumber', 'Company', 'Year', 'Month', 'Hierarchy', 'Scenario', 'NAV', 'Encoded', 'CreationDate', 'UnknownNumber', 'extension'].Value
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

# -------------------------------------------------------------------------
# Extract from FileName the Year/Month needed actualy all the components
# returns an object with all the identified components of the name
# -------------------------------------------------------------------------
# Returns a structure with all the required fields
# -------------------------------------------------------------------------
function ExtractCharacteristics($FileName) {

    # Use only # as separators
    # Caution with ' ', '-' and equivalent which are separators
    $str = $FileName.replace('_','#').replace(' ','ZzZ').replace('-','AaA')
    
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
              Company  = $Company.replace('ZzZ',' ').replace('AaA','-')
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

