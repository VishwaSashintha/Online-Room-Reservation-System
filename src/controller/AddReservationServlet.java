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
@WebServlet("/AddReservationServlet")
public class AddReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;
    @Override
    public void init() throws ServletException {
        reservationDAO = new ReservationDAO();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            String guestName = request.getParameter("guestName");
            String address = request.getParameter("address");
            String contact = request.getParameter("contact");
            String roomType = request.getParameter("roomType");
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));
            double totalBill = Double.parseDouble(request.getParameter("totalBill"));
            if (guestName == null || guestName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Guest name is required!");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
                return;
            }
            if (contact == null || !contact.matches("\\d{10}")) {
                request.setAttribute("errorMessage", "Contact must be 10 digits!");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
                return;
            }
            if (checkOut.before(checkIn) || checkOut.equals(checkIn)) {
                request.setAttribute("errorMessage", "Check-out date must be after check-in date!");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
                return;
            }
            if (reservationDAO.searchReservation(reservationId) != null) {
                request.setAttribute("errorMessage", "Reservation ID already exists! Please use a different ID.");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
                return;
            }
            Reservation reservation = new Reservation();
            reservation.setReservationId(reservationId);
            reservation.setGuestName(guestName.trim());
            reservation.setAddress(address.trim());
            reservation.setContact(contact.trim());
            reservation.setRoomType(roomType);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);
            reservation.setTotalBill(totalBill);
            boolean success = reservationDAO.addReservation(reservation);
            if (success) {
                request.setAttribute("successMessage", "Reservation added successfully!");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Room already booked for selected dates! Please choose different dates.");
                request.getRequestDispatcher("addReservation.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format!");
            request.getRequestDispatcher("addReservation.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid date format!");
            request.getRequestDispatcher("addReservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("addReservation.jsp").forward(request, response);
    }
}
