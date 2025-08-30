# Database Schema (DDL) – Airbnb Clone

## 📌 File: schema.sql
This file defines the **database schema** for the Airbnb clone project using SQL DDL statements.  
It includes all entities, relationships, constraints, and indexes for performance optimization.

---

## 🎯 Objective
- Translate the requirements and normalized schema into SQL `CREATE TABLE` statements  
- Ensure **data integrity** using primary keys, foreign keys, and constraints  
- Optimize searches with **indexes**  

---

## 🔹 Schema Overview

### 1. **Users**
- Stores user information
- Ensures unique emails
- Columns: `user_id`, `full_name`, `email`, `phone_number`, `password_hash`

### 2. **Properties**
- Represents listings created by users
- Linked to `users` via `owner_id`
- Columns: `property_id`, `owner_id`, `title`, `description`, `address`, `city`, `price_per_night`

### 3. **Property Images**
- Stores images linked to a property
- Each property can have multiple images
- Columns: `image_id`, `property_id`, `image_url`

### 4. **Bookings**
- Stores booking transactions
- Enforces date constraints (`end_date > start_date`)
- Columns: `booking_id`, `user_id`, `property_id`, `start_date`, `end_date`, `total_price`

### 5. **Reviews**
- Linked to `bookings` (only users who booked can review)
- Rating range enforced between 1 and 5
- Columns: `review_id`, `booking_id`, `rating`, `comment`

---

## 🔹 Constraints & Indexes

- **Primary Keys**: Each table has a unique primary key (`*_id`)  
- **Foreign Keys**:
  - `properties.owner_id → users.user_id`
  - `property_images.property_id → properties.property_id`
  - `bookings.user_id → users.user_id`
  - `bookings.property_id → properties.property_id`
  - `reviews.booking_id → bookings.booking_id`
- **Constraints**:
  - Unique emails in `users`
  - Ratings between 1–5 in `reviews`
  - Booking `end_date` must be greater than `start_date`
- **Indexes**:
  - `users(email)` → fast lookup for login
  - `properties(city)` → efficient property search by city
  - `bookings(start_date, end_date)` → optimize availability checks

---

## ✅ Final Check
- Schema aligns with **requirements.md** and **normalization.md**  
- All relationships modeled with **foreign keys**  
- Includes constraints and indexes for **performance & reliability**  

---
