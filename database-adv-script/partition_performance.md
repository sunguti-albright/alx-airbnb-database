# Partitioning Performance Report

## Objective
The `booking` table was assumed to be very large, causing slow queries on date ranges.  
We implemented **range partitioning** on the `start_date` column.

## Setup
- Parent table: `booking`
- Partitions:
  - `booking_2024` (all bookings in 2024)
  - `booking_2025` (all bookings in 2025)
  - `booking_default` (future/fallback)

## Observations

### Before Partitioning
- Queries scanning bookings by `start_date` required **sequential scans** on the entire table.
- For example, fetching bookings for **September 2025** required scanning all rows in the table.

### After Partitioning
- Queries are automatically routed to the relevant partition.
- Example:
  ```sql
  EXPLAIN ANALYZE
  SELECT * FROM booking
  WHERE start_date BETWEEN '2025-09-01' AND '2025-09-30';
