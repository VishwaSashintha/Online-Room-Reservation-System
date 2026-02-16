package controller;

import dao.ReservationDAO;
import model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Search Reservation Servlet
 * Handles searching for reservations by ID
 */
@WebServlet("/SearchReservationServlet")
public class SearchReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
    }
    
    /**
     * Handle POST request to search reservation
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get search parameter
            String reservationIdStr = request.getParameter("reservationId");
            
            if (reservationIdStr == null || reservationIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please enter a reservation ID!");
                request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
                return;
            }
            
            int reservationId = Integer.parseInt(reservationIdStr.trim());
            
            // Search for reservation
            Reservation reservation = reservationDAO.searchReservation(reservationId);
            
            if (reservation != null) {
                request.setAttribute("reservation", reservation);
                request.setAttribute("successMessage", "Reservation found!");
            } else {
                request.setAttribute("errorMessage", "Reservation not found with ID: " + reservationId);
            }
            
            request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid reservation ID format!");
            request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle GET request - redirect to search page
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
    }
}
