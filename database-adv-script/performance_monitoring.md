# Database Performance Monitoring

This document reports the monitoring and refinement of query performance in the **Airbnb database**.

---

## 1. Queries Monitored
We selected two frequently used queries:

### Query A: Fetch bookings with user details
```sql
EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, u.first_name, u.last_name
FROM booking b
JOIN "User" u ON b.user_id = u.user_id
WHERE b.status = 'confirmed';
``` 

### Query B: Find top-rated properties
```sql
EXPLAIN ANALYZE
SELECT p.property_id, p.name, AVG(r.rating) AS avg_rating
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name
HAVING AVG(r.rating) > 4.0;
``` 
#### Initial Observations

Query A: Used a sequential scan on the booking table, even though we often filter by status.

Query B: Required a full table scan on review for aggregation.

#### Optimization Applied

To improve performance, I added the following indexes:
```sql 
CREATE INDEX idx_booking_status ON booking(status);
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_review_property_id ON review(property_id);
```

#### Results After Indexing

Query A: Execution switched from sequential scan → index scan, reducing execution time.

Query B: Aggregation became faster because the join used the index on review.property_id.

#### Conclusion

By analyzing execution plans using EXPLAIN ANALYZE and applying targeted indexing, we reduced query execution time for common operations such as fetching bookings by status and aggregating reviews by property.