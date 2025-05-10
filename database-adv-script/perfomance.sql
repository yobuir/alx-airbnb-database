-- Initial Complex Query
-- Retrieves all bookings along with user details, property details, and payment details
-- This query has not been optimized and may have performance issues

-- Performance Analysis of Initial Query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email,
    u.registration_date,
    u.phone_number,
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    p.bedrooms,
    p.bathrooms,
    p.max_guests,
    h.host_id,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    h.email AS host_email,
    h.phone_number AS host_phone,
    pm.payment_id,
    pm.payment_method,
    pm.payment_status,
    pm.payment_date,
    pm.amount,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date,
    a.amenity_id,
    a.name AS amenity_name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pm ON b.booking_id = pm.booking_id
LEFT JOIN Review r ON b.booking_id = r.booking_id
LEFT JOIN PropertyAmenity pa ON p.property_id = pa.property_id
LEFT JOIN Amenity a ON pa.amenity_id = a.amenity_id
ORDER BY b.start_date DESC;

-- Optimized Query
-- The following query has been refactored to improve performance
-- 1. Removed unnecessary joins (PropertyAmenity and Amenity tables)
-- 2. Limited the columns being selected to only those needed
-- 3. Removed the sort operation (ORDER BY) which was expensive
-- 4. Added a WHERE clause to limit results to recent bookings (assumes indexes exist)

-- Performance Analysis of Optimized Query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name AS user_first_name,
    u.last_name AS user_last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    h.user_id AS host_id,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    pm.payment_id,
    pm.payment_status,
    pm.amount
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pm ON b.booking_id = pm.booking_id
WHERE b.start_date > '2025-01-01' AND b.total_price > 0  -- Filter for recent bookings only and valid prices
LIMIT 100;  -- Limit the number of results returned