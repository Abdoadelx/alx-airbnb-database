-- ===================================================================
-- Airbnb Clone: Table Partitioning Script
-- ===================================================================
-- This script modifies the existing `bookings` table to implement
-- partitioning by range based on the YEAR of the `start_date`.
-- This is a common strategy for time-series data to improve query
-- performance, especially for date-range queries.
-- ===================================================================

-- Section 1: Applying the Partitioning Scheme
-- -------------------------------------------------------------------
-- We use ALTER TABLE because the `bookings` table already exists.
-- The table is split into logical partitions, with each partition
-- storing bookings for a specific year.

ALTER TABLE bookings
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before_2025 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- ===================================================================
-- Section 2: Testing Partition Performance with EXPLAIN
-- -------------------------------------------------------------------
-- To verify that partitioning is working, we can use the EXPLAIN
-- command on a query that filters by a specific date range.

-- The query below searches for bookings within September 2025.
EXPLAIN SELECT *
FROM bookings
WHERE start_date BETWEEN '2025-09-01' AND '2025-09-30';

-- ===================================================================
-- How to Read the EXPLAIN Output:
--
-- In the output of the EXPLAIN command, look for a column named `partitions`.
-- For the query above, the value in this column should be `p2025`.
--
-- This proves that the database is using "partition pruning" – it's smart
-- enough to scan ONLY the `p2025` partition and completely ignore all the others.
-- This is what makes the query significantly faster on large tables.
-- If it listed all partitions (or NULL), the partitioning would not be effective.
-- ===================================================================
