-- =====================================================
-- DriveGo - Complete Sample Data Initialization
-- =====================================================
-- This file automatically creates sample data if tables are empty
-- Uses INSERT IGNORE to prevent duplicate entries on restart

-- =====================================================
-- 1. ROLES - User role definitions
-- =====================================================
INSERT IGNORE INTO roles (id, name) VALUES (1, 'ROLE_USER');
INSERT IGNORE INTO roles (id, name) VALUES (2, 'ROLE_ADMIN');

-- =====================================================
-- 2. USERS - Sample user accounts
-- =====================================================
-- Note: Passwords are BCrypt hashed. Plain text passwords:
-- admin@drivego.com -> admin123
-- john.doe@email.com -> user123
-- jane.smith@email.com -> user123

INSERT IGNORE INTO users (user_id, first_name, last_name, email, password, contact_num, is_guest, created_at) 
VALUES 
(1, 'Admin', 'User', 'admin@drivego.com', '$2a$10$xqw6qKJqJZk9xnZ6qKJqJO7.ZqKJqJZk9xnZ6qKJqJO7.ZqKJqJZk', '0771234567', 0, NOW()),
(2, 'John', 'Doe', 'john.doe@email.com', '$2a$10$xqw6qKJqJZk9xnZ6qKJqJO7.ZqKJqJZk9xnZ6qKJqJO7.ZqKJqJZk', '0777654321', 0, NOW()),
(3, 'Jane', 'Smith', 'jane.smith@email.com', '$2a$10$xqw6qKJqJZk9xnZ6qKJqJO7.ZqKJqJZk9xnZ6qKJqJO7.ZqKJqJZk', '0772233445', 0, NOW()),
(4, 'Guest', 'User', 'guest@temp.com', '$2a$10$xqw6qKJqJZk9xnZ6qKJqJO7.ZqKJqJZk9xnZ6qKJqJO7.ZqKJqJZk', '0779988776', 1, NOW());

-- =====================================================
-- 3. USER-ROLE MAPPING
-- =====================================================
INSERT IGNORE INTO users_roles (user_id, role_id) VALUES (1, 2); -- Admin has ROLE_ADMIN
INSERT IGNORE INTO users_roles (user_id, role_id) VALUES (1, 1); -- Admin also has ROLE_USER
INSERT IGNORE INTO users_roles (user_id, role_id) VALUES (2, 1); -- John is ROLE_USER
INSERT IGNORE INTO users_roles (user_id, role_id) VALUES (3, 1); -- Jane is ROLE_USER
INSERT IGNORE INTO users_roles (user_id, role_id) VALUES (4, 1); -- Guest is ROLE_USER

-- =====================================================
-- 4. PAYMENT METHODS - Available payment options
-- =====================================================
INSERT IGNORE INTO payment_methods (method_id, method_type, provider) VALUES (1, 'Paypal', 'PayPal Inc');
INSERT IGNORE INTO payment_methods (method_id, method_type, provider) VALUES (2, 'CreditCard', 'Visa');
INSERT IGNORE INTO payment_methods (method_id, method_type, provider) VALUES (3, 'DebitCard', 'HSBC');
INSERT IGNORE INTO payment_methods (method_id, method_type, provider) VALUES (4, 'CreditCard', 'MasterCard');
INSERT IGNORE INTO payment_methods (method_id, method_type, provider) VALUES (5, 'Cash', 'Cash Payment');
INSERT IGNORE INTO payment_methods (method_id, method_type, provider) VALUES (6, 'BankTransfer', 'Bank Transfer');

-- =====================================================
-- 5. VEHICLES - Sample vehicle inventory
-- =====================================================
-- Economy Cars
INSERT IGNORE INTO vehicles (reg_no, model, mileage, rental_price, fuel_type, maintenance_history, availability, seats, daily_rate) 
VALUES 
('ABC-1234', 'Toyota Corolla 2023', 15000, 4500.00, 'Petrol', 'Last serviced: 2025-09-15. Oil changed, brakes checked.', 1, 5, 4500.00),
('XYZ-5678', 'Honda Civic 2022', 22000, 4800.00, 'Petrol', 'Last serviced: 2025-08-20. New tires installed.', 1, 5, 4800.00),
('DEF-9012', 'Nissan Sentra 2023', 18000, 4200.00, 'Petrol', 'Last serviced: 2025-10-01. AC serviced.', 1, 5, 4200.00);

