-- ===================================================================
-- Airbnb Clone: Indexing Performance Analysis Script
-- ===================================================================
-- This script demonstrates the performance improvement from adding indexes.
-- It first runs an EXPLAIN ANALYZE on a query to show the plan and actual
-- execution stats without indexes, then creates the indexes, and finally
-- runs the same command again to show the optimized plan and stats.
-- ===================================================================

-- Section 1: Analyze Query Performance BEFORE Adding Indexes
-- -------------------------------------------------------------------
-- We are analyzing a common query: finding all bookings for a specific user.
-- The output of this command will show the execution plan and the *actual time*
-- it took. Notice the high cost and likely "Full Table Scan".

EXPLAIN ANALYZE SELECT
    b.booking_id,
    b.start_date,
    p.title
FROM bookings AS b
JOIN properties AS p ON b.property_id = p.property_id
WHERE b.user_id = 2;

-- ===================================================================

-- Section 2: Create Indexes for Optimization
-- -------------------------------------------------------------------
-- Now, we create the indexes on foreign key columns that are frequently
-- used in JOINs and WHERE clauses to speed up data retrieval.

-- Description: Speeds up queries that join properties with their owners.
CREATE INDEX idx_properties_owner_id ON properties(owner_id);

-- Description: Speeds up queries that retrieve all bookings for a specific user.
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Description: Speeds up queries that find all bookings for a particular property.
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Description: Improves performance when fetching reviews for a specific booking.
CREATE INDEX idx_reviews_booking_id ON reviews(booking_id);

-- ===================================================================

-- Section 3: Analyze Query Performance AFTER Adding Indexes
-- -------------------------------------------------------------------
-- We run the exact same EXPLAIN ANALYZE command again.
-- Now, the execution plan will show the use of the new `idx_bookings_user_id`
-- and the actual execution time should be significantly lower.

EXPLAIN ANALYZE SELECT
    b.booking_id,
    b.start_date,
    p.title
FROM bookings AS b
JOIN properties AS p ON b.property_id = p.property_id
WHERE b.user_id = 2;

-- ===================================================================
