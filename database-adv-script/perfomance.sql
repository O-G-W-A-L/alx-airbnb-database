-- perfomance.sql

-- Initial complex query: all bookings + users + properties + payments
EXPLAIN ANALYZE
SELECT 
  b.booking_id,
  b.start_date AS booking_start,
  b.end_date AS booking_end,
  u.first_name || ' ' || u.last_name AS user_name,
  u.email,
  p.name AS property_name,
  p.location,
  pay.amount AS payment_amount,
  pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;

-- Refactored query: drop email (non‑essential), rely on indexes
EXPLAIN ANALYZE
SELECT
  b.booking_id,
  b.start_date AS booking_start,
  u.first_name || ' ' || u.last_name AS user_name,
  p.name AS property_name,
  pay.amount AS payment_amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;
