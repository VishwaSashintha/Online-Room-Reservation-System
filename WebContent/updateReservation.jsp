<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.Reservation" %>
        <% // Check if user is logged in if (session==null || session.getAttribute("user")==null) {
            response.sendRedirect("login.jsp"); return; } String username=(String) session.getAttribute("username");
            String role=(String) session.getAttribute("role"); String errorMessage=(String)
            request.getAttribute("errorMessage"); String successMessage=(String) request.getAttribute("successMessage");
            Reservation reservation=(Reservation) request.getAttribute("reservation"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Update Reservation - Ocean View Resort</title>
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
                        <li><a href="addReservation.jsp">➕ Add Reservation</a></li>
                        <li><a href="searchReservation.jsp">🔍 Search Reservation</a></li>
                        <li><a href="updateReservation.jsp" class="active">✏️ Update Reservation</a></li>
                        <% if ("ADMIN".equals(role)) { %>
                            <li><a href="deleteReservation.jsp">❌ Delete Reservation</a></li>
                            <% } %>
                                <li><a href="help.jsp">📖 Help</a></li>
                    </ul>
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="content-header">
                        <h2>Update Reservation</h2>
                        <p>Modify existing reservation details</p>
                    </div>

                    <% if (reservation==null) { %>
                        <!-- Search Form -->
                        <div class="card">
                            <% if (errorMessage !=null) { %>
                                <div class="alert alert-error">
                                    <%= errorMessage %>
                                </div>
                                <% } %>

                                    <form action="UpdateReservationServlet" method="get">
                                        <input type="hidden" name="action" value="load">
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="reservationId">Reservation ID *</label>
                                                <input type="number" id="reservationId" name="reservationId"
                                                    placeholder="Enter reservation ID to update" required>
                                            </div>
                                        </div>

                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary">Load Reservation</button>
                                            <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                                        </div>
                                    </form>
                        </div>
                        <% } else { %>
                            <!-- Update Form -->
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

                                                <form action="UpdateReservationServlet" method="post"
                                                    onsubmit="return validateReservationForm(event)">
                                                    <div class="form-row">
                                                        <div class="form-group">
                                                            <label for="reservationId">Reservation ID *</label>
                                                            <input type="number" id="reservationId" name="reservationId"
                                                                value="<%= reservation.getReservationId() %>" readonly
                                                                style="background-color: var(--light-bg);">
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="guestName">Guest Name *</label>
                                                            <input type="text" id="guestName" name="guestName"
                                                                value="<%= reservation.getGuestName() %>" required>
                                                        </div>
                                                    </div>

                                                    <div class="form-row">
                                                        <div class="form-group">
                                                            <label for="address">Address *</label>
                                                            <input type="text" id="address" name="address"
                                                                value="<%= reservation.getAddress() %>" required>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="contact">Contact Number *</label>
                                                            <input type="text" id="contact" name="contact"
                                                                value="<%= reservation.getContact() %>" maxlength="10"
                                                                required>
                                                            <small id="contactError" style="display: none;"></small>
                                                        </div>
                                                    </div>

                                                    <div class="form-row">
                                                        <div class="form-group">
                                                            <label for="roomType">Room Type *</label>
                                                            <select id="roomType" name="roomType" required>
                                                                <option value="Standard" <%="Standard"
                                                                    .equals(reservation.getRoomType()) ? "selected" : ""
                                                                    %>>Standard - LKR 8,000/night</option>
                                                                <option value="Deluxe" <%="Deluxe"
                                                                    .equals(reservation.getRoomType()) ? "selected" : ""
                                                                    %>>Deluxe - LKR 12,000/night</option>
                                                                <option value="Suite" <%="Suite"
                                                                    .equals(reservation.getRoomType()) ? "selected" : ""
                                                                    %>>Suite - LKR 20,000/night</option>
                                                            </select>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="checkIn">Check-in Date *</label>
                                                            <input type="date" id="checkIn" name="checkIn"
                                                                value="<%= reservation.getCheckIn() %>" required>
                                                        </div>
                                                    </div>

                                                    <div class="form-row">
                                                        <div class="form-group">
                                                            <label for="checkOut">Check-out Date *</label>
                                                            <input type="date" id="checkOut" name="checkOut"
                                                                value="<%= reservation.getCheckOut() %>" required>
                                                            <small id="dateError" style="display: none;"></small>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="totalBill">Total Bill (LKR) *</label>
                                                            <input type="number" id="totalBill" name="totalBill"
                                                                value="<%= reservation.getTotalBill() %>" step="0.01"
                                                                readonly
                                                                style="background-color: var(--light-bg); font-weight: 600; color: var(--accent-orange);">
                                                        </div>
                                                    </div>

                                                    <!-- Billing Summary -->
                                                    <div id="billingSummary" class="billing-summary"
                                                        style="display: none;">
                                                        <!-- Will be populated by JavaScript -->
                                                    </div>

                                                    <div class="form-actions">
                                                        <button type="submit" class="btn btn-success">Update
                                                            Reservation</button>
                                                        <a href="updateReservation.jsp" class="btn btn-secondary">Load
                                                            Another</a>
                                                        <a href="dashboard.jsp" class="btn"
                                                            style="background: var(--text-light); color: var(--white);">Cancel</a>
                                                    </div>
                                                </form>
                            </div>
                            <% } %>

                                <!-- Footer -->
                                <div class="footer">
                                    © 2026 Ocean View Resort | Galle
                                </div>
                </div>

                <script src="js/validation.js"></script>
                <% if (reservation !=null) { %>
                    <script>
                        // Trigger initial bill calculation on page load
                        window.addEventListener('load', function () {
                            calculateBill();
                        });
                    </script>
                    <% } %>
            </body>

            </html>