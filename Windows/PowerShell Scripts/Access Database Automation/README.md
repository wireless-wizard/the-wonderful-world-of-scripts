# Access Database Automation
This script was to create PDF reports in an automated way to save me time and the hassle of remembering to generate and send reports to executives.  A wise man once told me if you do a task more than 3 times automate it.


## Description
To automatcly generate a PDF report from an access database so I don't need to touch it for my own sanity.  Please note if you are running this with Windows Task Scheduler you need to set the "Run only when user is logged on" otherwise it won't open the Access Database.

## Declorations Used
These are the following declorations used and will need to be edited before this script will work.
|Name|Description|
|----|-----------|
|$dbPath|<p>Path to the Access Database that I want the report generated from</p>|
|$reportName1|<p>Name of the first report in Access</p>|
|$reportName2|<p>Name of the second report in Access</p>|
|$reportDumpPath|<p>Can be ether a local or remote location</p>|
|$reportArchivePath|<p>Can be ether a local or remote location</p>|
|$dateString|<p>Generate a date string in the format "yyyy-MM-dd"</p>|
|$outputPath1|<p>Full pathto save the report, including the date in the filename</p>|
|$outputPath2|<p>Full pathto save the report, including the date in the filename</p>|
|$webhook|<p>Webhook intergration for notifications if you want them</p>|
|$smtpServer|<p>Replace with your SMTP server</p>|
|$smtpFrom|<p>Email address of the system</p>|
|$smtpTo|<p>You can add multiple recipients as a comma-separated string</p>|
|$emailSubject|<p>Replace with your desired subject</p>|
|$emailBody|<p>Replace with your desired message within the email</p>|
|$payload|<p>Webhook text that is called out multiple times and will need to be edited for each responce</p>|
