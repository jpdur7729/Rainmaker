# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-05-02 09:19:36 jpdur"
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Source = "999_G006_PL_AC_2019_01_FIS_Data_Enconded_20210108_2203.xlsx",
    [Parameter(Mandatory=$false)] [string] $Result,
    [Parameter(Mandatory=$false)] [switch] $Keep, # To keep the module active
    [Parameter(Mandatory=$false)] [string] $Script = "Results.sql",
    [Parameter(Mandatory=$false)] [string] $StartCollectionDate = "2019-01-01",
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# ------------------------------------------------------------
# Execution is done within the directory where the script it called 
# that way it gives easy access to the data files to be processed
# ------------------------------------------------------------
# $Exec_Dir is the actual directory where the script is found 
# ------------------------------------------------------------

# Create a temporary file to generate the SQL script
$TempFile = New-TemporaryFile 


# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This is the line Number which will be used to refer to cell and create the formula
$LineNumber = 13
# $[global:]$LineNumber = 2

# New set of data to be created
$newdata = @()

# To Ease the conversion from number to letter
$Alphabet = "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function DetermineNbMonth ($StartDate,$EndDate) {
    # Determine the number of month between 2 dates
    $StartMonth = $StartDate.Month
    $StartYear  = $StartDate.Year
    $EndMonth   = $DateasDate.Month
    $EndYear    = $DateasDate.Year

    # Nb of Months
    $NbMonth = ($EndYear - $StartYear)*12 + ($EndMonth - $StartMonth)

    # Return the Nb of Months
    [math]::Min($NbMonth,3)
}

function DetermineLetter ($StartDate,$EndDate) {

    # Determine the number of month
    $NbMonth = DetermineNbMonth -StartDate $StartDate -EndDate $EndDate

    #Determine letter corresponding to the nb of months added
    #Split into Prefix and Suffix as the difference maybe over 26 
    $LetterNumber = 6+$NbMonth

    $Prefix = [int][Math]::Floor($LetterNumber/26)
    $Suffix = [int]$LetterNumber % 26

    # To easy map the data
    $Letter = $script:Alphabet[$Suffix-1]
    # If there is a need for a prefix 
    if ($Prefix -gt 0) {$Letter = $script:Alphabet[$Prefix-1]+$Letter}

    # Return Value is actually a string
    $Letter
}

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function InsertRecord($Data,$Refbreaklevel,$LimitLevel) {

    "within the Insert Function"
    $Data
    $RefbreakLevel
    $LimitLevel
    "before Loop"

    for ( $breakLevel = $RefbreakLevel; $breakLevel -lt $LimitLevel ; $breakLevel++)  {

	"In the Insert Loop"

	# Create the new record
	$newline = $Data.PsObject.Copy()

	# Prepare the record accordingly
	$newline.level = $breakLevel
	$newline.NbLine = $script:LineNumber++
	$newline.type = "F"

	# Manage the names of the different level 
	for ( $j = $breakLevel+1 ; $j -le 4 ; $j++) {
	    $newline.("L"+$j)=""
	}

	# Add the newline in the set of data
	$script:newdata += $newline

	# $script:newdata | Format-Table
    }

}

# ----------------------------------------------------------------------------------------------------------
# The process is totally agnostic of the spreadsheet provided. So it generated the result with the same name
# but the 1st 3 letters. i.e. by default as it could be that there is desired results
# ----------------------------------------------------------------------------------------------------------
$Result = "DIA"+$Source.substring(3,$Source.length-3)

# Use only # as separators
# Any other possible space  - in the name of the company - are replaced by XYZ
$str = $Source.replace('_','#').replace(' ','XYZ')

# Pattern to read the file name
# $firstLastPattern = "^(?<BatchNumber>\w+)#(?<Output>\w+)#(?<Number1>\w+)#(?<FIS>\w+)#(?<Company>\w+)#(?<Year>\w+)#(?<Month>\w+)#(?<Hierarchy>\w+)#(?<Scenario>\w+)#(?<CreationDate>\w+)#(?<UnknownNumber>\w+).(?<extension>\w+)"
$firstLastPattern = "^(?<BatchNumber>\w+)#(?<Company>\w+)#(?<Hierarchy>\w+)#(?<Scenario>\w+)#(?<Year>\w+)#(?<Month>\w+)#(?<FIS>\w+)#(?<DataStr>\w+)#(?<Encoded>\w+)#(?<CreationDate>\w+)#(?<UnknownNumber>\w+).(?<extension>\w+)"
$firstLastPattern

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

