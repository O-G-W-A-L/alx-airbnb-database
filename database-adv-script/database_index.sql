-- Create indexes to improve query performance

-- BEFORE indexing:
-- Run the following query to analyze performance
-- Expected output: Sequential Scan
EXPLAIN ANALYZE
SELECT * FROM booking WHERE user_id = 1;

-- Users table indexes
CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_email ON users (email);

-- Booking table indexes
CREATE INDEX idx_booking_user_id ON booking (user_id);
CREATE INDEX idx_booking_property_id ON booking (property_id);
CREATE INDEX idx_booking_booking_date ON booking (booking_date);

-- Properties table indexes
CREATE INDEX idx_properties_host_id ON properties (host_id);
CREATE INDEX idx_properties_location ON properties (location);

-- AFTER indexing:
-- Rerun the same query to see improved performance
-- Expected output: Index Scan
EXPLAIN ANALYZE
SELECT * FROM booking WHERE user_id = 1;
