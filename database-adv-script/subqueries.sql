-- Subqueries
-- A subquery to find the average rating of properties of properties gretaer than 4.0
SELECT property_id
FROM (
    SELECT property_id, AVG (rating) AS avg_rating
    FROM reviews
    GROUP BY property_id
) AS avg_ratings
WHERE avg_rating > 4.0;

--a correlated subquery to find users who have made more than 3 bookings.
SELECT user_id
FROM users u
WHERE (SELECT COUNT(*)
       FROM booking b
       WHERE b.user_id = u.user_id) > 3;