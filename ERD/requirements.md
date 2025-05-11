Below is a **requirements.md** that captures all of the entities, relationships, attributes and business rules implied by your ERD diagram.

```markdown
# Airbnb-Style Database: Requirements Specification

## 1. Overview
Design a relational database to power an Airbnb-like platform.  
Key features:
- **Users** register as guests, hosts or admins.
- **Hosts** list properties for rent.
- **Guests** book properties and make payments.
- **Users** can send in-platform messages.
- **Guests** leave reviews on properties they’ve stayed in.

This document spells out the entities (tables), their attributes (columns), relationships, and integrity/business rules.

---

## 2. Entities & Attributes

### 2.1 USERS
- **user_id** (UUID, PK, indexed)  
- **first_name** (VARCHAR, NOT NULL)  
- **last_name** (VARCHAR, NOT NULL)  
- **email** (VARCHAR, UNIQUE, NOT NULL)  
- **password_hash** (VARCHAR, NOT NULL)  
- **phone_number** (VARCHAR, NULL)  
- **role** (ENUM: `guest`, `host`, `admin`; NOT NULL)  
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

### 2.2 PROPERTIES
- **property_id** (UUID, PK, indexed)  
- **host_id** (UUID, FK → USERS.user_id)  
- **name** (VARCHAR, NOT NULL)  
- **description** (TEXT, NOT NULL)  
- **location** (VARCHAR, NOT NULL)  
- **price_per_night** (DECIMAL, NOT NULL)  
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  
- **updated_at** (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)  

### 2.3 BOOKINGS
- **booking_id** (UUID, PK, indexed)  
- **property_id** (UUID, FK → PROPERTIES.property_id)  
- **user_id** (UUID, FK → USERS.user_id)  
- **start_date** (DATE, NOT NULL)  
- **end_date** (DATE, NOT NULL)  
- **total_price** (DECIMAL, NOT NULL)  
- **status** (ENUM: `pending`, `confirmed`, `canceled`; NOT NULL)  
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

### 2.4 PAYMENTS
- **payment_id** (UUID, PK, indexed)  
- **booking_id** (UUID, FK → BOOKINGS.booking_id)  
- **amount** (DECIMAL, NOT NULL)  
- **payment_date** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  
- **payment_method** (ENUM: `credit_card`, `paypal`, `stripe`; NOT NULL)  

### 2.5 REVIEWS
- **review_id** (UUID, PK, indexed)  
- **property_id** (UUID, FK → PROPERTIES.property_id)  
- **user_id** (UUID, FK → USERS.user_id)  
- **rating** (INTEGER, CHECK rating ≥ 1 AND rating ≤ 5, NOT NULL)  
- **comment** (TEXT, NOT NULL)  
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

### 2.6 MESSAGES
- **message_id** (UUID, PK, indexed)  
- **sender_id** (UUID, FK → USERS.user_id)  
- **recipient_id** (UUID, FK → USERS.user_id)  
- **message_body** (TEXT, NOT NULL)  
- **sent_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)  

---

## 3. Relationships & Cardinalities

1. **USERS (host) ➔ PROPERTIES**  
   - 1 User (role=`host`) ⟶ *Many* Properties  
2. **USERS (guest) ➔ BOOKINGS**  
   - 1 User (role=`guest`) ⟶ *Many* Bookings  
3. **PROPERTIES ➔ BOOKINGS**  
   - 1 Property ⟶ *Many* Bookings  
4. **BOOKINGS ➔ PAYMENTS**  
   - 1 Booking ⟶ *One* Payment  
5. **USERS ➔ MESSAGES ➔ USERS**  
   - 1 User ⟶ *Many* Messages as Sender  
   - 1 User ⟶ *Many* Messages as Recipient  
6. **USERS ➔ REVIEWS** & **PROPERTIES ➔ REVIEWS**  
   - 1 User ⟶ *Many* Reviews  
   - 1 Property ⟶ *Many* Reviews  

---

## 4. Business Rules & Data Integrity

- **Emails** must be unique across all users.
- **Passwords** are stored as hashed strings; never in plain text.
- **User.role** limits actions:
  - `guest` → can book, pay, review, message
  - `host` → can list properties, message guests
  - `admin` → full system oversight
- **Booking.status** lifecycle: `pending` → `confirmed` or `canceled`
- **Review.rating** must be an integer between 1 and 5.
- **Payment** must reference an existing booking; one-to-one.
- **Timestamps** (`created_at`, `updated_at`) auto-populate.

---

## 5. Indexing & Performance

- Primary keys (`*_id`) are UUIDs and indexed by default.
- Foreign keys (`host_id`, `user_id`, `property_id`, `booking_id`) should each have an index for fast joins.
- Consider indexing commonly filtered fields:
  - `Bookings.start_date`, `Bookings.status`
  - `Properties.location`, `Properties.price_per_night`

---

## 6. Sample User Stories

1. **As a Guest**, I want to browse available properties so I can choose where to stay.  
2. **As a Host**, I want to list a new property with images, description, location and pricing.  
3. **As a Guest**, I want to book a property for specific dates and pay securely.  
4. **As a Guest**, I want to leave a review (rating + comment) after my stay.  
5. **As a User**, I want to message other users (e.g. guest ⇄ host) within the platform.  
6. **As an Admin**, I want to view and manage all bookings, payments, users, and listings.  

---