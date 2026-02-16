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
                <title>Update Reservation - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <jsp:include page="includes/header.jsp" />
                <div class="dashboard-wrapper">
                    <jsp:include page="includes/sidebar.jsp" />
                    <div class="main-content">
                        <div class="content-header">
                            <h2>Update Reservation</h2>
                            <p>Modify existing guest bookings</p>
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
                                            <% if (reservation==null) { %>
                                                <form action="UpdateReservationServlet" method="get">
                                                    <input type="hidden" name="action" value="load">
                                                    <div class="form-row">
                                                        <div class="form-group" style="flex: 1;">
                                                            <label for="reservationId">Reservation ID *</label>
                                                            <input type="number" id="reservationId" name="reservationId"
                                                                placeholder="Enter reservation ID to update" required>
                                                        </div>
                                                        <div class="form-group"
                                                            style="flex: 0 0 200px; align-self: flex-end;">
                                                            <button type="submit" class="btn btn-primary"
                                                                style="width: 100%;">Load Reservation</button>
                                                        </div>
                                                    </div>
                                                </form>
                                                <% } else { %>
                                                    <form action="UpdateReservationServlet" method="post">
                                                        <input type="hidden" name="reservationId"
                                                            value="<%= reservation.getReservationId() %>">
                                                        <div class="form-row">
                                                            <div class="form-group">
                                                                <label>Reservation ID</label>
                                                                <input type="text"
                                                                    value="<%= reservation.getReservationId() %>"
                                                                    disabled>
                                                                <small>ID cannot be changed</small>
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
                                                                    value="<%= reservation.getContact() %>" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="form-group">
                                                                <label for="roomType">Room Type *</label>
                                                                <select id="roomType" name="roomType" required
                                                                    onchange="calculateBill()">
                                                                    <option value="Standard" <%="Standard"
                                                                        .equals(reservation.getRoomType()) ? "selected"
                                                                        : "" %>>Standard (LKR 8,000)</option>
                                                                    <option value="Deluxe" <%="Deluxe"
                                                                        .equals(reservation.getRoomType()) ? "selected"
                                                                        : "" %>>Deluxe (LKR 12,000)</option>
                                                                    <option value="Suite" <%="Suite"
                                                                        .equals(reservation.getRoomType()) ? "selected"
                                                                        : "" %>>Suite (LKR 20,000)</option>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="checkIn">Check-in Date *</label>
                                                                <input type="date" id="checkIn" name="checkIn"
                                                                    value="<%= reservation.getCheckIn() %>" required
                                                                    onchange="calculateBill()">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="checkOut">Check-out Date *</label>
                                                                <input type="date" id="checkOut" name="checkOut"
                                                                    value="<%= reservation.getCheckOut() %>" required
                                                                    onchange="calculateBill()">
                                                            </div>
                                                        </div>
                                                        <div class="bill-summary" id="billSummary">
                                                            <h4>Current Billing</h4>
                                                            <div id="billDetails">
                                                                <p>Number of Nights: <strong id="nightCount">--</strong>
                                                                </p>
                                                            </div>
                                                            <div class="total-bill">Total: LKR <span
                                                                    id="totalBillAmount">
                                                                    <%= String.format("%,.2f",
                                                                        reservation.getTotalBill()) %>
                                                                </span></div>
                                                        </div>
                                                        <div class="form-actions">
                                                            <button type="submit" class="btn btn-primary">Update
                                                                Reservation</button>
                                                            <a href="updateReservation.jsp"
                                                                class="btn btn-secondary">Cancel</a>
                                                        </div>
                                                    </form>
                                                    <% } %>
                        </div>
                    </div>
                </div>
                <script src="js/validation.js"></script>
                <script>
                    window.onload = function () {
                        if (document.getElementById('roomType')) {
                            calculateBill();
                        }
                    };
                    function calculateBill() {
                        const roomType = document.getElementById('roomType').value;
                        const checkIn = document.getElementById('checkIn').value;
                        const checkOut = document.getElementById('checkOut').value;
                        if (roomType && checkIn && checkOut) {
                            const date1 = new Date(checkIn);
                            const date2 = new Date(checkOut);
                            if (date2 > date1) {
                                const diffTime = Math.abs(date2 - date1);
                                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                                let rate = 0;
                                if (roomType === "Standard") rate = 8000;
                                else if (roomType === "Deluxe") rate = 12000;
                                else if (roomType === "Suite") rate = 20000;
                                const total = diffDays * rate;
                                document.getElementById('nightCount').textContent = diffDays;
                                document.getElementById('totalBillAmount').textContent = total.toLocaleString(undefined, { minimumFractionDigits: 2 });
                            }
                        }
                    }
                </script>
            </body>

            </html>