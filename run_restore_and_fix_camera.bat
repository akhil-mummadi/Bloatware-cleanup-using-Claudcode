@echo off
setlocal enabledelayedexpansion

title OPPO CPH2285 - Complete Restore & Camera Fix
cls

echo =====================================================
echo   OPPO CPH2285 - COMPLETE RESTORE & CAMERA FIX
echo =====================================================
echo.
echo This script will:
echo   1. Re-enable ALL 37 previously disabled packages
echo   2. Clear camera app cache
echo   3. Restart the device to apply changes
echo.
echo IMPORTANT: Do NOT disconnect the phone during this process!
echo.
pause

cls
echo Checking ADB connection...
adb devices
echo.

echo [PHASE 1] Re-enabling ALL previously disabled packages...
echo.
set "packages=com.mediatek.engineermode com.oplus.bttestmode com.oplus.engineercamera com.oplus.engineermode com.coloros.bootreg com.coloros.floatassistant com.coloros.healthcheck com.coloros.lockassistant com.coloros.scenemode com.coloros.smartsidebar com.oplus.appplatform com.oplus.apprecover com.oplus.interconnectcollectkit com.oplus.lfeh com.oplus.obrain com.oplus.ocloud com.oplus.olc com.oplus.qualityprotect com.oplus.stdsp com.oplus.subsys com.oplus.upgradeguide com.oplus.uxdesign com.oplus.wifibackuprestore com.oplus.wirelesssettings com.heytap.colorfulengine com.nearme.instant.platform com.android.wallpaper.livepicker com.android.wallpaperbackup com.android.wallpaperpicker com.android.systemui.overlay.fingerprint.anim.ccyh com.android.systemui.overlay.fingerprint.anim.fy com.android.systemui.overlay.fingerprint.anim.jslz com.android.systemui.overlay.fingerprint.anim.none com.android.systemui.overlay.fingerprint.anim.sw com.android.systemui.overlay.fingerprint.anim.xklc com.android.systemui.overlay.fingerprint.anim.xw"

set count=0
set success=0
for %%p in (!packages!) do (
    set /a count+=1
    echo [!count!/37] Enabling %%p...
    adb shell pm enable --user 0 %%p 2>&1 | find /I "new state:" >nul
    if !ERRORLEVEL! EQU 0 set /a success+=1
)

echo.
echo [PHASE 2] Re-enabling camera-specific dependencies...
echo.
adb shell pm enable --user 0 com.oplus.statistics.rom >nul 2>&1
adb shell pm enable --user 0 com.oplus.onetrace >nul 2>&1
adb shell pm enable --user 0 com.oplus.portrait >nul 2>&1
adb shell pm enable --user 0 com.oplus.linker >nul 2>&1
adb shell pm enable --user 0 com.oplus.logkit >nul 2>&1
echo    Camera dependencies re-enabled.

echo.
echo [PHASE 3] Clearing camera app cache...
echo.
adb shell pm clear --user 0 com.oplus.camera 2>&1
if !ERRORLEVEL! NEQ 0 (
    echo    Note: Cache clear via ADB may be restricted. Manual clear recommended.
)

echo.
echo [PHASE 4] Verifying disabled packages...
echo.
adb shell pm list packages -d
echo.
echo    Packages still disabled (should be minimal now):
adb shell pm list packages -d | find /c "package:" >nul
set /a disabled=!ERRORLEVEL!

cls
echo =====================================================
echo   RESTORE COMPLETE!
echo =====================================================
echo.
echo Successfully re-enabled !success! packages.
echo.
echo IMPORTANT NEXT STEP:
echo   Your phone will now restart to apply all changes.
echo   Please do NOT unplug until the reboot completes.
echo.
echo After reboot:
echo   1. Open the Camera app immediately
echo   2. If it crashes, manually clear cache:
echo      Settings > Apps > Camera > Storage > Clear Cache
echo   3. If still crashing, clear app data:
echo      Settings > Apps > Camera > Storage > Clear Data
echo.
echo Press any key to RESTART the device now...
pause >nul

cls
echo Restarting device...
adb reboot
echo.
echo Device is rebooting. Please wait 2-3 minutes...
echo.
echo Once the phone restarts, open the Camera app to test.
echo.
pause
endlocal
