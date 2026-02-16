<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } String
        username=(String) session.getAttribute("username"); String role=(String) session.getAttribute("role"); String
        errorMessage=(String) request.getAttribute("errorMessage"); String successMessage=(String)
        request.getAttribute("successMessage"); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Reservation - Ocean View Resort</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <jsp:include page="includes/header.jsp" />
            <div class="dashboard-wrapper">
                <jsp:include page="includes/sidebar.jsp" />
                <div class="main-content">
                    <div class="content-header">
                        <h2>Add Reservation</h2>
                        <p>Register a new booking in the system</p>
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
                                        <form action="AddReservationServlet" method="post" id="reservationForm">
                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="reservationId">Reservation ID *</label>
                                                    <input type="number" id="reservationId" name="reservationId"
                                                        placeholder="Enter numeric ID" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="guestName">Guest Name *</label>
                                                    <input type="text" id="guestName" name="guestName"
                                                        placeholder="Enter guest's full name" required>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="address">Address *</label>
                                                    <input type="text" id="address" name="address"
                                                        placeholder="Guest's address" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="contact">Contact Number *</label>
                                                    <input type="text" id="contact" name="contact"
                                                        placeholder="10-digit phone number" required>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="roomType">Room Type *</label>
                                                    <select id="roomType" name="roomType" required
                                                        onchange="calculateBill()">
                                                        <option value="" disabled selected>Select Room Type</option>
                                                        <option value="Standard">Standard (LKR 8,000)</option>
                                                        <option value="Deluxe">Deluxe (LKR 12,000)</option>
                                                        <option value="Suite">Suite (LKR 20,000)</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="checkIn">Check-in Date *</label>
                                                    <input type="date" id="checkIn" name="checkIn" required
                                                        onchange="calculateBill()">
                                                </div>
                                                <div class="form-group">
                                                    <label for="checkOut">Check-out Date *</label>
                                                    <input type="date" id="checkOut" name="checkOut" required
                                                        onchange="calculateBill()">
                                                </div>
                                            </div>
                                            <div class="bill-summary" id="billSummary" style="display:none;">
                                                <h4>Billing Summary</h4>
                                                <div id="billDetails"></div>
                                                <div class="total-bill">Total: LKR <span
                                                        id="totalBillAmount">0.00</span></div>
                                            </div>
                                            <div class="form-actions">
                                                <button type="submit" class="btn btn-primary">Add Reservation</button>
                                                <button type="reset" class="btn btn-secondary">Clear Form</button>
                                            </div>
                                        </form>
                    </div>
                </div>
            </div>
            <script src="js/validation.js"></script>
            <script>
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
                            document.getElementById('billSummary').style.display = 'block';
                            document.getElementById('billDetails').innerHTML = `
                <p>Room Type: <strong>${roomType}</strong></p>
                <p>Nights: <strong>${diffDays}</strong></p>
                <p>Rate per Night: <strong>LKR ${rate.toLocaleString()}</strong></p>
            `;
                            document.getElementById('totalBillAmount').textContent = total.toLocaleString(undefined, { minimumFractionDigits: 2 });
                        } else {
                            document.getElementById('billSummary').style.display = 'none';
                        }
                    }
                }
            </script>
        </body>

        </html>