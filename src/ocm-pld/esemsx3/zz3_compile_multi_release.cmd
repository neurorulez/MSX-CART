@echo off
rem --- 'zz3_compile_multi_release.cmd' v2.5 by KdL (2019.05.20)

set TIMEOUT=1
set SRC=C:\Altera\multi_release\
if "%1"=="" color 87&title Multi-Release compiler tool
if not exist "%QUARTUS_ROOTDIR%" goto err_quartus
if not exist %SRC%compile_multi_release.cmd goto err_msg
cd "%SRC%"
start "%SRC%" /d %SRC% /min compile_multi_release.cmd
goto quit

:err_quartus
if "%1"=="" color f0
echo.&echo Quartus II was not found!
goto timer

:err_msg
if "%1"=="" color f0
echo.&echo '%SRC%compile_multi_release.cmd' not found!

:timer
if "%1"=="" waitfor /T %TIMEOUT% pause >nul 2>nul

:quit
