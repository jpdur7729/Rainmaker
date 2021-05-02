# ------------------------------------------------------------------------------
#                     Author    : FIS - JPD
#                     Time-stamp: "2021-04-27 17:22:12 jpdur"
# ------------------------------------------------------------------------------

# Capture the actual directory where the script is found
param(
    [Parameter(Mandatory=$false)] [string] $Exec_Dir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
)

# Check if the directory has already been added into the path
$result = $env:Path | Select-String -Pattern $Exec_Dir -CaseSensitive -SimpleMatch

# If not let's add it to the path
if ($result.length -eq 0) {

    # What is the last char found
    $Lastchar = $env:Path[$env:Path.length -1]
    
    if ($Lastchar -eq ";") {
	# Just add the directory
	$env:Path += $Exec_Dir
    }
    else {
	# Add the directory with a separator 
	$env:Path += ";"+$Exec_Dir
    }
}

# Display the path so that it ca be checked
$env:path
