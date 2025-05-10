-- Measure query performance BEFORE creating indexes
-- Query 1: Finding users by email (commonly used in login)
EXPLAIN ANALYZE
SELECT * FROM User WHERE email = 'example@email.com';

-- Query 2: Finding properties in a specific location within a price range
EXPLAIN ANALYZE
SELECT * FROM Property WHERE location = 'New York' AND price_per_night BETWEEN 100 AND 200;

-- Query 3: Finding available properties during a specific date range
EXPLAIN ANALYZE
SELECT p.* FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE b.property_id IS NULL
   OR b.start_date > '2025-06-01' OR b.end_date < '2025-05-25';

-- Query 4: Finding reviews for a specific property sorted by rating
EXPLAIN ANALYZE
SELECT * FROM Review WHERE property_id = 101 ORDER BY rating DESC;

-- Now create the indexes to improve performance

-- Indexes for User table
-- User email is frequently used for login and lookup operations
CREATE INDEX idx_user_email ON User(email);

-- Indexes for Property table
-- Properties are often searched by location
CREATE INDEX idx_property_location ON Property(location);
-- Properties are often filtered by price range
CREATE INDEX idx_property_price ON Property(price_per_night);

-- Indexes for Booking table
-- Bookings are frequently queried by date ranges
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);
-- Bookings are commonly joined with User and Property tables
CREATE INDEX idx_booking_user ON Booking(user_id);
CREATE INDEX idx_booking_property ON Booking(property_id);

-- Index for Review table
-- Reviews are commonly joined with Property and User tables
CREATE INDEX idx_review_property ON Review(property_id);
CREATE INDEX idx_review_user ON Review(user_id);
-- Reviews are often sorted by rating
CREATE INDEX idx_review_rating ON Review(rating);

-- Measure query performance AFTER creating indexes (same queries as before)
-- Query 1: Finding users by email (now using idx_user_email)
EXPLAIN ANALYZE
SELECT * FROM User WHERE email = 'example@email.com';

-- Query 2: Finding properties in a specific location within a price range (now using idx_property_location and idx_property_price)
EXPLAIN ANALYZE
SELECT * FROM Property WHERE location = 'New York' AND price_per_night BETWEEN 100 AND 200;

-- Query 3: Finding available properties during a specific date range (now using idx_booking_dates and idx_booking_property)
EXPLAIN ANALYZE
SELECT p.* FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE b.property_id IS NULL
   OR b.start_date > '2025-06-01' OR b.end_date < '2025-05-25';

-- Query 4: Finding reviews for a specific property sorted by rating (now using idx_review_property and idx_review_rating)
EXPLAIN ANALYZE
SELECT * FROM Review WHERE property_id = 101 ORDER BY rating DESC;