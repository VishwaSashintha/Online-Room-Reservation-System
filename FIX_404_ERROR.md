# 🚨 Quick Fix for 404 Error

The 404 error means your application wasn't deployed correctly. This is likely because:
1. The files weren't compiled, OR
2. The files weren't copied to Tomcat

## ✅ Let's Fix This - Simple Manual Method

Since the batch files might not be finding Tomcat automatically, let's do it manually:

### **Step 1: Find Your Tomcat Installation**

1. Open File Explorer
2. Search for "Tomcat" in `C:\Program Files`
3. Find the folder (it might be called):
   - `Apache Software Foundation\Tomcat 9.0`
   - `Apache Tomcat 9.0`
   - `Tomcat`
   - Or check `C:\` drive directly

**Write down the FULL path!** Example: `C:\Program Files\Apache Tomcat 9.0`

---

### **Step 2: Compile Files Manually**

1. Open **PowerShell**
2. Run these commands (replace `YOUR_TOMCAT_PATH` with your actual Tomcat path):

```powershell
cd "e:\Git Hub\Online-Room-Reservation-System"

# Compile model and DAO classes
& "C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar" -d WebContent\WEB-INF\classes src\model\*.java src\dao\*.java

# Compile servlets (REPLACE YOUR_TOMCAT_PATH)
& "C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "YOUR_TOMCAT_PATH\lib\servlet-api.jar;WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar;WebContent\WEB-INF\classes" -d WebContent\WEB-INF\classes src\controller\*.java
```

**Example with actual path:**
```powershell
& "C:\Program Files\Java\jdk-25.0.2\bin\javac.exe" -cp "C:\Program Files\Apache Tomcat 9.0\lib\servlet-api.jar;WebContent\WEB-INF\lib\mysql-connector-j-9.6.0.jar;WebContent\WEB-INF\classes" -d WebContent\WEB-INF\classes src\controller\*.java
```

---

### **Step 3: Copy to Tomcat Manually**

```powershell
# REPLACE YOUR_TOMCAT_PATH with your actual path
xcopy "WebContent" "YOUR_TOMCAT_PATH\webapps\Online-Room-Reservation-System" /E /I /Y
```

**Example:**
```powershell
xcopy "WebContent" "C:\Program Files\Apache Tomcat 9.0\webapps\Online-Room-Reservation-System" /E /I /Y
```

---

### **Step 4: Restart Tomcat**

1. **Stop Tomcat:**
   - Close the Tomcat window if it's open
   - OR run: `YOUR_TOMCAT_PATH\bin\shutdown.bat`

2. **Start Tomcat:**
   - Run: `YOUR_TOMCAT_PATH\bin\startup.bat`
   - OR double-click `start-tomcat.bat`

3. **Wait 10-20 seconds**

4. **Open browser:** `http://localhost:8080/Online-Room-Reservation-System/`

---

## 🔍 Alternative: Check if servlet-api.jar exists

If compilation still fails, the servlet JAR might have a different name:

```powershell
# Check what JAR files exist in Tomcat lib
dir "YOUR_TOMCAT_PATH\lib\*.jar"
```

Look for files like:
- `servlet-api.jar`
- `jakarta.servlet-api.jar`
- `javax.servlet-api.jar`

Use the one you find in the compile command!

---

## 📝 What's Your Tomcat Path?

Tell me the FULL path to your Tomcat installation and I'll give you the exact commands to run!
