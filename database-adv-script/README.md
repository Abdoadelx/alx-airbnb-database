# Complex SQL Queries with Joins - Airbnb Clone Database
---

This document explains the SQL join queries implemented in the `joins_queries.sql` file for the **Airbnb Clone Database**.  
It demonstrates how to use different types of joins to retrieve meaningful data across multiple tables.
It also explain **subqueries** (both correlated and non-correlated) which presents in `subqueries.sql`
Aggregations and Window Functions are also explained
---

## 🔑 Queries Overview

We cover the following join types:

1. **INNER JOIN** – Only matching records from both tables.  
2. **LEFT JOIN** – All records from the left table, and matches (if any) from the right table.  
3. **RIGHT JOIN** – All records from the right table, and matches (if any) from the left table.  
4. **FULL OUTER JOIN** – All records from both tables, regardless of matches.

---

## 1️⃣ INNER JOIN: Bookings with Users
**Query:**
```sql
SELECT 
    b.id AS booking_id,
    u.id AS user_id,
    u.name AS user_name,
    b.property_id,
    b.check_in,
    b.check_out
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.id;
```

---

## 2️⃣ LEFT JOIN: Properties with Reviews
```sql
SELECT 
    p.id AS property_id,
    p.title AS property_title,
    r.id AS review_id,
    r.rating,
    r.comment
FROM Properties p
LEFT JOIN Reviews r ON p.id = r.property_id;
```

---

## 3️⃣ RIGHT JOIN: Properties with Bookings
```sql
SELECT 
    b.id AS booking_id,
    b.user_id,
    p.id AS property_id,
    p.title AS property_title,
    b.check_in,
    b.check_out
FROM Bookings b
RIGHT JOIN Properties p ON b.property_id = p.id;
```

---

## 4️⃣ FULL OUTER JOIN: Users and Bookings
```sql
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    b.id AS booking_id,
    b.property_id,
    b.check_in,
    b.check_out
FROM Users u
FULL OUTER JOIN Bookings b ON u.id = b.user_id;
```
---
# Queries

### 1. Non-Correlated Subquery
**Objective:** Find all properties where the average rating is greater than `4.0`.

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location
FROM Property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.name ASC;
```
### 2. Correlated Subquery
**Objective:** Find all users who have made more than 3 bookings.
```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.first_name ASC;
```
### 3. Total Number of Bookings per User
```sql
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    COUNT(b.id) AS total_bookings
FROM Users u
LEFT JOIN Bookings b ON u.id = b.user_id
GROUP BY u.id, u.name
ORDER BY total_bookings DESC;
```
### 4. Rank Properties by Number of Bookings
```sql
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM Properties p
LEFT JOIN Bookings b ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY booking_rank;
```
---



