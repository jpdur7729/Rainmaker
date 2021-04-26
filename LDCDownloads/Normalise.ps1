# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-04-26 13:47:18 jpdur"
# ------------------------------------------------------------------------------

# Modified Monday, 26. April 2021 - 011 - structure - Income Statement/Direct/A/B and Statement/Indirect/A/B
# Creation of the lowest level issue (cf. CREATE_NODE_COMPANY) The formula had to be modified 
# ------------------------------------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Source = "002_004_PL_AC_2020_07_FIS_Data_Encoded_20210315_170913.xlsx",
    [Parameter(Mandatory=$false)] [string] $Result = "Results.xlsx",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [ValidateSet("runSQL","GenerateSQLScript")] [string] $Action = "GenerateSQLScript",
    [Parameter(Mandatory=$false)] [ValidateSet("StructureOnly","DataPointOnly","All")] [string] $Scope = "StructureOnly",
    [Parameter(Mandatory=$false)] [ValidateSet("Top","Industry","Company")] [string] $HierarchyLevel = "Company",
    [Parameter(Mandatory=$false)] [string] $Script = "Results.sql",
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Execution is done from the directory of the script ==> relative paths are thus possible
cd $Exec_Dir

# Create a temporary file to generate the SQL script
$TempFile = New-TemporaryFile 

# ---------------------------------------------------------------------------------- 
# Default parameter to execute the SQL or save the script with all the generated SQL
#         parameter to change Structure / Or Upload Data or both 
# ---------------------------------------------------------------------------------- 

# -------------------------------------------------------------
# File to be read ???
# And then the extra data point could be passed as a parameter 
# in the case of LDC it is extracted from the name of the file
# -------------------------------------------------------------

# --------------------------------------------------------------------------
# Utility function to execute all SQL statements from a column
# Actually from the set of objects data corresponding to the field SQLQuery
# --------------------------------------------------------------------------
function Execute-SQLColumn($data,$SQLQuery){

    # Loop for all elements of the column whose header has been provided
    # select -skip 1 is to just skip the 1st element which is the header 
    $data | select -skip 1 | ForEach-Object {
	$_."$SQLQuery",$SQLQuery,$HierarchyLevel
	if ($_."$SQLQuery".length -ne 0) {
	    if ($Action -eq "runSQL") {
		$data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $Database -Query $_."$SQLQuery"
	    }
	    # Only generates the top level request
	    If ( ($HierarchyLevel -eq "Top") -and ($SQLQuery -eq "SQL1") ) {
		$SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
	    }
	    If ( ($HierarchyLevel -eq "Industry") -and
		 (($SQLQuery -eq "SQL1") -or ($SQLQuery -eq "SQL2") -or ($SQLQuery -eq "SQL3") -or ($SQLQuery -eq "SQL4"))) {
		$SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
	    }
	    if ($HierarchyLevel -eq "Company") {
		    # We genertae by default for all Levels
		    $SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
	    }
	}
	# Display results if required 
	# $data_query1.ID
    }

}

# Handling RegExp ie. extracting varaibles setup from string organised as A_B_C_D
# $str = "A123_B22_Cr_DT"
# $str = $str.replace('_','#')
# $str

# -----------------------------------------------------------------------------
# Example is extracted from below // lots of examples
# -----------------------------------------------------------------------------
# https://devblogs.microsoft.com/powershell/parsing-text-with-powershell-1-3/
# \w	The \w meta character is used to find a word character.
#         A word character is a character from a-z, A-Z, 0-9,
#         including the _ (underscore) character. 
# -----------------------------------------------------------------------------
# From the observation above the idea of replacing _ by #
# and more generaly to replace any known separator with #
# -----------------------------------------------------------------------------
# # Use regular expresion to extract Expressions
# $firstLastPattern = "^(?<first>\w+)#(?<second>\w+)#(?<third>\w+)#(?<fourth>\w+)"
# $str |
  #   Select-String -Pattern $firstLastPattern |
  #   Foreach-Object {
#       # here we access the groups by name instead of by index
#       $first, $second, $third, $fourth = $_.Matches[0].Groups['first', 'second', 'third', 'fourth'].Value
#       [PSCustomObject] @{
#           FirstName = $first
#           LastName = $second
#           Handle = $third
#           TwitterFollowers = $fourth
#       }
#   }

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

