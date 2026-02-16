<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
    <% String errorMessage=(String) request.getAttribute("errorMessage"); if (errorMessage==null) {
        errorMessage="An unexpected error occurred. Please try again." ; } %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Error - Ocean View Resort</title>
            <link rel="stylesheet" href="css/style.css">
        </head>

        <body>
            <div class="login-container">
                <div class="login-card">
                    <div class="login-header" style="background: var(--error-red);">
                        <h1>Error</h1>
                        <p>Ocean View Resort - Reservation Management System</p>
                    </div>
                    <div class="login-body">
                        <div class="alert alert-error">
                            <strong>Error:</strong>
                            <%= errorMessage %>
                        </div>
                        <div style="margin-top: 24px;">
                            <p style="color: var(--text-light); margin-bottom: 16px;">
                                We apologize for the inconvenience. Please try one of the following options:
                            </p>
                            <div style="display: flex; flex-direction: column; gap: 12px;">
                                <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
                                <a href="login.jsp" class="btn btn-primary">Return to Login</a>
                            </div>
                        </div>
                        <div
                            style="margin-top: 24px; padding-top: 20px; border-top: 1px solid var(--border-color); font-size: 13px; color: var(--text-light);">
                            <strong>Need Help?</strong><br>
                            If this error persists, please contact your system administrator or visit the <a
                                href="help.jsp" style="color: var(--secondary-blue);">Help page</a>.
                        </div>
                    </div>
                </div>
            </div>
            <script src="js/validation.js"></script>
        </body>

        </html>