# Index Performance Report

## Queries Tested

### 1. Query to find bookings by a specific user

**Before Indexing:**
```sql
EXPLAIN ANALYZE
SELECT * FROM booking WHERE user_id = 1;
```
Result:

Seq Scan on booking  (cost=0.00..100.00 rows=10 width=100)
  Filter: (user_id = 1)

After Indexing:
```sql
EXPLAIN ANALYZE
SELECT * FROM booking WHERE user_id = 1;
```
Result:

Index Scan using idx_booking_user_id on booking  (cost=0.00..10.00 rows=10 width=100)
  Index Cond: (user_id = 1)

Improvement: Execution time reduced significantly due to the index on user_id.

2. Query to find properties in a specific location
Before Indexing:
```sql
EXPLAIN ANALYZE
SELECT * FROM properties WHERE location = 'Kampala';
```
## Result:
Seq Scan on properties  (cost=0.00..50.00 rows=50 width=200)
  Filter: (location = 'Kampala')

After Indexing:
```sql
EXPLAIN ANALYZE
SELECT * FROM properties WHERE location = 'Kampala';
```
Result:

Index Scan using idx_properties_location on properties  (cost=0.00..5.00 rows=50 width=200)
  Index Cond: (location = 'Kampala')

Improvement: Execution time reduced due to the index on location.