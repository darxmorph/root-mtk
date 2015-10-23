:ask
>%temp%\yesno.vbs echo MsgBox "Al parecer tu root está 'roto' (faltan archivos)" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\yesno.vbs echo               "¿Deseas desrootear tu dispositivo?","68","Root your MTK by Henry"
for /f "delims=" %%N in ('cscript //nologo %temp%\yesno.vbs') do set yesno=%%N & del %temp%\yesno.vbs
if %yesno%==7 goto exit
if %yesno%==6 goto continue
goto ask
:continue
call common continue
call common checkuid0
:main
echo Ahora es cuando las cosas se ponen interesantes...
echo.
echo Remontando la partici¢n /system a R/W...
ping 1.1.1.1 -n 1 -w 1000 >nul
adb shell mount -o remount,rw /system
echo.
echo Eliminando archivos...
adb shell rm /system/etc/install-recovery.sh
adb shell rm /system/app/SuperSU.apk
adb shell rm /system/xbin/su
adb shell rm /system/xbin/daemonsu
adb shell rm /system/xbin/sugote
adb shell rm /system/xbin/sugote-mksh
adb shell rm /system/xbin/supolicy
adb shell rm /data/dalvik-cache/system@app@SuperSU.apk@classes.dex
adb shell rm -r /data/data/eu.chainfire.supersu
echo Remontando la partici¢n /system a R/O...
adb shell sync
ping 1.1.1.1 -n 1 -w 3500 >nul
adb shell mount -o remount,ro /system
echo.
adb shell setprop ro.secure 1
:end
echo Finalizando servidor ADB...
adb kill-server
>%temp%\info.vbs echo MsgBox "¡Finalizado!" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "No olvides deshabilitar la depuración USB...","64","Root your MTK by Henry"
call %temp%\info.vbs & del /f /q %temp%\info.vbs
:eof
exit /b