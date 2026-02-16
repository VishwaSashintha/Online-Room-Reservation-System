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
                <title>Manage Users - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <%@ include file="includes/header.jsp" %>
                    <div class="dashboard-wrapper">
                        <%@ include file="includes/sidebar.jsp" %>
                            <div class="main-content">
                                <div class="content-header">
                                    <h2>Manage Users</h2>
                                    <p>View and manage system users</p>
                                </div>
                                <div class="summary-cards">
                                    <div class="summary-card">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Total Users</h4>
                                                <div class="number">2</div>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card orange-border">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Administrators</h4>
                                                <div class="number">1</div>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                    <div class="summary-card green-border">
                                        <div class="summary-card-content">
                                            <div class="summary-card-info">
                                                <h4>Staff Members</h4>
                                                <div class="number">1</div>
                                            </div>
                                            <div class="summary-card-icon"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h3>System Users</h3>
                                    </div>
                                    <div class="table-container">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>User ID</th>
                                                    <th>Username</th>
                                                    <th>Full Name</th>
                                                    <th>Email</th>
                                                    <th>Phone</th>
                                                    <th>Role</th>
                                                    <th>Status</th>
                                                    <th>Created Date</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td><strong>admin</strong></td>
                                                    <td>System Administrator</td>
                                                    <td>admin@oceanview.com</td>
                                                    <td>0771234567</td>
                                                    <td><span class="badge badge-admin">ADMIN</span></td>
                                                    <td><span class="status-badge status-active">ACTIVE</span></td>
                                                    <td>2026-02-17</td>
                                                    <td>
                                                        <button class="btn btn-primary btn-sm"
                                                            onclick="alert('Resetting password for admin...')">Reset</button>
                                                        <button class="btn btn-secondary btn-sm"
                                                            onclick="alert('Editing admin role...')">Edit</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td><strong>staff</strong></td>
                                                    <td>Staff Member</td>
                                                    <td>staff@oceanview.com</td>
                                                    <td>0779876543</td>
                                                    <td><span class="badge badge-staff">STAFF</span></td>
                                                    <td><span class="status-badge status-active">ACTIVE</span></td>
                                                    <td>2026-02-17</td>
                                                    <td>
                                                        <button class="btn btn-primary btn-sm"
                                                            onclick="alert('Resetting password for staff...')">Reset</button>
                                                        <button class="btn btn-secondary btn-sm"
                                                            onclick="alert('Editing staff role...')">Edit</button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-header">
                                        <h3>User Management Information</h3>
                                    </div>
                                    <div class="info-box">
                                        <p><strong>User Creation:</strong> System access is restricted. Only
                                            administrators can add new staff or administrator accounts through the
                                            database or management console.</p>
                                        <p><strong>Security:</strong> Self-registration is disabled to maintain strict
                                            system integrity.</p>
                                        <p><strong>Role Management:</strong> Only administrators can access this page
                                            and view all system users.</p>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <style>
                        .status-badge {
                            padding: 4px 12px;
                            border-radius: 12px;
                            font-size: 12px;
                            font-weight: 600;
                        }

                        .status-active {
                            background: #D5F4E6;
                            color: #0B5345;
                        }

                        .info-box {
                            background: var(--light-bg);
                            padding: var(--spacing-lg);
                            border-radius: var(--radius-md);
                            border-left: 4px solid var(--secondary-blue);
                        }

                        .info-box p {
                            margin-bottom: var(--spacing-sm);
                        }

                        .info-box p:last-child {
                            margin-bottom: 0;
                        }
                    </style>
            </body>

            </html>