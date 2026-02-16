<%@ page import="model.User" %>
    <% User headerUser=(User) session.getAttribute("user"); boolean headerIsAdmin="ADMIN" .equals(headerUser.getRole());
        %>
        <div class="header">
            <div class="header-left">
                <span class="logo">OVR</span>
                <span class="system-name">Ocean View Resort</span>
            </div>
            <div class="header-right">
                <div class="user-info">
                    Welcome, <strong>
                        <%= headerUser.getUsername() %>
                    </strong>
                    <span class="badge <%= headerIsAdmin ? " badge-admin" : "badge-staff" %>">
                        <%= headerIsAdmin ? "ADMIN" : "STAFF" %>
                    </span>
                </div>
                <a href="LogoutServlet" class="btn-logout">Logout</a>
            </div>
        </div>
        <style>
            .badge {
                padding: 4px 12px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: 600;
                margin-left: 8px;
            }

            .badge-admin {
                background: var(--accent-orange);
                color: white;
            }

            .badge-staff {
                background: var(--secondary-blue);
                color: white;
            }
        </style>