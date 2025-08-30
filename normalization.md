Database Normalization – Airbnb Clone

This document explains how the Airbnb clone database schema was normalized to Third Normal Form (3NF).

Step 1: First Normal Form (1NF)

Rules of 1NF:

Each table must have a primary key.

All attributes must be atomic (no repeating groups, no arrays).

No multi-valued attributes.

Applied to schema:

Users: attributes like first_name, last_name, email, password_hash are atomic.

Properties: each property has single values for address, city, price_per_night.

Bookings: each row stores one booking only, with one user_id and one property_id.

✅ All tables satisfy 1NF.

Step 2: Second Normal Form (2NF)

Rules of 2NF:

Must already be in 1NF.

No partial dependency (non-key attributes depending on part of a composite key).

Applied to schema:

All primary keys are single-column surrogate keys (UUIDs).

Example:

Bookings(booking_id, user_id, property_id, start_date, end_date, total_price)

total_price depends only on booking_id, not on part of a composite key.

✅ All tables satisfy 2NF.

Step 3: Third Normal Form (3NF)

Rules of 3NF:

Must already be in 2NF.

No transitive dependency (non-key attribute depending on another non-key attribute).

Applied to schema:

Users: email depends only on user_id. No attributes depend on email.

Properties: city depends only on property_id. No attribute depends on city.

Bookings: total_price depends on booking_id, not indirectly on user_id or property_id.

Reviews: rating and comment depend only on review_id.

✅ All tables satisfy 3NF.

Conclusion

The schema was reviewed against 1NF, 2NF, and 3NF.

No partial, repeating, or transitive dependencies remain.

The database design is fully normalized up to 3NF.