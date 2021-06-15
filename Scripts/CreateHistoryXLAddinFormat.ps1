# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-15 11:13:15 jpdur"
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Source = "999_G006_PL_AC_2019_01_FIS_Data_Enconded_20210108_2203.xlsx",
    [Parameter(Mandatory=$false)] [switch] $Keep, # To keep the module active
    [Parameter(Mandatory=$false)] [string] $Result = "DIG.xlsx", # Result Spreadsheet
    [Parameter(Mandatory=$false)] [string] $StartCollectionDate = "2019-01-01",
    [Parameter(Mandatory=$false)] [string] $EndCollectionDate = "2100-01-01",
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# "Within CreateHistoryXLAddinFormat"
# exit

# Call the common library of all the different modules 
$SourceModule = $Exec_Dir+"/RainmakerLib"
Import-module -Force -Name ($SourceModule)

# ------------------------------------------------------------
# Execution is done within the directory where the script it called 
# that way it gives easy access to the data files to be processed
# ------------------------------------------------------------
# $Exec_Dir is the actual directory where the script is found 
# ------------------------------------------------------------

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# This is the line Number which will be used to refer to cell and create the formula
$LineNumber = 13
# $[global:]$LineNumber = 2

# New set of data to be created
$newdata = @()

# # To Ease the conversion from number to letter
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
    $NbMonth
}										

