package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Logout Servlet
 * Handles user logout and session invalidation
 */
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Handle GET and POST requests for logout
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processLogout(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processLogout(request, response);
    }
    
    /**
     * Process logout - invalidate session and redirect to login
     */
    private void processLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        // Get current session
        HttpSession session = request.getSession(false);
        
        // Invalidate session if exists
        if (session != null) {
            session.invalidate();
        }
        
        // Redirect to login page
        response.sendRedirect("login.jsp");
    }
}
