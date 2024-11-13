@echo off
:: ============================================================================================================
:: Tytle			Multitool.bat
:: Author			Nathan J. Scheutz
:: Description		To create a tool for lanching multiple programs from the commandline
:: Resources		https://patorjk.com/software/taag/#p=display&f=3D-ASCII&t=Multi%20Tool
::
:: Created			11/11/2024
:: Modified			11/13/2024
:: Status			In development
:: ============================================================================================================


:: Declorations:
::====================================================
title MultiTool - By Nathan Schuetz
:: set the code page to 65001 for the banner to work
chcp 65001 >null
:: Set the VNC Ultra password for easy access
set VNCpass=HopefullySomeSecurePasswordYouSetForVNCAccess
:: Set the location for the Portable Apps
cd C:\Portable Apps


:: start the main menu
::========================
:start
cls
call :banner

:main_menu
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) Network Scanning[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) File Analsys Tools[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) Remote Connections[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠════(4) Security Management[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╚╦════(5) Custom Scripts[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╚══════^>[0m  
if /I %input% EQU 1 call :network_scanning
if /I %input% EQU 2 call :file_analsys
if /I %input% EQU 3 call :remote_connections
if /I %input% EQU 4 call :security_management
if /I %input% EQU 5 call :custom_scripts
if /I %input% EQU "exit" call :quit
cls
goto start

:network_scanning
cls
call :banner
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) NMAP Gui[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) Netscan[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) LanTopoLog[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╚╦═══(4) Main Menu[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╚══════^>[0m  
if /I %input% EQU 1 "Nmap - Zenmap GUI.lnk" 
if /I %input% EQU 2 start netscan.exe
if /I %input% EQU 3 start "\lantopolog250\lantopolog.exe"
if /I %input% EQU 4 call :start
cls
goto :network_scanning


:file_analsys
cls
call :banner
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) Agent Ransack[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) Hex Viewer[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) Notepad ++[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╚╦═══(4) Main Menu[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╚══════^>[0m  
if /I %input% EQU 1 "Agent Ransack.lnk" 
if /I %input% EQU 2 "Hex Viewer - XVI32.exe"
if /I %input% EQU 3 start "notepad++.exe"
if /I %input% EQU 4 call :start
cls
goto :file_analsys

:remote_connections
cls
call :banner
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) Remote Desktop[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) VNC[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) Putty[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╚╦═══(4) Main Menu[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╠══════^>[0m  
if /I %input% EQU 1 call :rdp_connection 
if /I %input% EQU 2 call :vnc_connection
if /I %input% EQU 3 start "putty.exe"
if /I %input% EQU 4 call :start
cls
goto :remote_connections

:vnc_connection
echo [38;2;255;255;0m         ║[0m  
set /p VNCAsset=.%BS% [38;2;255;255;0m        ╚══════^> Enter VNC Asset: [0m  
"C:\Program Files\uvnc bvba\UltraVNC\vncviewer.exe" -connect  %VNCAsset%.stamp.com:5900 -password %VNCpass% -autoscaling
goto :remote_connections

:rdp_connection
echo [38;2;255;255;0m         ║[0m  
set /p RDPAsset=.%BS% [38;2;255;255;0m        ╚══════^>Enter RDP Asset: [0m  
start mstsc /v: %RDPAsset%
goto :remote_connections

:custom_scripts
cls
call :banner
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) Unpopulated[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) Unpopulated[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) Unpopulated[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╚╦═══(4) Main Menu[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╚══════^>[0m  
if /I %input% EQU 1 goto :custom_scripts 
if /I %input% EQU 2 goto :custom_scripts
if /I %input% EQU 3 goto :custom_scripts
if /I %input% EQU 4 call :start
cls
goto :custom_scripts

:security_management
cls
call :banner
for /f %%A in ('"prompt $H &echo on &for %%B in (1) do rem"') do set BS=%%A
echo.
echo.
echo [38;2;255;255;0m        ╔═(1) Quick Scan via Windows Defender[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠══(2) Full Scan via Windows Defender[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╠═══(3) Unpopulated[0m  
echo [38;2;255;255;0m        ║[0m  
echo [38;2;255;255;0m        ╚╦═══(4) Main Menu[0m  
echo [38;2;255;255;0m         ║[0m  
set /p input=.%BS% [38;2;255;255;0m        ╠══════^>[0m  
if /I %input% EQU 1 call :quick_scan 
if /I %input% EQU 2 call :full_scan
if /I %input% EQU 3 goto :security_management
if /I %input% EQU 4 call :start
cls
goto :security_management

:quick_scan
echo [38;2;255;255;0m         ║[0m  
set /p Asset=.%BS% [38;2;255;255;0m        ╚══════^>Enter the Asset to scan: [0m  
wmic /node: %Asset%.stamp.com process call create "C:\Program Files\Microsoft Security Client\MpCmdRun.exe -Scan -ScanType 1"
echo "Scan started on %Asset%"
pause
goto :security_management

:full_scan
echo [38;2;255;255;0m         ║[0m  
set /p Asset=.%BS% [38;2;255;255;0m        ╚══════^>Enter the Asset to scan: [0m  
wmic /node: %Asset%.stamp.com process call create "C:\Program Files\Microsoft Security Client\MpCmdRun.exe -Scan -ScanType 2"
echo "Scan started on %Asset%"
pause
goto :security_management

:banner
echo.
echo.
echo		███╗   ███╗██╗   ██╗██╗  ████████╗██╗    ████████╗ ██████╗  ██████╗ ██╗     
echo		████╗ ████║██║   ██║██║  ╚══██╔══╝██║    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo		██╔████╔██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║     
echo		██║╚██╔╝██║██║   ██║██║     ██║   ██║       ██║   ██║   ██║██║   ██║██║     
echo		██║ ╚═╝ ██║╚██████╔╝███████╗██║   ██║       ██║   ╚██████╔╝╚██████╔╝███████╗
echo		╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝   ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
echo.
echo.