# In order to be able to have a Company Name with space they are entered as XYZ
# Let's reestablish the right elements
# If the company starts could be understood as a number 004 the user may add a Prefix 
# quick fix to the 004 situation on 2021-03-21 
$Company = $Company.replace('XYZ',' ')
$Company = $Prefix + $Company

# ----------------------------------------------------------------------
# Normalise the values in the fields in order to get the standard values 
# ----------------------------------------------------------------------

# Normalise the Hierarchy
switch($Hierarchy)
{
    'PL' {$Hierarchy = "Income Statement"}
    'CF' {$Hierarchy = "Cashflows"}
    # 'PL' {$Hierarchy = "Profit Loss"}
    'BS' {$Hierarchy = "Balance Sheet"}
}
$Hierarchy

# Normalise the Scenario
switch($Scenario)
{
    'AC' {$Scenario = "Actuals"}
    'BD' {$Scenario = "Budget"}
}
$Scenario

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
$MonthStr = "{0:00}" -f $Month
$DateString = "$Year-$MonthStr-01"

# Change the string to date in order to be able to later choose the right format
$DateasDate = [datetime]::ParseExact($DateString,"yyyy-MM-dd", $null)
$DateasDate = $DateasDate.addDays(-1)

$DateasDate
$Company

# For the sake of compatibility
$Industry = "Unknown"

# ----------------------------------------------------
# All parameters have been read as expected 
# Read the data structure and process it accordingly
# ----------------------------------------------------

# "Stage 1 - Test Here if result file is blocked"

# Determine the letter to be used
$StartCollectionDateasDate = [datetime]::ParseExact($StartCollectionDate,"yyyy-MM-dd", $null)
$NbMonth = DetermineNbMonth -StartDate $StartCollectionDateasDate -EndDate DateasDate
$Letter  = DetermineLetter  -StartDate $StartCollectionDateasDate -EndDate DateasDate

"Letter for Formula:"+$Letter

# Delete the NewFile if it exists
rm $Result -ErrorAction SilentlyContinue

# Prepare the output 
$HeaderList = @('L1','L2','L3','L4','Amount')

# Read the initial spreadsheet 
# StartRow = 1 is the 1st line //// StartRow 2 to eliminate the header and replace it
$data = Import-Excel -Path ("./"+$Source) -StartRow 2 -HeaderName $HeaderList 

# Add the params Tab - To be added if needed in the future
# @($Hierarchy,$Industry,$Company,$Scenario,$DateasDate.tostring("dd-MMM-yy"))  | Export-Excel -AutoSize -WorksheetName Params $Result

# Lets Process the data accordingly 
for( $i=0 ; $i -lt $data.length ; $i++ ) {

    # Add a property level to all the objects with a default value 
    $data[$i] | Add-Member -NotePropertyName level   -NotePropertyValue -1
    $data[$i] | Add-Member -NotePropertyName type    -NotePropertyValue DP
    $data[$i] | Add-Member -NotePropertyName NbLine  -NotePropertyValue -1
    $data[$i] | Add-Member -NotePropertyName Formula -NotePropertyValue ""

    # Add some padding columns in order to be able to have the right column in the right place 
    for ($j = 0 ; $j -lt $NbMonth ; $j++)
    { $data[$i] | Add-Member -NotePropertyName ("Empty"+$j)   -NotePropertyValue "" }

    # Determine the level of the data found1
    if      ($data[$i].L4.length -ne 0) {$data[$i].level = 4}
    else {if ($data[$i].L3.length -ne 0) {$data[$i].level = 3}
	  else {if ($data[$i].L2.length -ne 0) {$data[$i].level = 2}
		else {if ($data[$i].L1.length -ne 0) {$data[$i].level = 1}
		     }}}
    # -----------------------------------------------------------------
    # Handle the start of the list where the precedent does not exist 
    # but needs to be created in order to sort out the init level 
    # Create a copy of the objects in order to handle them 
    # -----------------------------------------------------------------
    if ($i -eq 0) {$precedent = $data[0].PsObject.Copy()
		  $precedent.L1 = $precedent.L1+'X'
		  $precedent.L2 = $precedent.L2+'X'
		  $precedent.L3 = $precedent.L3+'X'
		  $precedent.L4 = $precedent.L4+'X'
		 }
    else {$precedent = $data[$i-1].PsObject.Copy()}
    $next = $data[$i].PsObject.Copy()

    # "Precedent"
    # $precedent | Format-Table
    # "Next"
    # $next | Format-Table
    # "Fin Prececent /next"

    # We Try to determine at which level there is a new data item 
    # and thus whether or not some intermediate consolidation lines are required 
    if       ($precedent.L1 -ne $next.L1) {$breaklevel = 1 }
    else {if ($precedent.L2 -ne $next.L2) {$breaklevel = 2 }
	  else {if ($precedent.L3 -ne $next.L3) {$breaklevel = 3 }
		else {if ($precedent.L4 -ne $next.L4) {$breaklevel = 4 }
		     }}}
    "Test data"
    $breaklevel
    $next.level
    $precedent
    $next
    "Test Data"

    # If there this is the same level and the break occurs at that level ==> nothing to do
    If (-not (($next.level -eq $precedent.level) -and ($next.level -eq $breaklevel)) ) {
	# Add the data accordingly 
	InsertRecord -Data $next -RefbreakLevel $breaklevel -LimitLevel $next.level
    }

    # Add the next records as anticipated
    $next.NbLine = $LineNumber++
    $newdata += $next
}

