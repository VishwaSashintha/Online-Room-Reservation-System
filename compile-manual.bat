@echo off
setlocal EnableDelayedExpansion

echo ========================================
echo Ocean View Resort - Manual Compilation
echo ========================================
echo.

REM Set paths - Simplified and corrected
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "TOMCAT_HOME=C:\xampp\tomcat"
set "PROJECT_HOME=%~dp0"
set "SERVLET_JAR=%TOMCAT_HOME%\lib\servlet-api.jar"
set "MYSQL_JAR=%PROJECT_HOME%WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar"

echo [1/4] Checking paths...
echo JAVA_HOME: "!JAVA_HOME!"
echo TOMCAT_HOME: "!TOMCAT_HOME!"
echo SERVLET_JAR: "!SERVLET_JAR!"
echo MYSQL_JAR: "!MYSQL_JAR!"
echo.

if not exist "!JAVA_HOME!\bin\javac.exe" (
    echo ERROR: javac.exe not found at "!JAVA_HOME!\bin\javac.exe"
    pause
    exit /b 1
)

if not exist "!SERVLET_JAR!" (
    echo ERROR: servlet-api.jar not found at "!SERVLET_JAR!"
    pause
    exit /b 1
)

if not exist "!MYSQL_JAR!" (
    echo ERROR: MySQL Connector JAR not found at "!MYSQL_JAR!"
    pause
    exit /b 1
)

echo Paths verified.
echo.

echo [2/4] Cleaning old compiled files...
if exist "WebContent\WEB-INF\classes" (
    rmdir /s /q "WebContent\WEB-INF\classes"
)
mkdir "WebContent\WEB-INF\classes"
echo Done.
echo.

echo [3/4] Compiling Java files...
REM Compile models first, then DAOs, then Controllers
echo Compiling Models...
"!JAVA_HOME!\bin\javac.exe" -cp "!SERVLET_JAR!;!MYSQL_JAR!" -d "WebContent\WEB-INF\classes" src\model\*.java
if !ERRORLEVEL! NEQ 0 goto :error

echo Compiling DAOs...
"!JAVA_HOME!\bin\javac.exe" -cp "!SERVLET_JAR!;!MYSQL_JAR!;WebContent\WEB-INF\classes" -d "WebContent\WEB-INF\classes" src\dao\*.java
if !ERRORLEVEL! NEQ 0 goto :error

echo Compiling Controllers...
"!JAVA_HOME!\bin\javac.exe" -cp "!SERVLET_JAR!;!MYSQL_JAR!;WebContent\WEB-INF\classes" -d "WebContent\WEB-INF\classes" src\controller\*.java
if !ERRORLEVEL! NEQ 0 goto :error

echo.
echo [4/4] Deploying to Tomcat...
set "DEPLOY_DIR=!TOMCAT_HOME!\webapps\Online-Room-Reservation-System"

if exist "!DEPLOY_DIR!" (
    echo Removing old deployment...
    rmdir /s /q "!DEPLOY_DIR!"
)

echo Copying files to Tomcat...
xcopy "WebContent" "!DEPLOY_DIR!" /E /I /Y /Q

if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR: Deployment failed during copy!
    pause
    exit /b 1
)

echo.
echo ========================================
echo SUCCESS! Application deployed!
echo ========================================
echo.
echo Next steps:
echo 1. Run the database schema (database\schema.sql)
echo 2. Start Tomcat (C:\xampp\tomcat\bin\startup.bat)
echo 3. Access: http://localhost:8080/Online-Room-Reservation-System/
echo.
timeout /t 5
exit /b 0

:error
echo.
echo ERROR: Compilation failed!
pause
exit /b 1
