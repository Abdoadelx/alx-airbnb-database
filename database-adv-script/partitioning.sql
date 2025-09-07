-- ===================================================================
-- Airbnb Clone: Table Partitioning Script
-- ===================================================================
-- This script creates the `bookings` table with partitioning built-in
-- from the start. Partitioning is based on the YEAR of the `start_date`.
-- ===================================================================

-- To apply partitioning, we must recreate the table.
-- First, we safely drop the existing table.
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS bookings;

-- Section 1: Creating the Partitioned Table
-- -------------------------------------------------------------------
-- We add the `PARTITION BY RANGE` clause directly to the `CREATE TABLE`
-- statement. This builds the table with its partitioning scheme from scratch.

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (end_date > start_date)
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before_2025 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Note: After running this, you will need to re-run your seed script
-- to populate the new `bookings` table with data.

-- ===================================================================
-- Section 2: Testing Partition Performance with EXPLAIN
-- -------------------------------------------------------------------
-- We use EXPLAIN to verify that "partition pruning" is working.
-- The query below searches for bookings within September 2025.

EXPLAIN SELECT *
FROM bookings
WHERE start_date BETWEEN '2025-09-01' AND '2025-09-30';

-- Look for the `partitions` column in the EXPLAIN output. It should
-- only list `p2025`, proving that the database is correctly ignoring
-- all other partitions and making the query much faster.
-- ===================================================================
