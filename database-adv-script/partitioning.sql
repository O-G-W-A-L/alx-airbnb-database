-- Drop old table if needed
DROP TABLE IF EXISTS booking CASCADE;

-- Create partitioned parent table
CREATE TABLE booking (
  booking_id INT,
  user_id INT,
  property_id INT,
  start_date DATE NOT NULL,
  end_date DATE,
  status TEXT,
  PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- Create partitions
CREATE TABLE booking_2025_01 PARTITION OF booking
  FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE booking_2025_02 PARTITION OF booking
  FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

-- Index for partition pruning and join speed
CREATE INDEX idx_booking_user_id ON booking (user_id);
CREATE INDEX idx_booking_start_date ON booking (start_date);