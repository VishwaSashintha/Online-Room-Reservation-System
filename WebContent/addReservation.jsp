<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% // Check if user is logged in if (session==null || session.getAttribute("user")==null) {
        response.sendRedirect("login.jsp"); return; } String username=(String) session.getAttribute("username"); String
        role=(String) session.getAttribute("role"); String errorMessage=(String) request.getAttribute("errorMessage");
        String successMessage=(String) request.getAttribute("successMessage"); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Reservation - Ocean View Resort</title>
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
                    <li><a href="dashboard.jsp">📊 Dashboard</a></li>
                    <li><a href="addReservation.jsp" class="active">➕ Add Reservation</a></li>
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
                    <h2>Add New Reservation</h2>
                    <p>Create a new room reservation</p>
                </div>

                <div class="card">
                    <% if (errorMessage !=null) { %>
                        <div class="alert alert-error">
                            <%= errorMessage %>
                        </div>
                        <% } %>

                            <% if (successMessage !=null) { %>
                                <div class="alert alert-success">
                                    <%= successMessage %>
                                </div>
                                <% } %>

                                    <div id="formError" style="display: none;"></div>

                                    <form action="AddReservationServlet" method="post"
                                        onsubmit="return validateReservationForm(event)">
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="reservationId">Reservation ID *</label>
                                                <input type="number" id="reservationId" name="reservationId"
                                                    placeholder="Enter unique reservation ID" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="guestName">Guest Name *</label>
                                                <input type="text" id="guestName" name="guestName"
                                                    placeholder="Enter guest name" required>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="address">Address *</label>
                                                <input type="text" id="address" name="address"
                                                    placeholder="Enter guest address" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="contact">Contact Number *</label>
                                                <input type="text" id="contact" name="contact"
                                                    placeholder="Enter 10-digit contact number" maxlength="10" required>
                                                <small id="contactError" style="display: none;"></small>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="roomType">Room Type *</label>
                                                <select id="roomType" name="roomType" required>
                                                    <option value="">Select room type</option>
                                                    <option value="Standard">Standard - LKR 8,000/night</option>
                                                    <option value="Deluxe">Deluxe - LKR 12,000/night</option>
                                                    <option value="Suite">Suite - LKR 20,000/night</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="checkIn">Check-in Date *</label>
                                                <input type="date" id="checkIn" name="checkIn" required>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="checkOut">Check-out Date *</label>
                                                <input type="date" id="checkOut" name="checkOut" required>
                                                <small id="dateError" style="display: none;"></small>
                                            </div>

                                            <div class="form-group">
                                                <label for="totalBill">Total Bill (LKR) *</label>
                                                <input type="number" id="totalBill" name="totalBill" step="0.01"
                                                    readonly
                                                    style="background-color: var(--light-bg); font-weight: 600; color: var(--accent-orange);">
                                            </div>
                                        </div>

                                        <!-- Billing Summary -->
                                        <div id="billingSummary" class="billing-summary" style="display: none;">
                                            <!-- Will be populated by JavaScript -->
                                        </div>

                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary">Add Reservation</button>
                                            <button type="reset" class="btn btn-secondary">Clear Form</button>
                                            <a href="dashboard.jsp" class="btn"
                                                style="background: var(--text-light); color: var(--white);">Cancel</a>
                                        </div>
                                    </form>
                </div>

                <!-- Footer -->
                <div class="footer">
                    © 2026 Ocean View Resort | Galle
                </div>
            </div>

            <script src="js/validation.js"></script>
        </body>

        </html>