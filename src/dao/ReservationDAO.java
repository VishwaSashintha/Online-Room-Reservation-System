package dao;

import model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Reservation Data Access Object
 * Handles all database operations related to reservations
 */
public class ReservationDAO {
    
    /**
     * Add a new reservation
     * Includes double booking prevention logic
     * @param reservation Reservation object to add
     * @return true if successful, false otherwise
     */
    public boolean addReservation(Reservation reservation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // First check for double booking
            if (isRoomBooked(reservation.getRoomType(), reservation.getCheckIn(), 
                           reservation.getCheckOut(), conn)) {
                System.err.println("Room already booked for the selected dates!");
                return false;
            }
            
            // Insert reservation
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
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error adding reservation: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    /**
     * Check if room is already booked for overlapping dates
     * Prevents double booking
     * @param roomType Type of room
     * @param checkIn Check-in date
     * @param checkOut Check-out date
     * @param conn Database connection
     * @return true if room is booked, false if available
     */
    private boolean isRoomBooked(String roomType, Date checkIn, Date checkOut, Connection conn) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            // Check for overlapping dates
            String sql = "SELECT COUNT(*) FROM reservations WHERE room_type = ? AND " +
                        "((check_in <= ? AND check_out > ?) OR " +
                        "(check_in < ? AND check_out >= ?) OR " +
                        "(check_in >= ? AND check_out <= ?))";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, roomType);
            pstmt.setDate(2, checkIn);
            pstmt.setDate(3, checkIn);
            pstmt.setDate(4, checkOut);
            pstmt.setDate(5, checkOut);
            pstmt.setDate(6, checkIn);
            pstmt.setDate(7, checkOut);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking room availability: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return false;
    }
    
    /**
     * Search reservation by ID
     * @param reservationId Reservation ID to search
     * @return Reservation object if found, null otherwise
     */
    public Reservation searchReservation(int reservationId) {
        Reservation reservation = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM reservations WHERE reservation_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reservationId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                reservation = extractReservationFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching reservation: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return reservation;
    }
    
    /**
     * Update existing reservation
     * @param reservation Reservation object with updated data
     * @return true if successful, false otherwise
     */
    public boolean updateReservation(Reservation reservation) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "UPDATE reservations SET guest_name = ?, address = ?, contact = ?, " +
                        "room_type = ?, check_in = ?, check_out = ?, total_bill = ? " +
                        "WHERE reservation_id = ?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, reservation.getGuestName());
            pstmt.setString(2, reservation.getAddress());
            pstmt.setString(3, reservation.getContact());
            pstmt.setString(4, reservation.getRoomType());
            pstmt.setDate(5, reservation.getCheckIn());
            pstmt.setDate(6, reservation.getCheckOut());
            pstmt.setDouble(7, reservation.getTotalBill());
            pstmt.setInt(8, reservation.getReservationId());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating reservation: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    /**
     * Delete reservation by ID
     * @param reservationId Reservation ID to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteReservation(int reservationId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "DELETE FROM reservations WHERE reservation_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, reservationId);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting reservation: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(null, pstmt, conn);
        }
    }
    
    /**
     * Get all reservations
     * @return List of all reservations
     */
    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT * FROM reservations ORDER BY check_in DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                reservations.add(extractReservationFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all reservations: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return reservations;
    }
    
    /**
     * Get total count of reservations
     * @return Total number of reservations
     */
    public int getTotalReservations() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT COUNT(*) FROM reservations";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting total reservations: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return 0;
    }
    
    /**
     * Get count of active bookings (future check-ins)
     * @return Number of active bookings
     */
    public int getActiveBookings() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT COUNT(*) FROM reservations WHERE check_in >= CURDATE()";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting active bookings: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
        
        return 0;
    }
    
    /**
     * Extract Reservation object from ResultSet
     * @param rs ResultSet from query
     * @return Reservation object
     */
    private Reservation extractReservationFromResultSet(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setReservationId(rs.getInt("reservation_id"));
        reservation.setGuestName(rs.getString("guest_name"));
        reservation.setAddress(rs.getString("address"));
        reservation.setContact(rs.getString("contact"));
        reservation.setRoomType(rs.getString("room_type"));
        reservation.setCheckIn(rs.getDate("check_in"));
        reservation.setCheckOut(rs.getDate("check_out"));
        reservation.setTotalBill(rs.getDouble("total_bill"));
        return reservation;
    }
    
    /**
     * Close database resources
     */
    private void closeResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            System.err.println("Error closing resources: " + e.getMessage());
        }
    }
}
