<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User, model.Reservation, dao.ReservationDAO, service.UserService, java.util.List" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("staffDashboard.jsp"); return; } ReservationDAO reservationDAO=new ReservationDAO();
            UserService userService=new UserService(); int totalReservations=reservationDAO.getTotalReservations(); int
            activeBookings=reservationDAO.getActiveBookings(); double totalRevenue=reservationDAO.getTotalRevenue();
            double monthlyRevenue=reservationDAO.getMonthlyRevenue(); int
            monthlyBookings=reservationDAO.getMonthlyBookings(); int todayCheckIns=reservationDAO.getTodayCheckIns();
            int todayCheckOuts=reservationDAO.getTodayCheckOuts(); double avgBookingValue=totalReservations> 0 ?
            totalRevenue / totalReservations : 0;
            int totalRooms = 23;
            double occupancyRate = totalRooms > 0 ? ((double) activeBookings / totalRooms) * 100 : 0;
            int availableRooms = Math.max(0, totalRooms - activeBookings);

            double revenueStandard = reservationDAO.getRevenueByRoomType("Standard");
            double revenueDeluxe = reservationDAO.getRevenueByRoomType("Deluxe");
            double revenueSuite = reservationDAO.getRevenueByRoomType("Suite");
            int bookingsStandard = reservationDAO.getBookingCountByRoomType("Standard");
            int bookingsDeluxe = reservationDAO.getBookingCountByRoomType("Deluxe");
            int bookingsSuite = reservationDAO.getBookingCountByRoomType("Suite");
            int nightsStandard = reservationDAO.getTotalNightsByRoomType("Standard");
            int nightsDeluxe = reservationDAO.getTotalNightsByRoomType("Deluxe");
            int nightsSuite = reservationDAO.getTotalNightsByRoomType("Suite");

            double maxRevenue = Math.max(revenueStandard, Math.max(revenueDeluxe, revenueSuite));
            double barStandard = maxRevenue > 0 ? (revenueStandard / maxRevenue) * 100 : 0;
            double barDeluxe = maxRevenue > 0 ? (revenueDeluxe / maxRevenue) * 100 : 0;
            double barSuite = maxRevenue > 0 ? (revenueSuite / maxRevenue) * 100 : 0;

            int totalUsers = userService.getTotalUsers();
            int bookedStandard = reservationDAO.getBookedCountByRoomType("Standard");
            int bookedDeluxe = reservationDAO.getBookedCountByRoomType("Deluxe");
            int bookedSuite = reservationDAO.getBookedCountByRoomType("Suite");

            List<Reservation> recentReservations = reservationDAO.getAllReservations();

                String widthStandard = String.format("%.0f", barStandard) + "%";
                String widthDeluxe = String.format("%.0f", barDeluxe) + "%";
                String widthSuite = String.format("%.0f", barSuite) + "%";

                String styleStandard = "width: " + widthStandard + "; background: var(--secondary-blue);";
                String styleDeluxe = "width: " + widthDeluxe + "; background: var(--accent-orange);";
                String styleSuite = "width: " + widthSuite + "; background: var(--success-green);";
                %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Reports & Statistics - Ocean View Resort</title>
                    <link rel="stylesheet" href="css/style.css">
                </head>

                <body>
                    <%@ include file="includes/header.jsp" %>
                        <div class="dashboard-wrapper">
                            <%@ include file="includes/sidebar.jsp" %>
                                <div class="main-content">
                                    <div class="content-header">
                                        <h2>Reports & Statistics</h2>
                                        <p>View system analytics and performance metrics</p>
                                    </div>

                                    <div class="summary-cards">
                                        <div class="summary-card">
                                            <div class="summary-card-content">
                                                <div class="summary-card-info">
                                                    <h4>Total Revenue</h4>
                                                    <div class="number" style="font-size: 24px;">LKR <%=
                                                            String.format("%,.0f", totalRevenue) %>
                                                    </div>
                                                    <small style="color: var(--text-light);">This month: LKR <%=
                                                            String.format("%,.0f", monthlyRevenue) %></small>
                                                </div>
                                                <div class="summary-card-icon"></div>
                                            </div>
                                        </div>
                                        <div class="summary-card orange-border">
                                            <div class="summary-card-content">
                                                <div class="summary-card-info">
                                                    <h4>Total Bookings</h4>
                                                    <div class="number">
                                                        <%= totalReservations %>
                                                    </div>
                                                    <small style="color: var(--text-light);">This month: <%=
                                                            monthlyBookings %></small>
                                                </div>
                                                <div class="summary-card-icon"></div>
                                            </div>
                                        </div>
                                        <div class="summary-card green-border">
                                            <div class="summary-card-content">
                                                <div class="summary-card-info">
                                                    <h4>Occupancy Rate</h4>
                                                    <div class="number">
                                                        <%= String.format("%.0f", occupancyRate) %>%
                                                    </div>
                                                    <small style="color: var(--text-light);">
                                                        <%= activeBookings %> of <%= totalRooms %> rooms occupied
                                                    </small>
                                                </div>
                                                <div class="summary-card-icon"></div>
                                            </div>
                                        </div>
                                        <div class="summary-card">
                                            <div class="summary-card-content">
                                                <div class="summary-card-info">
                                                    <h4>Avg. Booking Value</h4>
                                                    <div class="number" style="font-size: 24px;">LKR <%=
                                                            String.format("%,.0f", avgBookingValue) %>
                                                    </div>
                                                    <small style="color: var(--text-light);">Per reservation</small>
                                                </div>
                                                <div class="summary-card-icon"></div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card">
                                        <div class="card-header">
                                            <h3>Revenue Analytics by Room Type</h3>
                                        </div>
                                        <div class="revenue-grid">
                                            <div class="revenue-item">
                                                <div class="revenue-header">
                                                    <span class="revenue-type">Standard Rooms</span>
                                                    <span class="revenue-amount">LKR <%= String.format("%,.0f",
                                                            revenueStandard) %></span>
                                                </div>
                                                <div class="revenue-bar">
                                                    <div class="revenue-fill" id="barStandardFill"
                                                        style="background: var(--secondary-blue);"></div>
                                                </div>
                                                <small class="revenue-details">
                                                    <%= bookingsStandard %> bookings &bull; <%= nightsStandard %> nights
                                                            &bull; LKR 8,000/night
                                                </small>
                                            </div>
                                            <div class="revenue-item">
                                                <div class="revenue-header">
                                                    <span class="revenue-type">Deluxe Rooms</span>
                                                    <span class="revenue-amount">LKR <%= String.format("%,.0f",
                                                            revenueDeluxe) %></span>
                                                </div>
                                                <div class="revenue-bar">
                                                    <div class="revenue-fill" id="barDeluxeFill"
                                                        style="background: var(--accent-orange);"></div>
                                                </div>
                                                <small class="revenue-details">
                                                    <%= bookingsDeluxe %> bookings &bull; <%= nightsDeluxe %> nights
                                                            &bull; LKR 12,000/night
                                                </small>
                                            </div>
                                            <div class="revenue-item">
                                                <div class="revenue-header">
                                                    <span class="revenue-type">Suites</span>
                                                    <span class="revenue-amount">LKR <%= String.format("%,.0f",
                                                            revenueSuite) %></span>
                                                </div>
                                                <div class="revenue-bar">
                                                    <div class="revenue-fill" id="barSuiteFill"
                                                        style="background: var(--success-green);"></div>
                                                </div>
                                                <small class="revenue-details">
                                                    <%= bookingsSuite %> bookings &bull; <%= nightsSuite %> nights
                                                            &bull; LKR 20,000/night
                                                </small>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card">
                                        <div class="card-header">
                                            <h3>Recent Reservations</h3>
                                        </div>
                                        <div class="table-container">
                                            <table class="data-table">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Guest Name</th>
                                                        <th>Room Type</th>
                                                        <th>Check-In</th>
                                                        <th>Check-Out</th>
                                                        <th>Nights</th>
                                                        <th>Total Bill</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% if (recentReservations==null || recentReservations.isEmpty()) {
                                                        %>
                                                        <tr>
                                                            <td colspan="8" style="text-align: center; padding: 20px;">
                                                                No reservations found</td>
                                                        </tr>
                                                        <% } else { int displayCount=0; java.util.Date today=new
                                                            java.util.Date(); for (Reservation r : recentReservations) {
                                                            if (displayCount>= 15) break;
                                                            long diffMs = r.getCheckOut().getTime() -
                                                            r.getCheckIn().getTime();
                                                            int nights = (int)(diffMs / (1000 * 60 * 60 * 24));
                                                            String status;
                                                            String statusClass;
                                                            if (r.getCheckOut().before(new
                                                            java.sql.Date(today.getTime())) ||
                                                            r.getCheckOut().equals(new java.sql.Date(today.getTime())))
                                                            {
                                                            status = "Completed";
                                                            statusClass = "status-completed";
                                                            } else if (r.getCheckIn().after(new
                                                            java.sql.Date(today.getTime()))) {
                                                            status = "Upcoming";
                                                            statusClass = "status-upcoming";
                                                            } else {
                                                            status = "Active";
                                                            statusClass = "status-active";
                                                            }
                                                            %>
                                                            <tr>
                                                                <td>
                                                                    <%= r.getReservationId() %>
                                                                </td>
                                                                <td><strong>
                                                                        <%= r.getGuestName() %>
                                                                    </strong></td>
                                                                <td><span class="text-blue" style="font-weight:600;">
                                                                        <%= r.getRoomType() %>
                                                                    </span></td>
                                                                <td>
                                                                    <%= r.getCheckIn() %>
                                                                </td>
                                                                <td>
                                                                    <%= r.getCheckOut() %>
                                                                </td>
                                                                <td>
                                                                    <%= nights %>
                                                                </td>
                                                                <td><span class="text-orange"
                                                                        style="font-weight:700;">LKR <%=
                                                                            String.format("%,.2f", r.getTotalBill()) %>
                                                                    </span></td>
                                                                <td><span class="status-badge <%= statusClass %>">
                                                                        <%= status %>
                                                                    </span></td>
                                                            </tr>
                                                            <% displayCount++; } } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="card">
                                        <div class="card-header">
                                            <h3>System Overview</h3>
                                        </div>
                                        <div class="stats-grid">
                                            <div class="stat-item">
                                                <div class="stat-icon">🏨</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= totalRooms %>
                                                    </div>
                                                    <div class="stat-label">Total Rooms</div>
                                                </div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-icon">✅</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= activeBookings %>
                                                    </div>
                                                    <div class="stat-label">Active Bookings</div>
                                                </div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-icon">🟢</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= availableRooms %>
                                                    </div>
                                                    <div class="stat-label">Available Rooms</div>
                                                </div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-icon">👥</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= totalUsers %>
                                                    </div>
                                                    <div class="stat-label">System Users</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card">
                                        <div class="card-header">
                                            <h3>Today's Activity</h3>
                                        </div>
                                        <div class="stats-grid">
                                            <div class="stat-item">
                                                <div class="stat-icon">📥</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= todayCheckIns %>
                                                    </div>
                                                    <div class="stat-label">Today's Check-Ins</div>
                                                </div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-icon">📤</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= todayCheckOuts %>
                                                    </div>
                                                    <div class="stat-label">Today's Check-Outs</div>
                                                </div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-icon">🛏️</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">
                                                        <%= Math.max(0, 10 - bookedStandard) %>/<%= Math.max(0, 8 -
                                                                bookedDeluxe) %>/<%= Math.max(0, 5 - bookedSuite) %>
                                                    </div>
                                                    <div class="stat-label">Available: Std/Dlx/Ste</div>
                                                </div>
                                            </div>
                                            <div class="stat-item">
                                                <div class="stat-icon">🌟</div>
                                                <div class="stat-info">
                                                    <div class="stat-value">100%</div>
                                                    <div class="stat-label">System Uptime</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        <style>
                            .revenue-grid {
                                display: flex;
                                flex-direction: column;
                                gap: var(--spacing-lg);
                            }

                            .revenue-item {
                                padding: var(--spacing-md);
                                background: var(--light-bg);
                                border-radius: var(--radius-md);
                            }

                            .revenue-header {
                                display: flex;
                                justify-content: space-between;
                                margin-bottom: var(--spacing-sm);
                            }

                            .revenue-type {
                                font-weight: 600;
                                color: var(--primary-blue);
                            }

                            .revenue-amount {
                                font-weight: 700;
                                color: var(--accent-orange);
                            }

                            .revenue-bar {
                                height: 8px;
                                background: var(--border-color);
                                border-radius: 4px;
                                overflow: hidden;
                                margin-bottom: var(--spacing-xs);
                            }

                            .revenue-fill {
                                height: 100%;
                                transition: width 0.6s ease;
                                border-radius: 4px;
                            }

                            .revenue-details {
                                color: var(--text-light);
                                font-size: 12px;
                            }

                            .status-badge {
                                padding: 4px 12px;
                                border-radius: 12px;
                                font-size: 12px;
                                font-weight: 600;
                                display: inline-block;
                            }

                            .status-active {
                                background: #D5F4E6;
                                color: #0B5345;
                            }

                            .status-completed {
                                background: #E8EAF6;
                                color: #283593;
                            }

                            .status-upcoming {
                                background: #FFF3E0;
                                color: #E65100;
                            }

                            .stats-grid {
                                display: grid;
                                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                                gap: var(--spacing-lg);
                            }

                            .stat-item {
                                display: flex;
                                align-items: center;
                                gap: var(--spacing-md);
                                padding: var(--spacing-lg);
                                background: var(--light-bg);
                                border-radius: var(--radius-md);
                            }

                            .stat-icon {
                                font-size: 40px;
                            }

                            .stat-value {
                                font-size: 32px;
                                font-weight: 700;
                                color: var(--primary-blue);
                            }

                            .stat-label {
                                font-size: 13px;
                                color: var(--text-light);
                            }
                        </style>
                        <script>
                            document.getElementById('barStandardFill').style.width = '<%= widthStandard %>';
                            document.getElementById('barDeluxeFill').style.width = '<%= widthDeluxe %>';
                            document.getElementById('barSuiteFill').style.width = '<%= widthSuite %>';
                        </script>
                </body>

                </html>