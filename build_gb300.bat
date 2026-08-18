@echo off
setlocal enabledelayedexpansion

REM ========================================
REM  FrogUI Build Script for GB300
REM ========================================

echo ========================================
echo  FrogUI - GB300 Build
echo ========================================
echo.

REM Auto-detect sf2000_multicore location
if defined MULTICORE_PATH (
    if exist "!MULTICORE_PATH!\Makefile" goto :found_multicore
)

if exist "%~dp0..\sf2000_multicore\Makefile" (
    set "MULTICORE_PATH=%~dp0..\sf2000_multicore"
    goto :found_multicore
)

if exist "%~dp0sf2000_multicore\Makefile" (
    set "MULTICORE_PATH=%~dp0sf2000_multicore"
    goto :found_multicore
)

if exist "D:\sf2000_multicore\Makefile" (
    set "MULTICORE_PATH=D:\sf2000_multicore"
    goto :found_multicore
)

if exist "C:\sf2000_multicore\Makefile" (
    set "MULTICORE_PATH=C:\sf2000_multicore"
    goto :found_multicore
)

echo ERROR: sf2000_multicore repository not found!
echo Please do one of the following:
echo   1. Clone sf2000_multicore in the parent directory:
echo      git clone --depth 1 https://github.com/Trademarked69/sf2000_multicore.git ..\sf2000_multicore
echo   2. Set MULTICORE_PATH environment variable to your sf2000_multicore path.
echo.
pause
exit /b 1

:found_multicore
pushd "!MULTICORE_PATH!"
set "MULTICORE_PATH=%CD%"
popd

echo Multicore path: !MULTICORE_PATH!
echo.

REM Copy FrogUI sources to multicore
echo Copying FrogUI sources to multicore...
xcopy /E /Y /Q "%~dp0cores\menu\*" "!MULTICORE_PATH!\cores\menu\" >nul

REM Convert Windows path to WSL path
set "WSL_PATH=!MULTICORE_PATH:\=/!"
for %%d in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    set "WSL_PATH=!WSL_PATH:%%d:=/mnt/%%d!"
    set "WSL_PATH=!WSL_PATH:%%D:=/mnt/%%d!"
)

echo Building in WSL from: !WSL_PATH!
echo.

wsl bash -c "cd '!WSL_PATH!' && make clean CORE=cores/menu FROGGY_TYPE=GB300V2 && make CORE=cores/menu FROGGY_TYPE=GB300V2 CONSOLE=menu"

if %ERRORLEVEL% EQU 0 (
    copy "!MULTICORE_PATH!\core_87000000" "%~dp0core_87000000_gb300" >nul
    echo.
    echo ========================================
    echo  BUILD SUCCESSFUL!
    echo  Output: %~dp0core_87000000_gb300
    echo ========================================
) else (
    echo.
    echo ========================================
    echo  BUILD FAILED!
    echo ========================================
)

pause
