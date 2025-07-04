# Query Optimization Report

## Initial Query
The initial query retrieves:
- All bookings with **user**, **property**, and **payment** details.
- It uses `WHERE b.status = 'confirmed' AND pay.status = 'completed'`.

### Problems
- Selected many unnecessary columns (`user_id`, `property_id`, etc.).
- Used `INNER JOIN` on `payment`, which excluded bookings without payments.
- Without indexes, PostgreSQL performed **sequential scans** on `booking` and `payment`.
- Combining `WHERE` with `AND` increased filtering cost.

## Optimized Query
The optimized query:
1. Reduced output columns to only what’s needed.
2. Changed `JOIN payment` to `LEFT JOIN payment`, making it more inclusive.
3. Still applied filters with `WHERE b.status = 'confirmed' AND (pay.status = 'completed' OR pay.status IS NULL)`.
4. Leveraged indexes:
   - `idx_booking_user_id`
   - `idx_booking_property_id`
   - `idx_payment_booking_id`

## Performance Gains
- `EXPLAIN ANALYZE` now shows **Index Scan** instead of Seq Scan.
- Query cost and execution time reduced significantly.
- More scalable for large datasets.
