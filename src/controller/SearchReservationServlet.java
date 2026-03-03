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
import java.util.List;

@WebServlet("/SearchReservationServlet")
public class SearchReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String searchType = request.getParameter("searchType");
        String reservationIdStr = request.getParameter("reservationId");
        String guestName = request.getParameter("guestName");
        try {
            if ("name".equals(searchType)) {
                if (guestName == null || guestName.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please enter a guest name to search!");
                    request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
                    return;
                }
                List<Reservation> results = reservationDAO.searchByGuestName(guestName.trim());
                if (results != null && !results.isEmpty()) {
                    request.setAttribute("reservationList", results);
                    request.setAttribute("successMessage",
                            results.size() + " reservation(s) found for \"" + guestName.trim() + "\"");
                } else {
                    request.setAttribute("errorMessage", "No reservations found for guest name: " + guestName.trim());
                }
            } else {
                if (reservationIdStr == null || reservationIdStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Please enter a Reservation ID!");
                    request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
                    return;
                }
                int reservationId = Integer.parseInt(reservationIdStr.trim());
                Reservation reservation = reservationDAO.searchReservation(reservationId);
                if (reservation != null) {
                    request.setAttribute("reservation", reservation);
                    request.setAttribute("successMessage", "Reservation found!");
                } else {
                    request.setAttribute("errorMessage", "No reservation found with ID: " + reservationId);
                }
            }
            request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Reservation ID — please enter a numeric ID!");
            request.getRequestDispatcher("searchReservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
