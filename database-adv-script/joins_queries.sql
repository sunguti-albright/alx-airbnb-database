-- 1. INNER JOIN: Bookings with respective users
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM booking b
INNER JOIN "User" u ON b.user_id = u.user_id
ORDER BY u.first_name, u.last_name;

-- 2. LEFT JOIN: Properties with their reviews (including properties without reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
ORDER BY p.name;

-- 3. FULL OUTER JOIN: Users and Bookings (all, even if unmatched)
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM "User" u
FULL OUTER JOIN booking b ON u.user_id = b.user_id
ORDER BY u.first_name, u.last_name;
