:ask
>%temp%\yesno.vbs echo WScript.Echo MsgBox("It seems your device isn't rooted" ^& vbCrLf ^& vbCrLf ^& _
for /f "delims=" %%N in ('cscript //nologo %temp%\yesno.vbs') do set yesno=%%N & del %temp%\yesno.vbs
>>%temp%\yesno.vbs echo               "Are you sure you want to root your device?","68","Root your MTK by Henry")
if %yesno%==7 goto exit
if %yesno%==6 goto continue
goto ask
:continue
call common usbdebinfo
adb shell setprop ro.secure 0
call common checkuid0
:root
echo Now is when things get interesting...
echo.
echo Remounting /system R/W...
ping 1.1.1.1 -n 1 -w 1000 >nul
adb shell mount -o remount,rw /system
echo.

echo Adding /system/lib/libsupol.so
adb push libsupol.so /system/lib/libsupol.so
echo Running 'chown 0:0 /system/lib/libsupol.so'
adb shell chown 0:0 /system/lib/libsupol.so
echo Running 'chmod 0644 /system/lib/libsupol.so'
adb shell chmod 0644 /system/lib/libsupol.so

echo Adding /system/xbin/supolicy
adb push supolicy /system/xbin/supolicy
echo Running 'chown 0:2000 /system/xbin/supolicy'
adb shell chown 0:2000 /system/xbin/supolicy
echo Running 'chmod 0755 /system/xbin/supolicy'
adb shell chmod 0755 /system/xbin/supolicy

echo Adding /system/xbin/su
adb push su /system/xbin/su
echo Running 'chown 0:2000 /system/xbin/su'
adb shell chown 0:2000 /system/xbin/su
echo Running 'chmod 0755 /system/xbin/su'
adb shell chmod 0755 /system/xbin/su

echo Installing SuperSU as System App1
adb push SuperSU.apk /system/app/SuperSU.apk
echo Running 'chown 0:0 /system/app/SuperSU.apk'
adb shell chown 0:0 /system/app/SuperSU.apk
echo Running 'chmod 0644 /system/app/SuperSU.apk'
adb shell chmod 0644 /system/app/SuperSU.apk
echo.

echo Starting SU daemon
adb shell /system/xbin/su --daemon
rem adb shell cd /system/xbin ^&^& busybox nohup su --daemon ^>/dev/null 2^>^&1
echo.
adb shell setprop ro.secure 1
:end
echo Killing ADB server...
adb kill-server
>%temp%\info.vbs echo MsgBox "Done^!" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "You must update SU binaries from SuperSU app before rebooting" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "Don't forget to disable USB debugging...","64","Root your MTK by Henry"
call %temp%\info.vbs & del /f /q %temp%\info.vbs
:eof
exit /b