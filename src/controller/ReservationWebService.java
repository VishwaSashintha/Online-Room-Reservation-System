package controller;

import service.ReservationService;
import model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.Date;
import java.util.List;

@WebServlet("/api/reservations")
public class ReservationWebService extends HttpServlet {

    private ReservationService reservationService = new ReservationService();

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
                case "search": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Reservation r = reservationService.searchReservation(id);
                    if (r != null) {
                        out.print(ReservationService.reservationToJson(r));
                    } else {
                        out.print("null");
                    }
                    break;
                }
                case "searchByName": {
                    String name = request.getParameter("name");
                    List<Reservation> list = reservationService.searchByGuestName(name);
                    out.print(ReservationService.reservationListToJson(list));
                    break;
                }
                case "getAll": {
                    List<Reservation> list = reservationService.getAllReservations();
                    out.print(ReservationService.reservationListToJson(list));
                    break;
                }
                case "totalReservations": {
                    out.print("{\"value\":" + reservationService.getTotalReservations() + "}");
                    break;
                }
                case "activeBookings": {
                    out.print("{\"value\":" + reservationService.getActiveBookings() + "}");
                    break;
                }
                case "totalRevenue": {
                    out.print("{\"value\":" + reservationService.getTotalRevenue() + "}");
                    break;
                }
                case "todayCheckIns": {
                    out.print("{\"value\":" + reservationService.getTodayCheckIns() + "}");
                    break;
                }
                case "todayCheckOuts": {
                    out.print("{\"value\":" + reservationService.getTodayCheckOuts() + "}");
                    break;
                }
                case "monthlyRevenue": {
                    out.print("{\"value\":" + reservationService.getMonthlyRevenue() + "}");
                    break;
                }
                case "monthlyBookings": {
                    out.print("{\"value\":" + reservationService.getMonthlyBookings() + "}");
                    break;
                }
                case "bookedCountByRoomType": {
                    String roomType = request.getParameter("roomType");
                    out.print("{\"value\":" + reservationService.getBookedCountByRoomType(roomType) + "}");
                    break;
                }
                case "bookedCountByRoomTypeAndDateRange": {
                    String roomType = request.getParameter("roomType");
                    Date checkIn = Date.valueOf(request.getParameter("checkIn"));
                    Date checkOut = Date.valueOf(request.getParameter("checkOut"));
                    out.print("{\"value\":"
                            + reservationService.getBookedCountByRoomTypeAndDateRange(roomType, checkIn, checkOut)
                            + "}");
                    break;
                }
                case "revenueByRoomType": {
                    String roomType = request.getParameter("roomType");
                    out.print("{\"value\":" + reservationService.getRevenueByRoomType(roomType) + "}");
                    break;
                }
                case "bookingCountByRoomType": {
                    String roomType = request.getParameter("roomType");
                    out.print("{\"value\":" + reservationService.getBookingCountByRoomType(roomType) + "}");
                    break;
                }
                case "totalNightsByRoomType": {
                    String roomType = request.getParameter("roomType");
                    out.print("{\"value\":" + reservationService.getTotalNightsByRoomType(roomType) + "}");
                    break;
                }
                default: {
                    response.setStatus(400);
                    out.print("{\"error\":\"Unknown action: " + action + "\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(500);
            out.print("{\"error\":\"" + ReservationService.escapeJson(e.getMessage()) + "\"}");
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
                case "add": {
                    Reservation r = new Reservation();
                    r.setReservationId(Integer.parseInt(request.getParameter("reservationId")));
                    r.setGuestName(request.getParameter("guestName"));
                    r.setAddress(request.getParameter("address"));
                    r.setContact(request.getParameter("contact"));
                    r.setRoomType(request.getParameter("roomType"));
                    r.setCheckIn(Date.valueOf(request.getParameter("checkIn")));
                    r.setCheckOut(Date.valueOf(request.getParameter("checkOut")));
                    r.setTotalBill(Double.parseDouble(request.getParameter("totalBill")));
                    boolean success = reservationService.addReservation(r);
                    out.print("{\"success\":" + success + "}");
                    break;
                }
                case "update": {
                    Reservation r = new Reservation();
                    r.setReservationId(Integer.parseInt(request.getParameter("reservationId")));
                    r.setGuestName(request.getParameter("guestName"));
                    r.setAddress(request.getParameter("address"));
                    r.setContact(request.getParameter("contact"));
                    r.setRoomType(request.getParameter("roomType"));
                    r.setCheckIn(Date.valueOf(request.getParameter("checkIn")));
                    r.setCheckOut(Date.valueOf(request.getParameter("checkOut")));
                    r.setTotalBill(Double.parseDouble(request.getParameter("totalBill")));
                    boolean success = reservationService.updateReservation(r);
                    out.print("{\"success\":" + success + "}");
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean success = reservationService.deleteReservation(id);
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
            out.print("{\"error\":\"" + ReservationService.escapeJson(e.getMessage()) + "\"}");
        }
        out.flush();
    }
}
