package controller;

import service.UserService;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
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
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            UserService userService = new UserService();
            // Fetch existing user to preserve the password since it's not in the edit form
            User existingUser = userService.getUserByUsername(username);
            String existingPassword = (existingUser != null) ? existingUser.getPassword() : "";

            User userToUpdate = new User();
            userToUpdate.setUserId(userId);
            userToUpdate.setUsername(username);
            userToUpdate.setPassword(existingPassword);
            userToUpdate.setFullName(fullName);
            userToUpdate.setEmail(email);
            userToUpdate.setPhone(phone);

            boolean success = userService.updateUser(userToUpdate);

            if (success) {
                request.setAttribute("successMessage", "User updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update user.");
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }
}
