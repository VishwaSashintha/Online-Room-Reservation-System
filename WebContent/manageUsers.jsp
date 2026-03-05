<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User, service.UserService, java.util.List" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            loggedInUser=(User) session.getAttribute("user"); if (!"ADMIN".equals(loggedInUser.getRole())) {
            response.sendRedirect("staffDashboard.jsp"); return; } UserService userService=new UserService(); List<User>
            allUsers = null;
            int totalUsers = 0;
            int adminCount = 0;
            int staffCount = 0;

            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");

            try {
            allUsers = userService.getAllUsers();
            totalUsers = userService.getTotalUsers();
            adminCount = userService.getAdminCount();
            staffCount = userService.getStaffCount();
            } catch (Exception e) {
            errorMessage = "An unexpected error occurred while fetching user data. Please try again.";
            e.printStackTrace();
            }
            %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Users - Ocean View Resort</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <jsp:include page="includes/header.jsp" />
                <div class="dashboard-wrapper">
                    <jsp:include page="includes/sidebar.jsp" />
                    <div class="main-content">
                        <div class="content-header">
                            <div class="header-title">
                                <h2>Manage System Users</h2>
                                <p>View and manage staff and administrator accounts</p>
                            </div>
                            <button class="btn btn-primary" onclick="openAddUserModal()">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" style="margin-right: 8px;">
                                    <line x1="12" y1="5" x2="12" y2="19"></line>
                                    <line x1="5" y1="12" x2="19" y2="12"></line>
                                </svg>
                                Add New User
                            </button>
                        </div>

                        <% if (successMessage !=null) { %>
                            <div class="alert alert-success">
                                <%= successMessage %>
                            </div>
                            <% } %>
                                <% if (errorMessage !=null) { %>
                                    <div class="alert alert-error">
                                        <%= errorMessage %>
                                    </div>
                                    <% } %>

                                        <div class="summary-cards" style="margin-bottom: 30px;">
                                            <div class="summary-card">
                                                <div class="summary-card-content">
                                                    <div class="summary-card-info">
                                                        <h4>Total Users</h4>
                                                        <div class="number">
                                                            <%= totalUsers %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="summary-card orange-border">
                                                <div class="summary-card-content">
                                                    <div class="summary-card-info">
                                                        <h4>Administrators</h4>
                                                        <div class="number">
                                                            <%= adminCount %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="summary-card green-border">
                                                <div class="summary-card-content">
                                                    <div class="summary-card-info">
                                                        <h4>Staff Members</h4>
                                                        <div class="number">
                                                            <%= staffCount %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card">
                                            <div class="card-header">
                                                <h3>System User Directory</h3>
                                            </div>
                                            <div class="table-container">
                                                <table class="data-table">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Username</th>
                                                            <th>Full Name</th>
                                                            <th>Email</th>
                                                            <th>Phone</th>
                                                            <th>Role</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% if (allUsers==null || allUsers.isEmpty()) { %>
                                                            <tr>
                                                                <td colspan="8"
                                                                    style="text-align: center; padding: 20px;">
                                                                    No users found
                                                                </td>
                                                            </tr>
                                                            <% } else { for (User u : allUsers) { if (u==null) continue;
                                                                String role=u.getRole() !=null ? u.getRole() : "STAFF" ;
                                                                %>
                                                                <tr>
                                                                    <td>
                                                                        <%= u.getUserId() %>
                                                                    </td>
                                                                    <td><strong>
                                                                            <%= u.getUsername() !=null ? u.getUsername()
                                                                                : "-" %>
                                                                        </strong></td>
                                                                    <td>
                                                                        <%= u.getFullName() !=null ? u.getFullName()
                                                                            : "-" %>
                                                                    </td>
                                                                    <td>
                                                                        <%= u.getEmail() !=null ? u.getEmail() : "-" %>
                                                                    </td>
                                                                    <td>
                                                                        <%= u.getPhone() !=null ? u.getPhone() : "-" %>
                                                                    </td>
                                                                    <td>
                                                                        <span class="badge <%= " ADMIN".equals(role)
                                                                            ? "badge-admin" : "badge-staff" %>">
                                                                            <%= role %>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <span class="status-badge status-active">
                                                                            <%= u.getStatus() !=null ? u.getStatus()
                                                                                : "ACTIVE" %>
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <% if ("STAFF".equals(role)) { %>
                                                                            <button class="btn-icon"
                                                                                data-userid="<%= u.getUserId() %>"
                                                                                data-username="<%= u.getUsername() != null ? u.getUsername() : "" %>"
                                                                                data-password="<%= u.getPassword() != null ? u.getPassword() : "" %>"
                                                                                data-fullname="<%= u.getFullName() != null ? u.getFullName() : "" %>"
                                                                                data-email="<%= u.getEmail() != null ? u.getEmail() : "" %>"
                                                                                data-phone="<%= u.getPhone() != null ? u.getPhone() : "" %>"
                                                                                onclick="handleEditClick(this)"
                                                                                title="Edit Staff">
                                                                                <svg width="18" height="18"
                                                                                    viewBox="0 0 24 24" fill="none"
                                                                                    stroke="currentColor"
                                                                                    stroke-width="2">
                                                                                    <path
                                                                                        d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7">
                                                                                    </path>
                                                                                    <path
                                                                                        d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z">
                                                                                    </path>
                                                                                </svg>
                                                                            </button>
                                                                            <% } else { %>
                                                                                <span class="text-muted"
                                                                                    style="font-size: 11px;">Admin
                                                                                    Read-Only</span>
                                                                                <% } %>
                                                                    </td>
                                                                </tr>
                                                                <% } } %>
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
                                                    administrators can add new staff or administrator accounts through
                                                    the management console.</p>
                                                <p><strong>Security:</strong> Self-registration is disabled to maintain
                                                    strict system integrity.</p>
                                                <p><strong>Role Management:</strong> Only administrators can access this
                                                    page and view all system users.</p>
                                            </div>
                                        </div>
                    </div>
                </div>



                <!-- Add User Modal -->
                <div id="addUserModal" class="modal">
                    <div class="modal-content" style="max-width: 500px;">
                        <div class="modal-header">
                            <h3>Add New System User</h3>
                            <span class="close" onclick="closeAddUserModal()">&times;</span>
                        </div>
                        <form action="AddUserServlet" method="POST">
                            <div
                                style="background: #f8f9fa; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #dee2e6;">
                                <h5 style="margin-top: 0; margin-bottom: 10px; color: #495057;">Admin Verification</h5>
                                <div class="form-group">
                                    <label for="adminUsername">Admin Username</label>
                                    <input type="text" id="adminUsername" name="adminUsername" required
                                        placeholder="Your current username">
                                </div>
                                <div class="form-group">
                                    <label for="adminPassword">Admin Password</label>
                                    <input type="password" id="adminPassword" name="adminPassword" required
                                        placeholder="Your current password">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="username">New Username</label>
                                <input type="text" id="username" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="password">New Password</label>
                                <input type="password" id="password" name="password" required>
                            </div>
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" id="fullName" name="fullName">
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email">
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="text" id="phone" name="phone">
                            </div>
                            <div class="form-group">
                                <label for="role">Role</label>
                                <select id="role" name="role">
                                    <option value="STAFF">Staff</option>
                                    <option value="ADMIN">Administrator</option>
                                </select>
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <button type="submit" class="btn btn-primary">Create User</button>
                                <button type="button" class="btn btn-secondary"
                                    onclick="closeAddUserModal()">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Edit User Modal -->
                <div id="editUserModal" class="modal">
                    <div class="modal-content" style="max-width: 500px;">
                        <div class="modal-header">
                            <h3>Update Staff Details</h3>
                            <span class="close" onclick="closeEditUserModal()">&times;</span>
                        </div>
                        <form action="UpdateUserServlet" method="POST">
                            <input type="hidden" id="editUserId" name="userId">
                            <div class="form-group">
                                <label for="editUsername">Username (Read-Only)</label>
                                <input type="text" id="editUsername" name="username" readonly
                                    style="background-color: #f1f3f5; cursor: not-allowed;">
                            </div>
                            <div class="form-group">
                                <label for="editFullName">Full Name</label>
                                <input type="text" id="editFullName" name="fullName">
                            </div>
                            <div class="form-group">
                                <label for="editEmail">Email</label>
                                <input type="email" id="editEmail" name="email">
                            </div>
                            <div class="form-group">
                                <label for="editPhone">Phone</label>
                                <input type="text" id="editPhone" name="phone">
                            </div>
                            <div class="form-actions" style="margin-top: 20px;">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                <button type="button" class="btn btn-secondary"
                                    onclick="closeEditUserModal()">Cancel</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>

                    function openAddUserModal() {
                        document.getElementById('addUserModal').style.display = 'flex';
                    }
                    function closeAddUserModal() {
                        document.getElementById('addUserModal').style.display = 'none';
                    }
                    function handleEditClick(btn) {
                        var id = btn.getAttribute('data-userid');
                        var username = btn.getAttribute('data-username');
                        var fullName = btn.getAttribute('data-fullname');
                        var email = btn.getAttribute('data-email');
                        var phone = btn.getAttribute('data-phone');
                        openEditUserModal(id, username, fullName, email, phone);
                    }
                    function openEditUserModal(id, username, fullName, email, phone) {
                        document.getElementById('editUserId').value = id;
                        document.getElementById('editUsername').value = username;
                        document.getElementById('editFullName').value = fullName;
                        document.getElementById('editEmail').value = email;
                        document.getElementById('editPhone').value = phone;
                        document.getElementById('editUserModal').style.display = 'flex';
                    }
                    function closeEditUserModal() {
                        document.getElementById('editUserModal').style.display = 'none';
                    }
                    window.onclick = function (event) {
                        if (event.target.className === 'modal') {
                            event.target.style.display = 'none';
                        }
                    }
                </script>

                <style>
                    .btn-icon {
                        background: none;
                        border: none;
                        color: #2b579a;
                        cursor: pointer;
                        padding: 4px;
                        border-radius: 4px;
                        transition: background 0.2s;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .btn-icon:hover {
                        background: rgba(43, 87, 154, 0.1);
                    }

                    .text-muted {
                        color: #888;
                    }

                    .modal {
                        display: none;
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0, 0, 0, 0.5);
                        z-index: 1000;
                        justify-content: center;
                        align-items: center;
                    }

                    .modal-content {
                        background: white;
                        padding: 24px;
                        border-radius: 8px;
                        width: 90%;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                        overflow-y: auto;
                        max-height: 90vh;
                    }

                    .modal-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                        border-bottom: 1px solid #eee;
                        padding-bottom: 10px;
                    }

                    .close {
                        font-size: 28px;
                        cursor: pointer;
                        color: #888;
                    }

                    .close:hover {
                        color: #333;
                    }

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

                    .badge-admin {
                        background: #E8EAF6;
                        color: #283593;
                    }

                    .badge-staff {
                        background: #E1F5FE;
                        color: #0277BD;
                    }

                    .alert {
                        padding: 12px 20px;
                        border-radius: 8px;
                        margin-bottom: 20px;
                    }

                    .alert-success {
                        background: #D5F4E6;
                        color: #0B5345;
                        border: 1px solid #A3E4D7;
                    }

                    .alert-error {
                        background: #FDEDEC;
                        color: #922B21;
                        border: 1px solid #FADBD8;
                    }

                    .form-group {
                        margin-bottom: 15px;
                    }

                    .form-group label {
                        display: block;
                        margin-bottom: 5px;
                        font-weight: 600;
                        font-size: 14px;
                    }

                    .form-group input,
                    .form-group select {
                        width: 100%;
                        padding: 8px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        box-sizing: border-box;
                    }
                </style>
            </body>

            </html>