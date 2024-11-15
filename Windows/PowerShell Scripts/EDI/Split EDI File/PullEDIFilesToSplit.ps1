#===================================================================================================
# Tytle: 			SplitEDIFiles860.ps1
# Author: 			Nathan J. Schuetz
#
# Description:		Split an EDI file with multiple lines into seperate files to work with an
#					SSIS package for automation.
#
# Date Created: 	11/14/2024
# Date Modified:	11/15/2024
# Status:			Working
#===================================================================================================

# Declorations
#==============
$SourceDir = "[SorcePathOfTheFilesToFindToSplit]"
$Destination = "[FilePathOfTheOutputFiles]"
$webhook = 'webhookaddress' 									# Webhook for the Slack Instance for notifications.
$allfiles = @() 												# Initialize an empty array to hold the files
$allfiles += Get-ChildItem -Path $SourceDir -Filter 860*.txt 	# Filter The files based on the file type
$allfiles += Get-ChildItem -Path $SourceDir -Filter 850*.txt 	# Filter The files based on the file type

# Processing
#============


# Loop through each file
foreach ($file in $allfiles) {
	# Check if the source file exists
	if (Test-Path $file) {
		# Count the lines in the file
		$lineCount = (Get-Content -Path $file).Count
    
		# If the file has more than one line, move it
		if ($lineCount -gt 1) {
			# Ensure the destination directory exists
			if (!(Test-Path $Destination)) {
				New-Item -ItemType Directory -Path $Destination
			}
        
			# Move the file
			Move-Item -Path $file -Destination $Destination
			Write-Output "File moved to $Destination because it has more than 1 line."
		}
		else {
			Write-Output "File has 1 line or less, so it was not moved."
		}
	}
	else {
		Write-Output "Source file does not exist."
	}
}