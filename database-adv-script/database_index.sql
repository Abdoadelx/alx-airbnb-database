-- =============================
-- INDEXES FOR PERFORMANCE OPTIMIZATION
-- =============================
-- These indexes are created to improve the performance of common queries.
-- Foreign key columns used in JOINs are prime candidates for indexing.
-- Description: Speeds up queries that join properties with their owners.
CREATE INDEX idx_properties_owner_id ON properties(owner_id);
-- Description: Speeds up queries that retrieve all bookings for a specific user.
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
-- Description: Speeds up queries that find all bookings associated with a particular property,
-- which is useful for checking availability.
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
-- Description: Improves performance when fetching reviews for a specific booking.
CREATE INDEX idx_reviews_booking_id ON reviews(booking_id);
