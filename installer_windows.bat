:: GoAnimate Kids Installer
:: Author: octanuary#6553 & sparrkz#0001
:: License: MIT
title GoAnimate Kids Installer [Initializing...]

::::::::::::::::::::
:: Initialization ::
::::::::::::::::::::

@echo off && cls
SETLOCAL ENABLEDELAYEDEXPANSION

:: Check for admin privileges
fsutil dirty query !systemdrive! >NUL 2>&1
if /i not !ERRORLEVEL!==0 (
	echo You need to run this file with admin privileges.
	echo Right click on this file, and click "Run as Administrator".
	echo If you don't have this option, your current user account does not have admin privileges.
	pause
	exit
)

:: Start in correct folder
pushd "%~dp0"
pushd "%~dp0"

::::::::::::::::::::::
:: Dependency Check ::
::::::::::::::::::::::

title GoAnimate Kids Installer [Checking for dependencies...]
echo Checking for dependencies...
echo:

set DEPENDENCIES_NEEDED=n
set GIT_DETECTED=n
set NODE_DETECTED=n
set HTTPSERVER_DETECTED=n
set FLASH_DETECTED=n

:: Git check
echo Checking for Git installation...
for /f "delims=" %%i in ('git --version 2^>nul') do set goutput=%%i
if "!goutput!"=="" (
	echo Git could not be found.
	set DEPENDENCIES_NEEDED=y
) else (
	echo Git is installed.
	echo:
	set GIT_DETECTED=y
)

:: Node.JS check
echo Checking for Node.JS installation...
for /f "delims=" %%i in ('node -v 2^>nul') do set noutput=%%i
if "!noutput!"=="" (
	echo Node.JS could not be found.
	set DEPENDENCIES_NEEDED=y
) else (
	echo Node.JS is installed.
	echo:
	set NODE_DETECTED=y
)

:: Flash check
echo Checking for Flash installation...
if exist "!windir!\SysWOW64\FlashPlayerApp.exe" set FLASH_DETECTED=y
if exist "!windir!\System32\FlashPlayerApp.exe" set FLASH_DETECTED=y
if !FLASH_DETECTED!==n (
	echo Flash could not be found.
	echo:
	set DEPENDENCIES_NEEDED=y
) else (
	echo Flash is installed.
	echo:
)

::::::::::::::::::::::::
:: Dependency Install ::
::::::::::::::::::::::::

if !DEPENDENCIES_NEEDED!==y (
	title GoAnimate Kids Installer [Installing Dependencies...]
	echo:
	echo Installing dependencies...
	echo:

	set INSTALL_FLAGS=ALLUSERS=1 /norestart
	set SAFE_MODE=n
	if /i "!SAFEBOOT_OPTION!"=="MINIMAL" set SAFE_MODE=y
	if /i "!SAFEBOOT_OPTION!"=="NETWORK" set SAFE_MODE=y
	set CPU_ARCHITECTURE=what
	if /i "!processor_architecture!"=="x86" set CPU_ARCHITECTURE=32
	if /i "!processor_architecture!"=="AMD64" set CPU_ARCHITECTURE=64
	if /i "!PROCESSOR_ARCHITEW6432!"=="AMD64" set CPU_ARCHITECTURE=64
)

if !GIT_DETECTED!==n (
	cls
	echo Installing Git...
	echo:
	if not exist "git_installer.exe" (
		powershell -Command "Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.35.1.windows.2/Git-2.35.1.2-32-bit.exe -OutFile git_installer.exe"
	)
	echo Proper Git installation doesn't seem possible to do automatically.
	echo You can just keep clicking next until it finishes,
	echo and the GoAnimate Kids installer will continue once it closes.
	start /wait "" "git_installer.exe"
	del "git_installer.exe"
	echo Git has been installed.
)

if !NODE_DETECTED!==n (
	cls
	echo Installing Node.js...
	echo:
	if !CPU_ARCHITECTURE!==64 (
		goto installnode64
	)
	if !CPU_ARCHITECTURE!==32 (
		goto installnode32
	)
	if !CPU_ARCHITECTURE!==what (
		echo:
		echo Well, this is a little embarrassing.
		echo GoAnimate Kids can't tell if you're on a 32-bit or 64-bit system.
		echo:
		echo Press 1 to try 32-bit installation or 3 to skip Node.js installation.
		:architecture_ask
		set /p CPUCHOICE=Response:
		if "!CPUCHOICE!"=="1" goto installnode32
		if "!CPUCHOICE!"=="3" goto after_nodejs_install
		echo You must pick one or the other.&& goto architecture_ask
	)

	:installnode64
	if not exist "node_installer_64.msi" (
		powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v22.14.0/node-v22.14.0-x64.msi -OutFile node_installer_64.msi"
	)
	start /wait msiexec /i "node_installer_64.msi" !INSTALL_FLAGS!
	del "node_installer_64.msi"
	goto nodejs_installed

	:installnode32
	if not exist "node_installer_32.msi" (
		powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v22.14.0/node-v22.14.0-x64.msi -OutFile node_installer_32.msi"
	)
	start /wait msiexec /i "node_installer_32.msi" !INSTALL_FLAGS!
	del "node_installer_32.msi"

	:nodejs_installed
	echo Node.js has been installed.
)

