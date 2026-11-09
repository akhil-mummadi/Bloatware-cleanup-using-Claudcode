@echo off
setlocal enabledelayedexpansion

title OPPO CPH2285 - CAMERA FIX SCRIPT
cls

echo =====================================================
echo   OPPO CAMERA FIX - Re-enable Critical Dependencies
echo =====================================================
echo.
echo This script will RE-ENABLE packages that the camera
echo app depends on to function properly.
echo.
echo CRITICAL PACKAGES TO RESTORE:
echo   - com.oplus.statistics.rom (OPPO telemetry)
echo   - com.oplus.portrait (Portrait/beauty mode)
echo   - com.oplus.onetrace (Performance tracing)
echo   - com.oplus.linker (System linker)
echo   - com.oplus.logkit (Logging service)
echo.
echo IMPORTANT:
echo   - USB Debugging MUST be enabled on your phone
echo   - Phone MUST be connected via USB cable
echo   - Run "adb devices" to verify connection
echo.
pause

cls
echo Checking ADB connection...
adb devices
echo.
pause

cls
echo.
echo =====================================================
echo   RE-ENABLING CRITICAL CAMERA DEPENDENCIES
echo =====================================================
echo.

setlocal enabledelayedexpansion

REM Critical packages for camera functionality
set "critical_packages=com.oplus.statistics.rom com.oplus.portrait com.oplus.onetrace com.oplus.linker com.oplus.logkit"

set count=0
for %%p in (!critical_packages!) do (
    set /a count+=1
    echo [!count!/5] Re-enabling: %%p...
    adb shell pm enable --user 0 %%p 2>&1 | find /V "Package disabled" >nul
    if !ERRORLEVEL! EQU 0 (
        echo    [SUCCESS]
    ) else (
        echo    [STATUS UPDATE]
    )
)

cls
echo.
echo =====================================================
echo   CLEARING CAMERA APP CACHE
echo =====================================================
echo.
echo Clearing cached data to fix initialization issues...
echo.
adb shell pm clear --user 0 com.oplus.camera
echo.
echo =====================================================
echo   RESTARTING ANDROID RUNTIME
echo =====================================================
echo.
echo Restarting camera service...
echo.
adb shell stop
timeout /t 3 /nobreak
adb shell start
echo.
timeout /t 5 /nobreak

cls
echo =====================================================
echo   CAMERA FIX COMPLETE!
echo =====================================================
echo.
echo Successfully re-enabled camera dependencies.
echo.
echo NEXT STEPS:
echo   1. Disconnect the USB cable
echo   2. Open the Camera app on your phone
echo   3. Verify camera is working properly
echo   4. If issues persist, restart your phone
echo.
echo If camera STILL doesn't work:
echo   - Check that all packages were enabled
echo   - Restart your phone manually
echo   - Run this script again
echo.
pause
endlocal
