<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.Reservation, dao.ReservationDAO, java.util.List, java.util.ArrayList" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; }
            String role=(String) session.getAttribute("role"); String searchType=request.getParameter("searchType");
            String idParam=request.getParameter("reservationId"); String nameParam=request.getParameter("guestName");
            String errorMessage=null; String successMessage=null; Reservation singleResult=null; List<Reservation>
            listResults = new ArrayList<Reservation>();
                boolean searched = false;

                if (searchType != null) {
                searched = true;
                ReservationDAO dao = new ReservationDAO();
                try {
                if ("name".equals(searchType)) {
                if (nameParam == null || nameParam.trim().isEmpty()) {
                errorMessage = "Please enter a guest name to search!";
                } else {
                listResults = dao.searchByGuestName(nameParam.trim());
                if (listResults == null || listResults.isEmpty()) {
                errorMessage = "No reservations found for: \"" + nameParam.trim() + "\"";
                listResults = new ArrayList<Reservation>();
                    } else {
                    successMessage = listResults.size() + " reservation(s) found for \"" + nameParam.trim() + "\"";
                    }
                    }
                    } else {
                    if (idParam == null || idParam.trim().isEmpty()) {
                    errorMessage = "Please enter a Reservation ID!";
                    } else {
                    int rid = Integer.parseInt(idParam.trim());
                    singleResult = dao.searchReservation(rid);
                    if (singleResult == null) {
                    errorMessage = "No reservation found with ID: " + rid;
                    } else {
                    successMessage = "Reservation found!";
                    }
                    }
                    }
                    } catch (NumberFormatException e) {
                    errorMessage = "Invalid Reservation ID — please enter a number!";
                    } catch (Exception e) {
                    errorMessage = "Database error: " + e.getMessage();
                    }
                    }
                    if (searchType == null) searchType = "id";
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Search Reservation - Ocean View Resort</title>
                        <link rel="stylesheet" href="css/style.css">
                        <style>
                            .search-tabs {
                                display: flex;
                                border-bottom: 2px solid #e0e0e0;
                                margin-bottom: 20px;
                            }

                            .tab-btn {
                                padding: 10px 28px;
                                cursor: pointer;
                                font-weight: 600;
                                color: #888;
                                background: none;
                                border: none;
                                border-bottom: 3px solid transparent;
                                margin-bottom: -2px;
                                font-size: 15px;
                                transition: color .2s, border-color .2s;
                            }

                            .tab-btn.active {
                                color: #1a73e8;
                                border-bottom: 3px solid #1a73e8;
                            }

                            .tab-panel {
                                display: none;
                            }

                            .tab-panel.active {
                                display: block;
                            }
                        </style>
                    </head>

                    <body>
                        <jsp:include page="includes/header.jsp" />
                        <div class="dashboard-wrapper">
                            <jsp:include page="includes/sidebar.jsp" />
                            <div class="main-content">
                                <div class="content-header">
                                    <h2>Search Reservation</h2>
                                    <p>Find bookings by Reservation ID or Guest Name</p>
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

                                                    <div class="search-tabs">
                                                        <button class="tab-btn <%= !" name".equals(searchType)
                                                            ? "active" : "" %>" onclick="showTab('id', this)">Search by
                                                            ID</button>
                                                        <button class="tab-btn <%= " name".equals(searchType) ? "active"
                                                            : "" %>" onclick="showTab('name', this)">Search by Guest
                                                            Name</button>
                                                    </div>

                                                    <!-- Search by ID -->
                                                    <div class="tab-panel <%= !" name".equals(searchType) ? "active"
                                                        : "" %>" id="tab-id">
                                                        <form action="searchReservation.jsp" method="get">
                                                            <input type="hidden" name="searchType" value="id">
                                                            <div class="form-row">
                                                                <div class="form-group" style="flex:1;">
                                                                    <label for="reservationId">Reservation ID</label>
                                                                    <input type="number" id="reservationId"
                                                                        name="reservationId"
                                                                        placeholder="Enter numeric reservation ID"
                                                                        value="<%= idParam != null ? idParam : "" %>">
                                                                </div>
                                                                <div class="form-group"
                                                                    style="flex:0 0 150px; align-self:flex-end;">
                                                                    <button type="submit" class="btn btn-primary"
                                                                        style="width:100%;">Search</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>

                                                    <!-- Search by Name -->
                                                    <div class="tab-panel <%= " name".equals(searchType) ? "active" : ""
                                                        %>" id="tab-name">
                                                        <form action="searchReservation.jsp" method="get">
                                                            <input type="hidden" name="searchType" value="name">
                                                            <div class="form-row">
                                                                <div class="form-group" style="flex:1;">
                                                                    <label for="guestName">Guest Name</label>
                                                                    <input type="text" id="guestName" name="guestName"
                                                                        placeholder="Enter full or partial guest name"
                                                                        value="<%= nameParam != null ? nameParam : "" %>">
                                                                </div>
                                                                <div class="form-group"
                                                                    style="flex:0 0 150px; align-self:flex-end;">
                                                                    <button type="submit" class="btn btn-primary"
                                                                        style="width:100%;">Search</button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                </div>

                                <%-- Single result (ID search) --%>
                                    <% if (singleResult !=null) { %>
                                        <div class="card">
                                            <div class="card-header">
                                                <h3>Reservation Details</h3>
                                            </div>
                                            <div class="table-container">
                                                <table class="data-table">
                                                    <thead>
                                                        <tr>
                                                            <th>Field</th>
                                                            <th>Value</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td><strong>Reservation ID</strong></td>
                                                            <td>
                                                                <%= singleResult.getReservationId() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Guest Name</strong></td>
                                                            <td>
                                                                <%= singleResult.getGuestName() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Address</strong></td>
                                                            <td>
                                                                <%= singleResult.getAddress() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Contact</strong></td>
                                                            <td>
                                                                <%= singleResult.getContact() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Room Type</strong></td>
                                                            <td><span class="text-blue" style="font-weight:600;">
                                                                    <%= singleResult.getRoomType() %>
                                                                </span></td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Check-in</strong></td>
                                                            <td>
                                                                <%= singleResult.getCheckIn() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Check-out</strong></td>
                                                            <td>
                                                                <%= singleResult.getCheckOut() %>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Total Bill</strong></td>
                                                            <td><span class="text-orange" style="font-weight:700;">LKR
                                                                    <%= String.format("%,.2f",
                                                                        singleResult.getTotalBill()) %></span></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="form-actions" style="margin-top:20px;">
                                                <form action="UpdateReservationServlet" method="get"
                                                    style="display:inline;">
                                                    <input type="hidden" name="reservationId"
                                                        value="<%= singleResult.getReservationId() %>">
                                                    <input type="hidden" name="action" value="load">
                                                    <button type="submit" class="btn btn-primary">Edit</button>
                                                </form>
                                                <% if ("ADMIN".equals(role)) { %>
                                                    <form action="DeleteReservationServlet" method="get"
                                                        style="display:inline;">
                                                        <input type="hidden" name="reservationId"
                                                            value="<%= singleResult.getReservationId() %>">
                                                        <input type="hidden" name="action" value="load">
                                                        <button type="submit" class="btn btn-danger">Delete</button>
                                                    </form>
                                                    <% } %>
                                            </div>
                                        </div>
                                        <% } %>

                                            <%-- Multiple results (Name search) --%>
                                                <% if (!listResults.isEmpty()) { %>
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h3>Search Results (<%= listResults.size() %> found)</h3>
                                                        </div>
                                                        <div class="table-container">
                                                            <table class="data-table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>ID</th>
                                                                        <th>Guest Name</th>
                                                                        <th>Room Type</th>
                                                                        <th>Check-in</th>
                                                                        <th>Check-out</th>
                                                                        <th>Total Bill</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <% for (Reservation r : listResults) { %>
                                                                        <tr>
                                                                            <td>
                                                                                <%= r.getReservationId() %>
                                                                            </td>
                                                                            <td><strong>
                                                                                    <%= r.getGuestName() %>
                                                                                </strong></td>
                                                                            <td><span class="text-blue"
                                                                                    style="font-weight:600;">
                                                                                    <%= r.getRoomType() %>
                                                                                </span></td>
                                                                            <td>
                                                                                <%= r.getCheckIn() %>
                                                                            </td>
                                                                            <td>
                                                                                <%= r.getCheckOut() %>
                                                                            </td>
                                                                            <td><span class="text-orange"
                                                                                    style="font-weight:700;">LKR <%=
                                                                                        String.format("%,.2f",
                                                                                        r.getTotalBill()) %></span></td>
                                                                            <td>
                                                                                <form action="UpdateReservationServlet"
                                                                                    method="get"
                                                                                    style="display:inline;">
                                                                                    <input type="hidden"
                                                                                        name="reservationId"
                                                                                        value="<%= r.getReservationId() %>">
                                                                                    <input type="hidden" name="action"
                                                                                        value="load">
                                                                                    <button type="submit"
                                                                                        class="btn btn-primary"
                                                                                        style="padding:4px 12px;font-size:13px;">Edit</button>
                                                                                </form>
                                                                                <% if ("ADMIN".equals(role)) { %>
                                                                                    <form
                                                                                        action="DeleteReservationServlet"
                                                                                        method="get"
                                                                                        style="display:inline;">
                                                                                        <input type="hidden"
                                                                                            name="reservationId"
                                                                                            value="<%= r.getReservationId() %>">
                                                                                        <input type="hidden"
                                                                                            name="action" value="load">
                                                                                        <button type="submit"
                                                                                            class="btn btn-danger"
                                                                                            style="padding:4px 12px;font-size:13px;">Delete</button>
                                                                                    </form>
                                                                                    <% } %>
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <% } %>

                            </div>
                        </div>
                        <script>
                            function showTab(tab, btn) {
                                document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
                                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                                document.getElementById('tab-' + tab).classList.add('active');
                                btn.classList.add('active');
                            }
                        </script>
                    </body>

                    </html>