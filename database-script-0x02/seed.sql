-- Insert Users
INSERT INTO User (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Alice', 'Johnson', 'alice@example.com', 'hashed_pw_1', '250781234567', 'host'),
('Bob', 'Smith', 'bob@example.com', 'hashed_pw_2', '250782345678', 'guest'),
('Cathy', 'Brown', 'cathy@example.com', 'hashed_pw_3', '250783456789', 'guest'),
('David', 'Lee', 'david@example.com', 'hashed_pw_4', '250784567890', 'host');

-- Insert Properties
INSERT INTO Property (host_id, name, description, location, price_per_night)
VALUES
(1, 'Cozy Apartment in Kigali', 'A quiet 2-bedroom near the city center.', 'Kigali, Rwanda', 45.00),
(4, 'Beachside Villa', 'Luxury beachfront property with pool.', 'Gisenyi, Rwanda', 150.00);

-- Insert Bookings
INSERT INTO Booking (property_id, user_id, start_date, end_date, total_price)
VALUES
(1, 2, '2025-06-01', '2025-06-05', 180.00),
(2, 3, '2025-07-10', '2025-07-15', 750.00);

-- Insert Payments
INSERT INTO Payment (booking_id, amount, payment_method)
VALUES
(1, 180.00, 'credit_card'),
(2, 750.00, 'paypal');

-- Insert Reviews
INSERT INTO Review (property_id, user_id, rating, comment)
VALUES
(1, 2, 5, 'Amazing apartment! Clean and well-located.'),
(2, 3, 4, 'Great place, a bit noisy at night.');

-- Insert Messages
INSERT INTO Message (sender_id, recipient_id, message_body)
VALUES
(2, 1, 'Hi, I’m interested in booking your apartment in Kigali.'),
(1, 2, 'Sure! It’s available from June 1st to 5th.'),
(3, 4, 'Is the beach villa available in July?'),
(4, 3, 'Yes, it is available until July 15.');
