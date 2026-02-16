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
                <title>Search Reservation - Ocean View Resort</title>
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
                        <li><a href="searchReservation.jsp" class="active">🔍 Search Reservation</a></li>
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
                        <h2>Search Reservation</h2>
                        <p>Find reservation by ID</p>
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

                                        <form action="SearchReservationServlet" method="post">
                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="reservationId">Reservation ID *</label>
                                                    <input type="number" id="reservationId" name="reservationId"
                                                        placeholder="Enter reservation ID to search" required>
                                                </div>
                                            </div>

                                            <div class="form-actions">
                                                <button type="submit" class="btn btn-primary">Search</button>
                                                <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                                            </div>
                                        </form>
                    </div>

                    <% if (reservation !=null) { %>
                        <div class="card">
                            <div class="card-header">
                                <h3>Reservation Details</h3>
                            </div>

                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>Field</th>
                                            <th>Value</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>Reservation ID</strong></td>
                                            <td>
                                                <%= reservation.getReservationId() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Guest Name</strong></td>
                                            <td>
                                                <%= reservation.getGuestName() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Address</strong></td>
                                            <td>
                                                <%= reservation.getAddress() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Contact Number</strong></td>
                                            <td>
                                                <%= reservation.getContact() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Room Type</strong></td>
                                            <td>
                                                <%= reservation.getRoomType() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Check-in Date</strong></td>
                                            <td>
                                                <%= reservation.getCheckIn() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Check-out Date</strong></td>
                                            <td>
                                                <%= reservation.getCheckOut() %>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>Total Bill</strong></td>
                                            <td><span class="text-orange" style="font-size: 18px; font-weight: 700;">LKR
                                                    <%= String.format("%,.2f", reservation.getTotalBill()) %></span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="form-actions" style="margin-top: 24px;">
                                <a href="updateReservation.jsp?action=load&reservationId=<%= reservation.getReservationId() %>"
                                    class="btn btn-secondary">Edit This Reservation</a>
                                <% if ("ADMIN".equals(role)) { %>
                                    <a href="deleteReservation.jsp?action=load&reservationId=<%= reservation.getReservationId() %>"
                                        class="btn btn-danger">Delete This Reservation</a>
                                    <% } %>
                            </div>
                        </div>
                        <% } %>

                            <!-- Footer -->
                            <div class="footer">
                                © 2026 Ocean View Resort | Galle
                            </div>
                </div>

                <script src="js/validation.js"></script>
            </body>

            </html>