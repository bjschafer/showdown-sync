REM install-windows.bat
REM
REM Purpose: Installs the file (from current directory) as a scheduled task to run once an hour.
REM
REM Author: Braxton J. Schafer (bjschafer) [bjs]
REM
REM Creation date: 10/14/2014
REM
REM Copyright (c) 2014 Braxton J. Schafer
REM
REM Changelog:
REM

IF "%1"=="" GOTO Usage
IF "%1"=="-i" GOTO Install
IF "%1"=="-u" GOTO Uninstall
IF "%1"=="-h" GOTO Help
GOTO:EOF

:Usage
ECHO Usage: install-windows.bat [-iu]
ECHO -i Installs program to run hourly
ECHO -u Uninstalls program from scheduled tasks
ECHO.

GOTO:EOF

:Install
schtasks /create /tn "Showdown Sync" /tr python3 main.ph /sc hourly
GOTO:EOF

:Uninstall
schtasks /delete /tn "Showdown Sync"
GOTO:EOF

:Help
GOTO Usage

