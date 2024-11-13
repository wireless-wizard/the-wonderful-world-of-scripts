#=============================================================================================================
# Tytle:			Remove Windows Apps.ps1
# Author:			Nathan J. Schuetz
#
# Description:		Remove some of the unessisary Windows application by the only way you can via PowerShell.
#					Use at your own risk.
#
# Reference: 		Get-AppxPackage | select Name, PackageFullName | Format-List 
#					To check the list of removable apps
#    
# Version 1.0
# Date Created:  	6/30/2023
# Date Modified: 	11/13/2024
# Status:   		Working
# Requires:   		None
#==============================================================================================================

# If you want to keep some of these apps just comment out the selection.
#News
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *bingweather* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage

#Microsoft Apps
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *onenote* | Remove-AppxPackage
Get-AppxPackage *MixedReality.Portal* | Remove-AppxPackage
Get-AppxPackage *YourPhone* | Remove-AppxPackage
Get-AppxPackage *skypeapp* | Remove-AppxPackage
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Get-AppxPackage *StorePurchaseApp* | Remove-AppxPackage
Get-AppxPackage *Wallet* | Remove-AppxPackage
Get-AppxPackage *windowsalarms* | Remove-AppxPackage
Get-AppxPackage *windowscamera* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
Get-AppxPackage *windowsmaps* | Remove-AppxPackage
Get-AppxPackage *windowsphone* | Remove-AppxPackage
Get-AppxPackage *windowsstore* | Remove-AppxPackage

#Microsoft Delvelopment
Get-AppxPackage *DevHome* | Remove-AppxPackage

#Microsoft Games
Get-AppxPackage *solitairecollection* | Remove-AppxPackage

#Zune Stuff
Get-AppxPackage *zunemusic* | Remove-AppxPackage
Get-AppxPackage *zunevideo* | Remove-AppxPackage

#Xboxapps
Get-AppxPackage *xboxapp* | Remove-AppxPackage
Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage *XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage *XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage *Xbox.TCUI* | Remove-AppxPackage

#Other Microsoft Stuff *Enterprise Only*
Get-AppxPackage *GetHelp* | Remove-AppxPackage