"Contents before creating the formula"
$newdata | Format-Table

# ------------------------------------------------------------------
# Handling the specific case of the data not being there 
# due to the structure of the SQL extract NULL is provided
# and that null is translated into "" and empty string 
# as part of the null vs. 0 process we put $null in all the fields
# ------------------------------------------------------------------
# Lets Process the data accordingly 
for( $i=0 ; $i -lt $newdata.length ; $i++ ) {
    if ($newdata[$i].Amount -eq "") {
	$newdata[$i].Amount = $null
    }
}

# Prepare the formula
for ($i = 0 ; $i -lt $newdata.length ; $i++) {

    # Only the added lines for which there is a formula to create
    if ($newdata[$i].type -ne "F") {continue}

    $Formula = ""
    $levelFormula = $newdata[$i].level

    # We add all the lineNumber for which the level is immediately superior 
    # till we have not found a level inferior or equal
    for ($j = $i+1 ; $j -lt $newdata.length ; $j++) {
	
	# The loop ends if we find something of a level inferior or equal 
	if ($newdata[$j].level -le $levelFormula) {break}
	
	# We only add the elements which are exactly at $levelFormula +1
	if ($newdata[$j].level -eq ($levelFormula+1)) {
	    $Formula += "+"+$Letter+$newdata[$j].NbLine
	}

    }
    
    # we associate the formula with the cell 
    $newdata[$i].Formula = $Formula
}

# Full debug of the created structure 
# $excel = $newdata |                                                    Export-Excel -AutoSize -NoHeader -StartRow 13 -WorksheetName DataDebug    $Result

# Add the Data Tab and display the key table without any filtering
# $excel = $newdata | Select-Object -Property level,L1,L2,L3,L4,Amount | Export-Excel -AutoSize -NoHeader -StartRow 13 -WorksheetName Data $Result -PassThru
# We need to add a few extra columns
$ListColumns = @()
$ListColumns += "level"
$ListColumns += "L1"
$ListColumns += "L2"
$ListColumns += "L3"
$ListColumns += "L4"
# Add the mock Columns 
$MockColumns = ""
for ($j = 0 ; $j -lt $NbMonth ; $j++)
{ $ListColumns += "Empty"+$j }

# Add the final Amount 
$ListColumns += "Amount"

# evel,L1,L2,L3,L4,"+$MockColumns+"Amount"
$ListColumns
$testdata = $newdata | Select-Object -Property $ListColumns
$testdata | Format-Table

$excel = $newdata | Select-Object -Property $ListColumns | Export-Excel -AutoSize -NoHeader -StartRow 13 -WorksheetName Data $Result -PassThru
$ws = $excel.Workbook.Worksheets['Data']

# Hide the Column A
Set-ExcelColumn -Worksheet $ws -Column 1 -AutoSize -Hide

# Create a table in order to have a different set of colour per level
$ListColors = @(
    [pscustomobject]@{level=1;BackgroundColor="Green"},
    [pscustomobject]@{level=2;BackgroundColor="Blue"},
    [pscustomobject]@{level=3;BackgroundColor="Yellow"}
)

