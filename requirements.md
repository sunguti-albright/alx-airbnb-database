# AirBnB Database - Entity Relationship Diagram Requirements

## Objective
To create a comprehensive Entity-Relationship Diagram (ERD) that visually represents the database structure for an AirBnB-like application.

## Entities and Attributes

### 1. User Entity
- `user_id`: Primary Key, UUID, Indexed
- `first_name`: VARCHAR, NOT NULL
- `last_name`: VARCHAR, NOT NULL
- `email`: VARCHAR, UNIQUE, NOT NULL
- `password_hash`: VARCHAR, NOT NULL
- `phone_number`: VARCHAR, NULL
- `role`: ENUM (guest, host, admin), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 2. Property Entity
- `property_id`: Primary Key, UUID, Indexed
- `host_id`: Foreign Key, references User(user_id)
- `name`: VARCHAR, NOT NULL
- `description`: TEXT, NOT NULL
- `location`: VARCHAR, NOT NULL
- `pricepernight`: DECIMAL, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### 3. Booking Entity
- `booking_id`: Primary Key, UUID, Indexed
- `property_id`: Foreign Key, references Property(property_id)
- `user_id`: Foreign Key, references User(user_id)
- `start_date`: DATE, NOT NULL
- `end_date`: DATE, NOT NULL
- `total_price`: DECIMAL, NOT NULL
- `status`: ENUM (pending, confirmed, canceled), NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 4. Payment Entity
- `payment_id`: Primary Key, UUID, Indexed
- `booking_id`: Foreign Key, references Booking(booking_id)
- `amount`: DECIMAL, NOT NULL
- `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL

### 5. Review Entity
- `review_id`: Primary Key, UUID, Indexed
- `property_id`: Foreign Key, references Property(property_id)
- `user_id`: Foreign Key, references User(user_id)
- `rating`: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
- `comment`: TEXT, NOT NULL
- `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### 6. Message Entity
- `message_id`: Primary Key, UUID, Indexed
- `sender_id`: Foreign Key, references User(user_id)
- `recipient_id`: Foreign Key, references User(user_id)
- `message_body`: TEXT, NOT NULL
- `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Relationships Definition

### 1. User to Property Relationship
- **Relationship Type**: One-to-Many (1:N)
- **Description**: A User (with host role) can list multiple Properties, but each Property is listed by exactly one User
- **Implementation**: Foreign key `host_id` in Property table referencing User table

### 2. User to Booking Relationship
- **Relationship Type**: One-to-Many (1:N)
- **Description**: A User (guest) can make multiple Bookings, but each Booking is made by exactly one User
- **Implementation**: Foreign key `user_id` in Booking table referencing User table

### 3. Property to Booking Relationship
- **Relationship Type**: One-to-Many (1:N)
- **Description**: A Property can have multiple Bookings, but each Booking is for exactly one Property
- **Implementation**: Foreign key `property_id` in Booking table referencing Property table

### 4. Booking to Payment Relationship
- **Relationship Type**: One-to-One (1:1)
- **Description**: Each Booking has exactly one Payment, and each Payment is for exactly one Booking
- **Implementation**: Foreign key `booking_id` in Payment table referencing Booking table

### 5. User to Review Relationship
- **Relationship Type**: One-to-Many (1:N)
- **Description**: A User can write multiple Reviews, but each Review is written by exactly one User
- **Implementation**: Foreign key `user_id` in Review table referencing User table

### 6. Property to Review Relationship
- **Relationship Type**: One-to-Many (1:N)
- **Description**: A Property can receive multiple Reviews, but each Review is for exactly one Property
- **Implementation**: Foreign key `property_id` in Review table referencing Property table

### 7. User to Message Relationships
- **Relationship Type**: Many-to-Many (M:N) implemented as two One-to-Many relationships
- **Description**: A User can send multiple Messages to different recipients and receive multiple Messages from different senders
- **Implementation**: Two foreign keys in Message table (`sender_id` and `recipient_id`) both referencing User table

## Constraints
- All primary keys must be UUIDs and indexed
- Unique constraint on User.email
- Non-null constraints on all required fields
- Foreign key constraints on all relationship fields
- ENUM constraints on role, status, and payment_method fields
- Check constraint on Review.rating (1-5)

## Indexing Requirements
- Primary Keys: Automatically indexed
- Additional Indexes:
  - email in User table
  - property_id in Property and Booking tables
  - booking_id in Booking and Payment tables
  - user_id in Booking and Review tables

