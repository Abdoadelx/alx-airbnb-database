# Database Performance Monitoring and Refinement Report

This report outlines the process of continuously monitoring database performance, identifying bottlenecks, and implementing schema adjustments to ensure our Airbnb clone application remains fast and responsive.

---

## 1. Identifying High-Frequency Queries for Monitoring

The first step is to identify the queries that will be executed most frequently in our application. For an Airbnb-like platform, these are typically:

1.  **Property Search Query:** Finding all available properties in a specific city for a given date range. This is the most critical query for users browsing the site.
2.  **User Bookings Query:** Retrieving a specific user's upcoming bookings. This is essential for the user's dashboard.

---

## 2. Monitoring with `EXPLAIN ANALYZE` and Identifying Bottlenecks

We use `EXPLAIN ANALYZE` to inspect the execution plan and actual runtime of our key queries.

### Query 1: Property Search

**Objective:** Find all properties in 'Alexandria' available from October 1st to October 7th, 2025.

**Initial (Naive) Approach:**
A common but inefficient way to write this query is to find all properties in a city and then exclude those that have overlapping bookings.

```sql
-- This query can be a performance bottleneck
EXPLAIN ANALYZE
SELECT p.*
FROM properties p
WHERE p.city = 'Alexandria' AND p.property_id NOT IN (
    SELECT b.property_id
    FROM bookings b
    WHERE b.start_date < '2025-10-07' AND b.end_date > '2025-10-01'
);
```
---
