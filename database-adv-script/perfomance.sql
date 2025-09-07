-- ===================================================================
-- Airbnb Clone: Complex Query Performance Script
-- ===================================================================
-- This script contains a specific, filtered query to test performance
-- under realistic conditions.
-- ===================================================================

-- Section 1: Complex Query with Filters
-- -------------------------------------------------------------------
-- Objective: Retrieve all paid bookings for properties in 'Cairo'
-- that start on or after September 1st, 2025.
--
-- This query joins FOUR tables and uses WHERE with AND to filter the results.
-- Its performance heavily relies on indexes on the JOIN keys (booking_id, user_id,
-- property_id) and the columns in the WHERE clause (p.city, b.start_date).

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    p.title AS property_title,
    p.city,
    u.full_name AS guest_name,
    py.amount,
    py.status AS payment_status
FROM
    bookings AS b
JOIN
    properties AS p ON b.property_id = p.property_id
JOIN
    users AS u ON b.user_id = u.user_id
JOIN
    payments AS py ON b.booking_id = py.booking_id
WHERE
    p.city = 'Cairo'
AND
    b.start_date >= '2025-09-01'
AND
    py.status = 'completed';

-- ===================================================================
-- Section 2: Optimization Notes
-- -------------------------------------------------------------------
-- The query above is considered "optimized" because its performance
-- depends on the database structure. For this query to be fast, the
-- following indexes must exist:
--
-- 1. Indexes on Foreign Keys for JOINs:
--    - idx_bookings_user_id ON bookings(user_id)
--    - idx_bookings_property_id ON bookings(property_id)
--    - idx_payments_booking_id ON payments(booking_id) -- On the new table
--
-- 2. Indexes on Columns in the WHERE clause:
--    - idx_property_city ON properties(city)
--    - idx_booking_dates ON bookings(start_date, end_date)

