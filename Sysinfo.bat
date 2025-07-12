@echo off
setlocal EnableDelayedExpansion

:: admin request
NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    ECHO UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    DEL "%temp%\getadmin.vbs"
    EXIT /B 0
)
::end
::Lang Option
:LS
cls
echo [94mChoose Language[0m:[96mElige idioma[0m
echo [94mEnglish[1][0m:[96mEspanol[2][0m
set /p lang=">>"

if /i "%lang%"=="1" (
    goto ENG
) else if /i "%lang%"=="English" (
    goto ENG
) else if /i "%lang%"=="2" (
    goto SPAN
) else if /i "%lang%"=="Espanol" (
    goto SPAN
) else (
    echo [94mTry Again[0m:[96mIntenta Otravez[0m
    timeout /t 1 > NUL
    goto LS
)
::end
:ENG
cls
SET "OUTPUT_DIR=C:\"
SET "OUTPUT_FILE=%OUTPUT_DIR%\system_report.txt"

ECHO Saving info onto "%OUTPUT_FILE%"...
systeminfo > "%OUTPUT_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: systeminfo command failed with error code %ERRORLEVEL%. Check "%OUTPUT_FILE%" for details.
    PAUSE
    EXIT /B 1
)

wmic path softwareLicensingService get OA3xOriginalProductKey >> "%OUTPUT_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: wmic command failed with error code %ERRORLEVEL%. Check "%OUTPUT_FILE%" for details.
    PAUSE
    EXIT /B 1
)


ECHO.
ECHO ==================================================================
ECHO         System report saved to: "%OUTPUT_FILE%"
ECHO         Send me the text file through Instagram
ECHO ==================================================================
ECHO.
start explorer.exe "C:\"
start chrome.exe "https://www.instagram.com/tech_ease_solutions/"
pause
exit /b 
::end of english part
:SPAN
cls
SET "OUTPUT_DIR=C:\"
SET "OUTPUT_FILE=%OUTPUT_DIR%\Reporte_de_systema.txt"

ECHO Salvando Reporte en "%OUTPUT_FILE%"...
systeminfo > "%OUTPUT_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: Reporte fallo, %ERRORLEVEL%. revisa "%OUTPUT_FILE%" para mas detalles.
    PAUSE
    EXIT /B 1
)

wmic path softwareLicensingService get OA3xOriginalProductKey >> "%OUTPUT_FILE%" 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: WindowsKey fallo, %ERRORLEVEL%. revisa "%OUTPUT_FILE%" para mas detalles.
    PAUSE
    EXIT /B 1
)

ECHO.
ECHO ==================================================================
ECHO         Reporte del sistema guardado en: "%OUTPUT_FILE%"
ECHO            Enviame el archivo de texto por Instagram
ECHO ==================================================================
ECHO.
start explorer.exe "C:\"
start chrome.exe "https://www.instagram.com/tech_ease_solutions/"
pause
exit /b 
::end of spanish part
