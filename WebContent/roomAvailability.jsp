<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Room Availability - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
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
                                    <form method="get" action="">
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="checkIn">Check-In Date</label>
                                                <input type="date" id="checkIn" name="checkIn" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="checkOut">Check-Out Date</label>
                                                <input type="date" id="checkOut" name="checkOut" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="roomType">Room Type</label>
                                                <select id="roomType" name="roomType">
                                                    <option value="">All Types</option>
                                                    <option value="Standard">Standard</option>
                                                    <option value="Deluxe">Deluxe</option>
                                                    <option value="Suite">Suite</option>
                                                </select>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Check Availability</button>
                                    </form>
                                </div>
                                <div class="summary-cards">
                                    <div class="summary-card">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Standard Rooms</h4>
                                                <div class="number">10</div>
                                                <small style="color: var(--text-light);">LKR 8,000 / night</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card orange-border">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Deluxe Rooms</h4>
                                                <div class="number">8</div>
                                                <small style="color: var(--text-light);">LKR 12,000 / night</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card green-border">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Suites</h4>
                                                <div class="number">5</div>
                                                <small style="color: var(--text-light);">LKR 20,000 / night</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h3>Room Type Details</h3>
                                    </div>
                                    <div class="room-details-grid">
                                        <div class="room-detail-card">
                                            <div class="room-detail-header">
                                                <h4>Standard Room</h4>
                                                <span class="room-price">LKR 8,000/night</span>
                                            </div>
                                            <p class="room-description">Comfortable standard room with essential
                                                amenities</p>
                                            <div class="room-amenities">
                                                <span class="amenity-tag">AC</span>
                                                <span class="amenity-tag">TV</span>
                                                <span class="amenity-tag">WiFi</span>
                                                <span class="amenity-tag">Breakfast</span>
                                            </div>
                                            <div class="room-availability">
                                                <strong>Available:</strong> 10 rooms
                                            </div>
                                        </div>
                                        <div class="room-detail-card">
                                            <div class="room-detail-header">
                                                <h4>Deluxe Room</h4>
                                                <span class="room-price">LKR 12,000/night</span>
                                            </div>
                                            <p class="room-description">Spacious deluxe room with ocean view</p>
                                            <div class="room-amenities">
                                                <span class="amenity-tag">AC</span>
                                                <span class="amenity-tag">TV</span>
                                                <span class="amenity-tag">WiFi</span>
                                                <span class="amenity-tag">Breakfast</span>
                                                <span class="amenity-tag">Ocean View</span>
                                                <span class="amenity-tag">Mini Bar</span>
                                            </div>
                                            <div class="room-availability">
                                                <strong>Available:</strong> 8 rooms
                                            </div>
                                        </div>
                                        <div class="room-detail-card">
                                            <div class="room-detail-header">
                                                <h4>Suite</h4>
                                                <span class="room-price">LKR 20,000/night</span>
                                            </div>
                                            <p class="room-description">Luxurious suite with premium amenities</p>
                                            <div class="room-amenities">
                                                <span class="amenity-tag">AC</span>
                                                <span class="amenity-tag">TV</span>
                                                <span class="amenity-tag">WiFi</span>
                                                <span class="amenity-tag">Breakfast</span>
                                                <span class="amenity-tag">Ocean View</span>
                                                <span class="amenity-tag">Mini Bar</span>
                                                <span class="amenity-tag">Jacuzzi</span>
                                                <span class="amenity-tag">Living Room</span>
                                            </div>
                                            <div class="room-availability">
                                                <strong>Available:</strong> 5 rooms
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <style>
                        .room-details-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                            gap: var(--spacing-lg);
                        }

                        .room-detail-card {
                            padding: var(--spacing-lg);
                            background: var(--light-bg);
                            border-radius: var(--radius-lg);
                            border: 2px solid var(--border-color);
                            transition: all 0.3s ease;
                        }

                        .room-detail-card:hover {
                            border-color: var(--secondary-blue);
                            transform: translateY(-4px);
                            box-shadow: var(--shadow-md);
                        }

                        .room-detail-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: var(--spacing-md);
                        }

                        .room-detail-header h4 {
                            color: var(--primary-blue);
                            font-size: 18px;
                        }

                        .room-price {
                            color: var(--accent-orange);
                            font-weight: 700;
                            font-size: 16px;
                        }

                        .room-description {
                            color: var(--text-light);
                            margin-bottom: var(--spacing-md);
                        }

                        .room-amenities {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 8px;
                            margin-bottom: var(--spacing-md);
                        }

                        .amenity-tag {
                            background: white;
                            padding: 4px 12px;
                            border-radius: 12px;
                            font-size: 12px;
                            border: 1px solid var(--border-color);
                        }

                        .room-availability {
                            padding-top: var(--spacing-md);
                            border-top: 1px solid var(--border-color);
                            color: var(--success-green);
                            font-weight: 600;
                        }
                    </style>
            </body>

            </html>