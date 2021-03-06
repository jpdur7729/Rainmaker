# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-03-05 14:50:12 jpdur"
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
#     [Parameter(Mandatory=$false)] [string] $Source = "6_Output_1_FIS_TestCo_2020_10_PL_AC_20210108 2203.xlsx",
    [Parameter(Mandatory=$false)] [string] $Source = "6_Output_1_FIS-SortOrder_TestCo_2020_10_PL_AC_20210108 2203.xlsx",
#    [Parameter(Mandatory=$false)] [string] $Result = "Results.xlsx",
    [Parameter(Mandatory=$false)] [string] $Result = "Onboarding.xlsx",
    [Parameter(Mandatory=$false)] [string] $DatabaseInstance = "localhost",
    [Parameter(Mandatory=$false)] [string] $Database = "DIA2",
    [Parameter(Mandatory=$false)] [ValidateSet("runSQL","GenerateSQLScript")] [string] $Action = "runSQL",
    [Parameter(Mandatory=$false)] [ValidateSet("StructureOnly")] [string] $Scope = "StructureOnly",
    [Parameter(Mandatory=$false)] [string] $Script = "Onboarding.sql"
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
	$_."$SQLQuery"
	if ($_."$SQLQuery".length -ne 0) {
	    if ($Action -eq "runSQL") {
		$data_query1 = Invoke-DbaQuery -SqlInstance $DatabaseInstance -Database $Database -Query $_."$SQLQuery"
	    }
	    $SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
	}
	# Display results if required 
	# $data_query1.ID
    }

}

# Use only # as separators
$str = $FileName.replace('-','#').replace('_','#').replace(' ','#')
$str

# Pattern to read the file name
$firstLastPattern = "^(?<BatchNumber>\w+)#(?<Output>\w+)#(?<Number1>\w+)#(?<FIS>\w+)#(?<SortOrder>\w+)#(?<Company>\w+)#(?<Year>\w+)#(?<Month>\w+)#(?<Hierarchy>\w+)#(?<Scenario>\w+)#(?<CreationDate>\w+)#(?<UnknownNumber>\w+).(?<extension>\w+)"

$str |
  Select-String -Pattern $firstLastPattern |
  Foreach-Object {
      # here we access the groups by name instead of by index
      $BatchNumber, $Output, $Number1, $FIS, $SortOrder, $Company, $Year, $Month, $Hierarchy, $Scenario, $CreationDate, $UnknownNumber, $extension = $_.Matches[0].Groups['BatchNumber', 'Output', 'Number1', 'FIS', 'SortOrder', 'Company', 'Year', 'Month', 'Hierarchy', 'Scenario', 'CreationDate', 'UnknownNumber', 'extension'].Value
      [PSCustomObject] @{
          Hierarchy = $Hierarchy
          Company  = $Company
	  # Number1 = $Number1
	  FIS = $FIS
	  SortOrder = $SortOrder
          Scenario = $Scenario
	  Year = $Year
	  Month = $Month
          Extension = $extension
      }
  }

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
    # 'PL' {$Hierarchy = "Income Statement"}
    'PL' {$Hierarchy = "Profit Loss"}
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

# Levels before Company Level
# ="EXEC PS_STG_CREATE_NODE  '"&A2&"','"&Params!$A$1&"',"&E2
Set-ExcelColumn -Worksheet $ws -Heading "SQL1" -Column 10 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODE '""&A$row&""' , '""&Params!`$A`$1&""' , ""&E$row&""      """) }
# "EXEC PS_STG_LINK_GENERIC '"&Params!$A$1&"','"&A2&"','"&Params!$A$1&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL2" -Column 11 -AutoSize -Value {("=""EXEC PS_STG_LINK_GENERIC '""&Params!`$A`$1&""' , '""&A$row&""' , '""&Params!`$A`$1&""'   """) }
# ="EXEC PS_STG_CREATE_NODEINDUSTRY '"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&A2&"' ," &F2
Set-ExcelColumn -Worksheet $ws -Heading "SQL3" -Column 12 -AutoSize -Value {("=IF(LEN(B$row)=0,"""",""EXEC PS_STG_CREATE_NODEINDUSTRY '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&A$row&""' , ""&F$row&""  "")") }
# ="EXEC PS_STG_LINK_GENERIC_INDUSTRY '"&A2&"','"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL4" -Column 13 -AutoSize -Value {("=IF(LEN(B$row)=0,"""",""EXEC PS_STG_LINK_GENERIC_INDUSTRY '""&A$row&""' , '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' "")") }

