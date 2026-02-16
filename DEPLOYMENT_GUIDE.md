# Quick Start Guide - Ocean View Resort System

## 🚀 Quick Setup (5 Minutes)

### Step 1: Database Setup
1. Open MySQL Command Line or MySQL Workbench
2. Run the following commands:
```sql
CREATE DATABASE oceanview_db;
USE oceanview_db;
```
3. Execute the `database/schema.sql` file

### Step 2: Configure Database Connection
1. Open `src/dao/DBConnection.java`
2. Update these lines with your MySQL credentials:
```java
private static final String PASSWORD = "your_mysql_password";
```

### Step 3: Add MySQL JDBC Driver
1. Download MySQL Connector/J: https://dev.mysql.com/downloads/connector/j/
2. Create folder: `WebContent/WEB-INF/lib/`
3. Copy `mysql-connector-java-8.x.jar` into the lib folder

### Step 4: Deploy to Tomcat

**Using Eclipse:**
1. Right-click project → Run As → Run on Server
2. Select Apache Tomcat
3. Click Finish

**Manual Deployment:**
1. Copy entire project folder to `TOMCAT_HOME/webapps/`
2. Start Tomcat: `TOMCAT_HOME/bin/startup.bat` (Windows) or `startup.sh` (Linux/Mac)

### Step 5: Access Application
Open browser: `http://localhost:8080/Online-Room-Reservation-System/`

**Login Credentials:**
- Admin: `admin` / `admin123`
- Staff: `staff` / `staff123`

---

## 📦 What's Included

### Backend (Java)
- ✅ 6 Servlets (Login, Logout, Add, Search, Update, Delete)
- ✅ 3 DAO Classes (DBConnection, UserDAO, ReservationDAO)
- ✅ 2 Model Classes (User, Reservation)

### Frontend (JSP + CSS + JS)
- ✅ 8 JSP Pages (Login, Dashboard, Add, Search, Update, Delete, Help, Error)
- ✅ Professional CSS with exact color theme
- ✅ JavaScript validation and bill calculation

### Features
- ✅ Role-based access (Admin/Staff)
- ✅ Session management (30-min timeout)
- ✅ Double booking prevention
- ✅ Automatic bill calculation
- ✅ Client & server validation
- ✅ Responsive design

---

## 🎯 Testing the System

### Test 1: Login
1. Go to login page
2. Enter: `admin` / `admin123`
3. Should redirect to dashboard

### Test 2: Add Reservation
1. Click "Add Reservation"
2. Fill form:
   - Reservation ID: 2001
   - Guest Name: Test Guest
   - Address: Test Address
   - Contact: 0771234567
   - Room Type: Deluxe
   - Check-in: Tomorrow's date
   - Check-out: 3 days from tomorrow
3. Bill should auto-calculate
4. Click "Add Reservation"
5. Should show success message

### Test 3: Search Reservation
1. Click "Search Reservation"
2. Enter ID: 2001
3. Should display reservation details

### Test 4: Double Booking Prevention
1. Try adding another Deluxe room reservation with overlapping dates
2. Should show error: "Room already booked"

### Test 5: Role-Based Access
1. Logout
2. Login as: `staff` / `staff123`
3. "Delete Reservation" should NOT appear in sidebar

---

## ⚠️ Common Issues & Solutions

### Issue: "Cannot connect to database"
**Solution:** 
- Check MySQL is running: `net start MySQL80`
- Verify credentials in `DBConnection.java`
- Ensure database `oceanview_db` exists

### Issue: "ClassNotFoundException: com.mysql.cj.jdbc.Driver"
**Solution:** 
- Add MySQL JDBC driver to `WebContent/WEB-INF/lib/`
- Restart Tomcat

### Issue: "404 Not Found"
**Solution:** 
- Check project is deployed in Tomcat webapps
- Verify URL: `http://localhost:8080/Online-Room-Reservation-System/`
- Check Tomcat is running on port 8080

### Issue: "Session expired" immediately
**Solution:** 
- Clear browser cookies
- Restart Tomcat server

---

## 📊 System Architecture

```
┌─────────────────────────────────────────────┐
│           Browser (User Interface)          │
│  HTML + CSS + JavaScript (Client-side)      │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│         JSP Pages (View Layer)              │
│  login.jsp, dashboard.jsp, etc.             │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│      Servlets (Controller Layer)            │
│  LoginServlet, AddReservationServlet, etc.  │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│         DAO Layer (Data Access)             │
│  UserDAO, ReservationDAO, DBConnection      │
└─────────────────┬───────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────┐
│         MySQL Database                      │
│  oceanview_db (users, reservations)         │
└─────────────────────────────────────────────┘
```

---

## 🎨 Color Theme Reference

```css
--primary-blue: #0A3D62      /* Headers, titles */
--secondary-blue: #1B6CA8    /* Links, buttons */
--accent-orange: #F39C12     /* CTAs, highlights */
--light-bg: #F4F8FB          /* Page background */
--success-green: #27AE60     /* Success messages */
--error-red: #E74C3C         /* Error messages */
```

---

## 📝 File Checklist

Before deployment, ensure these files exist:

**Backend:**
- [ ] src/controller/LoginServlet.java
- [ ] src/controller/LogoutServlet.java
- [ ] src/controller/AddReservationServlet.java
- [ ] src/controller/SearchReservationServlet.java
- [ ] src/controller/UpdateReservationServlet.java
- [ ] src/controller/DeleteReservationServlet.java
- [ ] src/dao/DBConnection.java
- [ ] src/dao/UserDAO.java
- [ ] src/dao/ReservationDAO.java
- [ ] src/model/User.java
- [ ] src/model/Reservation.java

**Frontend:**
- [ ] WebContent/css/style.css
- [ ] WebContent/js/validation.js
- [ ] WebContent/login.jsp
- [ ] WebContent/dashboard.jsp
- [ ] WebContent/addReservation.jsp
- [ ] WebContent/searchReservation.jsp
- [ ] WebContent/updateReservation.jsp
- [ ] WebContent/deleteReservation.jsp
- [ ] WebContent/help.jsp
- [ ] WebContent/error.jsp
- [ ] WebContent/WEB-INF/web.xml

**Database:**
- [ ] database/schema.sql

**Dependencies:**
- [ ] WebContent/WEB-INF/lib/mysql-connector-java-8.x.jar

---

## 🔧 Development Tools

**Recommended IDE:**
- Eclipse IDE for Enterprise Java Developers
- IntelliJ IDEA Ultimate

**Required Software:**
- JDK 8 or higher
- Apache Tomcat 9.x
- MySQL Server 8.x
- MySQL JDBC Driver 8.x

---

## 📞 Support

For issues or questions:
1. Check the Help page in the application
2. Review README.md for detailed documentation
3. Check common issues section above

---

**Ready to go! 🚀**
