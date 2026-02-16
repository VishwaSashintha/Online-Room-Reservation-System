@echo off
echo ========================================
echo  Ocean View Resort - Start Tomcat
echo ========================================
echo.

set TOMCAT_BIN=

REM Check common Tomcat locations
if exist "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\startup.bat" (
    set TOMCAT_BIN=C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin
)
if exist "C:\Program Files\Apache Tomcat 9.0\bin\startup.bat" (
    set TOMCAT_BIN=C:\Program Files\Apache Tomcat 9.0\bin
)
if exist "C:\Tomcat\bin\startup.bat" (
    set TOMCAT_BIN=C:\Tomcat\bin
)
if exist "C:\apache-tomcat-9.0\bin\startup.bat" (
    set TOMCAT_BIN=C:\apache-tomcat-9.0\bin
)

if "%TOMCAT_BIN%"=="" (
    echo ERROR: Could not find Tomcat bin directory!
    echo.
    echo Please enter the full path to your Tomcat installation:
    echo Example: C:\Program Files\Apache Tomcat 9.0
    echo.
    set /p TOMCAT_HOME="Tomcat Directory: "
    set TOMCAT_BIN=%TOMCAT_HOME%\bin
)

echo Starting Tomcat from: %TOMCAT_BIN%
echo.

cd /d "%TOMCAT_BIN%"
call startup.bat

echo.
echo ========================================
echo  Tomcat is starting...
echo ========================================
echo.
echo Wait 10-20 seconds, then open your browser to:
echo http://localhost:8080/Online-Room-Reservation-System/
echo.
echo Login credentials:
echo   Username: admin
echo   Password: admin123
echo.
pause
