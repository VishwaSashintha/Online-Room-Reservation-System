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
@WebServlet("/DeleteReservationServlet")
public class DeleteReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            request.setAttribute("errorMessage", "Access Denied! Only administrators can delete reservations.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
        request.getRequestDispatcher("deleteReservation.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            request.setAttribute("errorMessage", "Access Denied! Only administrators can delete reservations.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            boolean success = reservationDAO.deleteReservation(reservationId);
            if (success) {
                request.setAttribute("successMessage", "Reservation deleted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to delete reservation!");
            }
            request.getRequestDispatcher("deleteReservation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid reservation ID!");
            request.getRequestDispatcher("deleteReservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
