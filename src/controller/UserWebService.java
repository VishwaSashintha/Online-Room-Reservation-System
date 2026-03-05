package controller;

import service.UserDBService;
import service.UserService;
import model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.List;

@WebServlet("/api/users")
public class UserWebService extends HttpServlet {

    private UserDBService userService = new UserDBService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "authenticate": {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    User user = userService.authenticateUser(username, password);
                    out.print(UserService.userToJson(user));
                    break;
                }
                case "getByUsername": {
                    String username = request.getParameter("username");
                    User user = userService.getUserByUsername(username);
                    out.print(UserService.userToJson(user));
                    break;
                }
                case "getAll": {
                    List<User> users = userService.getAllUsers();
                    out.print(UserService.userListToJson(users));
                    break;
                }
                case "totalUsers": {
                    out.print("{\"value\":" + userService.getTotalUsers() + "}");
                    break;
                }
                case "adminCount": {
                    out.print("{\"value\":" + userService.getAdminCount() + "}");
                    break;
                }
                case "staffCount": {
                    out.print("{\"value\":" + userService.getStaffCount() + "}");
                    break;
                }
                case "emailExists": {
                    String email = request.getParameter("email");
                    out.print("{\"value\":" + userService.emailExists(email) + "}");
                    break;
                }
                case "usernameExists": {
                    String username = request.getParameter("username");
                    out.print("{\"value\":" + userService.usernameExists(username) + "}");
                    break;
                }
                default: {
                    response.setStatus(400);
                    out.print("{\"error\":\"Unknown action: " + action + "\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"" + UserService.escapeJson(e.getMessage()) + "\"}");
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "register": {
                    User user = new User();
                    user.setUsername(request.getParameter("username"));
                    user.setPassword(request.getParameter("password"));
                    user.setRole(request.getParameter("role"));
                    user.setFullName(request.getParameter("fullName"));
                    user.setEmail(request.getParameter("email"));
                    user.setPhone(request.getParameter("phone"));
                    boolean success = userService.registerUser(user);
                    out.print("{\"success\":" + success + "}");
                    break;
                }
                case "update": {
                    User user = new User();
                    user.setUserId(Integer.parseInt(request.getParameter("userId")));
                    user.setUsername(request.getParameter("username"));
                    user.setPassword(request.getParameter("password"));
                    user.setFullName(request.getParameter("fullName"));
                    user.setEmail(request.getParameter("email"));
                    user.setPhone(request.getParameter("phone"));
                    boolean success = userService.updateUser(user);
                    out.print("{\"success\":" + success + "}");
                    break;
                }
                default: {
                    response.setStatus(400);
                    out.print("{\"error\":\"Unknown action: " + action + "\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"" + UserService.escapeJson(e.getMessage()) + "\"}");
        }
        out.flush();
    }
}
