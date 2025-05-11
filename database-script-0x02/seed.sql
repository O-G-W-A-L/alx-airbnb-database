-- USERS
INSERT INTO USERS (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  (UUID(), 'John', 'Doe', 'john@example.com', 'hash1', '25677700000', 'guest', CURRENT_TIMESTAMP),
  (UUID(), 'Skip', 'Calvins', 'skip@example.com', 'hash2', '254783882132', 'host', CURRENT_TIMESTAMP);

-- PROPERTIES
INSERT INTO PROPERTIES (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'Skip' LIMIT 1), 'Hilltop Cabin', 'Secluded cabin with a view', 'Kampala Hills', 110.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'Skip' LIMIT 1), 'Urban Nest', 'Compact space in town', 'Central Kampala', 140.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- BOOKINGS
INSERT INTO BOOKINGS (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Hilltop Cabin'), (SELECT user_id FROM USERS WHERE first_name = 'John'), '2025-06-01', '2025-06-05', 440.00, 'confirmed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Urban Nest'), (SELECT user_id FROM USERS WHERE first_name = 'John'), '2025-07-01', '2025-07-03', 280.00, 'pending', CURRENT_TIMESTAMP);

-- PAYMENTS
INSERT INTO PAYMENTS (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  (UUID(), (SELECT booking_id FROM BOOKINGS WHERE status = 'confirmed' LIMIT 1), 440.00, CURRENT_TIMESTAMP, 'credit_card'),
  (UUID(), (SELECT booking_id FROM BOOKINGS WHERE status = 'pending' LIMIT 1), 280.00, CURRENT_TIMESTAMP, 'paypal');

-- REVIEWS
INSERT INTO REVIEWS (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Hilltop Cabin'), (SELECT user_id FROM USERS WHERE first_name = 'John'), 5, 'Peaceful and clean.', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Urban Nest'), (SELECT user_id FROM USERS WHERE first_name = 'John'), 4, 'Great spot, but noisy.', CURRENT_TIMESTAMP);

-- MESSAGES
INSERT INTO MESSAGES (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'John'), (SELECT user_id FROM USERS WHERE first_name = 'Skip'), 'Interested in Hilltop Cabin.', CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'John'), (SELECT user_id FROM USERS WHERE first_name = 'Skip'), 'Any discounts for longer stays?', CURRENT_TIMESTAMP);