# Setup the formula for each and every cell
for ($i = 0 ; $i -lt $newdata.length ; $i++) {
    # Only the added lines for which there is a formula to create
    if ($newdata[$i].type -ne "F") {continue}

    # Extract the background color from the list
    $BackgroundColor = $ListColors | Where level -eq $newdata[$i].level | Select -ExpandProperty BackgroundColor
    $BackgroundColor

    # Changing the backgrund Color 
    Set-Format -WorkSheet $ws -Range ("B"+$newdata[$i].NbLine+":"+$Letter+$newdata[$i].NbLine) -BackgroundColor $BackgroundColor

    # Just add the formula in the corresponding cell
    Set-ExcelRange -Worksheet $ws -Range ($Letter+$newdata[$i].NbLine)   -Formula $newdata[$i].Formula -Bold
}

# All Amounts in currency format
Set-ExcelColumn -Worksheet $ws -Column (6+$NbMonth) -AutoSize -NumberFormat '#,##0.00'

$DatabaseName = "JP LDC"

# Prepare/add the header of the spreadsheet
Set-ExcelRange -Worksheet $ws -Range "B1" -Value $DatabaseName
Set-Format     -WorkSheet $ws -Range "B1" -FontName Calibri -FontSize 14 -Bold -AutoSize
Set-ExcelRange -Worksheet $ws -Range "B2" -Value "Portfolio data collection"
Set-Format     -WorkSheet $ws -Range "B2" -FontName Calibri -FontSize 11 -Bold -AutoSize
Set-ExcelRange -Worksheet $ws -Range "B3" -Value ("Financials-"+$Hierarchy+" Template")
Set-Format     -WorkSheet $ws -Range "B3" -FontName Calibri -FontSize 11 -Bold -AutoSize

# Prepare/add the details of the company
Set-ExcelRange -Worksheet $ws -Range "B5" -Value "Company:"
Set-ExcelRange -Worksheet $ws -Range "B6" -Value "As Of Date:"
Set-ExcelRange -Worksheet $ws -Range "B7" -Value "Time Period:"
Set-ExcelRange -Worksheet $ws -Range "C5" -Value $Company
Set-ExcelRange -Worksheet $ws -Range "C6" -Value (Get-Date -Format "dd/MM/yyyy")
Set-ExcelRange -Worksheet $ws -Range "C7" -Value "Monthly"

# Format the header accordingly 
Set-Format     -WorkSheet $ws -Range "B5:C5" -FontName Calibri -FontSize 12 -Bold -FontColor "Blue" -AutoSize
Set-Format     -WorkSheet $ws -Range "B6:C6" -FontName Calibri -FontSize 12 -Bold -FontColor "Blue" -AutoSize
Set-Format     -WorkSheet $ws -Range "B7:C7" -FontName Calibri -FontSize 12 -Bold -FontColor "Blue" -AutoSize

# Add the descripton of the data collected
$Letter
Set-ExcelRange -Worksheet $ws -Range ($Letter+"10") -Value $Scenario                             # Actuals   
Set-ExcelRange -Worksheet $ws -Range ($Letter+"11") -Value ($DateasDate.tostring("yyyy MMM"))	# 2019 Jan  
Set-ExcelRange -Worksheet $ws -Range ($Letter+"12") -Value ($DateasDate.tostring("M/dd/yyyy"))	# 1/31/2019 
Set-Format     -WorkSheet $ws -Range ($Letter+"10") -BorderAround Thick -FontName Calibri -Bold -FontSize 11
Set-Format     -WorkSheet $ws -Range ($Letter+"11") -BorderAround Thick -FontName Calibri -Bold -FontSize 11
Set-Format     -WorkSheet $ws -Range ($Letter+"12") -BorderAround Thick -FontName Calibri -Bold -FontSize 11

"After 3 columns",$Letter

# Format the list of Amnounts with border and Bold
$Range = $Letter+"10:"+$Letter+($newdata.length+12)

# Border about each and every one of the Amount
for ($j = 13 ; $j -le ($newdata.length+12) ; $j++) {
    if ( $newdata[$j-13].type -eq "F" ) {
	Set-Format     -WorkSheet $ws -Range ($Letter+$j) -AutoSize -BorderAround Thick -Bold -FontSize 12
    }
    else {
	Set-Format     -WorkSheet $ws -Range ($Letter+$j) -AutoSize -BorderAround Thick
    }
}

