# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-06-10 07:08:55 jpdur"
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# The aim is to verify the number of items provided in the template spreadsheet 
# in order to have a quick understanding of the evolution of the complexity 
# of the structure 
# ------------------------------------------------------------------------------
# Always as primary step to visually check the data consistency
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Company = "004",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("PL","BS","CF")] [string] $Hierarchy = "PL",
    [Parameter(Mandatory=$false)] [string] [ValidateSet("AC","BD")]      [string] $Scenario = "AC",
    [Parameter(Mandatory=$false)] [string] $Prefix #Quick Fix for company name such as 004 - not to be used/knowm
)

# Create the table of all the different table and nb of lines
$ListSourceItem = @()

# --------------------------------------------------------------------------- 
# In the current directory - Review all the different spreadsheets provided 
# Excluding those who may have been created as part of previous processes
# --------------------------------------------------------------------------- 
# $Pattern = "*_*.xlsx"
# # -Exclude "DIA*.xlsx"
# Get-ChildItem -Filter $Pattern |
  #   Foreach-Object {

# Pattern to extract all data / Old Naming convention
$Pattern = "*_"+$Company+"_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# # New Naming convention - 2021-06-09
# $Pattern = "*_"+$Company+"_*_"+$Hierarchy+"_"+$Scenario+"_*.xlsx"

# --------------------------------------------------------------------------------
# Process all files corresponding to the given pattern in the current directory
# filter out the DIA_*.xlsx files or more generally DIX_* 
# which may or may not have been created and may exist in the directory
# --------------------------------------------------------------------------------
Get-ChildItem -Filter $Pattern | Where-Object {$_.name -NotLike "DI*.*"} |
  Foreach-Object {

      # Open the speadsheet accordingly and count the lines describing the structure
      $HeaderList = @('G1','I1','1','2','Amount')
      $data = Import-Excel -Path ("./"+$_.Name) -StartRow 2 -HeaderName $HeaderList 

      # Prepare the data to be managed 
      $StructureData= @{Name    = $_.Name
			NbItems = $data.length }

      # For Each 
      $ListSourceItem += New-Object psobject -Property $StructureData

  }

# Present the data in a format table 
$ListSourceItem | Format-Table
