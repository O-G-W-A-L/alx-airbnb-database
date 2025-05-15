## Partition Performance Summary

### Baseline Query (Before Partitioning)

**Query:**
```sql
SELECT * FROM bookings WHERE start_date BETWEEN '2025-02-01' AND '2025-02-28';
```
## Execution Plan:

    Seq Scan on bookings

    Planning Time: 0.323 ms

    Execution Time: 0.033 ms

### After Partitioning by start_date

Partitioned Table: booking
Partition: booking_2025_02
Index Used: booking_2025_02_start_date_idx

**Query:**
```sql
SELECT * FROM booking WHERE start_date BETWEEN '2025-02-01' AND '2025-02-28';
```
## Execution Plan:

    Bitmap Index Scan → Bitmap Heap Scan on relevant partition

    Planning Time: 2.398 ms

    Execution Time: 0.100 ms