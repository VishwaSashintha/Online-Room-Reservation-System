# 🚀 EASIEST WAY TO RUN - Using Batch Scripts

I've created 3 simple batch files to make this super easy for you!

## ✅ Prerequisites Checklist

Before running, make sure you have:
- [x] MySQL installed and running
- [x] MySQL password set to `123456789` in `DBConnection.java`
- [x] MySQL Connector JAR in `WebContent\WEB-INF\lib\` ✅ (You have mysql-connector-j-9.6.0.jar)
- [ ] Tomcat installed
- [ ] JDK installed ✅ (You have jdk-25.0.2)
- [ ] Database created (see Step 1 below)

---

## 📋 Simple 4-Step Process

### **STEP 1: Setup MySQL Database**

1. Open **MySQL Command Line Client**
2. Enter password: `123456789`
3. Copy and paste this:

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

INSERT INTO reservations VALUES
(1001, 'John Doe', '123 Main St, Colombo', '0771234567', 'Deluxe', '2026-02-20', '2026-02-23', 36000.00),
(1002, 'Jane Smith', '456 Beach Rd, Galle', '0779876543', 'Suite', '2026-02-25', '2026-02-28', 60000.00);
```

Type `exit` when done.

---

### **STEP 2: Compile Java Files**

1. Go to your project folder: `e:\Git Hub\Online-Room-Reservation-System`
2. **Double-click: `compile.bat`**
3. If it asks for Tomcat directory, enter the path (e.g., `C:\Program Files\Apache Tomcat 9.0`)
4. Wait for "SUCCESS!" message

---

### **STEP 3: Deploy to Tomcat**

1. **Double-click: `deploy.bat`**
2. If it asks for Tomcat directory, enter the path
3. Wait for "SUCCESS!" message

---

### **STEP 4: Start Tomcat and Open Browser**

1. **Double-click: `start-tomcat.bat`** (or use `C:\xampp\tomcat\bin\startup.bat`)
2. A Tomcat window will open - **DON'T CLOSE IT!**
3. Wait 10-20 seconds
4. Open browser and go to: **[http://localhost:8080/Online-Room-Reservation-System/](http://localhost:8080/Online-Room-Reservation-System/)**
5. Login with your desired role:
   - **Admin Account**: Username: `admin`, Password: `admin123` (Access to Reports/Users)
   - **Staff Account**: Username: `staff`, Password: `staff123` (Operational view only)

---

## 👥 Role Differences

| Feature | Admin | Staff |
| :--- | :---: | :---: |
| View Dashboards | ✅ (Full Stats) | ✅ (Daily Ops) |
| Add/Update/Search | ✅ | ✅ |
| Delete Reservation | ✅ | ❌ |
| Manage Users | ✅ | ❌ |
| View Reports | ✅ | ❌ |

---

## 🎉 That's It!

If you see the dashboard, **YOU'RE DONE!** 🎊

---

## ❓ Troubleshooting

### Problem: compile.bat says "Cannot find servlet-api.jar"

**Solution:**
When it asks for Tomcat directory, enter the FULL path where you installed Tomcat.

Common locations:
- `C:\Program Files\Apache Software Foundation\Tomcat 9.0`
- `C:\Program Files\Apache Tomcat 9.0`
- `C:\Tomcat`
- `C:\apache-tomcat-9.0`

### Problem: "Port 8080 already in use"

**Solution:**
1. Close any programs using port 8080
2. Or restart your computer
3. Try again

### Problem: "Cannot connect to database"

**Solution:**
1. Make sure MySQL service is running
2. Check password in `DBConnection.java` is `123456789`
3. Make sure you ran the SQL commands in Step 1

### Problem: Browser shows "404 Not Found"

**Solution:**
1. Make sure you ran `deploy.bat` successfully
2. Make sure Tomcat is running (the window should still be open)
3. Check the URL is exactly: `http://localhost:8080/Online-Room-Reservation-System/`

---

## 🛑 To Stop Tomcat

Just close the Tomcat window that opened when you ran `start-tomcat.bat`

---

## 📝 Summary

You now have 3 magic buttons:
1. **compile.bat** - Compiles your Java code
2. **deploy.bat** - Copies files to Tomcat
3. **start-tomcat.bat** - Starts the server

**Just run them in order (1, 2, 3) and you're done!** ✅
