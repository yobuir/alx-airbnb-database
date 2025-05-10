# Database Normalization

## 🔹 Step 1: First Normal Form (1NF)

**Requirements:**
- Each table should have a primary key.
- Each field should contain only atomic values (no repeating groups or arrays).

**Result:**
✅ All tables have unique primary keys (e.g., `user_id`, `property_id`, `booking_id`).
✅ All attributes contain atomic values (e.g., `first_name`, `email`, `location`, etc.).

---

## 🔹 Step 2: Second Normal Form (2NF)

**Requirements:**
- Must meet 1NF.
- All non-key attributes must be fully functionally dependent on the primary key.

**Analysis:**
✅ All tables have simple primary keys (not composite).
✅ All attributes in each table are fully dependent on their table's primary key.

Example:
- In the `Booking` table, attributes like `start_date`, `end_date`, and `total_price` depend fully on `booking_id`.

---

## 🔹 Step 3: Third Normal Form (3NF)

**Requirements:**
- Must meet 2NF.
- No transitive dependency (non-key attributes should not depend on other non-key attributes).

**Verification:**
- `User`: All fields depend directly on `user_id`.
- `Property`: All fields depend directly on `property_id`.
- `Booking`: All fields depend directly on `booking_id`.
- `Payment`: Depends only on `payment_id`; linked to `booking_id`.
- `Review`: Depends on `review_id`; foreign keys link to `property_id` and `user_id`.
- `Message`: No transitive dependency; `message_body` and `sent_at` depend on `message_id`.

✅ All tables satisfy 3NF.

---

## ✅ Conclusion

The current database schema meets all requirements of **Third Normal Form (3NF)**:

- Each table has a primary key.
- No partial dependencies exist.
- No transitive dependencies exist.
