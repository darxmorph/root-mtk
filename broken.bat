:ask
>%temp%\yesno.vbs echo WScript.Echo MsgBox("It seems your root is broken (there are missing files)" ^& vbCrLf ^& vbCrLf ^& _
>>%temp%\yesno.vbs echo               "Do you want to unroot it?","68","Root your MTK by Henry")
for /f "delims=" %%N in ('cscript //nologo %temp%\yesno.vbs') do set yesno=%%N & del %temp%\yesno.vbs
if %yesno%==7 goto eof
if %yesno%==6 unroot.bat
goto ask
:eof
exit /b