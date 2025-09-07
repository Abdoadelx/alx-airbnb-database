# Partitioning Performance Report

This report details the implementation of table partitioning on the `bookings` table and analyzes the resulting performance improvements.

---

## What is Table Partitioning?

Table partitioning is the process of dividing a large database table into smaller, more manageable pieces called **partitions**. However, to the user or application, it still looks like a single table. 🗄️

Think of a massive encyclopedia. A non-partitioned table is like having all the pages in one giant, unsorted pile. A partitioned table is like having the encyclopedia neatly organized into separate volumes labeled 'A', 'B', 'C', and so on. When you need to find "Cairo," you can go directly to the 'C' volume instead of searching through the entire pile.

For our `bookings` table, we partitioned it by the **year of the booking's start date**. This means the database creates separate internal storage for bookings from 2025, 2026, etc.

---

## Implementation

We modified the existing `bookings` table using the `ALTER TABLE` command to partition it by a `RANGE` of years based on the `start_date` column.

```sql
ALTER TABLE bookings
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before_2025 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);
```
---
