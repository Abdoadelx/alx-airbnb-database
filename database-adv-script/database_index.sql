-- ===================================================================
-- Airbnb Clone: Indexing Performance Analysis Script
-- ===================================================================
-- This script demonstrates the performance improvement from adding indexes.
-- It first runs an EXPLAIN on a query to show the plan without indexes,
-- then creates the indexes, and finally runs the same EXPLAIN again
-- to show the optimized plan.
-- ===================================================================

-- Section 1: Analyze Query Performance BEFORE Adding Indexes
-- -------------------------------------------------------------------
-- We are analyzing a common query: finding all bookings for a specific user.
-- Notice the output of this EXPLAIN. The database will likely perform a
-- "full table scan" on the `bookings` table because there is no index
-- on the `user_id` column.

EXPLAIN SELECT
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
-- We run the exact same EXPLAIN command again.
-- Now, observe the output. The database should use the new `idx_bookings_user_id`
-- to perform an "index scan" or "index lookup". This is much faster
-- because it can directly find the rows for `user_id = 2` without
-- checking every row in the table. 🚀

EXPLAIN SELECT
    b.booking_id,
    b.start_date,
    p.title
FROM bookings AS b
JOIN properties AS p ON b.property_id = p.property_id
WHERE b.user_id = 2;

-- ===================================================================
