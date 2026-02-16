@echo off
echo ========================================
echo  Ocean View Resort - Deploy to Tomcat
echo ========================================
echo.

set SOURCE=e:\Git Hub\Online-Room-Reservation-System\WebContent
set TOMCAT_WEBAPPS=

REM Check common Tomcat locations
if exist "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps" (
    set TOMCAT_WEBAPPS=C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps
)
if exist "C:\Program Files\Apache Tomcat 9.0\webapps" (
    set TOMCAT_WEBAPPS=C:\Program Files\Apache Tomcat 9.0\webapps
)
if exist "C:\Tomcat\webapps" (
    set TOMCAT_WEBAPPS=C:\Tomcat\webapps
)
if exist "C:\apache-tomcat-9.0\webapps" (
    set TOMCAT_WEBAPPS=C:\apache-tomcat-9.0\webapps
)

if "%TOMCAT_WEBAPPS%"=="" (
    echo ERROR: Could not find Tomcat webapps directory!
    echo.
    echo Please enter the full path to your Tomcat installation:
    echo Example: C:\Program Files\Apache Tomcat 9.0
    echo.
    set /p TOMCAT_HOME="Tomcat Directory: "
    set TOMCAT_WEBAPPS=%TOMCAT_HOME%\webapps
)

echo Deploying to: %TOMCAT_WEBAPPS%\Online-Room-Reservation-System
echo.

REM Remove old deployment
if exist "%TOMCAT_WEBAPPS%\Online-Room-Reservation-System" (
    echo Removing old deployment...
    rmdir /s /q "%TOMCAT_WEBAPPS%\Online-Room-Reservation-System"
)

echo Copying files...
xcopy "%SOURCE%" "%TOMCAT_WEBAPPS%\Online-Room-Reservation-System" /E /I /Y

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo  SUCCESS! Application deployed!
    echo ========================================
    echo.
    echo Next step: Run start-tomcat.bat
    echo.
) else (
    echo.
    echo ERROR: Deployment failed!
    echo.
)

pause
