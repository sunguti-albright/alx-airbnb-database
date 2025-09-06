-- AirBnB Database Seed Data - Data Insertion Only
-- This script populates existing tables with sample data

-- 1. Insert User Roles (only if they don't exist)
INSERT INTO userrole (role_name, description)
SELECT 'guest', 'Regular user who can book properties'
WHERE NOT EXISTS (SELECT 1 FROM userrole WHERE role_name = 'guest');

INSERT INTO userrole (role_name, description)
SELECT 'host', 'User who can list and manage properties'
WHERE NOT EXISTS (SELECT 1 FROM userrole WHERE role_name = 'host');

INSERT INTO userrole (role_name, description)
SELECT 'admin', 'Administrator with full system access'
WHERE NOT EXISTS (SELECT 1 FROM userrole WHERE role_name = 'admin');

-- 2. Insert Users (only if they don't exist)
INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'host'),
    'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2b$10$examplehash', '+1-555-0101'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'sarah.johnson@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'host'),
    'Mike', 'Chen', 'mike.chen@email.com', '$2b$10$examplehash', '+1-555-0102'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'mike.chen@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'host'),
    'Lisa', 'Rodriguez', 'lisa.rodriguez@email.com', '$2b$10$examplehash', '+1-555-0103'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'lisa.rodriguez@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'guest'),
    'David', 'Kim', 'david.kim@email.com', '$2b$10$examplehash', '+1-555-0104'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'david.kim@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'guest'),
    'Emily', 'Wilson', 'emily.wilson@email.com', '$2b$10$examplehash', '+1-555-0105'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'emily.wilson@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'guest'),
    'James', 'Brown', 'james.brown@email.com', '$2b$10$examplehash', '+1-555-0106'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'james.brown@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'guest'),
    'Maria', 'Garcia', 'maria.garcia@email.com', '$2b$10$examplehash', '+1-555-0107'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'maria.garcia@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'guest'),
    'Robert', 'Taylor', 'robert.taylor@email.com', '$2b$10$examplehash', '+1-555-0108'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'robert.taylor@email.com');

INSERT INTO "User" (role_id, first_name, last_name, email, password_hash, phone_number)
SELECT 
    (SELECT role_id FROM userrole WHERE role_name = 'admin'),
    'Admin', 'User', 'admin@airbnb.com', '$2b$10$adminhash', '+1-555-0000'
WHERE NOT EXISTS (SELECT 1 FROM "User" WHERE email = 'admin@airbnb.com');

-- 3. Insert Locations (only if they don't exist)
INSERT INTO location (address, city, state, country, zip_code, latitude, longitude)
SELECT '123 Ocean Drive', 'Miami Beach', 'FL', 'USA', '33139', 25.7617, -80.1918
WHERE NOT EXISTS (SELECT 1 FROM location WHERE address = '123 Ocean Drive');

INSERT INTO location (address, city, state, country, zip_code, latitude, longitude)
SELECT '456 Broadway', 'New York', 'NY', 'USA', '10012', 40.7128, -74.0060
WHERE NOT EXISTS (SELECT 1 FROM location WHERE address = '456 Broadway');

INSERT INTO location (address, city, state, country, zip_code, latitude, longitude)
SELECT '789 Sunset Blvd', 'Los Angeles', 'CA', 'USA', '90046', 34.0522, -118.2437
WHERE NOT EXISTS (SELECT 1 FROM location WHERE address = '789 Sunset Blvd');

INSERT INTO location (address, city, state, country, zip_code, latitude, longitude)
SELECT '101 Mountain View', 'Denver', 'CO', 'USA', '80202', 39.7392, -104.9903
WHERE NOT EXISTS (SELECT 1 FROM location WHERE address = '101 Mountain View');

INSERT INTO location (address, city, state, country, zip_code, latitude, longitude)
SELECT '202 Lake Shore Dr', 'Chicago', 'IL', 'USA', '60611', 41.8781, -87.6298
WHERE NOT EXISTS (SELECT 1 FROM location WHERE address = '202 Lake Shore Dr');

-- 4. Insert Properties (only if they don't exist)
INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
    (SELECT location_id FROM location WHERE address = '123 Ocean Drive'),
    'Beachfront Paradise', 
    'Beautiful beachfront condo with stunning ocean views, fully equipped kitchen, and private balcony. Perfect for romantic getaways or family vacations.', 
    250.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'Beachfront Paradise');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
    (SELECT location_id FROM location WHERE address = '456 Broadway'),
    'NYC Luxury Loft', 
    'Spacious loft in the heart of Manhattan, featuring high ceilings, modern amenities, and easy access to all major attractions.', 
    350.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'NYC Luxury Loft');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'mike.chen@email.com'),
    (SELECT location_id FROM location WHERE address = '789 Sunset Blvd'),
    'Hollywood Hills Retreat', 
    'Private villa with panoramic city views, infinity pool, and outdoor entertainment area. Perfect for luxury seekers.', 
    500.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'Hollywood Hills Retreat');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'mike.chen@email.com'),
    (SELECT location_id FROM location WHERE address = '101 Mountain View'),
    'Mountain Cabin', 
    'Cozy log cabin with fireplace, hot tub, and access to hiking trails. Ideal for nature lovers and outdoor enthusiasts.', 
    180.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'Mountain Cabin');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com'),
    (SELECT location_id FROM location WHERE address = '202 Lake Shore Dr'),
    'Downtown Chic Apartment', 
    'Modern apartment in the heart of Chicago, steps away from restaurants, shopping, and cultural attractions.', 
    220.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'Downtown Chic Apartment');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com'),
    (SELECT location_id FROM location WHERE address = '456 Broadway'),
    'Broadway Studio', 
    'Compact but stylish studio perfect for solo travelers or couples exploring New York City.', 
    150.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'Broadway Studio');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com'),
    (SELECT location_id FROM location WHERE address = '789 Sunset Blvd'),
    'LA Bungalow', 
    'Charming bungalow with California vibe, private garden, and easy access to beaches and Hollywood.', 
    195.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'LA Bungalow');

