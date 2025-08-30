# Database Script 0x02: Seed Data

## 📌 Objective
This script provides **sample data** for the Airbnb clone database.  
It ensures the schema can be tested with realistic records across all entities.

---

## 📂 Files
- **`seed.sql`** → SQL script with `INSERT` statements for Users, Properties, Bookings, and Payments.
- **`README.md`** → Documentation of the seeding process.

---

## 🏗️ Entities & Data
1. **Users**
   - Sample users with names, emails, and phone numbers.
2. **Properties**
   - Different types of properties (apartment, villa, studio) hosted by users.
3. **Bookings**
   - Bookings that reference users and properties.
4. **Payments**
   - Payment records linked to bookings.

---

## ▶️ How to Run
Execute the script in your SQL environment after creating the schema:
```bash
mysql -u <username> -p <database_name> < seed.sql
