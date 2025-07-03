-- ==========================================
-- Partitioning Booking Table by start_date
-- ==========================================

-- 1. Rename old table for backup
ALTER TABLE booking RENAME TO booking_old;

-- 2. Create partitioned parent table
CREATE TABLE booking (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 3. Create partitions (example: yearly partitions)
CREATE TABLE booking_2024 PARTITION OF booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Default partition (future-proofing)
CREATE TABLE booking_default PARTITION OF booking DEFAULT;

-- 4. Insert old data back
INSERT INTO booking
SELECT * FROM booking_old;

-- ==========================================
-- Test Queries with Partitioning
-- ==========================================

-- Example: Fetch all bookings in September 2025
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date BETWEEN '2025-09-01' AND '2025-09-30';

-- Example: Count confirmed bookings in 2024
EXPLAIN ANALYZE
SELECT COUNT(*) FROM booking
WHERE status = 'confirmed' AND start_date BETWEEN '2024-01-01' AND '2024-12-31';
