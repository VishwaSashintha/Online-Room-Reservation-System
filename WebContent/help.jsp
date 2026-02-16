<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } String
        username=(String) session.getAttribute("username"); String role=(String) session.getAttribute("role"); %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Help - Ocean View Resort</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <jsp:include page="includes/header.jsp" />
            <div class="dashboard-wrapper">
                <jsp:include page="includes/sidebar.jsp" />
                <div class="main-content">
                    <div class="content-header">
                        <h2>System Documentation</h2>
                        <p>Learn how to use the Ocean View Resort Reservation Management System</p>
                    </div>
                    <div class="card">
                        <div class="accordion-item">
                            <div class="accordion-header" onclick="toggleAccordion(this)">
                                <h4>How to Login</h4>
                                <span class="accordion-icon">▼</span>
                            </div>
                            <div class="accordion-content">
                                <div class="accordion-body">
                                    <p><strong>Step 1:</strong> Open the login page (default page when accessing the
                                        system)</p>
                                    <p><strong>Step 2:</strong> Enter your username and password</p>
                                    <p><strong>Step 3:</strong> Click the "Login" button</p>
                                    <p><strong>Note:</strong> If you enter incorrect credentials, an error message will
                                        appear. Contact your administrator if you've forgotten your password.</p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <div class="accordion-header" onclick="toggleAccordion(this)">
                                <h3>Frequently Asked Questions</h3>
                                <span class="accordion-icon">▼</span>
                            </div>
                            <div class="accordion-content">
                                <div class="accordion-body">
                                    <p><strong>Step 1:</strong> Click "Add Reservation" from the sidebar menu</p>
                                    <p><strong>Step 2:</strong> Fill in all required fields:</p>
                                    <ul>
                                        <li><strong>Reservation ID:</strong> Enter a unique numeric ID</li>
                                        <li><strong>Guest Name:</strong> Full name of the guest</li>
                                        <li><strong>Address:</strong> Guest's address</li>
                                        <li><strong>Contact Number:</strong> 10-digit phone number</li>
                                        <li><strong>Room Type:</strong> Select from Standard, Deluxe, or Suite</li>
                                        <li><strong>Check-in Date:</strong> Arrival date</li>
                                        <li><strong>Check-out Date:</strong> Departure date (must be after check-in)
                                        </li>
                                    </ul>
                                    <p><strong>Step 3:</strong> The system will automatically calculate the total bill
                                        based on room type and number of nights</p>
                                    <p><strong>Step 4:</strong> Click "Add Reservation" to save</p>
                                    <p><strong>Important:</strong> The system prevents double booking. If the selected
                                        room type is already booked for overlapping dates, you'll receive an error
                                        message.</p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <div class="accordion-header" onclick="toggleAccordion(this)">
                                <h4>How to Search for a Reservation</h4>
                                <span class="accordion-icon">▼</span>
                            </div>
                            <div class="accordion-content">
                                <div class="accordion-body">
                                    <p><strong>Step 1:</strong> Click "Search Reservation" from the sidebar menu</p>
                                    <p><strong>Step 2:</strong> Enter the Reservation ID you want to find</p>
                                    <p><strong>Step 3:</strong> Click "Search"</p>
                                    <p><strong>Result:</strong> If found, all reservation details will be displayed in a
                                        formatted table. If not found, an error message will appear.</p>
                                    <p><strong>Quick Actions:</strong> From the search results, you can directly edit or
                                        delete the reservation (delete requires admin role).</p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <div class="accordion-header" onclick="toggleAccordion(this)">
                                <h4>How to Update a Reservation</h4>
                                <span class="accordion-icon">▼</span>
                            </div>
                            <div class="accordion-content">
                                <div class="accordion-body">
                                    <p><strong>Step 1:</strong> Click "Update Reservation" from the sidebar menu</p>
                                    <p><strong>Step 2:</strong> Enter the Reservation ID you want to update</p>
                                    <p><strong>Step 3:</strong> Click "Load Reservation"</p>
                                    <p><strong>Step 4:</strong> The form will be pre-filled with existing data. Modify
                                        any fields as needed</p>
                                    <p><strong>Step 5:</strong> The total bill will automatically recalculate if you
                                        change the room type or dates</p>
                                    <p><strong>Step 6:</strong> Click "Update Reservation" to save changes</p>
                                    <p><strong>Note:</strong> The Reservation ID cannot be changed. All other fields can
                                        be modified.</p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <div class="accordion-header" onclick="toggleAccordion(this)">
                                <h4>How Billing Works</h4>
                                <span class="accordion-icon">▼</span>
                            </div>
                            <div class="accordion-content">
                                <div class="accordion-body">
                                    <p><strong>Room Rates:</strong></p>
                                    <ul>
                                        <li>Standard Room: LKR 8,000 per night</li>
                                        <li>Deluxe Room: LKR 12,000 per night</li>
                                        <li>Suite: LKR 20,000 per night</li>
                                    </ul>
                                    <p><strong>Calculation Formula:</strong></p>
                                    <p><code>Total Bill = Number of Nights × Room Rate</code></p>
                                    <p><strong>Example:</strong></p>
                                    <ul>
                                        <li>Room Type: Deluxe (LKR 12,000/night)</li>
                                        <li>Check-in: February 20, 2026</li>
                                        <li>Check-out: February 23, 2026</li>
                                        <li>Number of Nights: 3</li>
                                        <li>Total Bill: 3 × 12,000 = LKR 36,000</li>
                                    </ul>
                                    <p><strong>Automatic Calculation:</strong> The system automatically calculates the
                                        bill when you select room type and dates. The billing summary shows a detailed
                                        breakdown.</p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <div class="accordion-header" onclick="toggleAccordion(this)">
                                <h4>System Rules & Policies</h4>
                                <span class="accordion-icon">▼</span>
                            </div>
                            <div class="accordion-content">
                                <div class="accordion-body">
                                    <p><strong>Double Booking Prevention:</strong></p>
                                    <p>The system automatically checks for overlapping bookings. You cannot book the
                                        same room type for dates that overlap with existing reservations.</p>
                                    <p><strong>Role-Based Access:</strong></p>
                                    <ul>
                                        <li><strong>ADMIN:</strong> Full access to all features including delete
                                            functionality</li>
                                        <li><strong>STAFF:</strong> Can add, search, and update reservations but cannot
                                            delete</li>
                                    </ul>
                                    <p><strong>Session Management:</strong></p>
                                    <ul>
                                        <li>Sessions expire after 30 minutes of inactivity</li>
                                        <li>You'll be automatically logged out for security</li>
                                        <li>Always logout when finished to protect your account</li>
                                    </ul>
                                    <p><strong>Data Validation:</strong></p>
                                    <ul>
                                        <li>Contact numbers must be exactly 10 digits</li>
                                        <li>Check-out date must be after check-in date</li>
                                        <li>Check-in date cannot be in the past</li>
                                        <li>All required fields must be filled</li>
                                    </ul>
                                    <p><strong>Reservation ID:</strong></p>
                                    <ul>
                                        <li>Must be unique (no duplicates allowed)</li>
                                        <li>Must be a positive number</li>
                                        <li>Cannot be changed after creation</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="footer">
                        © 2026 Ocean View Resort | Galle
                    </div>
                </div>
            </div>
            <script>
                function toggleAccordion(header) {
                    const item = header.parentElement;
                    item.classList.toggle('active');
                    const icon = header.querySelector('.accordion-icon');
                    icon.textContent = item.classList.contains('active') ? '▲' : '▼';
                }
            </script>
        </body>

        </html>