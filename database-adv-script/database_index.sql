-- Indexes for performance optimization

-- 1. Index on User email (commonly searched or used in authentication)
CREATE INDEX IF NOT EXISTS idx_user_email
ON "User"(email);

-- 2. Index on Booking user_id (frequently joined with User table)
CREATE INDEX IF NOT EXISTS idx_booking_user_id
ON booking(user_id);

-- 3. Index on Booking property_id (frequently joined with Property table)
CREATE INDEX IF NOT EXISTS idx_booking_property_id
ON booking(property_id);

-- 4. Index on Property name (search/filter by name)
CREATE INDEX IF NOT EXISTS idx_property_name
ON property(name);

-- 5. Index on Review property_id (joining reviews with properties)
CREATE INDEX IF NOT EXISTS idx_review_property_id
ON review(property_id);

-- ==========================================
-- Performance Testing with EXPLAIN ANALYZE
-- ==========================================

-- Query 1: Bookings joined with User by email
EXPLAIN ANALYZE
SELECT * 
FROM booking b
JOIN "User" u ON b.user_id = u.user_id
WHERE u.email = 'sarah.johnson@email.com';

-- Query 2: Count bookings per property (aggregation)
EXPLAIN ANALYZE
SELECT p.name, COUNT(b.booking_id) 
FROM property p
JOIN booking b ON p.property_id = b.property_id
GROUP BY p.name
ORDER BY COUNT(b.booking_id) DESC;
