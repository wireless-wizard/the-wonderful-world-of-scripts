#==============================================================================
# Tytle			installApteanTCMClient.ps1
# Author		Nathan J. Schuetz
# Description	Insatll the Aptean TCM client version 10.2
#				Note that all items in [] should be replaced in there entirety
#
# Created		11/13/2024
# Modified		11/13/2024
# Status		Working
#===============================================================================

# Declorations
#==============
$ServerName = "[TCMServerName]" # Input your TCM Server Name Also, I assume your installation is hosted on the TCM Server.
# Define the Firewall Rule parameters
$ruleNameTCP = "TCP Query User{B54B968D-3418-442A-B9A3-F711BD08903A}C:\tcm\v102_tcm\cache\dotnet\client\workwise.tcm.client.common.workbench.exe"
$ruleNameUDP = "UDP Query User{8759C2DD-35E4-4CE2-8A09-CAB8F3DE7DF4}C:\tcm\v102_tcm\cache\dotnet\client\workwise.tcm.client.common.workbench.exe"
$ruleDisplayNameTCP = "WW-ERP Navigator TCP"
$ruleDisplayNameUDP = "WW-ERP Navigator UDP"
$ruleDescription = "WW-ERP Navigator"
$ruleAction = "Allow"
$ruleDirection = "Inbound"
$ruleProtocolTCP = "TCP"
$ruleProtocolUDP = "UDP"
$programPath = "C:\tcm\v102_tcm\cache\dotnet\client\workwise.tcm.client.common.workbench.exe"

# Determine if the OS is 32-bit or 64-bit For installing different parts of the applicaiton based on the CPU architecture
if ([Environment]::Is64BitOperatingSystem) {
    $architecture = "64-bit"
} else {
    $architecture = "32-bit"
}


Remove-PSDrive -Name "Z"

# Start Installation
#====================

# Step 1
# Install Microsoft .Net Framework 4.7
#======================================
# Mount a network drive
New-PSDrive -Name "Z" -PSProvider FileSystem -Root "[SharepathToEXEFolder]"
Start-Process -FilePath "Z:\ndp47-kb3186497-x86-x64-allos-enu.exe" -ArgumentList "/quiet /norestart" -Wait -NoNewWindow
Remove-PSDrive -Name "Z"


# Step 2
# Install Synergy/DE Synergex Per Aptean Guidlines
#==================================================
New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\$ServerName\products_v102\SynergyDE\"
Start-Process "Z:\101SDE1111e.exe" -ArgumentList "/qn ADDLOCAL=CC,WB,PS,CN,RW LICENSETYPE=Client SERVERNAME=$ServerName" -Wait -NoNewWindow 
Remove-PSDrive -Name "Z"


# Wait for 60 seconds for the install to finish
Start-Sleep 60


# Step 3
# Install Synergy
#=================
New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\$ServerName\products_v102\SynergyDE\"
if ($architecture = "64-bit") {
	# Install the 64 Bit version of Synergy
	Start-Process "Z:\104NN1111d.exe" -ArgumentList "/quiet /norestart" -Wait -NoNewWindow 
    Write-Host "64 Bit Installed"
	}
else {
	# Install the 32 Bit version of Synergy
	Start-Process "Z:\101NN1111d.exe" -ArgumentList "/quiet /norestart" -Wait -NoNewWindow 
    Write-Host "32 Bit Installed"
	}

Remove-PSDrive -Name "Z"


# Step 4
# Install TCM 10.2
#==================
Start-Process -FilePath msiexec.exe -ArgumentList "/i `"\\$ServerName\v102_tcm\install\win_client\WW-ERP_102_Client_Install.msi`" ALLUSERS=1 /qn /norestart /log output.log SERVER_NAME=$ServerName" -Wait -NoNewWindow


# Step 5
# Apply TCM License
#===================
Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "lmu -r $ServerName -nc -y" -NoNewWindow -Wait


# Step 6
# Remove TCM Command Link (Optional Step)
#=========================================
del "C:\Users\Public\Desktop\WW-ERP 10.2 Command.lnk"


# Step 7
# Add Firewall Rule TCP
#========================
# Check if the rule already exists
$existingRule = Get-NetFirewallRule -DisplayName $ruleDisplayNameTCP -ErrorAction SilentlyContinue

if ($existingRule -eq $null) {
    # Create a new firewall rule for the specified program
    New-NetFirewallRule -DisplayName $ruleDisplayNameTCP -Name $ruleNameTCP -Description $ruleDescription -Action $ruleAction -Direction $ruleDirection -Protocol $ruleProtocolTCP -Program $programPath -Profile Domain
    Write-Host "Inbound firewall rule for the program added successfully."
} else {
    Write-Host "The rule '$ruleDisplayName' already exists."
}


# Step 8
# Add Firewall Rule UDP
#==========================
# Check if the rule already exists
$existingRule = Get-NetFirewallRule -DisplayName $ruleDisplayNameUDP -ErrorAction SilentlyContinue

if ($existingRule -eq $null) {
    # Create a new firewall rule for the specified program
    New-NetFirewallRule -DisplayName $ruleDisplayNameUDP -Name $ruleName -Description $ruleDescription -Action $ruleAction -Direction $ruleDirection -Protocol $ruleProtocolUDP -Program $programPath -Profile Domain
    Write-Host "Inbound firewall rule for the program added successfully."
} else {
    Write-Host "The rule '$ruleDisplayName' already exists."
}

Write-Host "Task completed"