# Extract the Industry for the given company 
$query1 = "select Name from IndustryList where ID in (select IndustryID from CompanyList where Name = '"+$Company+"')"
$data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $Database -Query $query1

# Error message or confirmation if needed
if ($data_query1 -eq $null) {
    "Company:" + $Company +" is not known"
}
else {
    "Company " + $Company +" belongs to the industry " + $data_query1.Name
}

# Keep the industry
$Industry = $data_query1.Name

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

"Stage 1 - Test Here if result file is blocked"

# Delete the NewFile if it exists
rm $Result -ErrorAction SilentlyContinue

# Prepare the output 
$HeaderList = @('G1','I1','1','2','Amount')

# Read the initial spreadsheet 
# StartRow = 1 is the 1st line //// StartRow 2 to eliminate the header and replace it
$data = Import-Excel -Path ("./"+$Source) -StartRow 2 -HeaderName $HeaderList 

# Add the params Tab 
@($Hierarchy,$Industry,$Company,$Scenario,$DateasDate.tostring("dd-MMM-yy"))  | Export-Excel -AutoSize -WorksheetName Params $Result

# Create the new spreadsheet 
$excel = $data | Export-Excel -AutoSize -AutoFilter -WorksheetName Data $Result -PassThru
# Get a pointer to the Data Sheet 
$ws = $excel.Workbook.Worksheets['Data']

# Add the ordering columns in order to prepare the node insertion
# =IF(A1=A2,F1,F1+1)
Set-ExcelColumn -Worksheet $ws -Heading "0"   -Column 6 -AutoSize -Value {("=IF(A$row=A$($row-1),F$($row-1),F$($row-1)+1)") }
# =IF(B1=B2,G1,G1+1)
Set-ExcelColumn -Worksheet $ws -Heading "0"   -Column 7 -AutoSize -Value {("=IF(B$row=B$($row-1),G$($row-1),G$($row-1)+1)") }
# =IF(C1=C2,H1,H1+1)
Set-ExcelColumn -Worksheet $ws -Heading "0"   -Column 8 -AutoSize -Value {("=IF(C$row=C$($row-1),H$($row-1),H$($row-1)+1)") }
# IF(LEN(D2)=0,0,IF(C1<>C2,1,I1+1))
Set-ExcelColumn -Worksheet $ws -Heading "2"   -Column 9 -AutoSize -Value {("=IF(LEN(D$row)=0,0,IF(C$row<>C$($row-1),1,I$($row-1)+1))") }

# Levels before Company Level
# ="EXEC PS_STG_CREATE_NODE  '"&A2&"','"&Params!$A$1&"',"&F2
Set-ExcelColumn -Worksheet $ws -Heading "SQL1" -Column 10 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODE '""&A$row&""' , '""&Params!`$A`$1&""' , ""&F$row&""      """) }
# "EXEC PS_STG_LINK_GENERIC '"&Params!$A$1&"','"&A2&"','"&Params!$A$1&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL2" -Column 11 -AutoSize -Value {("=""EXEC PS_STG_LINK_GENERIC '""&Params!`$A`$1&""' , '""&A$row&""' , '""&Params!`$A`$1&""'   """) }
# ="EXEC PS_STG_CREATE_NODEINDUSTRY '"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&A2&"' ," &G2
Set-ExcelColumn -Worksheet $ws -Heading "SQL3" -Column 12 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODEINDUSTRY '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&A$row&""' , ""&G$row&""  """) }
# ="EXEC PS_STG_LINK_GENERIC_INDUSTRY '"&A2&"','"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL4" -Column 13 -AutoSize -Value {("=""EXEC PS_STG_LINK_GENERIC_INDUSTRY '""&A$row&""' , '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' """) }

