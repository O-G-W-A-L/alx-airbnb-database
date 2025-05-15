-- 1. Create ENUM types
CREATE TYPE role_enum AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status_enum AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');

-- 2. USERS table
CREATE TABLE users (
  user_id        UUID PRIMARY KEY,
  first_name     VARCHAR(255) NOT NULL,
  last_name      VARCHAR(255) NOT NULL,
  email          VARCHAR(255) UNIQUE NOT NULL,
  password_hash  VARCHAR(255) NOT NULL,
  phone_number   VARCHAR(255),
  role           role_enum   NOT NULL,
  created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- 3. PROPERTIES table
CREATE TABLE properties (
  property_id     UUID PRIMARY KEY,
  host_id         UUID NOT NULL REFERENCES users(user_id),
  name            VARCHAR(255) NOT NULL,
  description     TEXT       NOT NULL,
  location        VARCHAR(255) NOT NULL,
  price_per_night DECIMAL(10,2) NOT NULL,
  created_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
  updated_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- 4. BOOKINGS table
CREATE TABLE bookings (
  booking_id   UUID PRIMARY KEY,
  property_id  UUID NOT NULL REFERENCES properties(property_id),
  user_id      UUID NOT NULL REFERENCES users(user_id),
  start_date   DATE NOT NULL,
  end_date     DATE NOT NULL,
  total_price  DECIMAL(10,2) NOT NULL,
  status       booking_status_enum NOT NULL,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. PAYMENTS table
CREATE TABLE payments (
  payment_id     UUID PRIMARY KEY,
  booking_id     UUID NOT NULL REFERENCES bookings(booking_id),
  amount         DECIMAL(10,2) NOT NULL,
  payment_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method payment_method_enum NOT NULL
);

-- 6. REVIEWS table
CREATE TABLE reviews (
  review_id   UUID PRIMARY KEY,
  property_id UUID NOT NULL REFERENCES properties(property_id),
  user_id     UUID NOT NULL REFERENCES users(user_id),
  rating      INTEGER CHECK (rating BETWEEN 1 AND 5) NOT NULL,
  comment     TEXT NOT NULL,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. MESSAGES table
CREATE TABLE messages (
  message_id   UUID PRIMARY KEY,
  sender_id    UUID NOT NULL REFERENCES users(user_id),
  recipient_id UUID NOT NULL REFERENCES users(user_id),
  message_body TEXT NOT NULL,
  sent_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Indexes on foreign keys
CREATE INDEX idx_properties_host_id     ON properties(host_id);
CREATE INDEX idx_bookings_property_id   ON bookings(property_id);
CREATE INDEX idx_bookings_user_id       ON bookings(user_id);
CREATE INDEX idx_payments_booking_id    ON payments(booking_id);
CREATE INDEX idx_reviews_property_id    ON reviews(property_id);
CREATE INDEX idx_reviews_user_id        ON reviews(user_id);
CREATE INDEX idx_messages_sender_id     ON messages(sender_id);
CREATE INDEX idx_messages_recipient_id  ON messages(recipient_id);
