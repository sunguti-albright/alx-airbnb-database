# Complex Joins Queries

This directory contains SQL scripts demonstrating the use of INNER JOIN, LEFT JOIN, and FULL OUTER JOIN on the Airbnb database.

## Files
- **joins_queries.sql**: Contains SQL queries with different types of joins.
- **README.md**: This file.

## Queries Overview
1. **INNER JOIN** → Retrieves all bookings along with the users who made them.
2. **LEFT JOIN** → Retrieves all properties and their reviews, including properties with no reviews.
3. **FULL OUTER JOIN** → Retrieves all users and all bookings, even if the user has no booking or the booking is not linked to a user.

---

# Subqueries

This section demonstrates both **non-correlated** and **correlated** subqueries in SQL.

## Files
- **subqueries.sql**: Contains SQL queries using subqueries.
- **README.md**: This file.

## Queries Overview
1. **Properties with Average Rating > 4.0 (Non-Correlated Subquery)**  
   - Finds all properties whose average rating is greater than 4.0.  
   - Uses a subquery to calculate the average rating per property.  
   - The outer query returns only those properties meeting the condition.

2. **Users with More Than 3 Bookings (Correlated Subquery)**  
   - Identifies users who have made more than three bookings.  
   - Uses a correlated subquery where the inner query counts bookings for each user.  
   - Only users with more than 3 bookings are included.

---

# Aggregations and Window Functions

This directory demonstrates the use of SQL aggregation (`COUNT`, `GROUP BY`) and window functions (`RANK`, `ROW_NUMBER`) on the Airbnb database.

## Files
- **aggregations_and_window_functions.sql**: Contains SQL queries using aggregations and window functions.
- **README.md**: This file.

## Queries Overview
1. **Total Bookings by User (Aggregation)**  
   - Uses `COUNT` to calculate the total number of bookings per user.  
   - Groups results by user and orders them by the number of bookings in descending order.  
   - Ensures users with no bookings are still listed (via `LEFT JOIN`).

2. **Ranking Properties by Bookings (Window Function)**  
   - Uses `RANK()` window function to assign a ranking to each property based on the number of bookings.  
   - Properties with the same booking count share the same rank.  
   - Results are ordered by rank, showing the most booked properties first.


---
# Aggregations and Window Functions

This directory demonstrates the use of SQL aggregation (`COUNT`, `GROUP BY`) and window functions (`ROW_NUMBER`, `RANK`) on the Airbnb database.

## Files
- **aggregations_and_window_functions.sql**: Contains SQL queries using aggregations and window functions.
- **README.md**: This file.

## Queries Overview
1. **Total Bookings by User (Aggregation)**  
   - Uses `COUNT` to calculate the total number of bookings per user.  
   - Groups results by user and orders them by the number of bookings in descending order.  
   - Ensures users with no bookings are still listed (via `LEFT JOIN`).

2. **Ranking Properties (Window Functions)**  
   - **ROW_NUMBER()** assigns a unique sequential number to each property ordered by booking count.  
   - **RANK()** assigns rankings, allowing ties if multiple properties have the same booking count.  
   - Both show the most booked properties first.
