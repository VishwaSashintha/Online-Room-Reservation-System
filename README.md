# Ocean View Resort - Room Reservation System

## Project Overview
The Ocean View Resort Room Reservation System is a robust, web-based application designed to streamline the management of hotel bookings, guest records, and room availability. Built using an MVC (Model-View-Controller) architecture, the system provides a centralized platform for both administrative and staff-level operations, ensuring efficient data management and a professional user experience.

## Technology Stack
The system is developed using core Java web technologies to ensure stability, performance, and clear architectural separation.
*   **Frontend:** HTML5, CSS3, Vanilla JavaScript, JavaServer Pages (JSP)
*   **Backend:** Java Servlets (Controller layer)
*   **Service Layer:** Distributed Service Architecture using RESTful API communication
*   **Database:** MySQL (Relational Database Management)
*   **Connectivity:** JDBC (Java Database Connectivity)
*   **Server:** Apache Tomcat 9.0+

## Features
*   **User Authentication & Authorization:** Secure login system with role-based access control (RBAC) distinguishing between Administrator and Staff privileges.
*   **Reservation Management:** Full CRUD (Create, Read, Update, Delete) operations for managing guest bookings.
*   **Dynamic Bill Calculation:** Automated real-time calculation of total costs based on room type, duration of stay, and seasonal rates.
*   **Room Availability Tracking:** Real-time monitoring of room occupancy to prevent double-booking and ensure accurate scheduling.
*   **User Management:** Centralized dashboard for administrators to manage system users and staff accounts.
*   **Data Validation:** Comprehensive client-side and server-side validation to ensure data integrity and prevent erroneous entries.

## Project Structure
```text
Online-Room-Reservation-System/
├── src/
│   ├── controller/      # Servlet classes for request handling
│   ├── dao/             # Data Access Objects and API Clients
│   ├── model/           # Data models (POJOs)
│   └── service/         # Business logic and service orchestration
├── WebContent/
│   ├── css/             # Stylesheets (Vanilla CSS)
│   ├── js/              # Client-side scripts and validation
│   ├── includes/        # Reusable JSP components (Header, Sidebar)
│   ├── WEB-INF/         # Configuration and protected resources
│   └── *.jsp            # User interface pages
├── database/            # SQL scripts for database initialization
└── README.md            # Project documentation
```

## Database Setup
1.  Ensure **MySQL Server** is installed and running on your local machine.
2.  Create a new database named `oceanview_db`.
3.  Execute the `database/schema.sql` script to create the necessary tables and populate initial data.
    ```sql
    source database/schema.sql;
    ```
4.  Configure the database credentials in `src/dao/DBConnection.java` (or equivalent configuration file) to match your local environment.

## How to Run the Project
1.  **Clone the Repository:** Download the source code to your local development environment.
2.  **JDK Setup:** Ensure JDK 8 or higher is installed.
3.  **Servlet Container:** Set up **Apache Tomcat 9.0** or a compatible version.
4.  **Deployment:**
    *   Import the project into an IDE (e.g., Eclipse or IntelliJ) as a Dynamic Web Project.
    *   Add the `mysql-connector-java.jar` to the project's library path.
    *   Build and deploy the project to the Tomcat server.
5.  **Access:** Open a web browser and navigate to `http://localhost:8080/Online-Room-Reservation-System/`.

## Default Login Credentials
*   **Administrator Account:**
    *   Username: `admin`
    *   Password: `admin123`
*   **Staff Account:**
    *   Username: `staff`
    *   Password: `staff123`

## Security Implementation
The system prioritizes data security through several implementation layers:
*   **SQL Injection Prevention:** Utilization of `PreparedStatement` for all database interactions to ensure parameterized queries.
*   **Session Management:** Secure HTTP session handling with automatic timeout and server-side validation on every protected route.
*   **Access Control:** Strict role-based authorization implemented at the Servlet level to restrict sensitive actions (e.g., deletion) to authorized personnel only.
*   **Input Sanitization:** Rigorous escaping and validation of user input to prevent Cross-Site Scripting (XSS) and other common web vulnerabilities.

## Testing Summary
The application has undergone comprehensive testing to ensure reliability:
*   **Unit Testing:** Verification of individual service methods and data access logic.
*   **Integration Testing:** Validation of the interaction between the Controller, Service, and Data layers.
*   **System Testing:** End-to-end verification of user workflows, including authentication, reservation creation, and reporting.
*   **Validation Testing:** Stress testing of form inputs and edge-case date ranges to ensure robust error handling.

## Project Information
*   **Project Name:** Ocean View Resort Management System
*   **Version:** 1.0.0
*   **Submission Date:** March 2026
*   **Institution:** University Submission