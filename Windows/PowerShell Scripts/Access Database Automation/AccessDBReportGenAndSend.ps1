#==========================================================================================================================
# Title			AccessDBReportGenAndSend.ps1
# Author		Nathan J. Schuetz
# Description		To automatcly generate a PDF report from an access database so I don't need
#			to touch it for my own sanity.  Please note if you are running this with Windows Task Scheduler
#			you need to set the "Run only when user is logged on" otherwise it won't open the Access Database.
#
# Created		11/04/2024
# Modified		11/06/2024
# Status		Working
#===========================================================================================================================

# Declorations
#==============
$dbPath = "PathToDB.accdb"					# Path to the Access Database that I want the report generated from 
$reportName1 = "rptName1"					# Name of the first report in Access
$reportName2 = "rptName2"					# Name of the second report in Access
$reportDumpPath = "C:\Temp\ReportDump" 				# Can be ether a local or remote location
$reportArchivePath = "C:\Temp\ReportDump\Archive" 		# Can be ether a local or remote location
$dateString = (Get-Date -Format "yyyy-MM-dd") 			# Generate a date string in the format "yyyy-MM-dd"
$outputPath1 = "C:\Temp\ReportDump\rptName1_$dateString.pdf"  	# Full pathto save the report, including the date in the filename
$outputPath2 = "C:\Temp\ReportDump\rptName2_$dateString.pdf" 	# Full pathto save the report, including the date in the filename
$webhook = 'webhookaddress' 					# Webhook intergration for notifications if you want them.

# SMTP settings
$smtpServer = "smtpaddress"  					# Replace with your SMTP server
$smtpFrom = "eamil@someplace.com"				# Email address of the system
$smtpTo = "toemail@someplace.com"  				# You can add multiple recipients as a comma-separated string
$emailSubject = "Email Subject"					# Replace with your desired subject
$emailBody = "Body of the email"				# Replace with your desired message within the email


# Processing
#=============

# Clear the old files from the last run into the Arhive folder
Move-Item -Path $reportDumpPath\*.pdf -Destination $reportArchivePath

# Try to create the Access COM object, handling Office versions
try {
    $accessApp = New-Object -ComObject Access.Application
} catch {
    # Error catch #1 send a notification on falure if no Access installation is installed.
	$payload=@{"text" = "Error #1: Microsoft Access is not installed or could not be initialized for the Reports to Generate"}
	Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
    exit 1
}

# Check if the database exists
if (-Not (Test-Path -Path $dbPath)) {
    # Error catch #2 send a notification if the database path does not exist.
	$payload=@{"text" = "Error #2: The database path provided does not exist."}
	Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
    exit 1
}

try {
    # Open the Access database
    $accessApp.OpenCurrentDatabase($dbPath)

    # Export the first report to PDF on the network share
    if ($accessApp.CurrentProject.AllReports.Item($reportName1) -ne $null) {
        $accessApp.DoCmd.OutputTo(
            [Microsoft.Office.Interop.Access.AcOutputObjectType]::acOutputReport, 
            $reportName1, 
            "PDFFormat(*.pdf)", 
            $outputPath1, 
            $false
        )
        Write-Output "Success: First report exported to $outputPath1"
    } else {
        # Error catch #3 send a notification if the first report is not found.
		$payload=@{"text" = "Error #3: The report '$reportName1' does not exist in the database."}
		Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
    }

    # Export the second report to PDF on the network share
    if ($accessApp.CurrentProject.AllReports.Item($reportName2) -ne $null) {
        $accessApp.DoCmd.OutputTo(
            [Microsoft.Office.Interop.Access.AcOutputObjectType]::acOutputReport, 
            $reportName2, 
            "PDFFormat(*.pdf)", 
            $outputPath2, 
            $false
        )
        Write-Output "Success: Second report exported to $outputPath2"
    } else {
        # Error catch #4 send a notification if the second report is not found.
		$payload=@{"text" = "Error #4: The report '$reportName2' does not exist in the database."}
		Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
    }

} catch {
    Write-Output "An error occurred while processing the reports: $_"
} finally {
    # Close the Access application
    $accessApp.CloseCurrentDatabase()
    $accessApp.Quit()

    # Release COM object
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($accessApp) | Out-Null
}

# Cleanup COM object from memory
Remove-Variable -Name accessApp

# Email the reports
try {
    Send-MailMessage -From $smtpFrom -To $smtpTo -Subject $emailSubject -Body $emailBody -SmtpServer $smtpServer -Attachments $outputPath1, $outputPath2
    # Temp notification to make sure the email has sent properly
	$payload=@{"text" = "Script has successfully sent the email to the recipients."}
	Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
} catch {
    # Error catch #5 send a notification if the email failed to send.
	$payload=@{"text" = "Error #5: Failed to send email to $smtpTo"}
	Invoke-RestMethod -Uri $webhook -Method Post -Body (ConvertTo-Json -InputObject $payload)
}
