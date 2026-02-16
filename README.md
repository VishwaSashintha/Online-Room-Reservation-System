# 🏨 Ocean View Resort - Reservation Management System

## Project Overview

A fully functional web-based Hotel Reservation Management System built using **HTML, CSS, Vanilla JavaScript, Java Servlets, JSP, JDBC, and MySQL**. This system is designed for Ocean View Resort in Galle, providing a professional, user-friendly interface for managing hotel room reservations.

---

## 📋 Table of Contents

1. [Technology Stack](#technology-stack)
2. [Features](#features)
3. [Design Philosophy](#design-philosophy)
4. [Project Structure](#project-structure)
5. [Database Setup](#database-setup)
6. [Deployment Instructions](#deployment-instructions)
7. [User Guide](#user-guide)
8. [Security Features](#security-features)
9. [Testing](#testing)
10. [Design Rationale](#design-rationale)

---

## 🛠 Technology Stack

### Frontend
- **HTML5** - Structure and semantic markup
- **CSS3** - Styling with custom design system
- **Vanilla JavaScript** - Client-side validation and interactivity
- **JSP (JavaServer Pages)** - Dynamic page generation

### Backend
- **Java Servlets** - Controller layer (MVC pattern)
- **JDBC** - Database connectivity
- **Plain Java** - Business logic and data access

### Database
- **MySQL** - Relational database management

### Server
- **Apache Tomcat** - Servlet container

### Architecture
- **MVC-like Pattern** - Clean separation of concerns
  - **Model**: User.java, Reservation.java
  - **View**: JSP pages
  - **Controller**: Servlet classes
  - **DAO**: Database access layer

---

## ✨ Features

### Core Functionality
1. **User Authentication**
   - Secure login system
   - Role-based access control (Admin/Staff)
   - Session management with 30-minute timeout
   - Automatic session invalidation on logout

2. **Reservation Management**
   - Add new reservations
   - Search reservations by ID
   - Update existing reservations
   - Delete reservations (Admin only)

3. **Automatic Bill Calculation**
   - Real-time calculation based on room type and dates
   - Room rates:
     - Standard: LKR 8,000/night
     - Deluxe: LKR 12,000/night
     - Suite: LKR 20,000/night
   - Visual billing summary display

4. **Double Booking Prevention**
   - Automatic detection of overlapping reservations
   - Database-level validation
   - User-friendly error messages

5. **Comprehensive Validation**
   - Client-side JavaScript validation
   - Server-side servlet validation
   - Contact number format validation (10 digits)
   - Date range validation
   - Required field validation

6. **Dashboard & Analytics**
   - Total reservations count
   - Active bookings count
   - Room types available
   - Quick action buttons

7. **Help System**
   - Interactive accordion-style help documentation
   - Step-by-step guides
   - Troubleshooting section

---

## 🎨 Design Philosophy

### Color Theme Rationale

The system uses a carefully selected color palette designed specifically for a beach hotel in Galle:

- **Primary Deep Ocean Blue (#0A3D62)**: Represents trust, professionalism, and the ocean
- **Secondary Blue (#1B6CA8)**: Provides visual hierarchy and brand consistency
- **Accent Orange (#F39C12)**: Highlights call-to-action elements and important information
- **Success Green (#27AE60)**: Indicates successful operations
- **Error Red (#E74C3C)**: Alerts users to errors and warnings
- **Light Background (#F4F8FB)**: Creates a clean, professional workspace

**Why This Theme?**
- **Blue** builds trust and reliability, essential for hospitality
- **Orange** creates urgency and draws attention to booking actions
- **High contrast** improves usability and accessibility
- **Professional appearance** reflects the quality of the resort

### UX Principles Applied

1. **Clarity**: Clear labels, intuitive navigation, obvious actions
2. **Consistency**: Uniform design patterns across all pages
3. **Feedback**: Immediate visual feedback for all user actions
4. **Error Prevention**: Validation before submission, confirmation dialogs
5. **Efficiency**: Quick actions, auto-calculation, pre-filled forms
6. **Accessibility**: Large touch targets, readable fonts, color contrast

---

## 📁 Project Structure

```
Online-Room-Reservation-System/
│
├── src/
│   ├── controller/
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── AddReservationServlet.java
│   │   ├── SearchReservationServlet.java
│   │   ├── UpdateReservationServlet.java
│   │   └── DeleteReservationServlet.java
│   │
│   ├── dao/
│   │   ├── DBConnection.java
│   │   ├── UserDAO.java
│   │   └── ReservationDAO.java
│   │
│   └── model/
│       ├── User.java
│       └── Reservation.java
│
├── WebContent/
│   ├── css/
│   │   └── style.css
│   │
│   ├── js/
│   │   └── validation.js
│   │
│   ├── WEB-INF/
│   │   └── web.xml
│   │
│   ├── login.jsp
│   ├── dashboard.jsp
│   ├── addReservation.jsp
│   ├── searchReservation.jsp
│   ├── updateReservation.jsp
│   ├── deleteReservation.jsp
│   ├── help.jsp
│   └── error.jsp
│
└── database/
    └── schema.sql
```

---

## 🗄 Database Setup

### Prerequisites
- MySQL Server installed and running
- MySQL user with database creation privileges

### Setup Steps

1. **Start MySQL Server**
   ```bash
   # Windows
   net start MySQL80
   
   # Linux/Mac
   sudo systemctl start mysql
   ```

2. **Access MySQL**
   ```bash
   mysql -u root -p
   ```

3. **Run Database Schema**
   ```sql
   source /path/to/database/schema.sql
   ```
   
   Or manually execute the schema.sql file contents.

4. **Verify Database Creation**
   ```sql
   USE oceanview_db;
   SHOW TABLES;
   SELECT * FROM users;
   ```

### Database Configuration

Update database credentials in `src/dao/DBConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/oceanview_db";
private static final String USERNAME = "root";
private static final String PASSWORD = "your_password_here";
```

---

## 🚀 Deployment Instructions

### Prerequisites
1. **JDK 8 or higher** installed
2. **Apache Tomcat 9.x** installed
3. **MySQL Server** running
4. **MySQL JDBC Driver** (mysql-connector-java-8.x.jar)

### Step-by-Step Deployment

#### 1. Setup Database
Follow the [Database Setup](#database-setup) section above.

#### 2. Add MySQL JDBC Driver
- Download MySQL Connector/J from [MySQL website](https://dev.mysql.com/downloads/connector/j/)
- Copy `mysql-connector-java-8.x.jar` to:
  - `WebContent/WEB-INF/lib/` (create lib folder if it doesn't exist)
  - OR Tomcat's `lib` folder: `TOMCAT_HOME/lib/`

#### 3. Compile Java Files

**Option A: Using IDE (Eclipse/IntelliJ)**
1. Import project as "Dynamic Web Project"
2. Configure build path to include MySQL JDBC driver
3. Build project (automatic compilation)

**Option B: Using Command Line**
```bash
# Navigate to project directory
cd Online-Room-Reservation-System

# Compile all Java files
javac -cp "path/to/mysql-connector.jar;path/to/servlet-api.jar" -d WebContent/WEB-INF/classes src/**/*.java
```

#### 4. Create WAR File (Optional)

**Using Eclipse:**
1. Right-click project → Export
2. Select "WAR file"
3. Choose destination
4. Click Finish

**Using Command Line:**
```bash
jar -cvf oceanview.war -C WebContent/ .
```

#### 5. Deploy to Tomcat

**Option A: Copy to webapps**
```bash
# Copy entire project folder or WAR file
cp -r Online-Room-Reservation-System TOMCAT_HOME/webapps/
# OR
cp oceanview.war TOMCAT_HOME/webapps/
```

**Option B: Using Tomcat Manager**
1. Access Tomcat Manager: `http://localhost:8080/manager`
2. Use "Deploy" section
3. Upload WAR file or specify path

#### 6. Start Tomcat
```bash
# Windows
TOMCAT_HOME\bin\startup.bat

# Linux/Mac
TOMCAT_HOME/bin/startup.sh
```

#### 7. Access Application
Open browser and navigate to:
```
http://localhost:8080/Online-Room-Reservation-System/
```

### Default Login Credentials

**Admin Account:**
- Username: `admin`
- Password: `admin123`

**Staff Account:**
- Username: `staff`
- Password: `staff123`

---

## 📖 User Guide

### Login
1. Navigate to the application URL
2. Enter username and password
3. Click "Login"

### Add Reservation
1. Click "Add Reservation" from sidebar
2. Fill in all required fields
3. Select room type and dates
4. System automatically calculates total bill
5. Click "Add Reservation"

### Search Reservation
1. Click "Search Reservation"
2. Enter Reservation ID
3. Click "Search"
4. View detailed reservation information

### Update Reservation
1. Click "Update Reservation"
2. Enter Reservation ID and click "Load Reservation"
3. Modify fields as needed
4. Bill recalculates automatically
5. Click "Update Reservation"

### Delete Reservation (Admin Only)
1. Click "Delete Reservation"
2. Enter Reservation ID and click "Load Reservation"
3. Review reservation details
4. Click "Confirm Delete"
5. Confirm in popup dialog

---

## 🔒 Security Features

### 1. SQL Injection Prevention
- All database queries use `PreparedStatement`
- User input is parameterized, never concatenated
- Example:
  ```java
  String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
  pstmt = conn.prepareStatement(sql);
  pstmt.setString(1, username);
  pstmt.setString(2, password);
  ```

### 2. Session Management
- 30-minute session timeout
- Session invalidation on logout
- Session validation on every protected page
- Automatic redirect to login if session expired

### 3. Role-Based Access Control
- Admin: Full access including delete
- Staff: Cannot access delete functionality
- Server-side role validation in servlets

### 4. Input Validation
- **Client-side**: JavaScript validation for immediate feedback
- **Server-side**: Servlet validation as final security layer
- Both layers validate:
  - Required fields
  - Data types
  - Format (contact numbers, dates)
  - Business rules (date ranges, unique IDs)

### 5. Error Handling
- Try-catch blocks in all database operations
- Custom error page for exceptions
- User-friendly error messages (no stack traces exposed)
- Proper resource cleanup (connections, statements, result sets)

---

## 🧪 Testing

### Test Scenarios

#### 1. Valid Login Test
- **Input**: Correct username and password
- **Expected**: Redirect to dashboard
- **Actual**: ✓ Pass

#### 2. Invalid Login Test
- **Input**: Incorrect credentials
- **Expected**: Error message displayed
- **Actual**: ✓ Pass

#### 3. Add Reservation Test
- **Input**: All valid reservation data
- **Expected**: Reservation added successfully
- **Actual**: ✓ Pass

#### 4. Overlapping Booking Prevention Test
- **Setup**: Existing reservation for Deluxe room (Feb 20-23)
- **Input**: New reservation for Deluxe room (Feb 21-24)
- **Expected**: Error message "Room already booked"
- **Actual**: ✓ Pass

#### 5. Update Reservation Test
- **Input**: Modified guest name and dates
- **Expected**: Reservation updated, bill recalculated
- **Actual**: ✓ Pass

#### 6. Delete Reservation Test (Admin)
- **Input**: Valid reservation ID
- **Expected**: Reservation deleted after confirmation
- **Actual**: ✓ Pass

#### 7. Delete Reservation Test (Staff)
- **Input**: Staff user attempts to access delete page
- **Expected**: Access denied error
- **Actual**: ✓ Pass

#### 8. Session Expiration Test
- **Setup**: Wait 30+ minutes of inactivity
- **Expected**: Redirect to login page
- **Actual**: ✓ Pass

#### 9. Contact Validation Test
- **Input**: Contact number with letters or wrong length
- **Expected**: Validation error
- **Actual**: ✓ Pass

#### 10. Date Validation Test
- **Input**: Check-out date before check-in date
- **Expected**: Validation error
- **Actual**: ✓ Pass

---

## 💡 Design Rationale

### Why No Frameworks?

**Requirement**: Build using only core technologies without frameworks.

**Benefits of This Approach**:
1. **Educational Value**: Demonstrates deep understanding of fundamentals
2. **Full Control**: Complete control over every aspect of the application
3. **Lightweight**: No framework overhead, faster load times
4. **Transparency**: Clear understanding of how everything works
5. **Deployment Simplicity**: Minimal dependencies, easier deployment

**Challenges Addressed**:
- Manual session management (solved with servlet filters and session checks)
- Manual routing (solved with servlet URL patterns)
- Manual validation (solved with reusable JavaScript functions)
- Manual database connection management (solved with DAO pattern)

### Why This Color Theme?

The blue + orange combination was specifically chosen for:

1. **Trust & Reliability** (Blue): Hotels need to convey trustworthiness
2. **Action & Urgency** (Orange): Encourages booking actions
3. **Professional Appearance**: Suitable for business operations
4. **Brand Identity**: Memorable and distinctive
5. **Accessibility**: High contrast ratios for readability

### How Usability Principles Were Applied

1. **Consistency**: Same header, sidebar, and footer on all pages
2. **Feedback**: Success/error messages for every action
3. **Error Prevention**: Validation before submission, confirmation dialogs
4. **Recognition Over Recall**: Icons + text labels, visible navigation
5. **Flexibility**: Responsive design for different screen sizes
6. **Aesthetic & Minimalist**: Clean design, no unnecessary elements

### How Security Was Implemented

1. **Defense in Depth**: Multiple layers (client + server validation)
2. **Least Privilege**: Role-based access control
3. **Secure by Default**: Sessions expire, connections close
4. **Input Validation**: Never trust user input
5. **Error Handling**: Graceful failures, no information leakage

### How Double Booking Prevention Works

**Algorithm**:
```sql
SELECT COUNT(*) FROM reservations 
WHERE room_type = ? AND (
  (check_in <= ? AND check_out > ?) OR
  (check_in < ? AND check_out >= ?) OR
  (check_in >= ? AND check_out <= ?)
)
```

**Logic**:
- Checks for any overlapping date ranges
- Covers all possible overlap scenarios:
  1. Existing reservation starts before and ends during new reservation
  2. Existing reservation starts during and ends after new reservation
  3. Existing reservation is completely within new reservation
- Returns count > 0 if overlap exists
- Prevents insertion if overlap detected

### How MVC Architecture Improves Maintainability

**Separation of Concerns**:
- **Model** (model/): Pure data objects, no business logic
- **View** (JSP): Presentation only, minimal logic
- **Controller** (controller/): Request handling, business logic orchestration
- **DAO** (dao/): Database operations isolated

**Benefits**:
1. **Easier Testing**: Each layer can be tested independently
2. **Code Reusability**: DAOs used by multiple servlets
3. **Easier Maintenance**: Changes in one layer don't affect others
4. **Team Collaboration**: Different developers can work on different layers
5. **Scalability**: Easy to add new features following same pattern

---

## 📝 Additional Notes

### Production Deployment Considerations

For production deployment, consider:

1. **Password Hashing**: Implement bcrypt or similar for password storage
2. **HTTPS**: Use SSL/TLS certificates
3. **Connection Pooling**: Implement database connection pooling (e.g., HikariCP)
4. **Logging**: Add comprehensive logging (e.g., Log4j)
5. **Configuration**: Externalize configuration (properties files)
6. **Backup**: Regular database backups
7. **Monitoring**: Application and server monitoring
8. **Load Balancing**: For high traffic scenarios

### Future Enhancements

Potential features for future versions:
- Email notifications for bookings
- Payment gateway integration
- Room availability calendar view
- Guest history tracking
- Reporting and analytics
- Multi-language support
- Mobile app version

---

## 👨‍💻 Developer Information

**System Name**: Ocean View Resort - Reservation Management System  
**Version**: 1.0  
**Architecture**: MVC Pattern  
**Database**: MySQL  
**Server**: Apache Tomcat  
**Build Tool**: Manual compilation or IDE  

---

## 📄 License

This project is created for educational purposes as part of a university assignment demonstrating proficiency in Java web development without frameworks.

---

## 🙏 Acknowledgments

- Ocean View Resort, Galle (Conceptual Client)
- Java Servlet API Documentation
- MySQL Documentation
- Web Design Best Practices

---

**© 2026 Ocean View Resort | Galle, Sri Lanka**