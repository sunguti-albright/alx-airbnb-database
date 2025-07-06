# Index Performance Optimization

This task focuses on improving query performance in the Airbnb database by creating indexes on frequently used columns.

## Files
- **database_index.sql**: Contains `CREATE INDEX` statements for high-usage columns.
- **index_performance.md**: This file with explanations and performance notes.

## Index Strategy
1. **User Table**
   - **Column:** `email`  
   - **Reason:** Commonly used for login/authentication queries (`WHERE email = ?`).
   - **Index:** `idx_user_email`

2. **Booking Table**
   - **Column:** `user_id`  
   - **Reason:** Frequently joined with the `User` table to find who made a booking.  
   - **Index:** `idx_booking_user_id`

   - **Column:** `property_id`  
   - **Reason:** Frequently joined with the `Property` table to find which property was booked.  
   - **Index:** `idx_booking_property_id`

3. **Property Table**
   - **Column:** `name`  
   - **Reason:** Used in searches and filters by property name.  
   - **Index:** `idx_property_name`

4. **Review Table**
   - **Column:** `property_id`  
   - **Reason:** Joins with properties to fetch all reviews for a property.  
   - **Index:** `idx_review_property_id`

## Performance Testing
We measured performance with `EXPLAIN ANALYZE` before and after creating indexes.
