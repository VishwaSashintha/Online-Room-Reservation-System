<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.Reservation" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; }
            String username=(String) session.getAttribute("username"); String role=(String)
            session.getAttribute("role"); String errorMessage=(String) request.getAttribute("errorMessage"); String
            successMessage=(String) request.getAttribute("successMessage"); model.Reservation
            reservation=(model.Reservation) request.getAttribute("reservation"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Search Reservation - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <jsp:include page="includes/header.jsp" />
                <div class="dashboard-wrapper">
                    <jsp:include page="includes/sidebar.jsp" />
                    <div class="main-content">
                        <div class="content-header">
                            <h2>Search Reservation</h2>
                            <p>Find existing bookings by ID</p>
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
                                            <form action="SearchReservationServlet" method="get">
                                                <div class="form-row">
                                                    <div class="form-group" style="flex: 1;">
                                                        <label for="reservationId">Reservation ID *</label>
                                                        <input type="number" id="reservationId" name="reservationId"
                                                            placeholder="Enter reservation ID to search" required>
                                                    </div>
                                                    <div class="form-group"
                                                        style="flex: 0 0 150px; align-self: flex-end;">
                                                        <button type="submit" class="btn btn-primary"
                                                            style="width: 100%;">Search</button>
                                                    </div>
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
                                                <td><strong>ID</strong></td>
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
                                                <td><strong>Room Type</strong></td>
                                                <td><span class="text-blue" style="font-weight: 600;">
                                                        <%= reservation.getRoomType() %>
                                                    </span></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Check-in</strong></td>
                                                <td>
                                                    <%= reservation.getCheckIn() %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Check-out</strong></td>
                                                <td>
                                                    <%= reservation.getCheckOut() %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Total Bill</strong></td>
                                                <td><span class="text-orange" style="font-weight: 700;">LKR <%=
                                                            String.format("%,.2f", reservation.getTotalBill()) %></span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-actions" style="margin-top: 24px;">
                                    <form action="UpdateReservationServlet" method="get" style="display:inline;">
                                        <input type="hidden" name="reservationId"
                                            value="<%= reservation.getReservationId() %>">
                                        <input type="hidden" name="action" value="load">
                                        <button type="submit" class="btn btn-primary">Edit</button>
                                    </form>
                                    <% if ("ADMIN".equals(role)) { %>
                                        <form action="DeleteReservationServlet" method="get" style="display:inline;">
                                            <input type="hidden" name="reservationId"
                                                value="<%= reservation.getReservationId() %>">
                                            <input type="hidden" name="action" value="load">
                                            <button type="submit" class="btn btn-danger">Delete</button>
                                        </form>
                                        <% } %>
                                </div>
                            </div>
                            <% } %>
                    </div>
                </div>
            </body>

            </html>