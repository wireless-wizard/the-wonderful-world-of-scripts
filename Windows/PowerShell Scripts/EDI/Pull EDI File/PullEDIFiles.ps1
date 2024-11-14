#===================================================================================================
# Tytle: 			PullEDIFiles.ps1
# Author: 			Nathan J. Schuetz
#
# Description:		Move any files into a temporary holding location to manually edit the file later
#					Should there be an automated script for making these changes yes, I do agree. So
#					far I haven't figgred it out yet.
#
# Date Created: 	9/30/2024
# Date Modified:	11/11/2024
# Status:			Working
#===================================================================================================

# Declorations
#====================
# Define the source directory and destination directory
$SourceDir = "[FilePathOfSorceEDIFiles]"
$Destination = "[FilePathOfDumpLocationForHolding]"
$webhook = 'webhookaddress' # Webhook for the Slack Instance for notifications.

# Initialize an empty array to hold the files
$allfiles = @()

# Find files matching both 856*.edi and 810*.edi patterns in the source directory
$allfiles += Get-ChildItem -Path $SourceDir -Filter 856*.edi
$allfiles += Get-ChildItem -Path $SourceDir -Filter 810*.edi

# Loop through each file
foreach ($file in $allfiles) {
   # Join the content into a single string for comparison
   $content = (Get-Content $file.FullName) -join "`n"
   
   # Check for both specific patterns and move the file to the destination if either is found
   if ($content -like "*[phrase to search for the 856]*" -or $content -like "*[phrase to search for the 810]*") {
       Move-Item -Path $file.FullName -Destination $Destination
	   $payload=@{"text" = "Pulled $allfiles out of the ED directory and into holding location."}
		Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
   }
}