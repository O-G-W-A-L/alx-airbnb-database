-- Create USERS table
CREATE TABLE users (
    user_id UUID CONSTRAINT pk_users PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255),
    role ENUM('guest','host','admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create PROPERTIES table
CREATE TABLE properties (
    property_id UUID CONSTRAINT pk_properties PRIMARY KEY,
    host_id UUID NOT NULL CONSTRAINT fk_properties_host REFERENCES users(user_id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create BOOKINGS table
CREATE TABLE bookings (
    booking_id UUID CONSTRAINT pk_bookings PRIMARY KEY,
    property_id UUID NOT NULL CONSTRAINT fk_bookings_property REFERENCES properties(property_id),
    user_id UUID NOT NULL CONSTRAINT fk_bookings_user REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending','confirmed','canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create PAYMENTS table
CREATE TABLE payments (
    payment_id UUID CONSTRAINT pk_payments PRIMARY KEY,
    booking_id UUID NOT NULL CONSTRAINT fk_payments_booking REFERENCES bookings(booking_id),
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card','paypal','stripe') NOT NULL
);

-- Create REVIEWS table
CREATE TABLE reviews (
    review_id UUID CONSTRAINT pk_reviews PRIMARY KEY,
    property_id UUID NOT NULL CONSTRAINT fk_reviews_property REFERENCES properties(property_id),
    user_id UUID NOT NULL CONSTRAINT fk_reviews_user REFERENCES users(user_id),
    rating INTEGER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create MESSAGES table
CREATE TABLE messages (
    message_id UUID CONSTRAINT pk_messages PRIMARY KEY,
    sender_id UUID NOT NULL CONSTRAINT fk_messages_sender REFERENCES users(user_id),
    recipient_id UUID NOT NULL CONSTRAINT fk_messages_recipient REFERENCES users(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for foreign keys
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_messages_sender_id ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id ON messages(recipient_id);
