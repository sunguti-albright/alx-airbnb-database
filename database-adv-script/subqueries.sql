-- 1. Non-correlated subquery: Properties with average rating > 4.0
SELECT 
    p.property_id,
    p.name,
    p.pricepernight
FROM property p
WHERE (
    SELECT AVG(r.rating)
    FROM review r
    WHERE r.property_id = p.property_id
) > 4.0
ORDER BY p.name;

-- 2. Correlated subquery: Users with more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM "User" u
WHERE (
    SELECT COUNT(*)
    FROM booking b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.first_name, u.last_name;
