-- Seed Data for Airbnb Clone Database
-- Populating Users, Properties, Bookings, Payments

-- Insert Users
INSERT INTO users (user_id, name, email, phone_number, created_at)
VALUES
  (1, 'Alice Johnson', 'alice@example.com', '+1234567890', NOW()),
  (2, 'Bob Smith', 'bob@example.com', '+1987654321', NOW()),
  (3, 'Charlie Davis', 'charlie@example.com', '+1122334455', NOW());

-- Insert Properties
INSERT INTO properties (property_id, host_id, title, description, location, price_per_night, created_at)
VALUES
  (1, 1, 'Cozy Apartment in Cairo', '2-bedroom apartment near the Nile', 'Cairo, Egypt', 50.00, NOW()),
  (2, 2, 'Beach House in Alexandria', 'Sea-view villa with private pool', 'Alexandria, Egypt', 120.00, NOW()),
  (3, 1, 'Modern Studio in Giza', 'Close to the Pyramids and city center', 'Giza, Egypt', 35.00, NOW());

-- Insert Bookings
INSERT INTO bookings (booking_id, user_id, property_id, start_date, end_date, status, created_at)
VALUES
  (1, 2, 1, '2025-09-01', '2025-09-05', 'confirmed', NOW()),
  (2, 3, 2, '2025-09-10', '2025-09-15', 'pending', NOW()),
  (3, 1, 3, '2025-09-20', '2025-09-22', 'confirmed', NOW());

-- Insert Payments
INSERT INTO payments (payment_id, booking_id, amount, status, payment_date)
VALUES
  (1, 1, 200.00, 'completed', '2025-09-01'),
  (2, 2, 600.00, 'pending', '2025-09-10'),
  (3, 3, 70.00, 'completed', '2025-09-20');
