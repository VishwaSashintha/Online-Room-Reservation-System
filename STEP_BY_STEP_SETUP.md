# Step-by-Step Setup Guide for Beginners

## ✅ What You've Done So Far
- ✅ Downloaded and installed JDK
- ✅ Downloaded and installed Apache Tomcat
- ✅ Downloaded and installed MySQL

## 🎯 Now Let's Run Your Application

### **STEP 1: Setup MySQL Database (5 minutes)**

#### 1.1 Start MySQL Server
1. Press `Windows + R`
2. Type `services.msc` and press Enter
3. Find "MySQL80" (or similar) in the list
4. Right-click → Start (if not already running)

#### 1.2 Open MySQL Command Line
1. Press `Windows + S` (Search)
2. Type "MySQL Command Line Client" or "MySQL 8.0 Command Line Client"
3. Click to open it
4. Enter your MySQL root password (the one you set during installation)

#### 1.3 Create the Database
Copy and paste these commands one by one:

```sql
CREATE DATABASE oceanview_db;
```
Press Enter. You should see "Query OK".

```sql
USE oceanview_db;
```
Press Enter.

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);
```
Press Enter.

```sql
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
```
Press Enter.

```sql
INSERT INTO users (username, password, role) VALUES 
('admin', 'admin123', 'ADMIN'),
('staff', 'staff123', 'STAFF');
```
Press Enter.

```sql
INSERT INTO reservations (reservation_id, guest_name, address, contact, room_type, check_in, check_out, total_bill) VALUES
(1001, 'John Doe', '123 Main St, Colombo', '0771234567', 'Deluxe', '2026-02-20', '2026-02-23', 36000.00),
(1002, 'Jane Smith', '456 Beach Rd, Galle', '0779876543', 'Suite', '2026-02-25', '2026-02-28', 60000.00);
```
Press Enter.

#### 1.4 Verify Database
```sql
SELECT * FROM users;
```
You should see 2 users (admin and staff).

```sql
SELECT * FROM reservations;
```
You should see 2 sample reservations.

Type `exit` and press Enter to close MySQL.

---

### **STEP 2: Update Database Password in Code (2 minutes)**

1. Open this file: `e:\Git Hub\Online-Room-Reservation-System\src\dao\DBConnection.java`
2. Find line 15 (around line 15):
   ```java
   private static final String PASSWORD = "root";
   ```
3. Change `"root"` to YOUR MySQL password (the one you use to login to MySQL)
4. Save the file (Ctrl + S)

---

### **STEP 3: Add MySQL Driver (3 minutes)**

#### 3.1 Download MySQL Connector
1. Go to: https://dev.mysql.com/downloads/connector/j/
2. Click "Download" for "Platform Independent"
3. Click "No thanks, just start my download"
4. Extract the ZIP file
5. Find the file: `mysql-connector-java-8.x.x.jar` (or `mysql-connector-j-8.x.x.jar`)

#### 3.2 Copy to Project
1. In your project folder, create this path if it doesn't exist:
   ```
   e:\Git Hub\Online-Room-Reservation-System\WebContent\WEB-INF\lib\
   ```
2. Copy the `mysql-connector-java-8.x.x.jar` file into the `lib` folder

---

### **STEP 4: Setup Eclipse IDE (10 minutes)**

#### 4.1 Download Eclipse (if you don't have it)
1. Go to: https://www.eclipse.org/downloads/
2. Download "Eclipse IDE for Enterprise Java and Web Developers"
3. Install it

#### 4.2 Import Project into Eclipse
1. Open Eclipse
2. File → Import
3. Select "Existing Projects into Workspace" → Next
4. Click "Browse" next to "Select root directory"
5. Navigate to: `e:\Git Hub\Online-Room-Reservation-System`
6. Click "Select Folder"
7. Make sure your project is checked
8. Click "Finish"

#### 4.3 Configure Project
1. Right-click on your project in Eclipse
2. Properties → Project Facets
3. Check these boxes:
   - ✅ Dynamic Web Module (version 3.1 or 4.0)
   - ✅ Java (version 1.8 or higher)
4. Click "Apply and Close"

#### 4.4 Add Tomcat Server to Eclipse
1. Window → Preferences
2. Server → Runtime Environments
3. Click "Add"
4. Select "Apache Tomcat v9.0" → Next
5. Click "Browse" and select your Tomcat installation folder (e.g., `C:\Program Files\Apache Software Foundation\Tomcat 9.0`)
6. Click "Finish"
7. Click "Apply and Close"

---

### **STEP 5: Run the Application (2 minutes)**

#### 5.1 Start the Server
1. In Eclipse, right-click on your project
2. Run As → Run on Server
3. Select "Tomcat v9.0 Server"
4. Click "Finish"

#### 5.2 Wait for Server to Start
- Watch the Console tab at the bottom
- Wait until you see something like "Server startup in [xxxx] milliseconds"

#### 5.3 Open in Browser
Eclipse should automatically open a browser. If not:
1. Open your web browser (Chrome, Firefox, Edge)
2. Go to: `http://localhost:8080/Online-Room-Reservation-System/`

---

### **STEP 6: Login and Test**

1. You should see the login page
2. Enter:
   - Username: `admin`
   - Password: `admin123`
3. Click "Login"
4. You should see the Dashboard!

---

## 🎉 Success!

If you see the dashboard, congratulations! Your application is running!

You can now:
- ✅ Add new reservations
- ✅ Search for reservations
- ✅ Update reservations
- ✅ Delete reservations (as admin)

---

## ❌ If Something Goes Wrong

### Problem: "Cannot connect to database"
**Solution:**
1. Make sure MySQL service is running (Step 1.1)
2. Check password in `DBConnection.java` matches your MySQL password
3. Make sure database `oceanview_db` exists

### Problem: "ClassNotFoundException: com.mysql.cj.jdbc.Driver"
**Solution:**
1. Make sure you copied the MySQL connector JAR to `WebContent/WEB-INF/lib/`
2. Right-click project in Eclipse → Refresh
3. Right-click project → Maven → Update Project (if using Maven)

### Problem: "404 Not Found"
**Solution:**
1. Check the URL is exactly: `http://localhost:8080/Online-Room-Reservation-System/`
2. Make sure Tomcat started successfully (check Console in Eclipse)
3. Try right-click project → Run As → Run on Server again

### Problem: "Port 8080 already in use"
**Solution:**
1. Close any other applications using port 8080
2. Or change Tomcat port:
   - In Eclipse: Servers tab → double-click Tomcat server
   - Change HTTP/1.1 port from 8080 to 8081
   - Save and restart server
   - Use URL: `http://localhost:8081/Online-Room-Reservation-System/`

---

## 📞 Need More Help?

If you're stuck on any step, let me know which step number you're on and what error message you see!
