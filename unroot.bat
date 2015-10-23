:ask
>%temp%\yesno.vbs echo WScript.Echo MsgBox("It seems your device is already rooted" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\yesno.vbs echo               "Do you want to unroot it?","68","Root your MTK by Henry")
for /f "delims=" %%N in ('cscript //nologo %temp%\yesno.vbs') do set yesno=%%N & del %temp%\yesno.vbs
if %yesno%==7 goto exit
if %yesno%==6 goto continue
goto ask
:continue
call common usbdebinfo
adb shell setprop ro.secure 0
call common checkuid0
:main
echo Now is when things get interesting...
echo.
echo Remounting /system R/W...
ping 1.1.1.1 -n 1 -w 1000 >nul
adb shell mount -o remount,rw /system
echo.
echo Deleting files...
echo.
echo Deleting /system/etc/install-recovery.sh
adb shell rm /system/etc/install-recovery.sh
echo Deleting /system/xbin/su
adb shell rm /system/xbin/su
echo Deleting /system/xbin/daemonsu
adb shell rm /system/xbin/daemonsu
echo Deleting /system/xbin/sugote
adb shell rm /system/xbin/sugote
echo Deleting /system/xbin/sugote-mksh
adb shell rm /system/xbin/sugote-mksh
echo Deleting /system/xbin/supolicy
adb shell rm /system/xbin/supolicy
echo.

echo Uninstalling SuperSU...
echo.
echo Deleting /system/app/SuperSU.apk
adb shell rm /system/app/SuperSU.apk
echo Deleting directory recursive /system/bin/.ext
adb shell rm -r /system/bin/.ext
echo Deleting /system/xbin/.tmpsu
adb shell rm /system/xbin/.tmpsu
echo Deleting /system/etc/.installed_su_daemon
adb shell rm /system/etc/.installed_su_daemon
echo Deleting /data/dalvik-cache/system@app@SuperSU.apk@classes.dex
adb shell rm /data/dalvik-cache/system@app@SuperSU.apk@classes.dex
echo Deleting directory recursive /data/data/eu.chainfire.supersu
adb shell rm -r /data/data/eu.chainfire.supersu
echo.

echo Remounting /system R/O...
adb shell sync
ping 1.1.1.1 -n 1 -w 3500 >nul
adb shell mount -o remount,ro /system
echo.
adb shell setprop ro.secure 1
:end
echo Killing ADB server...
adb kill-server
>%temp%\info.vbs echo MsgBox "Done^!" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "Don't forget to disable USB debugging...","64","Root your MTK by Henry"
call %temp%\info.vbs & del /f /q %temp%\info.vbs
:eof
exit /b