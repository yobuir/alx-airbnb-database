-- Implementation of table partitioning for the Booking table based on start_date
-- This approach improves query performance for large datasets by dividing the table into smaller, more manageable chunks

-- 1. Create a new partitioned table structure
CREATE TABLE Booking_Partitioned (
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create quarterly partitions for years 2024 and 2025
-- Q1 2024 (Jan-Mar)
CREATE TABLE booking_q1_2024 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

-- Q2 2024 (Apr-Jun)
CREATE TABLE booking_q2_2024 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

-- Q3 2024 (Jul-Sep)
CREATE TABLE booking_q3_2024 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

-- Q4 2024 (Oct-Dec)
CREATE TABLE booking_q4_2024 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

-- Q1 2025 (Jan-Mar)
CREATE TABLE booking_q1_2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

-- Q2 2025 (Apr-Jun)
CREATE TABLE booking_q2_2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

-- Q3 2025 (Jul-Sep)
CREATE TABLE booking_q3_2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

-- Q4 2025 (Oct-Dec)
CREATE TABLE booking_q4_2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- Partition for historical data (before 2024)
CREATE TABLE booking_historical PARTITION OF Booking_Partitioned
    FOR VALUES FROM (MINVALUE) TO ('2024-01-01');

-- Partition for future data (after 2025)
CREATE TABLE booking_future PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- 3. Copy data from the original Booking table to the partitioned table
INSERT INTO Booking_Partitioned
SELECT * FROM Booking;

-- 4. Create indexes on the partitioned table for better query performance
CREATE INDEX idx_booking_part_user ON Booking_Partitioned(user_id);
CREATE INDEX idx_booking_part_property ON Booking_Partitioned(property_id);
CREATE INDEX idx_booking_part_dates ON Booking_Partitioned(start_date, end_date);

-- 5. Test query performance before partitioning
EXPLAIN ANALYZE
SELECT * 
FROM Booking
WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31';

-- 6. Test query performance after partitioning (same query on partitioned table)
EXPLAIN ANALYZE
SELECT * 
FROM Booking_Partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31';

-- 7. Test query performance for a specific user's bookings before partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE user_id = 123 AND start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- 8. Test query performance for a specific user's bookings after partitioning
EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE user_id = 123 AND start_date BETWEEN '2025-01-01' AND '2025-12-31';

-- 9. Optional: If everything is working correctly, rename the tables to switch to the partitioned version
-- Note: In production, this would require proper planning and downtime management
-- RENAME TABLE Booking TO Booking_Old;
-- RENAME TABLE Booking_Partitioned TO Booking;