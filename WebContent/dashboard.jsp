<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="dao.ReservationDAO" %>
        <% // Check if user is logged in if (session==null || session.getAttribute("user")==null) {
            response.sendRedirect("login.jsp"); return; } String username=(String) session.getAttribute("username");
            String role=(String) session.getAttribute("role"); // Get dashboard statistics ReservationDAO
            reservationDAO=new ReservationDAO(); int totalReservations=reservationDAO.getTotalReservations(); int
            activeBookings=reservationDAO.getActiveBookings(); int roomTypes=3; // Standard, Deluxe, Suite %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <!-- Header -->
                <div class="header">
                    <div class="header-left">
                        <div class="logo">Ocean View Resort</div>
                        <div class="system-name">Reservation Management System</div>
                    </div>
                    <div class="header-right">
                        <div class="user-info">
                            Welcome, <strong>
                                <%= username %>
                            </strong> (<%= role %>)
                        </div>
                        <a href="LogoutServlet" class="btn-logout">Logout</a>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="sidebar">
                    <ul class="sidebar-menu">
                        <li><a href="dashboard.jsp" class="active">📊 Dashboard</a></li>
                        <li><a href="addReservation.jsp">➕ Add Reservation</a></li>
                        <li><a href="searchReservation.jsp">🔍 Search Reservation</a></li>
                        <li><a href="updateReservation.jsp">✏️ Update Reservation</a></li>
                        <% if ("ADMIN".equals(role)) { %>
                            <li><a href="deleteReservation.jsp">❌ Delete Reservation</a></li>
                            <% } %>
                                <li><a href="help.jsp">📖 Help</a></li>
                    </ul>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="content-header">
                        <h2>Dashboard</h2>
                        <p>Welcome to Ocean View Resort Reservation Management System</p>
                    </div>

                    <!-- Summary Cards -->
                    <div class="summary-cards">
                        <div class="summary-card">
                            <div class="summary-card-content">
                                <div class="summary-card-info">
                                    <h4>Total Reservations</h4>
                                    <div class="number">
                                        <%= totalReservations %>
                                    </div>
                                </div>
                                <div class="summary-card-icon">📋</div>
                            </div>
                        </div>

                        <div class="summary-card orange-border">
                            <div class="summary-card-content">
                                <div class="summary-card-info">
                                    <h4>Active Bookings</h4>
                                    <div class="number">
                                        <%= activeBookings %>
                                    </div>
                                </div>
                                <div class="summary-card-icon">🏨</div>
                            </div>
                        </div>

                        <div class="summary-card green-border">
                            <div class="summary-card-content">
                                <div class="summary-card-info">
                                    <h4>Room Types Available</h4>
                                    <div class="number">
                                        <%= roomTypes %>
                                    </div>
                                </div>
                                <div class="summary-card-icon">🛏️</div>
                            </div>
                        </div>
                    </div>

                    <!-- Welcome Card -->
                    <div class="card">
                        <div class="card-header">
                            <h3>Welcome, <%= username %>!</h3>
                        </div>
                        <p>You are logged in as <strong class="text-orange">
                                <%= role %>
                            </strong>.</p>
                        <p>Use the sidebar menu to navigate through the system and manage reservations.</p>

                        <div
                            style="margin-top: 24px; padding: 16px; background: var(--light-bg); border-radius: var(--radius-md);">
                            <h4 style="color: var(--primary-blue); margin-bottom: 12px;">Quick Actions</h4>
                            <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                                <a href="addReservation.jsp" class="btn btn-primary">Add New Reservation</a>
                                <a href="searchReservation.jsp" class="btn btn-secondary">Search Reservation</a>
                            </div>
                        </div>
                    </div>

                    <!-- System Information -->
                    <div class="card">
                        <div class="card-header">
                            <h3>System Information</h3>
                        </div>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px;">
                            <div>
                                <strong style="color: var(--primary-blue);">Room Types:</strong>
                                <ul style="margin-top: 8px; margin-left: 20px;">
                                    <li>Standard - LKR 8,000/night</li>
                                    <li>Deluxe - LKR 12,000/night</li>
                                    <li>Suite - LKR 20,000/night</li>
                                </ul>
                            </div>
                            <div>
                                <strong style="color: var(--primary-blue);">Features:</strong>
                                <ul style="margin-top: 8px; margin-left: 20px;">
                                    <li>Automatic bill calculation</li>
                                    <li>Double booking prevention</li>
                                    <li>Role-based access control</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="footer">
                        © 2026 Ocean View Resort | Galle
                    </div>
                </div>

                <script src="js/validation.js"></script>
            </body>

            </html>