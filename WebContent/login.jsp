<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Ocean View Resort</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <div class="login-container">
            <div class="login-card">
                <div class="login-header">
                    <h1>Ocean View Resort</h1>
                    <p>Reservation Management System</p>
                </div>
                <div class="login-body">
                    <% String errorMessage=(String) request.getAttribute("errorMessage"); String successMessage=(String)
                        request.getAttribute("successMessage"); if (errorMessage !=null) { %>
                        <div class="alert alert-error">
                            <span class="alert-icon"></span>
                            <span>
                                <%= errorMessage %>
                            </span>
                        </div>
                        <% } %>
                            <% if (successMessage !=null) { %>
                                <div class="alert alert-success">
                                    <span class="alert-icon"></span>
                                    <span>
                                        <%= successMessage %>
                                    </span>
                                </div>
                                <% } %>
                                    <form action="LoginServlet" method="post"
                                        onsubmit="return validateLoginForm(event)">
                                        <div class="form-group">
                                            <label for="username">Username</label>
                                            <input type="text" id="username" name="username"
                                                placeholder="Enter your username" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="password">Password</label>
                                            <div class="password-wrapper">
                                                <input type="password" id="password" name="password"
                                                    placeholder="Enter your password" required>
                                                <button type="button" class="password-toggle" id="passwordToggle"
                                                    onclick="togglePassword()">Show</button>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                                    </form>
                </div>
            </div>
        </div>
        <script src="js/validation.js"></script>
    </body>

    </html>