-- Mid-Range Sedans
INSERT IGNORE INTO vehicles (reg_no, model, mileage, rental_price, fuel_type, maintenance_history, availability, seats, daily_rate) 
VALUES 
('GHI-3456', 'Toyota Camry 2024', 8000, 6500.00, 'Hybrid', 'Last serviced: 2025-09-25. Battery check completed.', 1, 5, 6500.00),
('JKL-7890', 'Honda Accord 2023', 12000, 6200.00, 'Petrol', 'Last serviced: 2025-09-10. Transmission fluid changed.', 1, 5, 6200.00),
('MNO-2345', 'Mazda 6 2023', 16000, 5800.00, 'Petrol', 'Last serviced: 2025-08-15. Suspension checked.', 1, 5, 5800.00);

-- SUVs
INSERT IGNORE INTO vehicles (reg_no, model, mileage, rental_price, fuel_type, maintenance_history, availability, seats, daily_rate) 
VALUES 
('PQR-6789', 'Toyota RAV4 2024', 5000, 8500.00, 'Hybrid', 'Last serviced: 2025-10-05. All systems checked.', 1, 7, 8500.00),
('STU-0123', 'Honda CR-V 2023', 10000, 7800.00, 'Petrol', 'Last serviced: 2025-09-20. Engine tuned.', 1, 7, 7800.00),
('VWX-4567', 'Nissan X-Trail 2023', 13000, 7500.00, 'Diesel', 'Last serviced: 2025-09-05. Fuel injectors cleaned.', 1, 7, 7500.00);

-- Luxury Cars
INSERT IGNORE INTO vehicles (reg_no, model, mileage, rental_price, fuel_type, maintenance_history, availability, seats, daily_rate) 
VALUES 
('YZA-8901', 'BMW 5 Series 2024', 3000, 12000.00, 'Petrol', 'Last serviced: 2025-10-10. Premium maintenance package.', 1, 5, 12000.00),
('BCD-2345', 'Mercedes-Benz E-Class 2024', 4000, 13500.00, 'Diesel', 'Last serviced: 2025-10-08. Full inspection completed.', 1, 5, 13500.00),
('EFG-6789', 'Audi A6 2023', 7000, 11500.00, 'Petrol', 'Last serviced: 2025-09-28. Software updated.', 1, 5, 11500.00);

-- Vans
INSERT IGNORE INTO vehicles (reg_no, model, mileage, rental_price, fuel_type, maintenance_history, availability, seats, daily_rate) 
VALUES 
('HIJ-0123', 'Toyota Hiace 2023', 20000, 9500.00, 'Diesel', 'Last serviced: 2025-09-15. Brake pads replaced.', 1, 12, 9500.00),
('KLM-4567', 'Mercedes-Benz Sprinter 2024', 8000, 11000.00, 'Diesel', 'Last serviced: 2025-10-01. Commercial grade service.', 1, 15, 11000.00);

-- Currently Rented (Not Available)
INSERT IGNORE INTO vehicles (reg_no, model, mileage, rental_price, fuel_type, maintenance_history, availability, seats, daily_rate) 
VALUES 
('NOP-8901', 'Toyota Prius 2023', 14000, 5500.00, 'Hybrid', 'Last serviced: 2025-09-12. Currently on rental.', 0, 5, 5500.00),
('QRS-2345', 'Ford Mustang 2024', 2000, 15000.00, 'Petrol', 'Last serviced: 2025-10-05. Sports package maintained.', 0, 4, 15000.00);

-- =====================================================
-- 6. CAR BOOKINGS - Sample booking records
-- =====================================================
INSERT IGNORE INTO car_bookings (id, booked_email, contact_person_name, contact_number, pickup_location, pickup_date, return_date, car_id, vehicle_reg_no, status, booking_date, additional_notes, delete_status, created_at, updated_at) 
VALUES 
-- Confirmed Bookings
(1, 'john.doe@email.com', 'John Doe', '0777654321', 'Colombo Airport', '2025-10-25', '2025-10-30', 1, 'ABC-1234', 'Confirmed', '2025-10-15 10:30:00', 'Need GPS and child seat', 0, NOW(), NOW()),
(2, 'jane.smith@email.com', 'Jane Smith', '0772233445', 'Kandy City', '2025-10-22', '2025-10-24', 4, 'GHI-3456', 'Confirmed', '2025-10-16 14:20:00', 'Full insurance please', 0, NOW(), NOW()),

-- Pending Bookings
(3, 'customer1@email.com', 'Michael Brown', '0771112233', 'Galle Beach', '2025-11-01', '2025-11-05', 7, 'PQR-6789', 'Pending', '2025-10-18 09:15:00', 'Weekend trip', 0, NOW(), NOW()),
(4, 'customer2@email.com', 'Sarah Williams', '0774445566', 'Negombo Hotel', '2025-11-10', '2025-11-12', 10, 'YZA-8901', 'Pending', '2025-10-19 16:45:00', 'Business trip', 0, NOW(), NOW()),

