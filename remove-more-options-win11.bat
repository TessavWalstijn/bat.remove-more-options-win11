@REM show me all commands reg can do
@REM reg /?

@reg query "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" >nul 2> nul && (
  @echo Legacy Context Menu is already on
  @goto revert
)

@echo Legacy Context Menu is cuerrently off
@goto legacy

:changes
@echo. >> %temp%\remove-more-options-win11.bat 
@echo:
@echo Reboot the computer to complete the process
@echo Do you want your computer to restart?
@set /p restart=Enter Yes or No:
@If "%restart%"=="Y" (
  @goto yes-restart
) Else If "%restart%"=="y" (
  @goto yes-restart
) Else If "%restart%"=="yes" (
  @goto yes-restart
) Else If "%restart%"=="Yes" (
  @goto yes-restart
) Else If "%restart%"=="YEs" (
  @goto yes-restart
) Else If "%restart%"=="YES" (@goto yes-restart)
@goto no

:legacy
@echo:
@echo Do you want to remove 'More Options' from 'Context Menu'
@echo and use the Legacy Context Menu?
@set /p legacyMenu=Enter Yes or No:
@If "%legacyMenu%"=="Y" (
  @goto yes-legacy
) Else If "%legacyMenu%"=="y" (
  @goto yes-legacy
) Else If "%legacyMenu%"=="yes" (
  @goto yes-legacy
) Else If "%legacyMenu%"=="Yes" (
  @goto yes-legacy
) Else If "%legacyMenu%"=="YEs" (
  @goto yes-legacy
) Else If "%legacyMenu%"=="YES" (@goto yes-legacy)
@echo Cancelled legacy process
@goto no

:revert
@echo:
@echo Do you want to add 'More Options' again in 'Context Menu'
@echo and use the New Context Menu?
@set /p newMenu=Enter Yes or No:
@If "%newMenu%"=="Y" (
  @goto yes-revert
) Else If "%newMenu%"=="y" (
  @goto yes-revert
) Else If "%newMenu%"=="yes" (
  @goto yes-revert
) Else If "%newMenu%"=="Yes" (
  @goto yes-revert
) Else If "%newMenu%"=="YEs" (
  @goto yes-revert
) Else If "%newMenu%"=="YES" (@goto yes-revert)
@echo Cancelled revert process
@goto no

:yes-legacy
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /d "" /f
@goto changes

:yes-revert
@echo Reverting process
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
@goto changes

:yes-restart
@echo Restarting computer in 10 seconds
@shutdown -r -f -t 10

:no
@echo:
@echo Press any key to exit
@pause >nul