# Level-0	Level-1	Level-2	DataItem Presentation Line
Set-ExcelRange -Worksheet $ws -Range "B9" -Value "Level-0"
Set-ExcelRange -Worksheet $ws -Range "C9" -Value "Level-1"
Set-ExcelRange -Worksheet $ws -Range "D9" -Value "Level-2"
Set-ExcelRange -Worksheet $ws -Range "E9" -Value "DataItem"
Set-Format     -WorkSheet $ws -Range "B9:E9" -FontName "Calibri" -FontSize 11

# For the different columns add the Batch Number
for ($j = 0 ; $j -le $NbMonth ; $j++) {
    $rangebatch = $Alphabet[($j + 5)]+"9"
    $rangebatch
    Set-ExcelRange -Worksheet $ws -Range $rangebatch -Value ("Batch"+$j)
}


# Autosize Column with the values
$ColumnNumber = 6 + $NbMonth
Set-ExcelColumn -Worksheet $ws -Column $ColumnNumber -AutoSize

# Closes the data and recalculate
Close-ExcelPackage $excel -Calculate

# Just show the Excel spreadsheet for debug purposes
# Export-Excel -Show $Result

# # Create the new spreadsheet 
# $excel = $data | Export-Excel -AutoSize -AutoFilter -WorksheetName Data $Result -PassThru
# # Get a pointer to the Data Sheet 
# $ws = $excel.Workbook.Worksheets['Data']

# # Add the ordering columns in order to prepare the node insertion
# # =IF(A1=A2,F1,F1+1)
# Set-ExcelColumn -Worksheet $ws -Heading "0"   -Column 6 -AutoSize -Value {("=IF(A$row=A$($row-1),F$($row-1),F$($row-1)+1)") }
# # =IF(B1=B2,G1,G1+1)
# Set-ExcelColumn -Worksheet $ws -Heading "0"   -Column 7 -AutoSize -Value {("=IF(B$row=B$($row-1),G$($row-1),G$($row-1)+1)") }
# # =IF(C1=C2,H1,H1+1)
# Set-ExcelColumn -Worksheet $ws -Heading "0"   -Column 8 -AutoSize -Value {("=IF(C$row=C$($row-1),H$($row-1),H$($row-1)+1)") }
# # IF(LEN(D2)=0,0,IF(C1<>C2,1,I1+1))
# Set-ExcelColumn -Worksheet $ws -Heading "2"   -Column 9 -AutoSize -Value {("=IF(LEN(D$row)=0,0,IF(C$row<>C$($row-1),1,I$($row-1)+1))") }

# # Levels before Company Level
# # ="EXEC PS_STG_CREATE_NODE  '"&A2&"','"&Params!$A$1&"',"&F2
# Set-ExcelColumn -Worksheet $ws -Heading "SQL1" -Column 10 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODE '""&A$row&""' , '""&Params!`$A`$1&""' , ""&F$row&""      """) }
# # "EXEC PS_STG_LINK_GENERIC '"&Params!$A$1&"','"&A2&"','"&Params!$A$1&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL2" -Column 11 -AutoSize -Value {("=""EXEC PS_STG_LINK_GENERIC '""&Params!`$A`$1&""' , '""&A$row&""' , '""&Params!`$A`$1&""'   """) }
# # ="EXEC PS_STG_CREATE_NODEINDUSTRY '"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&A2&"' ," &G2
# Set-ExcelColumn -Worksheet $ws -Heading "SQL3" -Column 12 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODEINDUSTRY '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&A$row&""' , ""&G$row&""  """) }
# # ="EXEC PS_STG_LINK_GENERIC_INDUSTRY '"&A2&"','"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL4" -Column 13 -AutoSize -Value {("=""EXEC PS_STG_LINK_GENERIC_INDUSTRY '""&A$row&""' , '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' """) }

