# Query Optimization Report

This report documents the process of analyzing and optimizing a complex query for the Airbnb clone database. The goal is to improve performance by ensuring efficient data retrieval across multiple tables.

---

## 1. Initial Complex Query

The initial objective was to write a query that retrieves all bookings along with the user details, property details, and payment details.

**Note on the `payments` table:** The provided database schema does not include a `payments` table. Therefore, the query was constructed using the three logically connected tables: `bookings`, `users`, and `properties`.

Here is the initial query designed to fetch this comprehensive data:

```sql
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
