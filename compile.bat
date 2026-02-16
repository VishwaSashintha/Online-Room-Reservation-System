@echo off
echo ========================================
echo  Ocean View Resort - Compile Script
echo ========================================
echo.

cd /d "e:\Git Hub\Online-Room-Reservation-System"

echo Step 1: Creating classes directory...
if not exist "WebContent\WEB-INF\classes" mkdir "WebContent\WEB-INF\classes"

echo Step 2: Compiling Java files...
echo.

REM First, compile model and dao classes (no servlet dependencies)
"C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar" -d WebContent\WEB-INF\classes src\model\*.java src\dao\*.java

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile model and DAO classes!
    pause
    exit /b 1
)

echo Model and DAO classes compiled successfully!
echo.

REM Now compile servlets - try different possible servlet JAR locations
set SERVLET_JAR=

REM Check common Tomcat locations
if exist "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\servlet-api.jar" (
    set SERVLET_JAR=C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\servlet-api.jar
)
if exist "C:\Program Files\Apache Tomcat 9.0\lib\servlet-api.jar" (
    set SERVLET_JAR=C:\Program Files\Apache Tomcat 9.0\lib\servlet-api.jar
)
if exist "C:\Tomcat\lib\servlet-api.jar" (
    set SERVLET_JAR=C:\Tomcat\lib\servlet-api.jar
)
if exist "C:\apache-tomcat-9.0\lib\servlet-api.jar" (
    set SERVLET_JAR=C:\apache-tomcat-9.0\lib\servlet-api.jar
)

REM Try jakarta servlet API (Tomcat 10+)
if exist "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\jakarta.servlet-api.jar" (
    set SERVLET_JAR=C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\jakarta.servlet-api.jar
)

if "%SERVLET_JAR%"=="" (
    echo.
    echo ERROR: Could not find servlet-api.jar!
    echo.
    echo Please enter the full path to your Tomcat installation directory:
    echo Example: C:\Program Files\Apache Tomcat 9.0
    echo.
    set /p TOMCAT_HOME="Tomcat Directory: "
    
    if exist "%TOMCAT_HOME%\lib\servlet-api.jar" (
        set SERVLET_JAR=%TOMCAT_HOME%\lib\servlet-api.jar
    ) else if exist "%TOMCAT_HOME%\lib\jakarta.servlet-api.jar" (
        set SERVLET_JAR=%TOMCAT_HOME%\lib\jakarta.servlet-api.jar
    ) else (
        echo ERROR: servlet-api.jar not found in %TOMCAT_HOME%\lib\
        pause
        exit /b 1
    )
)

echo Using servlet JAR: %SERVLET_JAR%
echo.

"C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "%SERVLET_JAR%;WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar;WebContent\WEB-INF\classes" -d WebContent\WEB-INF\classes src\controller\*.java

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to compile servlet classes!
    echo.
    echo This might be because:
    echo 1. Tomcat is not installed correctly
    echo 2. servlet-api.jar is in a different location
    echo.
    echo Please check your Tomcat installation.
    pause
    exit /b 1
)

echo.
echo ========================================
echo  SUCCESS! All files compiled!
echo ========================================
echo.
echo Next steps:
echo 1. Run: deploy.bat (to copy files to Tomcat)
echo 2. Run: start-tomcat.bat (to start server)
echo.
pause
