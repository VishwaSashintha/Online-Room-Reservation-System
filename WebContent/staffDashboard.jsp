<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); String role=user.getRole(); if ("ADMIN".equals(role)) {
            response.sendRedirect("adminDashboard.jsp"); return; } boolean isAdmin=false; %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Staff Dashboard - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <jsp:include page="includes/header.jsp" />
                <div class="dashboard-wrapper">
                    <jsp:include page="includes/sidebar.jsp" />
                    <div class="main-content">
                        <div class="content-header">
                            <h2>Staff Dashboard</h2>
                            <p>Welcome, managing daily operations</p>
                        </div>
                        <div class="summary-cards">
                            <div class="summary-card orange-border">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Active Bookings</h4>
                                        <div class="number">18</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                            <div class="summary-card green-border">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Today's Check-ins</h4>
                                        <div class="number">5</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                            <div class="summary-card">
                                <div class="summary-card-content">
                                    <div class="summary-card-info">
                                        <h4>Today's Check-outs</h4>
                                        <div class="number">3</div>
                                    </div>
                                    <div class="summary-card-icon"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3>Operation Quick Actions</h3>
                            </div>
                            <div class="quick-actions">
                                <a href="addReservation.jsp" class="quick-action-btn">
                                    <div class="quick-action-icon"></div>
                                    <div class="quick-action-text">
                                        <strong>New Booking</strong>
                                        <small>Register a guest</small>
                                    </div>
                                </a>
                                <a href="searchReservation.jsp" class="quick-action-btn">
                                    <div class="quick-action-icon"></div>
                                    <div class="quick-action-text">
                                        <strong>Find Guest</strong>
                                        <small>Reservation lookup</small>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h3>Room Availability Overview</h3>
                            </div>
                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-label">Standard</div>
                                    <div class="info-value">12 Available</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Deluxe</div>
                                    <div class="info-value">8 Available</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-label">Suite</div>
                                    <div class="info-value">3 Available</div>
                                </div>
                            </div>
                            <div style="margin-top: 20px;">
                                <a href="roomAvailability.jsp" class="btn btn-secondary">View Detail Calendar</a>
                            </div>
                        </div>
                    </div>
                </div>
            </body>

            </html>