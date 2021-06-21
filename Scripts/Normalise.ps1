# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-20 11:47:40 jpdur"
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
    [Parameter(Mandatory=$false)] [switch] $Keep,
    [Parameter(Mandatory=$false)] [ValidateSet("runSQL","GenerateSQLScript")] [string] $Action = "GenerateSQLScript",
    [Parameter(Mandatory=$false)] [ValidateSet("StructureOnly","DataPointOnly","All")] [string] $Scope = "StructureOnly",
    [Parameter(Mandatory=$false)] [ValidateSet("Top","Industry","Company")] [string] $HierarchyLevel = "Company",
    [Parameter(Mandatory=$false)] [string] $UploadScript = "UploadDataResults.sql",
    [Parameter(Mandatory=$false)] [string] $LogFile,
    [Parameter(Mandatory=$false)] [string] $Script = "Results.sql",
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
	    # Only generates the top level request
	    If ( ($HierarchyLevel -eq "Top") -and ($SQLQuery -eq "SQL1") ) {
		$SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
		if ($Action -eq "runSQL") {
		    $data_query1 = Invoke-DbaQueryLog -SqlInstance $DatabaseInstance -Database $Database -Query $_."$SQLQuery" -Log $LogFile
		}
	    }
	    If ( ($HierarchyLevel -eq "Industry") -and
		 (($SQLQuery -eq "SQL1") -or ($SQLQuery -eq "SQL2") -or ($SQLQuery -eq "SQL3") -or ($SQLQuery -eq "SQL4"))) {
		     $SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
		     if ($Action -eq "runSQL") {
			 $data_query1 = Invoke-DbaQueryLog -SqlInstance $DatabaseInstance -Database $Database -Query $_."$SQLQuery" -Log $LogFile
		     }
		 }
	    if ($HierarchyLevel -eq "Company") {
		# We genertae by default for all Levels
		$SQLQuery + $_."$SQLQuery" | Out-File -Encoding ASCII -Append $TempFile
		if ($Action -eq "runSQL") {
		    $data_query1 = Invoke-DbaQueryLog -SqlInstance $DatabaseInstance -Database $Database -Query $_."$SQLQuery" -Log $LogFile
		}
	    }
	}
	# Display results if required 
	# $data_query1.ID
    }

}

# Extract the characteristics based on the File Name 
$Data = ExtractCharacteristics -FileName $Source

# -------------------------------------------------------------------------------------
# If the company starts could be understood as a number 004 the user may add a Prefix 
# quick fix to the 004 situation on 2021-03-21 
# -------------------------------------------------------------------------------------
$Company = $Prefix + $Data.Company
$Year = $Data.Year
$Month = $Data.Month
$Hierarchy = $Data.Hierarchy
$Scenario = $Data.Scenario

"Source File             :" + $Source
"Extracted Data - Company:" + $Company

# Access the module to extract the Corresponding Industry 
$Industry = GetIndustry -Company $Company -DatabaseInstance $DatabaseInstance -Database $Database

# Standardise the Hierarchy based on the Code Received 
$Hierarchy = DecodeHierarchyCode -HierarchyCode $Hierarchy

# Standardise the Scenario based on the Code Received 
$Scenario = DecodeScenarioCode -ScenarioCode $Scenario

# Date - as a Date - which is the last day of the corresponding month 
$DateasDate = LastDayofMonth -Year $Year -Month $Month


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

# "-----------------------------------------------------------------------------"
# "Stage 2 - Check if no data in company level then change the level to Industry"
# "-----------------------------------------------------------------------------"
# $NoCompanyData = $true

# # Test for all line if .1 and .2 are actually empty
# for( $i=0 ; $i -lt $data.length ; $i++ ) {
#     $NoCompanyData = $NoCompanyData -and ($data[$i]."1".length -eq 0) -and ($data[$i]."2".length -eq 0)
# }

# if (($HierarchyLevel -eq "Company") -and ($NoCompanyData)) {
#     $HierarchyLevel = "Industry"
# }

# # Debug // Check that the data level has been changed 
# $HierarchyLevel

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
Set-ExcelColumn -Worksheet $ws -Heading "SQL7" -Column 16 -AutoSize -Value {("= ""EXEC PS_STG_LINK_INDUSTRY_COMPANY '""&B$row&""' , '""&C$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&A$row&""' """) }
# ="EXEC PS_STG_LINK_COMPANY_COMPANY '"&C2&"','"&D2&"','"&Params!$A$1&"','"& Params!$A$2&"','"& Params!$A$3&"','"&B2&"'"
Set-ExcelColumn -Worksheet $ws -Heading "SQL8" -Column 17 -AutoSize -Value {("= IF(LEN(C$row)=0,"""",""EXEC PS_STG_LINK_COMPANY_COMPANY '""&C$row&""' , '""&D$row&""' , '""&Params!`$A`$1&""' , '""&Params!`$A`$2&""' , '""&Params!`$A`$3&""' , '""&B$row&""' "")") }

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

"Stage 3 - upload of values depending of $Scope"

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

# Generate the UploadScript to prepare the upload
# EXEC PS_Populate_CompanyStructure 'Income Statement','Utilities (221)','F0004'
$UploadScriptCmd = "EXEC PS_Populate_CompanyStructure '" + $Hierarchy + "' ,'" + $Industry + "','" + $Company + "'"
$UploadScriptCmd > ($UploadScript)
	  
# That way the module is only used as part of the script and no afterwards
if (!($Keep)) {
    Remove-Module RainmakerLib
}
