package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection Utility
 * Manages MySQL database connections using JDBC
 */
public class DBConnection {
    
    // Database credentials - Update these based on your MySQL setup
    private static final String URL = "jdbc:mysql://localhost:3306/oceanview_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "123456789"; // Update with your MySQL password
    
    // JDBC Driver
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName(DRIVER);
            
            // Establish connection
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
            throw new SQLException("Database driver not found", e);
        }
        
        return connection;
    }
    
    /**
     * Close database connection
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Error closing database connection");
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test database connection
     * @return true if connection successful, false otherwise
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Database connection test failed!");
            e.printStackTrace();
            return false;
        }
    }
}
