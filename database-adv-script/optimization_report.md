# Query Optimization Report

## Initial Query
The initial query joined four tables:
- **booking** → base table
- **User** → user details
- **property** → property details
- **payment** → payment details

### Problems
- Selected **too many columns** (`user_id`, `property_id`, etc.) that were not required in the final output.
- Used an **INNER JOIN** with `payment`, which excluded bookings without payments.
- Execution plan used **sequential scans** because no indexes existed on join/filter columns.

## Optimized Query
The optimized query:
1. Reduced the **selected columns** to only those needed in the output.
2. Changed `INNER JOIN payment` to `LEFT JOIN payment` to include all bookings (with or without payments).
3. Leveraged the indexes:
   - `idx_booking_user_id`
   - `idx_booking_property_id`
   - `idx_payment_booking_id`

### Performance Gains
- Execution plan switched from **Seq Scan** to **Index Scan**.
- Reduced query cost and execution time (as shown in `EXPLAIN ANALYZE`).
- The query now runs significantly faster on large datasets.
