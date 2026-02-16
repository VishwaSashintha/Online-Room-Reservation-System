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
import java.sql.Date;

/**
 * Update Reservation Servlet
 * Handles updating existing reservations
 */
@WebServlet("/UpdateReservationServlet")
public class UpdateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
    }
    
    /**
     * Handle GET request - load reservation for editing
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("load".equals(action)) {
            try {
                int reservationId = Integer.parseInt(request.getParameter("reservationId"));
                Reservation reservation = reservationDAO.searchReservation(reservationId);
                
                if (reservation != null) {
                    request.setAttribute("reservation", reservation);
                } else {
                    request.setAttribute("errorMessage", "Reservation not found!");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid reservation ID!");
            }
        }
        
        request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
    }
    
    /**
     * Handle POST request - update reservation
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
            // Get form parameters
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            String guestName = request.getParameter("guestName");
            String address = request.getParameter("address");
            String contact = request.getParameter("contact");
            String roomType = request.getParameter("roomType");
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));
            double totalBill = Double.parseDouble(request.getParameter("totalBill"));
            
            // Server-side validation
            if (guestName == null || guestName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Guest name is required!");
                request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
                return;
            }
            
            if (contact == null || !contact.matches("\\d{10}")) {
                request.setAttribute("errorMessage", "Contact must be 10 digits!");
                request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
                return;
            }
            
            if (checkOut.before(checkIn) || checkOut.equals(checkIn)) {
                request.setAttribute("errorMessage", "Check-out date must be after check-in date!");
                request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
                return;
            }
            
            // Create reservation object
            Reservation reservation = new Reservation();
            reservation.setReservationId(reservationId);
            reservation.setGuestName(guestName.trim());
            reservation.setAddress(address.trim());
            reservation.setContact(contact.trim());
            reservation.setRoomType(roomType);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);
            reservation.setTotalBill(totalBill);
            
            // Update reservation
            boolean success = reservationDAO.updateReservation(reservation);
            
            if (success) {
                request.setAttribute("successMessage", "Reservation updated successfully!");
                request.setAttribute("reservation", reservation);
            } else {
                request.setAttribute("errorMessage", "Failed to update reservation!");
            }
            
            request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format!");
            request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid date format!");
            request.getRequestDispatcher("updateReservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
