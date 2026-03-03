package service;

import dao.DBConnection;
import model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationService {

    public boolean addReservation(Reservation reservation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            if (isRoomBooked(reservation.getRoomType(), reservation.getCheckIn(),
                    reservation.getCheckOut(), conn)) {
                return false;
            }
            String sql = "INSERT INTO reservations (reservation_id, guest_name, address, contact, " +
                    "room_type, check_in, check_out, total_bill) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reservation.getReservationId());
            pstmt.setString(2, reservation.getGuestName());
            pstmt.setString(3, reservation.getAddress());
            pstmt.setString(4, reservation.getContact());
            pstmt.setString(5, reservation.getRoomType());
            pstmt.setDate(6, reservation.getCheckIn());
            pstmt.setDate(7, reservation.getCheckOut());
            pstmt.setDouble(8, reservation.getTotalBill());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    private int getTotalRoomsByType(String roomType) {
        switch (roomType) {
            case "Standard":
                return 10;
            case "Deluxe":
                return 8;
            case "Suite":
                return 5;
            default:
                return 1;
        }
    }

    private boolean isRoomBooked(String roomType, Date checkIn, Date checkOut, Connection conn) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT COUNT(*) FROM reservations WHERE room_type = ? AND (check_in < ? AND check_out > ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, roomType);
            pstmt.setDate(2, checkOut);
            pstmt.setDate(3, checkIn);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) >= getTotalRoomsByType(roomType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
            } catch (SQLException e) {
            }
        }
        return false;
    }

    public Reservation searchReservation(int reservationId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement("SELECT * FROM reservations WHERE reservation_id = ?");
            pstmt.setInt(1, reservationId);
            rs = pstmt.executeQuery();
            if (rs.next())
                return extractReservation(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return null;
    }

    public List<Reservation> searchByGuestName(String guestName) {
        List<Reservation> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(
                    "SELECT * FROM reservations WHERE LOWER(guest_name) LIKE ? ORDER BY check_in DESC");
            pstmt.setString(1, "%" + guestName.toLowerCase() + "%");
            rs = pstmt.executeQuery();
            while (rs.next())
                list.add(extractReservation(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return list;
    }

    public boolean updateReservation(Reservation reservation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE reservations SET guest_name=?, address=?, contact=?, room_type=?, check_in=?, check_out=?, total_bill=? WHERE reservation_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, reservation.getGuestName());
            pstmt.setString(2, reservation.getAddress());
            pstmt.setString(3, reservation.getContact());
            pstmt.setString(4, reservation.getRoomType());
            pstmt.setDate(5, reservation.getCheckIn());
            pstmt.setDate(6, reservation.getCheckOut());
            pstmt.setDouble(7, reservation.getTotalBill());
            pstmt.setInt(8, reservation.getReservationId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    public boolean deleteReservation(int reservationId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement("DELETE FROM reservations WHERE reservation_id = ?");
            pstmt.setInt(1, reservationId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement("SELECT * FROM reservations ORDER BY check_in DESC");
            rs = pstmt.executeQuery();
            while (rs.next())
                list.add(extractReservation(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return list;
    }

    public int getTotalReservations() {
        return getIntResult("SELECT COUNT(*) FROM reservations");
    }

    public int getActiveBookings() {
        return getIntResult("SELECT COUNT(*) FROM reservations WHERE check_in <= CURDATE() AND check_out > CURDATE()");
    }

    public int getTodayCheckIns() {
        return getIntResult("SELECT COUNT(*) FROM reservations WHERE check_in = CURDATE()");
    }

    public int getTodayCheckOuts() {
        return getIntResult("SELECT COUNT(*) FROM reservations WHERE check_out = CURDATE()");
    }

    public int getMonthlyBookings() {
        return getIntResult(
                "SELECT COUNT(*) FROM reservations WHERE MONTH(created_date) = MONTH(CURDATE()) AND YEAR(created_date) = YEAR(CURDATE())");
    }

    public double getTotalRevenue() {
        return getDoubleResult("SELECT COALESCE(SUM(total_bill), 0) FROM reservations");
    }

    public double getMonthlyRevenue() {
        return getDoubleResult(
                "SELECT COALESCE(SUM(total_bill), 0) FROM reservations WHERE MONTH(created_date) = MONTH(CURDATE()) AND YEAR(created_date) = YEAR(CURDATE())");
    }

    public int getBookedCountByRoomType(String roomType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(
                    "SELECT COUNT(*) FROM reservations WHERE room_type = ? AND (check_in <= CURDATE() AND check_out > CURDATE())");
            pstmt.setString(1, roomType);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    public int getBookedCountByRoomTypeAndDateRange(String roomType, Date checkIn, Date checkOut) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(
                    "SELECT COUNT(*) FROM reservations WHERE room_type = ? AND (check_in < ? AND check_out > ?)");
            pstmt.setString(1, roomType);
            pstmt.setDate(2, checkOut);
            pstmt.setDate(3, checkIn);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    public double getRevenueByRoomType(String roomType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement("SELECT COALESCE(SUM(total_bill), 0) FROM reservations WHERE room_type = ?");
            pstmt.setString(1, roomType);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    public int getBookingCountByRoomType(String roomType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement("SELECT COUNT(*) FROM reservations WHERE room_type = ?");
            pstmt.setString(1, roomType);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    public int getTotalNightsByRoomType(String roomType) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(
                    "SELECT COALESCE(SUM(DATEDIFF(check_out, check_in)), 0) FROM reservations WHERE room_type = ?");
            pstmt.setString(1, roomType);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    private int getIntResult(String sql) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    private double getDoubleResult(String sql) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next())
                return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        return 0;
    }

    private Reservation extractReservation(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setGuestName(rs.getString("guest_name"));
        r.setAddress(rs.getString("address"));
        r.setContact(rs.getString("contact"));
        r.setRoomType(rs.getString("room_type"));
        r.setCheckIn(rs.getDate("check_in"));
        r.setCheckOut(rs.getDate("check_out"));
        r.setTotalBill(rs.getDouble("total_bill"));
        return r;
    }

    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
        }
    }

    public static String escapeJson(String s) {
        if (s == null)
            return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

    public static String reservationToJson(Reservation r) {
        return "{\"reservationId\":" + r.getReservationId() +
                ",\"guestName\":\"" + escapeJson(r.getGuestName()) + "\"" +
                ",\"address\":\"" + escapeJson(r.getAddress()) + "\"" +
                ",\"contact\":\"" + escapeJson(r.getContact()) + "\"" +
                ",\"roomType\":\"" + escapeJson(r.getRoomType()) + "\"" +
                ",\"checkIn\":\"" + r.getCheckIn() + "\"" +
                ",\"checkOut\":\"" + r.getCheckOut() + "\"" +
                ",\"totalBill\":" + r.getTotalBill() + "}";
    }

    public static String reservationListToJson(List<Reservation> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0)
                sb.append(",");
            sb.append(reservationToJson(list.get(i)));
        }
        sb.append("]");
        return sb.toString();
    }
}