INSERT INTO property (host_id, location_id, name, description, pricepernight)
SELECT 
    (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com'),
    (SELECT location_id FROM location WHERE address = '123 Ocean Drive'),
    'Miami Art Deco Studio', 
    'Historic art deco building studio with character, located in South Beach near nightlife and restaurants.', 
    175.00
WHERE NOT EXISTS (SELECT 1 FROM property WHERE name = 'Miami Art Deco Studio');

-- ========== BOOKINGS ==========

-- Sarah -> Beachfront Paradise
INSERT INTO booking (user_id, property_id, start_date, end_date, status, created_at)
SELECT
  (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
  (SELECT property_id FROM property WHERE name = 'Beachfront Paradise'),
  DATE '2025-09-10', DATE '2025-09-15', 'confirmed', NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM booking b
  WHERE b.user_id = (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com')
    AND b.property_id = (SELECT property_id FROM property WHERE name = 'Beachfront Paradise')
    AND b.start_date = DATE '2025-09-10' AND b.end_date = DATE '2025-09-15'
);

-- Mike -> NYC Luxury Loft
INSERT INTO booking (user_id, property_id, start_date, end_date, status, created_at)
SELECT
  (SELECT user_id FROM "User" WHERE email = 'mike.chen@email.com'),
  (SELECT property_id FROM property WHERE name = 'NYC Luxury Loft'),
  DATE '2025-09-12', DATE '2025-09-18', 'pending', NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM booking b
  WHERE b.user_id = (SELECT user_id FROM "User" WHERE email = 'mike.chen@email.com')
    AND b.property_id = (SELECT property_id FROM property WHERE name = 'NYC Luxury Loft')
    AND b.start_date = DATE '2025-09-12' AND b.end_date = DATE '2025-09-18'
);

-- Lisa -> Hollywood Hills Retreat
INSERT INTO booking (user_id, property_id, start_date, end_date, status, created_at)
SELECT
  (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com'),
  (SELECT property_id FROM property WHERE name = 'Hollywood Hills Retreat'),
  DATE '2025-09-20', DATE '2025-09-25', 'cancelled', NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM booking b
  WHERE b.user_id = (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com')
    AND b.property_id = (SELECT property_id FROM property WHERE name = 'Hollywood Hills Retreat')
    AND b.start_date = DATE '2025-09-20' AND b.end_date = DATE '2025-09-25'
);

-- ========== REVIEWS ==========

-- Sarah reviews Beachfront Paradise
INSERT INTO review (property_id, user_id, rating, comment, created_at)
SELECT
  (SELECT property_id FROM property WHERE name = 'Beachfront Paradise'),
  (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com'),
  5, 'Amazing beachfront stay! Highly recommended.', NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM review r
  WHERE r.property_id = (SELECT property_id FROM property WHERE name = 'Beachfront Paradise')
    AND r.user_id = (SELECT user_id FROM "User" WHERE email = 'sarah.johnson@email.com')
    AND r.rating = 5
    AND r.comment = 'Amazing beachfront stay! Highly recommended.'
);

-- Mike reviews NYC Luxury Loft
INSERT INTO review (property_id, user_id, rating, comment, created_at)
SELECT
  (SELECT property_id FROM property WHERE name = 'NYC Luxury Loft'),
  (SELECT user_id FROM "User" WHERE email = 'mike.chen@email.com'),
  4, 'Beautiful loft, but a bit noisy at night.', NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM review r
  WHERE r.property_id = (SELECT property_id FROM property WHERE name = 'NYC Luxury Loft')
    AND r.user_id = (SELECT user_id FROM "User" WHERE email = 'mike.chen@email.com')
    AND r.rating = 4
    AND r.comment = 'Beautiful loft, but a bit noisy at night.'
);

-- Lisa reviews Hollywood Hills Retreat
INSERT INTO review (property_id, user_id, rating, comment, created_at)
SELECT
  (SELECT property_id FROM property WHERE name = 'Hollywood Hills Retreat'),
  (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com'),
  3, 'Great view, but the pool was closed.', NOW()
WHERE NOT EXISTS (
  SELECT 1 FROM review r
  WHERE r.property_id = (SELECT property_id FROM property WHERE name = 'Hollywood Hills Retreat')
    AND r.user_id = (SELECT user_id FROM "User" WHERE email = 'lisa.rodriguez@email.com')
    AND r.rating = 3
    AND r.comment = 'Great view, but the pool was closed.'
);


-- Display success message
SELECT 'Database seeded successfully with sample data!' AS message;
