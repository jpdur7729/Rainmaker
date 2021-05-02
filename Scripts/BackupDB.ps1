# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-03-02 14:58:27 jpdur"
# ------------------------------------------------------------------------------

param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition),
    [Parameter(Mandatory=$false)] [string] $Database = "DIA"
)

cd $Exec_Dir

# "List of Instances on the laptop"

# # List Instances on the laptop
# Find-DbaInstance -ComputerName localhost

" "
"List of databases on the default instance"

# List of databases on the instance
Get-DbaDatabase -SqlInstance localhost -ExcludeSystem | select-object -ExpandProperty Name

# Backup to the ad-hoc directory
Backup-DbaDatabase -SqlInstance localhost -Database ($Database) -Path $Exec_Dir