function DetermineLetter ($StartDate,$EndDate) {				

    # Determine the number of month						
    $NbMonth = DetermineNbMonth -StartDate $StartDate -EndDate $EndDate	

    #Determine letter corresponding to the nb of months added			
    #Split into Prefix and Suffix as the difference maybe over 26 		
    $LetterNumber = 6+$NbMonth						

    $Prefix = [int][Math]::Floor( (($LetterNumber) -1) /26)				
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
# $Result is in that case the Global spreadsheet whose name is DIG_Company_Hiearchy_Scenario_From-To.xlsx
# $Source is of the usual format DIX_Company_Hierarchy_Scenarion_Year_Month*.xlsx
# ----------------------------------------------------------------------------------------------------------

# Extract the characteristics based on the File Name 
$Data = ExtractCharacteristics -FileName $Source

# -------------------------------------------------------------------------------------
# If the company starts could be understood as a number 004 the user may add a Prefix 
# quick fix to the 004 situation on 2021-03-21 
# -------------------------------------------------------------------------------------
$Company = $Prefix + $Data.Company
$Year = $Data.Year
$Month = $Data.Month
$HierarchyCode = $Data.Hierarchy
$ScenarioCode = $Data.Scenario

# Standardise the Hierarchy based on the Code Received 
$Hierarchy = DecodeHierarchyCode -HierarchyCode $HierarchyCode

# Standardise the Scenario based on the Code Received 
$Scenario = DecodeScenarioCode -ScenarioCode $ScenarioCode

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
$NbMonth = DetermineNbMonth -StartDate $StartCollectionDateasDate -EndDate $DateasDate
$Letter  = DetermineLetter  -StartDate $StartCollectionDateasDate -EndDate $DateasDate

"Letter for Formula:"+$Letter
$NbMonth
$StartCollectionDateasDate
$StartCollectionDateasDate.Year 
$StartCollectionDateasDate.Month
"DateasDate"
$DateasDate
$DateasDate.Year
$DateasDate.Month
"End Test"

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
# By default SQL extract NULL is provided but then it 
# becomes impossible to distinguish between 0 and NULL
# as "" - empty string - is provided in both cases
# a conventional value -0.12345 is used in order to make the distinction
# it is generated in the SQL script via a coalesce
# ------------------------------------------------------------------
# Lets Process the data accordingly --> Potential issue when calculating
# Occurs.... ??? Tried optons such as "0.00" but does not seem to work
# ------------------------------------------------------------------
for( $i=0 ; $i -lt $newdata.length ; $i++ ) {
    if ($newdata[$i].Amount -eq -0.12345) {
	$newdata[$i].Amount = $null
    }
    if ($newdata[$i].Amount -eq "") {
	$newdata[$i].Amount = 0.00
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

"Contents with the formula"
$newdata | Format-Table

# -------------------------------------------------------------------------
# Create the spreadsheet $Result from scratch if and only if $NbMonth = 0 
# i.e. when we start creating the History XL Addin
# -------------------------------------------------------------------------
if ($NbMonth -eq 0) {

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
}
else {
    
    # Just add the data on the spreadsheet 
    $excel = Export-Excel -WorksheetName Data $Result -PassThru
    $ws = $excel.Workbook.Worksheets['Data']

    # Setup the data for each and every cell
    for ($i = 0 ; $i -lt $newdata.length ; $i++) {
	# Only the added lines for which there is a DataPoint to add
	if ($newdata[$i].type -ne "DP") {continue}

	# Just add the formula in the corresponding cell
	Set-ExcelRange -Worksheet $ws -Range ($Letter+$newdata[$i].NbLine) -Value $newdata[$i].Amount
    }
}    

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

# For the different columns add the Batch Number
$rangebatch = $Letter+"9"
Set-ExcelRange -Worksheet $ws -Range $rangebatch -Value ("Batch"+$NbMonth)

# Add the descripton of the data collected
$Letter
Set-ExcelRange -Worksheet $ws -Range ($Letter+"10") -Value $Scenario				 # Actuals   
Set-ExcelRange -Worksheet $ws -Range ($Letter+"11") -Value ($DateasDate.tostring("yyyy MMM"))	# 2019 Jan  
Set-ExcelRange -Worksheet $ws -Range ($Letter+"12") -Value ($DateasDate.tostring("M/dd/yyyy"))	# 1/31/2019 
Set-Format     -WorkSheet $ws -Range ($Letter+"10") -FontName Calibri -Bold -FontSize 11
Set-Format     -WorkSheet $ws -Range ($Letter+"11") -FontName Calibri -Bold -FontSize 11
Set-Format     -WorkSheet $ws -Range ($Letter+"12") -FontName Calibri -Bold -FontSize 11

# All Amounts in currency format
Set-ExcelColumn -Worksheet $ws -Column (6+$NbMonth) -AutoSize -NumberFormat '#,##0.00'

# Autosize Column with the values
$ColumnNumber = 6 + $NbMonth
Set-ExcelColumn -Worksheet $ws -Column $ColumnNumber -AutoSize

# Check if we have reached the end of the Collection
$ToasDate = [datetime]::ParseExact($EndCollectionDate,"yyyy-MM-dd", $null)

# The Rest of the formatting only happens if this is the last month
if ($ToasDate -eq $DateasDate) {


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
    # $Letter
    Set-ExcelRange -Worksheet $ws -Range ($Letter+"10") -Value $Scenario			     # Actuals	 
    Set-ExcelRange -Worksheet $ws -Range ($Letter+"11") -Value ($DateasDate.tostring("yyyy MMM"))	# 2019 Jan  
    Set-ExcelRange -Worksheet $ws -Range ($Letter+"12") -Value ($DateasDate.tostring("M/dd/yyyy"))	# 1/31/2019 
    Set-Format	   -WorkSheet $ws -Range ($Letter+"10") -BorderAround Thick -FontName Calibri -Bold -FontSize 11
    Set-Format	   -WorkSheet $ws -Range ($Letter+"11") -BorderAround Thick -FontName Calibri -Bold -FontSize 11
    Set-Format	   -WorkSheet $ws -Range ($Letter+"12") -BorderAround Thick -FontName Calibri -Bold -FontSize 11

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

    # Autosize Column with the values
    $ColumnNumber = 6 + $NbMonth
    Set-ExcelColumn -Worksheet $ws -Column $ColumnNumber -AutoSize
}

# Closes the data and recalculate
Close-ExcelPackage $excel -Calculate

# That way the module is only used as part of the script and no afterwards
if (!($Keep)) {
    Remove-Module RainmakerLib
}

