# Performance Monitoring and Optimization

## Objective  
Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

## Step 1: Analyze Unoptimized Query

**Query Used:**
```sql
SELECT *
FROM bookings
WHERE start_date BETWEEN '2025-02-01' AND '2025-02-28';
```
## EXPLAIN ANALYZE Output (Before Optimization):

Seq Scan on bookings  (cost=0.00..20.80 rows=4 width=84) (actual time=0.003..0.003 rows=0 loops=1)
  Filter: ((start_date >= '2025-02-01'::date) AND (start_date <= '2025-02-28'::date))
Planning Time: 0.323 ms
Execution Time: 0.033 ms

**Diagnosis:**
- PostgreSQL used a sequential scan over the entire bookings table.
- No index was leveraged.
- For large datasets, this becomes inefficient.

## Step 2: Optimization Applied
Dropped the unpartitioned bookings table.
Created a partitioned table booking using RANGE partitioning on start_date.
Added indexes on each partition's start_date.

## Optimized Query Used:
```sql
SELECT *
FROM booking
WHERE start_date BETWEEN '2025-02-01' AND '2025-02-28';
```
## EXPLAIN ANALYZE Output (After Optimization):

Bitmap Heap Scan on booking_2025_02 booking  (cost=4.20..12.69 rows=5 width=52) (actual time=0.024..0.025 rows=0 loops=1)
  Recheck Cond: ((start_date >= '2025-02-01'::date) AND (start_date <= '2025-02-28'::date))
  ->  Bitmap Index Scan on booking_2025_02_start_date_idx  (cost=0.00..4.20 rows=5 width=0) (actual time=0.007..0.008 rows=0 loops=1)
Planning Time: 2.398 ms
Execution Time: 0.100 ms

**Outcome:**
Only the relevant partition (booking_2025_02) was scanned.
Bitmap index scan replaced the full table scan.
Optimized for scalability as data grows.

## Summary

By implementing table partitioning and strategic indexing, we optimized the query to:
Target only the relevant partition.
Use efficient index scans.