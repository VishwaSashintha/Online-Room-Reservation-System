package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Login Servlet
 * Handles user authentication and session creation
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    /**
     * Handle POST request for login
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Server-side validation
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userDAO.authenticateUser(username.trim(), password);
        
        if (user != null) {
            // Authentication successful - create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            // Set session timeout to 30 minutes
            session.setMaxInactiveInterval(30 * 60);
            
            // Redirect to dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle GET request - redirect to login page
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
