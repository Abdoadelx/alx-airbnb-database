# ER Diagram Requirements - Airbnb Clone Database

## Entities and Attributes

### User
- user_id (PK, UUID, Indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest, host, admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Property
- property_id (PK, UUID, Indexed)
- host_id (FK → User.user_id)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- pricepernight (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- booking_id (PK, UUID, Indexed)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending, confirmed, canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Payment
- payment_id (PK, UUID, Indexed)
- booking_id (FK → Booking.booking_id)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

### Review
- review_id (PK, UUID, Indexed)
- property_id (FK → Property.property_id)
- user_id (FK → User.user_id)
- rating (INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Message
- message_id (PK, UUID, Indexed)
- sender_id (FK → User.user_id)
- recipient_id (FK → User.user_id)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

## Relationships
- User (1) ↔ (N) Property
- User (1) ↔ (N) Booking
- Property (1) ↔ (N) Booking
- Booking (1) ↔ (N) Payment
- User (M) ↔ (N) Property via Review
- User (M) ↔ (N) User via Message

---

## ER Diagram Instructions
- Use **Draw.io** (or diagrams.net) to create the ER diagram.
- Represent each entity as a rectangle with attributes inside.
- Draw relationships with proper cardinality (1:N, M:N).
- Save/export your diagram as `airbnb_erd.png` or `airbnb_erd.pdf`.
- Place the diagram in the `ERD/` directory.

