
# Database Normalisation Report

## 1. Overview of Current Schema

The schema consists of six core entities (tables):

* **USERS** (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`)
* **PROPERTIES** (`property_id`, `host_id`, `name`, `description`, `location`, `price_per_night`, `created_at`, `updated_at`)
* **BOOKINGS** (`booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`)
* **PAYMENTS** (`payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`)
* **REVIEWS** (`review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`)
* **MESSAGES** (`message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`)

All primary keys are single-attribute UUIDs. Relationships are enforced via foreign keys.

---

## 2. First Normal Form (1NF)

* All columns store single, atomic values (e.g., `email` is a single string; `start_date` is a single date).
* No repeating groups or arrays in any attribute.
* Each table has a primary key (`*_id`) ensuring row-level uniqueness.

---

## 3. Second Normal Form (2NF)

* All tables use a single-attribute primary key (UUID). There are no composite keys, so partial dependencies cannot occur.
* Every non-key attribute in each table depends directly on the table’s primary key.

---

## 4. Third Normal Form (3NF)

* **USERS**: All attributes (`first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`) describe the user and depend solely on `user_id`. No attribute depends on another non-key attribute.
* **PROPERTIES**: Attributes (`name`, `description`, `location`, `price_per_night`, `created_at`, `updated_at`) depend only on `property_id`. The `host_id` foreign key references the user but is not used to derive other fields.
* **BOOKINGS**: Attributes (`start_date`, `end_date`, `total_price`, `status`, `created_at`) depend only on `booking_id`. No transitive dependency, as total price is assumed calculated prior to insertion.
* **PAYMENTS**: Attributes (`amount`, `payment_date`, `payment_method`) depend solely on `payment_id`. The relationship to `booking_id` is a foreign key, not a determinant for other fields.
* **REVIEWS**: Attributes (`rating`, `comment`, `created_at`) depend only on `review_id`. No attribute is functionally dependent on another non-key attribute.
* **MESSAGES**: Attributes (`message_body`, `sent_at`) depend only on `message_id`.

**Conclusion:** 
* After reviewing the database schema, we can confirm that it meets the requirements of 3NF. No major changes were needed.

---
