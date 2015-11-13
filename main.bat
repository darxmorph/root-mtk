@echo off
setlocal EnableDelayedExpansion
title Root your MTK by Henry
echo Welcome to Root your MTK
echo.
:waitfordevice
ping 1.1.1.1 -n 1 -w 1000 >nul
echo Waiting for device...
adb wait-for-device
echo.
echo Device detected^^!
echo.
:checkroot
echo Checking root status...
echo.
for /f "tokens=2" %%i in ('adb shell ls -al /system/xbin/su') do (
set subin=%%i
if not %%i==!subin:root=! goto hassubin
)
goto noroot
rem adb shell ls -al /system/xbin/su
rem Check for install-recovery.sh
:hassubin
for /f "tokens=2" %%i in ('adb shell ls -al /system/etc/install-recovery.sh') do (
set recsh=%%i
if not %%i==!recsh:root=! goto rooted
)
goto broken
:broken
call broken
goto eof
:rooted
call unroot
goto eof
:noroot
call root
goto eof
:eof
exit