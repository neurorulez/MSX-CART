@echo off
rem --- '6_fw-upload.cmd' v2.5 by KdL (2019.05.20)

set TIMEOUT=1
set CABLE="USB-Blaster [USB-0]"
if "%1"=="" color 1f&title FW-UPLOAD
if not exist "%QUARTUS_ROOTDIR%" goto err_quartus
if not exist fw\recovery.pof goto err_msg
if "%1"=="" echo.&echo Hardware Setup: %CABLE%&echo.&echo Press any key to start programming...&pause >nul 2>nul&cls
echo.&echo Uploading...&echo.&echo Firmware: "%~dp0fw\recovery.pof"&echo.

copy /Y fw\recovery.pof emsx_top.pof >nul 2>nul
"%QUARTUS_ROOTDIR%\bin\quartus_pgm.exe" -c %CABLE% emsx_top.cdf >nul 2>nul
if %ERRORLEVEL% == 0 (cls&echo.&echo PROGRAMMING SUCCEEDED!) else (color 4f&cls&echo.&echo PROGRAMMING FAILED!)
del emsx_top.pof >nul 2>nul
goto timer

:err_quartus
if "%1"=="" color f0
echo.&echo Quartus II was not found!
goto timer

:err_msg
if "%1"=="" color f0
echo.&echo 'fw\recovery.pof' not found!

:timer
waitfor /T %TIMEOUT% pause >nul 2>nul

:quit