# Levels starting at Company Level
# ="EXEC PS_STG_CREATE_NODECOMPANY '"&C2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&B2&"',"&H2&","&C$1
Set-ExcelColumn -Worksheet $ws -Heading "SQL5" -Column 14 -AutoSize -Value {("=IF(LEN(C$row)=0,"""",""EXEC PS_STG_CREATE_NODECOMPANY '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' , '""&G$row&""' , '""&C`$1&""' "")") }
# Set-ExcelColumn -Worksheet $ws -Heading "SQL5" -Column 14 -AutoSize -Value {("=""EXEC PS_STG_CREATE_NODECOMPANY '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' , '""&G$row&""' , '""&C`$1&""' """) }
# =IF(LEN(D2)=0,"","EXEC PS_STG_CREATE_NODECOMPANY '"&D2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&C2&"',"&I2&","&D$1)
Set-ExcelColumn -Worksheet $ws -Heading "SQL6" -Column 15 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC PS_STG_CREATE_NODECOMPANY '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&C$row&""' , '""&H$row&""' , '""&D`$1&""' "")") }
# # ="EXEC PS_STG_LINK_INDUSTRY_COMPANY_OLD '"&B2&"','"&C2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("=""EXEC PS_STG_LINK_INDUSTRY_COMPANY_OLD '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' """) }
# ="EXEC PS_STG_LINK_INDUSTRY_COMPANY '"&B2&"','"&C2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&C2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("=IF(LEN(C$row)=0,"""",""EXEC PS_STG_LINK_INDUSTRY_COMPANY '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&A$row&""' "")") }
# ="EXEC PS_STG_LINK_COMPANY_COMPANY '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&B2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL8" -Column 17 -AutoSize -Value {("=IF(LEN(D$row)=0,"""",""EXEC PS_STG_LINK_COMPANY_COMPANY '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' "")") }

# No need to show // Close Package calculate and closes the spreadsheet 
# Different from Export-Excel -ExcelPackage $excel -Calculate which requires to actually save the file
Close-ExcelPackage $excel -Calculate

"Stage 2"

# Test result spreadsheet - Read it 
$HeaderList = @('G1','I1','1','2','Amount','Sort_G1','Sort_I1','Sort_CL1','Sort_CL2','SQL1','SQL2','SQL3','SQL4','SQL5','SQL6','SQL7','SQL8')
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

# # ------------------------------------------------------------------------------
# #                     Author    : FIS - JPD
# #                     Time-stamp: "2021-03-05 14:21:21 jpdur"
# # ------------------------------------------------------------------------------

# # --------------------------------------------------------------------------
# # Utility function to execute all SQL statements from a column
# # Actually from the set of objects data corresponding to the field SQLQuery
# # --------------------------------------------------------------------------
# function Execute-SQLColumn($data,$SQLQuery){

#     # Loop for all elements of the column whose header has been provided
#     # select -skip 1 is to just skip the 1st element which is the header 
#     $data | select -skip 1 | ForEach-Object {
# 	$_."$SQLQuery"
# 	if ($_."$SQLQuery".length -ne 0) {
# 	    $data_query1 = Invoke-DbaQuery -SqlInstance localhost -Database TEST -Query $_."$SQLQuery"
# 	}
# 	# Display results if required 
# 	# $data_query1.ID
#     }

# }


# # Name structure Example
# $FileName = "6_Output_1_FIS-SortOrder_TestCo_2020_10_PL_AC_20210108 2203.xlsx"
# $NewFileName = "Onboarding.xlsx"

# # Use only # as separators
# $str = $FileName.replace('-','#').replace('_','#').replace(' ','#')
# $str

# # Pattern to read the file name
# $firstLastPattern = "^(?<BatchNumber>\w+)#(?<Output>\w+)#(?<Number1>\w+)#(?<FIS>\w+)#(?<SortOrder>\w+)#(?<Company>\w+)#(?<Year>\w+)#(?<Month>\w+)#(?<Hierarchy>\w+)#(?<Scenario>\w+)#(?<CreationDate>\w+)#(?<UnknownNumber>\w+).(?<extension>\w+)"