# # Levels starting at Company Level
# # ="EXEC PS_STG_CREATE_NODECOMPANY '"&C2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&B2&"',"&H2&","&C$1
# Set-ExcelColumn -Worksheet $ws -Heading "SQL5" -Column 14 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODECOMPANY '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' , '""&H$row&""' , '""&C`$1&""' """) }
# # =IF(LEN(D2)=0,"","EXEC PS_STG_CREATE_NODECOMPANY '"&D2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&C2&"',"&I2&","&D$1)
# Set-ExcelColumn -Worksheet $ws -Heading "SQL6" -Column 15 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_CREATE_NODECOMPANY '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&C$row&""' , '""&I$row&""' , '""&D`$1&""' "")") }
# # ="EXEC PS_STG_LINK_INDUSTRY_COMPANY '"&B2&"','"&C2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&C2&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("=""EXEC PS_STG_LINK_INDUSTRY_COMPANY '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&A$row&""' """) }
# # ="EXEC PS_STG_LINK_COMPANY_COMPANY '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&B2&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL8" -Column 17 -AutoSize -Value {("=""EXEC PS_STG_LINK_COMPANY_COMPANY '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' """) }

# # Add the data
# # Difficulties to interpret the function text with the parameters
# # ="EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL12 '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"& Params!$A$4&"','"&TEXT(Params!$A$5,"dd-mmmm-yy")&"', "&E2
# # Set-ExcelColumn -Worksheet $ws -Heading "SQL9" -Column 18 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL2 '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&Params!`$A`$4&""' , '""&TEXT(Params!`$A`$5,""dd-mmm-yy"")&""' , '""&E$row&""' "")")}
# # Set-ExcelColumn -Worksheet $ws -Heading "SQL9" -Column 18 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL2 '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&Params!`$A`$4&""' , '""&Params!`$A`$5&""' , ""&E$row&"" "")")}
# Set-ExcelColumn -Worksheet $ws -Heading "SQL9" -Column 18 -AutoSize -Value {("=""EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL12 '""&C$row&""' , '""&D$row&""' , '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&Params!`$A`$4&""' , '""&Params!`$A`$5&""' , ""&E$row&"" """)}

# # No need to show // Close Package calculate and closes the spreadsheet 
# # Different from Export-Excel -ExcelPackage $excel -Calculate which requires to actually save the file
# Close-ExcelPackage $excel -Calculate

# "Stage 2"

# # Test result spreadsheet - Read it 
# $HeaderList = @('G1','I1','1','2','Amount','Sort_G1','Sort_I1','Sort_CL1','Sort_CL2','SQL1','SQL2','SQL3','SQL4','SQL5','SQL6','SQL7','SQL8','SQL9')
# $HeaderList
# $data = Import-Excel $Result -WorksheetName Data -HeaderName $HeaderList
# $data

# if ($Scope -ne "DataPointOnly") {
#     # -------------------------------------------------------------------
#     # Execute the SQL in each and every of the column 1 column at a time
#     # In order to create the structure 
#     # -------------------------------------------------------------------
#     Execute-SQLColumn -data $data -SQLQuery "SQL1"
#     Execute-SQLColumn -data $data -SQLQuery "SQL2"
#     Execute-SQLColumn -data $data -SQLQuery "SQL3"
#     Execute-SQLColumn -data $data -SQLQuery "SQL4"
#     Execute-SQLColumn -data $data -SQLQuery "SQL5"
#     Execute-SQLColumn -data $data -SQLQuery "SQL6"
#     Execute-SQLColumn -data $data -SQLQuery "SQL7"
#     Execute-SQLColumn -data $data -SQLQuery "SQL8"
# }

# "Stage 3 - No upload of values"

# # Execute SQL for the actual DataPoint
# if ($Scope -ne "StructureOnly") {
#     Execute-SQLColumn -data $data -SQLQuery "SQL9"
# }

# # --------------------------------------------------------------------
# # Process the $Script in order to eliminate duplicate lines 
# # Lines where all prefixed by SQLx where x is the number of the steps
# # if not sort+uniq was reshuffling the order of the steps
# # --------------------------------------------------------------------
# $TempFile2 = New-TemporaryFile 
# cat $TempFile | sort | uniq > ($TempFile2)

# # Post precessing the $Script file in order to transform "SQL..EXEC" into EXEC 
# (Get-Content $TempFile2) -replace '^(SQL\d*EXEC )(.*)','EXEC $2' |  Out-File ($Script)

# # Eliminate the Temporary files
# rm $TempFile2
# rm $TempFile

# That way the module is only used as part of the script and no afterwards
if (!($Keep)) {
    Remove-Module RainmakerLib
}

