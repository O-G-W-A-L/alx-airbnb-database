-- This query retrieves booking details along with the associated user information.
-- It uses an INNER JOIN to combine the booking and users tables based on the user_id.
-- The result will include booking_id, booking_date, user_id, and username for each booking.
SELECT
b.booking_id,
b.booking_date,
u.user_id,
u.username,
FROM booking b
INNER JOIN users u
ON b.user_id = u.user_id;

---using LEFT JOIN to retreive all properties and their reviews, including properties that have no reviews.
--the result will include property_id, title, review_id, rating, and comment for each property.

SELECT
p.property_id,
p.title,
r.review_id,
r.rating,
r.comment,
FROM properties p ORDER BY p.property_id
LEFT JOIN reviews r
ON p.property_id = r.property_id;

--using FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT
u.user_id,
u.username,
b.booking_id,
b.booking_date,
FROM users u
FULL OUTER JOIN booking b
ON u.user_id = b.user_id;