-- Completed Bookings (Past dates)
(5, 'john.doe@email.com', 'John Doe', '0777654321', 'Colombo Fort', '2025-09-15', '2025-09-20', 2, 'XYZ-5678', 'Completed', '2025-09-10 11:00:00', 'Vacation trip', 0, NOW(), NOW()),
(6, 'jane.smith@email.com', 'Jane Smith', '0772233445', 'Ella Town', '2025-09-25', '2025-09-28', 3, 'DEF-9012', 'Completed', '2025-09-20 13:30:00', 'Hill country tour', 0, NOW(), NOW()),

-- Cancelled Booking
(7, 'customer3@email.com', 'David Lee', '0777778888', 'Jaffna City', '2025-11-15', '2025-11-18', 5, 'JKL-7890', 'Cancelled', '2025-10-17 10:00:00', 'Plan changed', 0, NOW(), NOW());

-- =====================================================
-- 7. PAYMENTS - Sample payment records
-- =====================================================
INSERT IGNORE INTO payments (payment_id, booking_id, payment_method, amount, card_holder, card_number, card_expiry, payment_date, payment_status) 
VALUES 
-- Completed Payments
(1, 5, 'CREDIT_CARD', 24000.00, 'John Doe', '4532123456789012', '12/26', '2025-09-20 15:30:00', 'COMPLETED'),
(2, 6, 'DEBIT_CARD', 12600.00, 'Jane Smith', '4532987654321098', '08/27', '2025-09-28 10:15:00', 'COMPLETED'),

-- Pending Payments
(3, 1, 'CREDIT_CARD', 22500.00, 'John Doe', '4532123456789012', '12/26', '2025-10-15 10:45:00', 'PENDING'),
(4, 2, 'CASH', 13000.00, NULL, NULL, NULL, '2025-10-16 14:30:00', 'PENDING'),

-- Bank Transfer (with receipt)
(5, 3, 'BANK_TRANSFER', 34000.00, NULL, NULL, NULL, '2025-10-18 09:30:00', 'PENDING'),

-- Failed Payment
(6, 4, 'CREDIT_CARD', 48000.00, 'Sarah Williams', '4532111122223333', '03/26', '2025-10-19 17:00:00', 'FAILED');

-- =====================================================
-- 8. BANK TRANSFER RECEIPTS - Sample receipt uploads
-- =====================================================
INSERT IGNORE INTO bank_transfer_receipts (receipt_id, payment_id, filename, file_path, file_size, upload_date) 
VALUES 
(1, 5, 'receipt_20251018_093015.jpg', '/uploads/receipts/receipt_20251018_093015.jpg', 245678, '2025-10-18 09:30:15');

-- =====================================================
-- 9. REPORTS - Sample generated reports (optional)
-- =====================================================
-- Revenue Report
INSERT IGNORE INTO reports (report_id, name, type, from_date, to_date, payload, created_at, updated_at) 
VALUES 
(1, 'September 2025 Revenue Report', 'revenue', '2025-09-01', '2025-09-30', '{"totalRevenue": 36600.00, "avgMonthly": 36600.00, "completedPayments": 2}', '2025-10-01 09:00:00', '2025-10-01 09:00:00'),
(2, 'Q3 2025 Fleet Usage Report', 'fleet', '2025-07-01', '2025-09-30', '{"totalBookings": 15, "vehicleTypes": 8, "mostPopular": "Toyota Camry"}', '2025-10-01 10:00:00', '2025-10-01 10:00:00'),
(3, 'Top Customers - September 2025', 'customers', '2025-09-01', '2025-09-30', '{"totalCustomers": 12, "topCustomer": "John Doe", "bookings": 3}', '2025-10-01 11:00:00', '2025-10-01 11:00:00');

-- =====================================================
-- END OF SAMPLE DATA
-- =====================================================
-- All tables are now populated with sample data!
-- 
-- Summary:
-- - 2 Roles (User, Admin)
-- - 4 Users (1 Admin, 2 Regular Users, 1 Guest)
-- - 6 Payment Methods
-- - 15 Vehicles (Economy, Sedan, SUV, Luxury, Vans)
-- - 7 Bookings (Confirmed, Pending, Completed, Cancelled)
-- - 6 Payments (Completed, Pending, Failed)
-- - 1 Bank Transfer Receipt
-- - 3 Sample Reports
--
-- Login Credentials (for testing):
-- Email: admin@drivego.com | Password: admin123 (needs proper BCrypt hash)
-- Email: john.doe@email.com | Password: user123 (needs proper BCrypt hash)
-- =====================================================