# $str |
#   Select-String -Pattern $firstLastPattern |
#   Foreach-Object {
#       # here we access the groups by name instead of by index
#       $BatchNumber, $Output, $Number1, $FIS, $SortOrder, $Company, $Year, $Month, $Hierarchy, $Scenario, $CreationDate, $UnknownNumber, $extension = $_.Matches[0].Groups['BatchNumber', 'Output', 'Number1', 'FIS', 'SortOrder', 'Company', 'Year', 'Month', 'Hierarchy', 'Scenario', 'CreationDate', 'UnknownNumber', 'extension'].Value
#       [PSCustomObject] @{
#           Hierarchy = $Hierarchy
#           Company  = $Company
# 	  # Number1 = $Number1
# 	  FIS = $FIS
# 	  SortOrder = $SortOrder
#           Scenario = $Scenario
# 	  Year = $Year
# 	  Month = $Month
#           Extension = $extension
#       }
#   }

# # ----------------------------------------------------------------------
# # Normalise the values in the fields in order to get the standard values 
# # ----------------------------------------------------------------------

# # Extract the Industry for the given company 
# $query1 = "select Name from IndustryList where ID in (select IndustryID from CompanyList where Name = '"+$Company+"')"
# $data_query1 = Invoke-DbaQuery -SqlInstance localhost -Database TEST -Query $query1

# # Error message or confirmation if needed
# if ($data_query1 -eq $null) {
#     "Company:" + $Company +" is not known"
# }
# else {
#     "Company " + $Company +" belongs to the industry " + $data_query1.Name
# }

# # Keep the industry
# $Industry = $data_query1.Name

# # Normalise the Hierarchy
# switch($Hierarchy)
# {
#     # 'PL' {$Hierarchy = "Income Statement"}
#     'PL' {$Hierarchy = "Profit Loss"}
#     'BS' {$Hierarchy = "Balance Sheet"}
# }
# $Hierarchy

# # Normalise the Scenario
# switch($Scenario)
# {
#     'AC' {$Scenario = "Actual"}
#     'BD' {$Scenario = "Budget"}
# }
# $Scenario

# # Process the Month and Year and convert them to integer
# $Month = [int]$Month
# $Year  = [int]$Year

# # Determine last day of the month by going to the 1 day of following month 
# if ($Month -eq 12) {
#     $Month = 1
#     $Year++}
# else{
#     $Month++
# }
# $MonthStr = "{0:00}" -f $Month
# $DateString = "$Year-$MonthStr-01"

# # Change the string to date in order to be able to later choose the right format
# $DateasDate = [datetime]::ParseExact($DateString,"yyyy-MM-dd", $null)
# $DateasDate = $DateasDate.addDays(-1)

# # Delete the NewFile if it exists
# rm $NewFileName -ErrorAction SilentlyContinue

# # Prepare the output 
# $HeaderList = @('Category','Subcategory1','1','2','SO1','SO2','SO3','SO4')

# # Read the initial spreadsheet 
# # StartRow = 1 is the 1st line //// StartRow 2 to eliminate the header and replace it
# $data = Import-Excel -Path ("./"+$FileName) -StartCol 2 -StartRow 2 -HeaderName $HeaderList 

# # Add the params Tab 
# @($Hierarchy,$Industry,$Company,$Scenario,$DateasDate.tostring("dd-MMM-yy"))  | Export-Excel -AutoSize -WorksheetName Params $NewFileName

# # Create the new spreadsheet 
# $excel = $data | Export-Excel -AutoSize -AutoFilter -WorksheetName Data $NewFileName -PassThru
# # Get a pointer to the Data Sheet 
# $ws = $excel.Workbook.Worksheets['Data']

