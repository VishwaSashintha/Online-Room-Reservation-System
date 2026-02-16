<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.Reservation" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; }
            String username=(String) session.getAttribute("username"); String role=(String)
            session.getAttribute("role"); if (!"ADMIN".equals(role)) { response.sendRedirect("staffDashboard.jsp");
            return; } String errorMessage=(String) request.getAttribute("errorMessage"); String successMessage=(String)
            request.getAttribute("successMessage"); model.Reservation reservation=(model.Reservation)
            request.getAttribute("reservation"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Delete Reservation - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
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
                <div class="sidebar">
                    <ul class="sidebar-menu">
                        <li><a href="dashboard.jsp">Dashboard</a></li>
                        <li><a href="addReservation.jsp">Add Reservation</a></li>
                        <li><a href="searchReservation.jsp">Search Reservation</a></li>
                        <li><a href="updateReservation.jsp">Update Reservation</a></li>
                        <li><a href="deleteReservation.jsp" class="active">Delete Reservation</a></li>
                        <li><a href="help.jsp">Help</a></li>
                    </ul>
                </div>
                <div class="main-content">
                    <div class="content-header">
                        <h2>Delete Reservation</h2>
                        <p>Remove a reservation from the system (Admin Only)</p>
                    </div>
                    <% if (reservation==null && successMessage==null) { %>
                        <div class="card">
                            <% if (errorMessage !=null) { %>
                                <div class="alert alert-error">
                                    <%= errorMessage %>
                                </div>
                                <% } %>
                                    <div class="alert alert-info">
                                        <strong>Warning:</strong> This action is irreversible. Only administrators
                                        can delete reservations.
                                    </div>
                                    <form action="DeleteReservationServlet" method="get">
                                        <input type="hidden" name="action" value="load">
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="reservationId">Reservation ID *</label>
                                                <input type="number" id="reservationId" name="reservationId"
                                                    placeholder="Enter reservation ID to delete" required>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary">Load Reservation</button>
                                            <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                                        </div>
                                    </form>
                        </div>
                        <% } else if (reservation !=null) { %>
                            <div class="card">
                                <div class="card-header">
                                    <h3>Confirm Deletion</h3>
                                </div>
                                <div class="alert alert-error">
                                    <strong>Warning:</strong> You are about to permanently delete this reservation.
                                    This action cannot be undone!
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
                                                <td><span class="text-orange"
                                                        style="font-size: 18px; font-weight: 700;">LKR <%=
                                                            String.format("%,.2f", reservation.getTotalBill()) %></span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <form action="DeleteReservationServlet" method="post" onsubmit="return confirmDelete()">
                                    <input type="hidden" name="reservationId"
                                        value="<%= reservation.getReservationId() %>">
                                    <div class="form-actions" style="margin-top: 24px;">
                                        <button type="submit" class="btn btn-danger">Confirm Delete</button>
                                        <a href="deleteReservation.jsp" class="btn"
                                            style="background: var(--accent-orange); color: var(--white); font-weight: 600;">Cancel</a>
                                    </div>
                                </form>
                            </div>
                            <% } else if (successMessage !=null) { %>
                                <div class="card">
                                    <div class="alert alert-success">
                                        <%= successMessage %>
                                    </div>
                                    <div class="form-actions">
                                        <a href="deleteReservation.jsp" class="btn btn-primary">Delete Another</a>
                                        <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                                    </div>
                                </div>
                                <% } %>
                                    <div class="footer">
                                        © 2026 Ocean View Resort | Galle
                                    </div>
                </div>
                <script src="js/validation.js"></script>
            </body>

            </html>