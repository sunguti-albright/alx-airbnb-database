-- AirBnB Database Schema
-- Created based on specification with normalization to 3NF

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create UserRole table (normalized from ENUM)
CREATE TABLE UserRole (
    role_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_name VARCHAR(20) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Location table (normalized from Property table)
CREATE TABLE Location (
    location_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    address VARCHAR NOT NULL,
    city VARCHAR NOT NULL,
    state VARCHAR NOT NULL,
    country VARCHAR NOT NULL,
    zip_code VARCHAR,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create User table
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    role_id UUID NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES UserRole(role_id)
);

-- Create Property table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    location_id UUID NOT NULL,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    pricepernight DECIMAL NOT NULL CHECK (pricepernight >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES "User"(user_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);

-- Create Booking table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES "User"(user_id),
    CHECK (start_date < end_date)
);

-- Create Payment table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL UNIQUE,
    amount DECIMAL NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Review table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES "User"(user_id)
);

-- Create Message table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES "User"(user_id),
    FOREIGN KEY (recipient_id) REFERENCES "User"(user_id)
);

-- Create PropertyAudit table for tracking price changes
CREATE TABLE PropertyAudit (
    audit_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    host_id UUID NOT NULL,
    old_price DECIMAL,
    new_price DECIMAL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    changed_by UUID,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (host_id) REFERENCES "User"(user_id),
    FOREIGN KEY (changed_by) REFERENCES "User"(user_id)
);

-- Create indexes for better performance

-- User table indexes
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_user_role ON "User"(role_id);

-- Property table indexes
CREATE INDEX idx_property_host ON Property(host_id);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Booking table indexes
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
CREATE INDEX idx_booking_status ON Booking(status);

-- Payment table indexes
CREATE INDEX idx_payment_booking ON Payment(booking_id);
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Review table indexes
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);

-- Message table indexes
CREATE INDEX idx_message_sender ON Message(sender_id);
CREATE INDEX idx_message_recipient ON Message(recipient_id);
CREATE INDEX idx_message_sent_at ON Message(sent_at);

-- PropertyAudit table indexes
CREATE INDEX idx_audit_property ON PropertyAudit(property_id);
CREATE INDEX idx_audit_changed_at ON PropertyAudit(changed_at);

-- Insert default user roles
INSERT INTO UserRole (role_id, role_name, description) VALUES
(uuid_generate_v4(), 'guest', 'Regular user who can book properties'),
(uuid_generate_v4(), 'host', 'User who can list and manage properties'),
(uuid_generate_v4(), 'admin', 'Administrator with full system access');

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_property_updated_at 
    BEFORE UPDATE ON Property
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Create function to log price changes
CREATE OR REPLACE FUNCTION log_price_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.pricepernight IS DISTINCT FROM NEW.pricepernight THEN
        INSERT INTO PropertyAudit (property_id, host_id, old_price, new_price, changed_by)
        VALUES (OLD.property_id, OLD.host_id, OLD.pricepernight, NEW.pricepernight, CURRENT_USER);
    END IF;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to log price changes
CREATE TRIGGER track_price_changes
    AFTER UPDATE OF pricepernight ON Property
    FOR EACH ROW
    EXECUTE FUNCTION log_price_change();