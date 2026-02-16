<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("staffDashboard.jsp"); return; } %>
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
                                                <div class="number" style="font-size: 24px;">LKR 0</div>
                                                <small style="color: var(--text-light);">No data this month</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card orange-border">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Total Bookings</h4>
                                                <div class="number">0</div>
                                                <small style="color: var(--text-light);">All time</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card green-border">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Occupancy Rate</h4>
                                                <div class="number">0%</div>
                                                <small style="color: var(--text-light);">0 of 23 rooms</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Avg. Booking Value</h4>
                                                <div class="number" style="font-size: 24px;">LKR 0</div>
                                                <small style="color: var(--text-light);">Per reservation</small>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h3>Revenue Analytics</h3>
                                    </div>
                                    <div class="revenue-grid">
                                        <div class="revenue-item">
                                            <div class="revenue-header">
                                                <span class="revenue-type">Standard</span>
                                                <span class="revenue-amount">LKR 0</span>
                                            </div>
                                            <div class="revenue-bar">
                                                <div class="revenue-fill"
                                                    style="width: 0%; background: var(--secondary-blue);"></div>
                                            </div>
                                            <small class="revenue-details">0 bookings • 0 nights</small>
                                        </div>
                                        <div class="revenue-item">
                                            <div class="revenue-header">
                                                <span class="revenue-type">Deluxe</span>
                                                <span class="revenue-amount">LKR 0</span>
                                            </div>
                                            <div class="revenue-bar">
                                                <div class="revenue-fill"
                                                    style="width: 0%; background: var(--accent-orange);"></div>
                                            </div>
                                            <small class="revenue-details">0 bookings • 0 nights</small>
                                        </div>
                                        <div class="revenue-item">
                                            <div class="revenue-header">
                                                <span class="revenue-type">Suite</span>
                                                <span class="revenue-amount">LKR 0</span>
                                            </div>
                                            <div class="revenue-bar">
                                                <div class="revenue-fill"
                                                    style="width: 0%; background: var(--success-green);"></div>
                                            </div>
                                            <small class="revenue-details">0 bookings • 0 nights</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h3>Recent Reservations</h3>
                                    </div>
                                    <div class="table-container">
                                        <table>
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
                                                <tr>
                                                    <td colspan="8" style="text-align: center; padding: 20px;">No recent
                                                        reservations found</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h3>System Reports</h3>
                                    </div>
                                    <div class="stats-grid">
                                        <div class="stat-item">
                                            <div class="stat-icon">🏨</div>
                                            <div class="stat-info">
                                                <div class="stat-value">23</div>
                                                <div class="stat-label">Total Rooms</div>
                                            </div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-icon">✅</div>
                                            <div class="stat-info">
                                                <div class="stat-value">0</div>
                                                <div class="stat-label">Active Bookings</div>
                                            </div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-icon">👥</div>
                                            <div class="stat-info">
                                                <div class="stat-value">2</div>
                                                <div class="stat-label">System Users</div>
                                            </div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-icon">🌟</div>
                                            <div class="stat-info">
                                                <div class="stat-value">100%</div>
                                                <div class="stat-label">Uptime</div>
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
                            transition: width 0.3s ease;
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
                        }

                        .status-confirmed {
                            background: #D5F4E6;
                            color: #0B5345;
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
            </body>

            </html>