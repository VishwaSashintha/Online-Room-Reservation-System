-- Ocean View Resort Database Schema
-- Enhanced version with user registration, room tracking, and reporting

-- Create Database
CREATE DATABASE IF NOT EXISTS oceanview_db;
USE oceanview_db;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS room_types;
DROP TABLE IF EXISTS users;

-- Create users table with enhanced fields
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create room types table
CREATE TABLE room_types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) UNIQUE NOT NULL,
    rate_per_night DECIMAL(10,2) NOT NULL,
    total_rooms INT NOT NULL,
    description TEXT,
    amenities TEXT
);

-- Create rooms table for individual room tracking
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    type_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE',
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

-- Create enhanced reservations table
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    contact VARCHAR(15) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    total_bill DOUBLE NOT NULL,
    status VARCHAR(20) DEFAULT 'CONFIRMED',
    created_by INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Insert default admin and staff users with enhanced fields
INSERT INTO users (username, password, role, full_name, email, phone, status) VALUES 
('admin', 'admin123', 'ADMIN', 'System Administrator', 'admin@oceanview.com', '0771234567', 'ACTIVE'),
('staff', 'staff123', 'STAFF', 'Staff Member', 'staff@oceanview.com', '0779876543', 'ACTIVE');

-- Insert room types
INSERT INTO room_types (type_name, rate_per_night, total_rooms, description, amenities) VALUES 
('Standard', 8000.00, 10, 'Comfortable standard room with essential amenities', 'AC, TV, WiFi, Breakfast'),
('Deluxe', 12000.00, 8, 'Spacious deluxe room with ocean view', 'AC, TV, WiFi, Breakfast, Ocean View, Mini Bar'),
('Suite', 20000.00, 5, 'Luxurious suite with premium amenities', 'AC, TV, WiFi, Breakfast, Ocean View, Mini Bar, Jacuzzi, Living Room');

-- Insert individual rooms
-- Standard Rooms (101-110)
INSERT INTO rooms (room_number, type_id, status) VALUES 
('101', 1, 'AVAILABLE'), ('102', 1, 'AVAILABLE'), ('103', 1, 'AVAILABLE'), 
('104', 1, 'AVAILABLE'), ('105', 1, 'AVAILABLE'), ('106', 1, 'AVAILABLE'),
('107', 1, 'AVAILABLE'), ('108', 1, 'AVAILABLE'), ('109', 1, 'AVAILABLE'), ('110', 1, 'AVAILABLE');

-- Deluxe Rooms (201-208)
INSERT INTO rooms (room_number, type_id, status) VALUES 
('201', 2, 'AVAILABLE'), ('202', 2, 'AVAILABLE'), ('203', 2, 'AVAILABLE'), 
('204', 2, 'AVAILABLE'), ('205', 2, 'AVAILABLE'), ('206', 2, 'AVAILABLE'),
('207', 2, 'AVAILABLE'), ('208', 2, 'AVAILABLE');

-- Suites (301-305)
INSERT INTO rooms (room_number, type_id, status) VALUES 
('301', 3, 'AVAILABLE'), ('302', 3, 'AVAILABLE'), ('303', 3, 'AVAILABLE'), 
('304', 3, 'AVAILABLE'), ('305', 3, 'AVAILABLE');

-- Insert sample reservations
INSERT INTO reservations (reservation_id, guest_name, address, contact, room_type, check_in, check_out, total_bill, status, created_by) VALUES
(1001, 'John Doe', '123 Main St, Colombo', '0771234567', 'Deluxe', '2026-02-20', '2026-02-23', 36000.00, 'CONFIRMED', 1),
(1002, 'Jane Smith', '456 Beach Rd, Galle', '0779876543', 'Suite', '2026-02-25', '2026-02-28', 60000.00, 'CONFIRMED', 1),
(1003, 'Mike Johnson', '789 Hill St, Kandy', '0771112222', 'Standard', '2026-02-18', '2026-02-20', 16000.00, 'CONFIRMED', 2);

-- Create indexes for better performance
CREATE INDEX idx_reservation_dates ON reservations(check_in, check_out);
CREATE INDEX idx_reservation_status ON reservations(status);
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_room_status ON rooms(status);
