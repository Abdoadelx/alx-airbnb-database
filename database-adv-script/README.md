# Complex SQL Queries with Joins - Airbnb Clone Database

This document explains the SQL join queries implemented in the `joins_queries.sql` file for the **Airbnb Clone Database**.  
It demonstrates how to use different types of joins to retrieve meaningful data across multiple tables.

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

---

## 2️⃣ LEFT JOIN: Properties with Reviews
**Query:**
```sql
SELECT 
    p.id AS property_id,
    p.title AS property_title,
    r.id AS review_id,
    r.rating,
    r.comment
FROM Properties p
LEFT JOIN Reviews r ON p.id = r.property_id;

---

## 3️⃣ RIGHT JOIN: Properties with Bookings
**Query:**
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

---

## 4️⃣ FULL OUTER JOIN: Users and Bookings
**Query:**
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

---