# # Levels before Company Level
# # ="EXEC CREATE_NODE  '"&A2&"','"&Params!$A$1&"',"&E2
# Set-ExcelColumn -Worksheet $ws -Heading "SQL1" -Column 10 -AutoSize -Value {("=""EXEC CREATE_NODE '""&A$row&""' , '""&Params!`$A`$1&""' , ""&E$row&""      """) }
# # "EXEC LINK_GENERIC '"&Params!$A$1&"','"&A2&"','"&Params!$A$1&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL2" -Column 11 -AutoSize -Value {("=""EXEC LINK_GENERIC '""&Params!`$A`$1&""' , '""&A$row&""' , '""&Params!`$A`$1&""'   """) }
# # ="EXEC CREATE_NODEINDUSTRY '"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&A2&"' ," &F2
# Set-ExcelColumn -Worksheet $ws -Heading "SQL3" -Column 12 -AutoSize -Value {("=IF(LEN(B$row)=0,"""",""EXEC CREATE_NODEINDUSTRY '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&A$row&""' , ""&F$row&""  "")") }
# # ="EXEC LINK_GENERIC_INDUSTRY '"&A2&"','"&B2&"','"&Params!$A$1&"','"&Params!$A$2&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL4" -Column 13 -AutoSize -Value {("=IF(LEN(B$row)=0,"""",""EXEC LINK_GENERIC_INDUSTRY '""&A$row&""' , '""&B$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' "")") }

# # Levels starting at Company Level
# # ="EXEC CREATE_NODECOMPANY '"&C2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&B2&"',"&H2&","&C$1
# Set-ExcelColumn -Worksheet $ws -Heading "SQL5" -Column 14 -AutoSize -Value {("=IF(LEN(C$row)=0,"""",""EXEC CREATE_NODECOMPANY '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' , '""&G$row&""' , '""&C`$1&""' "")") }
# # Set-ExcelColumn -Worksheet $ws -Heading "SQL5" -Column 14 -AutoSize -Value {("=""EXEC CREATE_NODECOMPANY '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' , '""&G$row&""' , '""&C`$1&""' """) }
# # =IF(LEN(D2)=0,"","EXEC CREATE_NODECOMPANY '"&D2&"','"&Params!$A$1&"','"&Params!$A$2&"','"&Params!$A$3&"','"&C2&"',"&I2&","&D$1)
# Set-ExcelColumn -Worksheet $ws -Heading "SQL6" -Column 15 -AutoSize -Value {("= IF(LEN(D$row)=0,"""",""EXEC CREATE_NODECOMPANY '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&C$row&""' , '""&H$row&""' , '""&D`$1&""' "")") }
# # # ="EXEC LINK_INDUSTRY_COMPANY_OLD '"&B2&"','"&C2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"'"
# # Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("=""EXEC LINK_INDUSTRY_COMPANY_OLD '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' """) }
# # ="EXEC LINK_INDUSTRY_COMPANY '"&B2&"','"&C2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&C2&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("=IF(LEN(C$row)=0,"""",""EXEC LINK_INDUSTRY_COMPANY '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&A$row&""' "")") }
# # ="EXEC LINK_COMPANY_COMPANY '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&B2&"'"
# Set-ExcelColumn -Worksheet $ws -Heading "SQL8" -Column 17 -AutoSize -Value {("=IF(LEN(D$row)=0,"""",""EXEC LINK_COMPANY_COMPANY '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' "")") }

# # No need to show // Close Package calculate and closes the spreadsheet 
# # Different from Export-Excel -ExcelPackage $excel -Calculate which requires to actually save the file
# Close-ExcelPackage $excel -Calculate

# # Test result spreadsheet - Read it 
# $HeaderList = @('G1','I1','1','2','Amount','Sort_G1','Sort_I1','Sort_CL1','Sort_CL2','SQL1','SQL2','SQL3','SQL4','SQL5','SQL6','SQL7','SQL8')
# $HeaderList
# $data = Import-Excel $NewFileName -WorksheetName Data -HeaderName $HeaderList
# $data

# # Execute the SQL in each and every of the column 1 column at a time
# # -------------------------------------------------------------------
# Execute-SQLColumn -data $data -SQLQuery "SQL1"
# Execute-SQLColumn -data $data -SQLQuery "SQL2"
# Execute-SQLColumn -data $data -SQLQuery "SQL3"
# Execute-SQLColumn -data $data -SQLQuery "SQL4"
# Execute-SQLColumn -data $data -SQLQuery "SQL5"
# Execute-SQLColumn -data $data -SQLQuery "SQL6"
# Execute-SQLColumn -data $data -SQLQuery "SQL7"
# Execute-SQLColumn -data $data -SQLQuery "SQL8"


