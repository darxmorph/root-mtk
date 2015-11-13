goto %1
:eof
exit /b
:checkuid0
for /f "tokens=2 delims==(" %%i in ('adb shell id') do set uid=%%i
if %uid%==0 goto eof
adb shell am start -n com.android.settings/.DevelopmentSettings
>%temp%\info.vbs echo MsgBox "Now disable USB debugging" ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "Wait 2 seconds and turn it back on" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "Accept any warnings in your device","64","Root your MTK by Henry"
call %temp%\info.vbs & del /f /q %temp%\info.vbs
echo.
ping 1.1.1.1 -n 1 -w 1000 >nul
echo Esperando la detecci¢n del dispositivo...
adb wait-for-device
for /f "tokens=2 delims==(" %%i in ('adb shell id') do set uid=%%i
if %uid%==0 goto eof
echo.
goto checkuid0
:usbdebinfo
>%temp%\info.vbs echo MsgBox "Before starting, be sure to enable USB debugging." ^& vbCrLf ^& vbCrLf ^& _
rem Explaining how to enable USB debugging
rem I'm too lazy to translate it so I skip it
rem >>%temp%\info.vbs echo               "Para activar todas las opciones de desarrollo ve a Ajustes > Información del teléfono > Aprieta en número de compilación hasta que aparezca que las opciones de desarrollo estén activadas" ^& vbCrLf ^& vbCrLf ^& _
rem >>%temp%\info.vbs echo               "Entonces ve a Ajustes > Opciones de desarrollo > Actívalas mediante el interruptor y activa la casilla de depuración USB" ^& vbCrLf ^& vbCrLf ^& _
rem >>%temp%\info.vbs echo               "Una vez hecho esto, conecta el dispositivo al PC" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\info.vbs echo               "Accept any warnings in your device","64","Root your MTK by Henry"
call %temp%\info.vbs & del /f /q %temp%\info.vbs
goto eof