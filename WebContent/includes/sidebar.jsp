<%@ page import="model.User" %>
    <% User sidebarUser=(User) session.getAttribute("user"); boolean sidebarIsAdmin="ADMIN"
        .equals(sidebarUser.getRole()); String currentPage=request.getRequestURI(); %>
        <div class="sidebar">
            <ul class="sidebar-menu">
                <li>
                    <% String dashboardLink=sidebarIsAdmin ? "adminDashboard.jsp" : "staffDashboard.jsp" ; %>
                        <a href="<%= dashboardLink %>" class="<%= currentPage.contains(" Dashboard") ? "active" : ""
                            %>">
                            <span class="menu-icon"></span>
                            <span>Dashboard</span>
                        </a>
                </li>
                <li>
                    <a href="addReservation.jsp" class="<%= currentPage.contains(" addReservation") ? "active" : "" %>">
                        <span class="menu-icon"></span>
                        <span>Add Reservation</span>
                    </a>
                </li>
                <li>
                    <a href="searchReservation.jsp" class="<%= currentPage.contains(" searchReservation") ? "active"
                        : "" %>">
                        <span class="menu-icon"></span>
                        <span>Search Reservation</span>
                    </a>
                </li>
                <li>
                    <a href="updateReservation.jsp" class="<%= currentPage.contains(" updateReservation") ? "active"
                        : "" %>">
                        <span class="menu-icon"></span>
                        <span>Update Reservation</span>
                    </a>
                </li>
                <% if (sidebarIsAdmin) { %>
                    <li>
                        <a href="deleteReservation.jsp" class="<%= currentPage.contains(" deleteReservation") ? "active"
                            : "" %>">
                            <span class="menu-icon"></span>
                            <span>Delete Reservation</span>
                        </a>
                    </li>
                    <% } %>
                        <li>
                            <a href="roomAvailability.jsp" class="<%= currentPage.contains(" roomAvailability")
                                ? "active" : "" %>">
                                <span class="menu-icon"></span>
                                <span>Room Availability</span>
                            </a>
                        </li>
                        <% if (sidebarIsAdmin) { %>
                            <li>
                                <a href="manageUsers.jsp" class="<%= currentPage.contains(" manageUsers") ? "active"
                                    : "" %>">
                                    <span class="menu-icon"></span>
                                    <span>Manage Users</span>
                                </a>
                            </li>
                            <li>
                                <a href="reports.jsp" class="<%= currentPage.contains(" reports") ? "active" : "" %>">
                                    <span class="menu-icon"></span>
                                    <span>Reports & Statistics</span>
                                </a>
                            </li>
                            <% } %>
                                <li>
                                    <a href="help.jsp" class="<%= currentPage.contains(" help") ? "active" : "" %>">
                                        <span class="menu-icon"></span>
                                        <span>Help</span>
                                    </a>
                                </li>
            </ul>
        </div>
        <style>
            .menu-icon {
                margin-right: 12px;
                font-size: 18px;
            }
        </style>