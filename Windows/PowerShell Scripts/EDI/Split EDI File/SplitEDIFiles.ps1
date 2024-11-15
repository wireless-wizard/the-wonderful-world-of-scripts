#===================================================================================================
# Tytle: 			SplitEDIFiles.ps1
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
$SourceDir = "[SorcePathOfTheFilesToSplit]"
$Destination = "[FilePathOfTheOutputFiles]"
$webhook = 'webhookaddress' 									# Webhook for the Slack Instance for notifications.
$allfiles = @() 												# Initialize an empty array to hold the files
$allfiles += Get-ChildItem -Path $SourceDir -Filter 860*.txt 	# Filter The files based on the file type
$allfiles += Get-ChildItem -Path $SourceDir -Filter 850*.txt 	# Filter The files based on the file type


# Processing
#============
cd $SourceDir



# Loop through each file
foreach ($file in $allfiles) {
	# Count the lines in the file
    $lineCount = (Get-Content $file).Count
	$payload=@{"text" = "$file contains $lineCount lines. File will be split into $lineCount files."}
	Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
	# Get the directory and file name of the input file
	
    $content = Get-Content -Path $file 		# Read all lines from the input file
	#$directory = Split-Path $file
	$baseFileName = [System.IO.Path]::GetFileNameWithoutExtension($file)
	$fileExtension = [System.IO.Path]::GetExtension($file)

    # Initialize a counter for new files
    $counter = 1

    # Loop through each line and create a new file for each
        foreach ($line in $content) {
            # Define the new file name by appending a number to the base file name
            $newFileName = "$Destination\$baseFileName$counter$fileExtension"
    
            # Write the line to the new file
            Set-Content -Path $newFileName -Value $line
    
            # Increment the counter
            $counter++
}

# Delete the old file
Remove-Item $file
}