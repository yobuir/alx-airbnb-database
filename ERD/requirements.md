# ERD and relations definition

## Overview

This Entity-Relationship Diagram (ERD) visually represents the database structure for the ALX Airbnb Clone project. The design is based on the given specifications and includes key entities such as users, properties, bookings, payments, reviews, and messages.

## ERD Screenshot

![ER Diagram](./ERD/Untitled%20Diagram.drawio.png)

## Entities and Relationships

### 1. **User**
- Attributes: `user_id (PK)`, `first_name`, `last_name`, `email (UNIQUE)`, `password_hash`, `phone_number`, `role (ENUM)`, `created_at`
- Relationships:
  - A user can **send and receive messages** (`Message.sender_id`, `Message.recipient_id`)
  - A user can make **multiple bookings**
  - A user can be a **host** of many properties
  - A user can write **multiple reviews**

### 2. **Property**
- Attributes: `property_id (PK)`, `host_id (FK)`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`
- Relationships:
  - Each property is **owned by a host (User)**
  - A property can have **many bookings**
  - A property can have **many reviews**

### 3. **Booking**
- Attributes: `booking_id (PK)`, `property_id (FK)`, `user_id (FK)`, `start_date`, `end_date`, `total_price`, `created_at`
- Relationships:
  - Each booking is made by a **guest (User)** and linked to a **property**
  - Each booking can have **one payment**

### 4. **Payment**
- Attributes: `payment_id (PK)`, `booking_id (FK)`, `amount`, `payment_date`, `payment_method (ENUM)`
- Relationship:
  - Each payment is linked to a **single booking**

### 5. **Review**
- Attributes: `review_id (PK)`, `property_id (FK)`, `user_id (FK)`, `rating`, `comment`, `created_at`
- Relationships:
  - A review is written by a **user** and is associated with a **property**

### 6. **Message**
- Attributes: `message_id (PK)`, `sender_id (FK)`, `recipient_id (FK)`, `message_body`, `sent_at`
- Relationships:
  - Messages are exchanged **between users**

## Notes
- All foreign key constraints are enforced.
- Indexes are applied on primary keys and key columns (e.g., `email`, `property_id`, `booking_id`).
- Enum values are used to ensure data consistency for `role`, `status`, and `payment_method`.
