-- ================================================
-- Complex SQL Queries with Joins for Airbnb Clone
-- ================================================

-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.id AS booking_id,
    u.id AS user_id,
    u.name AS user_name,
    b.property_id,
    b.check_in,
    b.check_out
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.id;


-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.id AS property_id,
    p.title AS property_title,
    r.id AS review_id,
    r.rating,
    r.comment
FROM Properties p
LEFT JOIN Reviews r ON p.id = r.property_id;


-- 3. RIGHT JOIN: Retrieve all bookings and their properties,
-- including bookings that may not have a matching property (rare but possible in test data)
SELECT 
    b.id AS booking_id,
    b.user_id,
    p.id AS property_id,
    p.title AS property_title,
    b.check_in,
    b.check_out
FROM Bookings b
RIGHT JOIN Properties p ON b.property_id = p.id;


-- 4. FULL OUTER JOIN: Retrieve all users and all bookings,
-- even if the user has no booking or a booking is not linked to a user
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    b.id AS booking_id,
    b.property_id,
    b.check_in,
    b.check_out
FROM Users u
FULL OUTER JOIN Bookings b ON u.id = b.user_id;
