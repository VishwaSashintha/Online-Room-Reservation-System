# 🚀 Run Without Eclipse - Simple Manual Deployment

## ✅ What You Have
- ✅ JDK installed
- ✅ Apache Tomcat installed
- ✅ MySQL installed and running
- ✅ MySQL password set to: `123456789`

---

## 📋 Quick 4-Step Setup

### **STEP 1: Setup MySQL Database (5 minutes)**

1. **Open MySQL Command Line Client** (search in Windows Start)
2. **Enter password:** `123456789`
3. **Run these commands:**

```sql
CREATE DATABASE oceanview_db;
USE oceanview_db;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact VARCHAR(15) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    total_bill DOUBLE NOT NULL
);

INSERT INTO users (username, password, role) VALUES 
('admin', 'admin123', 'ADMIN'),
('staff', 'staff123', 'STAFF');

INSERT INTO reservations (reservation_id, guest_name, address, contact, room_type, check_in, check_out, total_bill) VALUES
(1001, 'John Doe', '123 Main St, Colombo', '0771234567', 'Deluxe', '2026-02-20', '2026-02-23', 36000.00),
(1002, 'Jane Smith', '456 Beach Rd, Galle', '0779876543', 'Suite', '2026-02-25', '2026-02-28', 60000.00);
```

4. **Verify:**
```sql
SELECT * FROM users;
SELECT * FROM reservations;
```

You should see 2 users and 2 reservations. Type `exit` to close MySQL.

---

### **STEP 2: Add MySQL Connector JAR (3 minutes)**

1. **Download MySQL Connector:**
   - Go to: https://dev.mysql.com/downloads/connector/j/
   - Download "Platform Independent" ZIP
   - Extract the ZIP file

2. **Copy JAR to project:**
   - Find the file: `mysql-connector-j-8.x.x.jar` (or `mysql-connector-java-8.x.x.jar`)
   - Create folder if it doesn't exist: `e:\Git Hub\Online-Room-Reservation-System\WebContent\WEB-INF\lib\`
   - Copy the JAR file into the `lib` folder

---

### **STEP 3: Compile Java Files (5 minutes)**

1. **Open PowerShell** (search in Windows Start)

2. **Navigate to project:**
```powershell
cd "e:\Git Hub\Online-Room-Reservation-System"
```

3. **Find your JDK and Tomcat paths:**
   - JDK is usually in: `C:\Program Files\Java\jdk-xx.x.x\`
   - Tomcat is usually in: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\`

4. **Create classes directory:**
```powershell
mkdir WebContent\WEB-INF\classes -Force
```

5. **Compile all Java files:**

Replace `C:\Program Files\Java\jdk-xx.x.x` and `C:\Program Files\Apache Software Foundation\Tomcat 9.0` with your actual paths:

```powershell
& "C:\Program Files\Java\jdk-xx.x.x\bin\javac.exe" -cp "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\servlet-api.jar;WebContent\WEB-INF\lib\mysql-connector-j-8.x.x.jar" -d WebContent\WEB-INF\classes src\dao\*.java src\model\*.java src\controller\*.java
```

If you see no errors, compilation succeeded! ✅

---

### **STEP 4: Deploy to Tomcat and Run (2 minutes)**

#### Option A: Copy Entire Project to Tomcat

1. **Copy project to Tomcat webapps:**
```powershell
xcopy "e:\Git Hub\Online-Room-Reservation-System\WebContent" "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\Online-Room-Reservation-System" /E /I /Y
```

2. **Also copy compiled classes:**
```powershell
xcopy "e:\Git Hub\Online-Room-Reservation-System\WebContent\WEB-INF\classes" "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\Online-Room-Reservation-System\WEB-INF\classes" /E /I /Y
```

#### Option B: Create WAR file (Alternative)

```powershell
cd WebContent
& "C:\Program Files\Java\jdk-xx.x.x\bin\jar.exe" -cvf ..\oceanview.war *
copy ..\oceanview.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\"
```

---

### **STEP 5: Start Tomcat Server**

1. **Open PowerShell as Administrator** (right-click PowerShell → Run as Administrator)

2. **Navigate to Tomcat bin:**
```powershell
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
```

3. **Start Tomcat:**
```powershell
.\startup.bat
```

You should see a new window open with Tomcat logs.

**Wait 10-20 seconds** for Tomcat to fully start.

---

### **STEP 6: Open in Browser! 🎉**

1. **Open your web browser** (Chrome, Firefox, Edge)
2. **Go to:** `http://localhost:8080/Online-Room-Reservation-System/`
3. **Login:**
   - Username: `admin`
   - Password: `admin123`

---

## ✅ Success!

If you see the login page and can login to see the dashboard, **YOU DID IT!** 🎉

---

## 🔧 Troubleshooting

### Problem: "javac is not recognized"
**Solution:** Add JDK to PATH or use full path:
```powershell
& "C:\Program Files\Java\jdk-17\bin\javac.exe" ...
```

### Problem: "Cannot find servlet-api.jar"
**Solution:** Check your Tomcat path. The file is in: `TOMCAT_HOME\lib\servlet-api.jar`

### Problem: "Port 8080 already in use"
**Solution:** 
1. Stop other applications using port 8080
2. Or change Tomcat port in `TOMCAT_HOME\conf\server.xml`

### Problem: "Cannot connect to database"
**Solution:**
1. Make sure MySQL is running
2. Check password in `DBConnection.java` is `123456789`
3. Make sure database `oceanview_db` exists

### Problem: "404 Not Found"
**Solution:**
1. Make sure you copied files to correct location
2. Check URL is exactly: `http://localhost:8080/Online-Room-Reservation-System/`
3. Check Tomcat started successfully (look at the Tomcat window)

---

## 🛑 To Stop Tomcat

```powershell
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
.\shutdown.bat
```

---

## 📝 Notes

- Your database password is set to: `123456789` ✅
- MySQL Connector JAR must be in: `WebContent\WEB-INF\lib\` ✅
- Compiled classes go in: `WebContent\WEB-INF\classes\` ✅
