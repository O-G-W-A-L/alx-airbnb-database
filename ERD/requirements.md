# Airbnb-Style Database: Requirements Specification

## 1. Overview

Design a relational database for an Airbnb-like platform.
Core domain concepts are Users, Properties, Bookings, Payments, Reviews and Messages, with clear relationships and data integrity rules.

## 2. Entities & Attributes

### 2.1 USERS

* **user\_id** (UUID, PK, indexed)
* **first\_name** (VARCHAR, NOT NULL)
* **last\_name** (VARCHAR, NOT NULL)
* **email** (VARCHAR, UNIQUE, NOT NULL)
* **password\_hash** (VARCHAR, NOT NULL)
* **phone\_number** (VARCHAR, NULL)
* **role** (ENUM(`guest`,`host`,`admin`), NOT NULL)
* **created\_at** (TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP)

### 2.2 PROPERTIES

* **property\_id** (UUID, PK, indexed)
* **host\_id** (UUID, FK → USERS.user\_id)
* **name** (VARCHAR, NOT NULL)
* **description** (TEXT, NOT NULL)
* **location** (VARCHAR, NOT NULL)
* **price\_per\_night** (DECIMAL, NOT NULL)
* **created\_at** (TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP)
* **updated\_at** (TIMESTAMP, ON UPDATE CURRENT\_TIMESTAMP)

### 2.3 BOOKINGS

* **booking\_id** (UUID, PK, indexed)
* **property\_id** (UUID, FK → PROPERTIES.property\_id)
* **user\_id** (UUID, FK → USERS.user\_id)
* **start\_date** (DATE, NOT NULL)
* **end\_date** (DATE, NOT NULL)
* **total\_price** (DECIMAL, NOT NULL)
* **status** (ENUM(`pending`,`confirmed`,`canceled`), NOT NULL)
* **created\_at** (TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP)

### 2.4 PAYMENTS

* **payment\_id** (UUID, PK, indexed)
* **booking\_id** (UUID, FK → BOOKINGS.booking\_id)
* **amount** (DECIMAL, NOT NULL)
* **payment\_date** (TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP)
* **payment\_method** (ENUM(`credit_card`,`paypal`,`stripe`), NOT NULL)

### 2.5 REVIEWS

* **review\_id** (UUID, PK, indexed)
* **property\_id** (UUID, FK → PROPERTIES.property\_id)
* **user\_id** (UUID, FK → USERS.user\_id)
* **rating** (INTEGER, CHECK rating ≥ 1 AND rating ≤ 5, NOT NULL)
* **comment** (TEXT, NOT NULL)
* **created\_at** (TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP)

### 2.6 MESSAGES

* **message\_id** (UUID, PK, indexed)
* **sender\_id** (UUID, FK → USERS.user\_id)
* **recipient\_id** (UUID, FK → USERS.user\_id)
* **message\_body** (TEXT, NOT NULL)
* **sent\_at** (TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP)

## 3. Relationships & Cardinalities

* **USERS (host) → PROPERTIES**

  * 1 User ⟶ *Many* Properties

* **USERS (guest) → BOOKINGS**

  * 1 User ⟶ *Many* Bookings

* **PROPERTIES → BOOKINGS**

  * 1 Property ⟶ *Many* Bookings

* **BOOKINGS → PAYMENTS**

  * 1 Booking ⟶ *1* Payment

* **USERS ↔ MESSAGES**

  * 1 User ⟶ *Many* sent Messages
  * 1 User ⟶ *Many* received Messages

* **USERS → REVIEWS** & **PROPERTIES → REVIEWS**

  * 1 User ⟶ *Many* Reviews
  * 1 Property ⟶ *Many* Reviews

## 4. Integrity & Business Rules

* **Email** is unique; **password\_hash** stores only hashed passwords.
* **role** controls capabilities (guest vs. host vs. admin).
* **Booking.status** values: `pending`, `confirmed`, `canceled`.
* **rating** must be an integer between 1 and 5.
* **Payments** link one-to-one with Bookings.
* **Timestamps** auto-set on creation (`created_at`) and update (`updated_at` on Properties).

## 5. Indexing Guidelines

* UUID primary keys are indexed by default.
* Index foreign keys: `host_id`, `user_id`, `property_id`, `booking_id`.
* Optionally index frequently queried columns such as:

  * `Bookings.start_date`, `Bookings.status`
  * `Properties.location`, `Properties.price_per_night`
