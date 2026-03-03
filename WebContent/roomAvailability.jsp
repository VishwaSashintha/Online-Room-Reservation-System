<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User, dao.ReservationDAO, java.sql.Date, java.util.List, java.util.ArrayList" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); String checkInStr=request.getParameter("checkIn"); String
            checkOutStr=request.getParameter("checkOut"); String selectedRoomType=request.getParameter("roomType");
            ReservationDAO reservationDAO=new ReservationDAO(); int TOTAL_STANDARD=10; int TOTAL_DELUXE=8; int
            TOTAL_SUITE=5; int bookedStandard=0; int bookedDeluxe=0; int bookedSuite=0; boolean isSearch=(checkInStr
            !=null && !checkInStr.trim().isEmpty() && checkOutStr !=null && !checkOutStr.trim().isEmpty()); if
            (isSearch) { try { Date checkIn=Date.valueOf(checkInStr); Date checkOut=Date.valueOf(checkOutStr);
            bookedStandard=reservationDAO.getBookedCountByRoomTypeAndDateRange("Standard", checkIn, checkOut);
            bookedDeluxe=reservationDAO.getBookedCountByRoomTypeAndDateRange("Deluxe", checkIn, checkOut);
            bookedSuite=reservationDAO.getBookedCountByRoomTypeAndDateRange("Suite", checkIn, checkOut); } catch
            (Exception e) { e.printStackTrace(); } } else {
            bookedStandard=reservationDAO.getBookedCountByRoomType("Standard");
            bookedDeluxe=reservationDAO.getBookedCountByRoomType("Deluxe");
            bookedSuite=reservationDAO.getBookedCountByRoomType("Suite"); } int availStandard=Math.max(0, TOTAL_STANDARD
            - bookedStandard); int availDeluxe=Math.max(0, TOTAL_DELUXE - bookedDeluxe); int availSuite=Math.max(0,
            TOTAL_SUITE - bookedSuite); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Room Availability - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
                <style>
                    .room-details-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 24px;
                    }

                    .room-detail-card {
                        padding: 24px;
                        background: #f8f9fa;
                        border-radius: 12px;
                        border: 2px solid #e0e0e0;
                        transition: all 0.3s ease;
                    }

                    .room-detail-card:hover {
                        border-color: #1a73e8;
                        transform: translateY(-4px);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    }

                    .room-detail-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 16px;
                    }

                    .room-detail-header h4 {
                        color: #1a73e8;
                        font-size: 18px;
                        margin: 0;
                    }

                    .room-price {
                        color: #f68b1e;
                        font-weight: 700;
                        font-size: 16px;
                    }

                    .room-description {
                        color: #666;
                        margin-bottom: 16px;
                    }

                    .room-amenities {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 8px;
                        margin-bottom: 16px;
                    }

                    .amenity-tag {
                        background: white;
                        padding: 4px 12px;
                        border-radius: 12px;
                        font-size: 12px;
                        border: 1px solid #e0e0e0;
                    }

                    .room-availability-status {
                        padding-top: 16px;
                        border-top: 1px solid #e0e0e0;
                        color: #28a745;
                        font-weight: 600;
                    }

                    .alert {
                        padding: 12px 20px;
                        border-radius: 8px;
                        margin-bottom: 24px;
                    }

                    .alert-info {
                        background: #e3f2fd;
                        color: #0d47a1;
                        border: 1px solid #bbdefb;
                    }

                    .alert-success {
                        background: #e8f5e9;
                        color: #1b5e20;
                        border: 1px solid #c8e6c9;
                    }
                </style>
            </head>

            <body>
                <%@ include file="includes/header.jsp" %>
                    <div class="dashboard-wrapper">
                        <%@ include file="includes/sidebar.jsp" %>
                            <div class="main-content">
                                <div class="content-header">
                                    <h2>Room Availability</h2>
                                    <p>Check available rooms by date range and room type</p>
                                </div>

                                <div class="card">
                                    <div class="card-header">
                                        <h3>Search Available Rooms</h3>
                                    </div>
                                    <form method="get" action="roomAvailability.jsp">
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="checkIn">Check-In Date</label>
                                                <input type="date" id="checkIn" name="checkIn" required
                                                    value="<%= checkInStr != null ? checkInStr : "" %>">
                                            </div>
                                            <div class="form-group">
                                                <label for="checkOut">Check-Out Date</label>
                                                <input type="date" id="checkOut" name="checkOut" required
                                                    value="<%= checkOutStr != null ? checkOutStr : "" %>">
                                            </div>
                                            <div class="form-group">
                                                <label for="roomType">Room Type</label>
                                                <select id="roomType" name="roomType">
                                                    <option value="" <%=selectedRoomType==null || ""
                                                        .equals(selectedRoomType) ? "selected" : "" %>>All Types
                                                    </option>
                                                    <option value="Standard" <%="Standard" .equals(selectedRoomType)
                                                        ? "selected" : "" %>>Standard</option>
                                                    <option value="Deluxe" <%="Deluxe" .equals(selectedRoomType)
                                                        ? "selected" : "" %>>Deluxe</option>
                                                    <option value="Suite" <%="Suite" .equals(selectedRoomType)
                                                        ? "selected" : "" %>>Suite</option>
                                                </select>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Check Availability</button>
                                        <% if (isSearch) { %>
                                            <a href="roomAvailability.jsp" class="btn btn-secondary"
                                                style="margin-left: 10px;">Reset</a>
                                            <% } %>
                                    </form>
                                </div>

                                <% if (isSearch) { %>
                                    <div class="alert alert-success">
                                        Showing availability for: <strong>
                                            <%= checkInStr %>
                                        </strong> to <strong>
                                            <%= checkOutStr %>
                                        </strong>
                                    </div>
                                    <% } else { %>
                                        <div class="alert alert-info">
                                            Showing current availability as of today.
                                        </div>
                                        <% } %>

                                            <div class="summary-cards">
                                                <% if (selectedRoomType==null || "" .equals(selectedRoomType)
                                                    || "Standard" .equals(selectedRoomType)) { %>
                                                    <div class="summary-card">
                                                        <div class="summary-card-content">
                                                            <div class="summary-card-info">
                                                                <h4>Standard Rooms</h4>
                                                                <div class="number">
                                                                    <%= availStandard %>
                                                                </div>
                                                                <small style="color: var(--text-light);">LKR 8,000 /
                                                                    night</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } %>

                                                        <% if (selectedRoomType==null || "" .equals(selectedRoomType)
                                                            || "Deluxe" .equals(selectedRoomType)) { %>
                                                            <div class="summary-card orange-border">
                                                                <div class="summary-card-content">
                                                                    <div class="summary-card-info">
                                                                        <h4>Deluxe Rooms</h4>
                                                                        <div class="number">
                                                                            <%= availDeluxe %>
                                                                        </div>
                                                                        <small style="color: var(--text-light);">LKR
                                                                            12,000 / night</small>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <% } %>

                                                                <% if (selectedRoomType==null || ""
                                                                    .equals(selectedRoomType) || "Suite"
                                                                    .equals(selectedRoomType)) { %>
                                                                    <div class="summary-card green-border">
                                                                        <div class="summary-card-content">
                                                                            <div class="summary-card-info">
                                                                                <h4>Suites</h4>
                                                                                <div class="number">
                                                                                    <%= availSuite %>
                                                                                </div>
                                                                                <small
                                                                                    style="color: var(--text-light);">LKR
                                                                                    20,000 / night</small>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <% } %>
                                            </div>

                                            <div class="card">
                                                <div class="card-header">
                                                    <h3>Room Type Details</h3>
                                                </div>
                                                <div class="room-details-grid">
                                                    <% if (selectedRoomType==null || "" .equals(selectedRoomType)
                                                        || "Standard" .equals(selectedRoomType)) { %>
                                                        <div class="room-detail-card">
                                                            <div class="room-detail-header">
                                                                <h4>Standard Room</h4>
                                                                <span class="room-price">LKR 8,000/night</span>
                                                            </div>
                                                            <p class="room-description">Comfortable standard room with
                                                                essential amenities</p>
                                                            <div class="room-amenities">
                                                                <span class="amenity-tag">AC</span>
                                                                <span class="amenity-tag">TV</span>
                                                                <span class="amenity-tag">WiFi</span>
                                                                <span class="amenity-tag">Breakfast</span>
                                                            </div>
                                                            <div class="room-availability-status">
                                                                <strong>Available:</strong>
                                                                <%= availStandard %> / <%= TOTAL_STANDARD %> rooms
                                                            </div>
                                                        </div>
                                                        <% } %>

                                                            <% if (selectedRoomType==null || ""
                                                                .equals(selectedRoomType) || "Deluxe"
                                                                .equals(selectedRoomType)) { %>
                                                                <div class="room-detail-card">
                                                                    <div class="room-detail-header">
                                                                        <h4>Deluxe Room</h4>
                                                                        <span class="room-price">LKR 12,000/night</span>
                                                                    </div>
                                                                    <p class="room-description">Spacious deluxe room
                                                                        with ocean view</p>
                                                                    <div class="room-amenities">
                                                                        <span class="amenity-tag">AC</span>
                                                                        <span class="amenity-tag">TV</span>
                                                                        <span class="amenity-tag">WiFi</span>
                                                                        <span class="amenity-tag">Breakfast</span>
                                                                        <span class="amenity-tag">Ocean View</span>
                                                                    </div>
                                                                    <div class="room-availability-status">
                                                                        <strong>Available:</strong>
                                                                        <%= availDeluxe %> / <%= TOTAL_DELUXE %> rooms
                                                                    </div>
                                                                </div>
                                                                <% } %>

                                                                    <% if (selectedRoomType==null || ""
                                                                        .equals(selectedRoomType) || "Suite"
                                                                        .equals(selectedRoomType)) { %>
                                                                        <div class="room-detail-card">
                                                                            <div class="room-detail-header">
                                                                                <h4>Suite</h4>
                                                                                <span class="room-price">LKR
                                                                                    20,000/night</span>
                                                                            </div>
                                                                            <p class="room-description">Luxurious suite
                                                                                with premium amenities</p>
                                                                            <div class="room-amenities">
                                                                                <span class="amenity-tag">AC</span>
                                                                                <span class="amenity-tag">TV</span>
                                                                                <span class="amenity-tag">WiFi</span>
                                                                                <span
                                                                                    class="amenity-tag">Breakfast</span>
                                                                                <span class="amenity-tag">Living
                                                                                    Room</span>
                                                                            </div>
                                                                            <div class="room-availability-status">
                                                                                <strong>Available:</strong>
                                                                                <%= availSuite %> / <%= TOTAL_SUITE %>
                                                                                        rooms
                                                                            </div>
                                                                        </div>
                                                                        <% } %>
                                                </div>
                                            </div>
                            </div>
                    </div>
            </body>

            </html>