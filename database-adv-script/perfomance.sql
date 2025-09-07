-- ===================================================================
-- Airbnb Clone: Complex Query Performance Script
-- ===================================================================
-- This script contains an initial complex query and its optimized version.
-- We use EXPLAIN ANALYZE to inspect the performance of both.
-- ===================================================================

-- Section 1: Initial Complex Query (Potentially Unoptimized)
-- -------------------------------------------------------------------
-- Objective: Retrieve a comprehensive list of all bookings, including
-- details about the user who booked and the property that was booked.
--
-- This query joins three tables: bookings, users, and properties.
-- Without proper indexes on the JOIN keys (user_id, property_id),
-- this query would be very slow on a large dataset.

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.full_name AS guest_name,
    u.email AS guest_email,
    p.title AS property_title,
    p.address AS property_address,
    p.city AS property_city
FROM
    bookings AS b
JOIN
    users AS u ON b.user_id = u.user_id
JOIN
    properties AS p ON b.property_id = p.property_id;

-- ===================================================================

-- Section 2: Optimized Query
-- -------------------------------------------------------------------
-- The optimization for this type of query doesn't come from changing
-- the query's structure (the JOINs are necessary), but from ensuring
-- the database can execute the JOINs efficiently.
--
-- The performance gain comes from the indexes we created previously:
-- -> idx_bookings_user_id ON bookings(user_id)
-- -> idx_bookings_property_id ON bookings(property_id)
--
-- When these indexes exist, the database can use fast "Index Scans"
-- instead of slow "Full Table Scans" to find the matching rows for the JOINs.
-- The query text remains the same, but its execution is dramatically faster.

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.full_name AS guest_name,
    u.email AS guest_email,
    p.title AS property_title,
    p.address AS property_address,
    p.city AS property_city
FROM
    bookings AS b
JOIN
    users AS u ON b.user_id = u.user_id
JOIN
    properties AS p ON b.property_id = p.property_id;
