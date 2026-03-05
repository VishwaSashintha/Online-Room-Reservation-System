package controller;

import service.UserService;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (!"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect("staffDashboard.jsp");
            return;
        }

        try {
            String adminUsername = request.getParameter("adminUsername");
            String adminPassword = request.getParameter("adminPassword");

            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");

            UserService userService = new UserService();

            // Security Validation: Verify admin credentials
            User verifiedAdmin = userService.authenticateUser(adminUsername, adminPassword);
            if (verifiedAdmin == null || !"ADMIN".equals(verifiedAdmin.getRole())
                    || !verifiedAdmin.getUsername().equals(currentUser.getUsername())) {
                request.setAttribute("errorMessage", "Admin verification failed. Incorrect username or password.");
            } else {
                User newUser = new User();
                newUser.setUsername(username);
                newUser.setPassword(password);
                newUser.setFullName(fullName);
                newUser.setEmail(email);
                newUser.setPhone(phone);
                newUser.setRole(role);

                boolean success = userService.registerUser(newUser);

                if (success) {
                    request.setAttribute("successMessage", "User added successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to add user. Username or email might already exist.");
                }
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }
}
