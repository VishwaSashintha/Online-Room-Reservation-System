@echo off
echo ========================================
echo  FIXED Compile and Deploy Script
echo ========================================
echo.

cd /d "e:\Git Hub\Online-Room-Reservation-System"

echo Step 1: Creating classes directory...
if not exist "WebContent\WEB-INF\classes" mkdir "WebContent\WEB-INF\classes"

echo Step 2: Compiling model and DAO classes...
"C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar" -d WebContent\WEB-INF\classes src\model\*.java src\dao\*.java

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile model and DAO classes!
    pause
    exit /b 1
)

echo Model and DAO classes compiled successfully!
echo.

echo Step 3: Compiling servlet classes...
"C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\servlet-api.jar;WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar;WebContent\WEB-INF\classes" -d WebContent\WEB-INF\classes src\controller\*.java

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to compile servlet classes!
    echo.
    echo Possible reasons:
    echo 1. servlet-api.jar not found in Tomcat lib folder
    echo 2. Tomcat not installed correctly
    pause
    exit /b 1
)

echo Servlet classes compiled successfully!
echo.

echo Step 4: Deploying to Tomcat...
xcopy "WebContent" "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\Online-Room-Reservation-System" /E /I /Y

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Deployment failed!
    echo This might be because you need Administrator rights.
    echo.
    echo Try running this batch file as Administrator:
    echo Right-click compile-and-deploy.bat and select "Run as administrator"
    pause
    exit /b 1
)

echo.
echo ========================================
echo  SUCCESS! Compiled and Deployed!
echo ========================================
echo.
echo Next step: Restart Tomcat
echo 1. Close the Tomcat window if it's running
echo 2. Run: start-tomcat.bat
echo 3. Wait 10-20 seconds
echo 4. Open browser: http://localhost:8080/Online-Room-Reservation-System/
echo.
pause
