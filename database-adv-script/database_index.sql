# Measuring Index Performance

In database management, indexes are crucial for optimizing query performance. An index is a data structure that provides a quick lookup of data in a table. This guide demonstrates how to identify columns that need indexing and how to measure the performance gain using the `EXPLAIN` command.

---

## 1. Identifying Columns for Indexing

The best candidates for indexing are columns that are frequently used to find or sort data. Based on our schema and common use-cases, we identified the following high-usage columns:

* **`properties(owner_id)`**: This column is a foreign key used in `JOIN` operations to find all properties listed by a specific user. Indexing it will significantly speed up owner-specific queries.
* **`bookings(user_id)`**: Used in `JOIN`s to retrieve a user's booking history. This is a very common operation that benefits greatly from an index.
* **`bookings(property_id)`**: Essential for finding all bookings for a specific property. This is critical for tasks like checking a property's calendar for availability.
* **`reviews(booking_id)`**: Used to link a review to its specific booking. Indexing this makes fetching reviews for a booking much faster.

---

## 2. SQL Commands for Creating Indexes

The following SQL commands are used to create the indexes on the identified columns. You can find these commands in the `database_index.sql` file.

```sql
-- Index for the owner_id in the properties table
CREATE INDEX idx_properties_owner_id ON properties(owner_id);

-- Index for the user_id in the bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index for the property_id in the bookings table
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index for the booking_id in the reviews table
CREATE INDEX idx_reviews_booking_id ON reviews(booking_id);