# Levels starting at Company Level
# ="EXEC PS_STG_CREATE_NODECOMPANY '"&C2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&B2&"',"&H2&","&C$1
Set-ExcelColumn -Worksheet $ws -Heading "SQL5" -Column 14 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODECOMPANY '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' , '""&H$row&""' , '""&C`$1&""' , '""&A$row&""' """) }
# =IF(LEN(D2)=0,"","EXEC PS_STG_CREATE_NODECOMPANY '"&D2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&C2&"',"&I2&","&D$1)
Set-ExcelColumn -Worksheet $ws -Heading "SQL6" -Column 15 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_CREATE_NODECOMPANY '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&C$row&""' , '""&I$row&""' , '""&D`$1&""' , '""&B$row&""' "")") }
# ="EXEC PS_STG_LINK_INDUSTRY_COMPANY '"&B2&"','"&C2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&C2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("=""EXEC PS_STG_LINK_INDUSTRY_COMPANY '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&A$row&""' """) }
# ="EXEC PS_STG_LINK_COMPANY_COMPANY '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&B2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL8" -Column 17 -AutoSize -Value {("=""EXEC PS_STG_LINK_COMPANY_COMPANY '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' """) }

# Add the data
# Difficulties to interpret the function text with the parameters
# ="EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL12 '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"& Params!$A$4&"','"&TEXT(Params!$A$5,"dd-mmmm-yy")&"', "&E2
# Set-ExcelColumn -Worksheet $ws -Heading "SQL9" -Column 18 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL2 '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&Params!`$A`$4&""' , '""&TEXT(Params!`$A`$5,""dd-mmm-yy"")&""' , '""&E$row&""' "")")}
# Set-ExcelColumn -Worksheet $ws -Heading "SQL9" -Column 18 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL2 '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&Params!`$A`$4&""' , '""&Params!`$A`$5&""' , ""&E$row&"" "")")}
Set-ExcelColumn -Worksheet $ws -Heading "SQL9" -Column 18 -AutoSize -Value {("=""EXEC PS_STG_ADD_DATAPOINT_VALUE_COMPANYL12 '""&C$row&""' , '""&D$row&""' , '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&Params!`$A`$4&""' , '""&Params!`$A`$5&""' , ""&E$row&"" """)}

# No need to show // Close Package calculate and closes the spreadsheet 
# Different from Export-Excel -ExcelPackage $excel -Calculate which requires to actually save the file
Close-ExcelPackage $excel -Calculate

"Stage 2"

# Test result spreadsheet - Read it 
$HeaderList = @('G1','I1','1','2','Amount','Sort_G1','Sort_I1','Sort_CL1','Sort_CL2','SQL1','SQL2','SQL3','SQL4','SQL5','SQL6','SQL7','SQL8','SQL9')
$HeaderList
$data = Import-Excel $Result -WorksheetName Data -HeaderName $HeaderList
$data

if ($Scope -ne "DataPointOnly") {
    # -------------------------------------------------------------------
    # Execute the SQL in each and every of the column 1 column at a time
    # In order to create the structure 
    # -------------------------------------------------------------------
    Execute-SQLColumn -data $data -SQLQuery "SQL1"
    Execute-SQLColumn -data $data -SQLQuery "SQL2"
    Execute-SQLColumn -data $data -SQLQuery "SQL3"
    Execute-SQLColumn -data $data -SQLQuery "SQL4"
    Execute-SQLColumn -data $data -SQLQuery "SQL5"
    Execute-SQLColumn -data $data -SQLQuery "SQL6"
    Execute-SQLColumn -data $data -SQLQuery "SQL7"
    Execute-SQLColumn -data $data -SQLQuery "SQL8"
}

"Stage 3 - No upload of values"

# Execute SQL for the actual DataPoint
if ($Scope -ne "StructureOnly") {
    Execute-SQLColumn -data $data -SQLQuery "SQL9"
}

# --------------------------------------------------------------------
# Process the $Script in order to eliminate duplicate lines 
# Lines where all prefixed by SQLx where x is the number of the steps
# if not sort+uniq was reshuffling the order of the steps
# --------------------------------------------------------------------
$TempFile2 = New-TemporaryFile 
cat $TempFile | sort | uniq > ($TempFile2)

# Post precessing the $Script file in order to transform "SQL..EXEC" into EXEC 
(Get-Content $TempFile2) -replace '^(SQL\d*EXEC )(.*)','EXEC $2' |  Out-File ($Script)

# Eliminate the Temporary files
rm $TempFile2
rm $TempFile

