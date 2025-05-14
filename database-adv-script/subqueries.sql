-- Subqueries
-- A subquery to find the average rating of properties of properties gretaer than 4.0
SELECT property_id
FROM properties
WHERE AVG(rating) > 4.0

--a correlated subquery to find users who have made more than 3 bookings.
SELECT user_id
FROM users u
WHERE (SELECT COUNT(*)
       FROM booking b
       WHERE b.user_id = u.user_id) > 3;