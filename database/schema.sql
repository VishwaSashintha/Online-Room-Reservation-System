-- Ocean View Resort Database Schema
-- MySQL Database Setup

-- Create Database
CREATE DATABASE IF NOT EXISTS oceanview_db;
USE oceanview_db;

-- Users Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reservations Table
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact VARCHAR(15) NOT NULL,
    room_type VARCHAR(20) NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    total_bill DOUBLE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert Sample Users
-- Password: admin123 and staff123 (in production, these should be hashed)
INSERT INTO users (username, password, role) VALUES 
('admin', 'admin123', 'ADMIN'),
('staff', 'staff123', 'STAFF');

-- Insert Sample Reservations for Testing
INSERT INTO reservations (reservation_id, guest_name, address, contact, room_type, check_in, check_out, total_bill) VALUES
(1001, 'John Silva', '123 Main St, Colombo', '0771234567', 'Deluxe', '2026-02-20', '2026-02-23', 36000),
(1002, 'Mary Fernando', '456 Beach Rd, Galle', '0779876543', 'Suite', '2026-02-25', '2026-02-28', 60000),
(1003, 'David Perera', '789 Hill St, Kandy', '0765432109', 'Standard', '2026-03-01', '2026-03-04', 24000);

-- Create Index for faster searches
CREATE INDEX idx_reservation_dates ON reservations(check_in, check_out);
CREATE INDEX idx_room_type ON reservations(room_type);
