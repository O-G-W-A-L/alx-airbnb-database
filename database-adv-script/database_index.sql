--SQL CREATE INDEX commands to create appropriate indexes
-- on the tables in the database

-- Indexes for Users table
CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_users_email ON users (email);

-- Indexes for booking table
CREATE INDEX idx_booking_user_id ON booking (user_id);
CREATE INDEX idx_booking_property_id ON booking (property_id);
CREATE INDEX idx_booking_booking_date ON booking (booking_date);

-- indexes for properties table
CREATE INDEX idx_properties_host_id ON properties (title);
CREATE INDEX idx_properties_location ON properties (location);
