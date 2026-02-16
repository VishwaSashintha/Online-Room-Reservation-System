<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); String role=user.getRole(); if (!"ADMIN".equals(role)) {
            response.sendRedirect("staffDashboard.jsp"); return; } boolean isAdmin=true; %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Admin Dashboard - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <jsp:include page="includes/header.jsp" />
                <div class="dashboard-wrapper">
                    <jsp:include page="includes/sidebar.jsp" />
                    <div class="main-content">
                        <div class="content-header">
                            <h2>Admin Dashboard</h2>
                            <p>System Overview and Management</p>
                        </div>
                        <div class="summary-cards">
                            <div class="summary-card">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Total Reservations</h4>
                                        <div class="number">124</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                            <div class="summary-card orange-border">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Active Bookings</h4>
                                        <div class="number">42</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                            <div class="summary-card green-border">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Available Rooms</h4>
                                        <div class="number">23</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                            <div class="summary-card">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Total Revenue</h4>
                                        <div class="number" style="font-size: 24px;">LKR 842,500</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3>Recent Reservations</h3>
                            </div>
                            <div class="table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Guest Name</th>
                                            <th>Room Type</th>
                                            <th>Check-in</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>#OV-1024</td>
                                            <td>Vishwa Sashintha</td>
                                            <td class="text-blue">Deluxe Suite</td>
                                            <td>2026-02-18</td>
                                            <td><span class="status-badge status-confirmed">Confirmed</span></td>
                                        </tr>
                                        <tr>
                                            <td>#OV-1023</td>
                                            <td>John Doe</td>
                                            <td class="text-blue">Standard</td>
                                            <td>2026-02-17</td>
                                            <td><span class="status-badge status-confirmed">Confirmed</span></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3>Admin Management</h3>
                            </div>
                            <div class="quick-actions">
                                <a href="manageUsers.jsp" class="quick-action-btn">
                                    <div class="quick-action-icon"></div>
                                    <div class="quick-action-text">
                                        <strong>Manage Users</strong>
                                        <small>System access & roles</small>
                                    </div>
                                </a>
                                <a href="reports.jsp" class="quick-action-btn">
                                    <div class="quick-action-icon"></div>
                                    <div class="quick-action-text">
                                        <strong>System Reports</strong>
                                        <small>Revenue & Analytics</small>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </body>

            </html>