:after_nodejs_install

:: Flash Player
if !FLASH_DETECTED!==n (
	echo Installing Flash Player...
	echo:

	echo GoAnimate Kids will now close all open web browsers.
	echo Save your work and press any key to continue.
	pause
	echo:

	for %%i in (firefox,palemoon,iexplore,microsoftedge,chrome,chrome64,opera,brave) do (
		taskkill /f /im %%i.exe /t >nul
		wmic process where name="%%i.exe" call terminate >nul
	)

	if not exist "CleanFlash_34.0.0.325_Installer.exe" (
		powershell -Command "Invoke-WebRequest https://github.com/Aira-Sakuranomiya/CleanFlashInstaller/releases/download/34.0.0.323/CleanFlash_34.0.0.323_Installer.exe -OutFile CleanFlash_34.0.0.325_Installer.exe"
	)
	start /wait msiexec /i "CleanFlash_34.0.0.308_Installer.exe" !INSTALL_FLAGS! /quiet
	del "CleanFlash_34.0.0.308_Installer.exe"
	echo Flash has been installed.
)

if !DEPENDENCIES_NEEDED!==y (
	echo Dependencies installed.
	start "" "%~f0"
	exit
)

:::::::::::::::::::::::::
:: Post-Initialization ::
:::::::::::::::::::::::::

title GoAnimate Kids Installer
cls
echo:
echo GoAnimate Kids Installer
echo A project from VisualPlugin adapted by the GoAnimate Kids team
echo:
echo Enter 1 to install
echo Enter 0 to close the installer
:wrapperidle
echo:

:::::::::::::
:: Choices ::
:::::::::::::

set /p CHOICE=Choice:
if "!choice!"=="0" goto exit
if "!choice!"=="1" goto downloadmain
echo Time to choose. && goto wrapperidle

:downloadmain
cls
if not exist "GoAnimate-Kids" (
	echo Cloning repository from GitHub...
	git clone https://github.com/GoAnimate-Kids/GoAnimate-Kids.git
) else (
	echo You already have it installed apparently?
	echo If you're trying to install a different version, remove the old folder.
	pause
)
goto npminstall

:downloadbeta
cls
if not exist "GoAnimate-Kids" (
	echo Cloning repository from GitHub...
	git clone --single-branch --branch beta https://github.com/GoAnimate-Kids/GoAnimate-Kids.git
) else (
	echo You already have it installed apparently?
	echo If you're trying to install a different version, remove the old folder.
	pause
)
goto npminstall

:npminstall
cls
pushd "GoAnimate-Kids\wrapper"
if not exist "package-lock.json" (
	echo Installing Node.JS packages...
	call npm install
) else (
	echo Node.JS packages already installed.
)
popd

:httpserverinstall
cls
npm list -g | findstr "http-server" >nul
if !errorlevel! == 0 (
	echo HTTP-Server already installed.
) else (
	echo Installing HTTP-Server...
	call npm install http-server -g
)

:certinstall
cls
pushd "GoAnimate-Kids\server"
echo Installing HTTPS certificate...
echo:
if not exist "the.crt" (
	echo ...except it doesn't exist for some reason.
	echo GoAnimate Kids requires this to run.
	echo Get a "the.crt" file or redownload the project.
	pause
	exit
)
call certutil -addstore -f -enterprise -user root the.crt >nul
popd

:finish
cls
echo:
echo GoAnimate Kids has been installed! Would you like to start it now?
echo:
echo Enter 1 to open GoAnimate Kids now.
echo Enter 0 to just open the folder.
:finalidle
echo:

set /p CHOICE=Choice:
if "!choice!"=="0" goto folder
if "!choice!"=="1" goto start
echo Time to choose. && goto finalidle

:folder
start "" "GoAnimate-Kids"
pause & exit

:start
pushd GoAnimate-Kids
start start_wrapper.bat

:exit
pause & exit
