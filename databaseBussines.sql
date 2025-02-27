CREATE DATABASE BusinessDB;
USE BusinessDB;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    date_of_birth DATE
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    order_date DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE CreditCards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    card_number VARCHAR(20) NOT NULL,
    expiration_date DATE,
    cvv VARCHAR(5),
    billing_address VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    transaction_date DATETIME,
    ip_address VARCHAR(45),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE SecurityLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    login_attempt DATETIME,
    ip_address VARCHAR(45),
    success BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


INSERT INTO Users (user_name, email, first_name, last_name, phone, date_of_birth) VALUES
('shadow_wolf', 'shadow.wolf@example.com', 'Liam', 'Blackwood', '123-456-7890', '1990-05-15'),
('sunny_rays', 'sunny.rays@example.com', 'Sophie', 'Brightman', '123-456-7891', '1992-07-20'),
('code_master', 'code.master@example.com', 'Ethan', 'Hawthorne', '123-456-7892', '1988-11-02'),
('moon_gazer', 'moon.gazer@example.com', 'Isabella', 'Moonstone', '123-456-7893', '1995-03-12'),
('frost_byte', 'frost.byte@example.com', 'Nathan', 'Winters', '123-456-7894', '1991-08-30'),
('echo_dreams', 'echo.dreams@example.com', 'Ava', 'Whisper', '123-456-7895', '1993-10-05'),
('storm_rider', 'storm.rider@example.com', 'Mason', 'Thunder', '123-456-7896', '1987-06-25'),
('serene_wind', 'serene.wind@example.com', 'Olivia', 'Breeze', '123-456-7897', '1996-09-17'),
('iron_falcon', 'iron.falcon@example.com', 'Jacob', 'Steele', '123-456-7898', '1994-02-14'),
('nova_light', 'nova.light@example.com', 'Emma', 'Starfield', '123-456-7899', '1990-12-22'),
('silver_sage', 'silver.sage@example.com', 'Lucas', 'Silverwood', '123-456-7800', '1989-04-18'),
('ember_glow', 'ember.glow@example.com', 'Sophia', 'Fireheart', '123-456-7801', '1997-05-10'),
('cosmic_owl', 'cosmic.owl@example.com', 'Eli', 'Nebula', '123-456-7802', '1992-01-30'),
('terra_guardian', 'terra.guardian@example.com', 'Noah', 'Earthborn', '123-456-7803', '1986-08-09'),
('blue_horizon', 'blue.horizon@example.com', 'Charlotte', 'Skye', '123-456-7804', '1993-07-22'),
('phantom_knight', 'phantom.knight@example.com', 'Alexander', 'Shade', '123-456-7805', '1985-09-03'),
('arcane_flame', 'arcane.flame@example.com', 'Luna', 'Myst', '123-456-7806', '1998-10-27'),
('crimson_blade', 'crimson.blade@example.com', 'Henry', 'Redgrave', '123-456-7807', '1984-06-11'),
('frozen_mist', 'frozen.mist@example.com', 'Amelia', 'Snow', '123-456-7808', '1991-12-04'),
('silent_fox', 'silent.fox@example.com', 'Julian', 'Nightshade', '123-456-7809', '1983-03-29'),
('wild_ember', 'wild.ember@example.com', 'Scarlett', 'Flare', '123-456-7810', '1995-09-15'),
('thunder_roar', 'thunder.roar@example.com', 'Sebastian', 'Storm', '123-456-7811', '1989-11-23'),
('violet_dusk', 'violet.dusk@example.com', 'Natalie', 'Twilight', '123-456-7812', '1997-01-19'),
('golden_fox', 'golden.fox@example.com', 'Caleb', 'Frost', '123-456-7813', '1994-08-07'),
('shadow_sage', 'shadow.sage@example.com', 'Hannah', 'Moonlight', '123-456-7814', '1992-05-03'),
('twilight_hawk', 'twilight.hawk@example.com', 'Gabriel', 'Darkmoor', '123-456-7815', '1988-10-09'),
('scarlet_viper', 'scarlet.viper@example.com', 'Ella', 'Venom', '123-456-7816', '1996-07-14'),
('zephyr_wave', 'zephyr.wave@example.com', 'Daniel', 'Breeze', '123-456-7817', '1991-06-02'),
('onyx_knight', 'onyx.knight@example.com', 'Victoria', 'Ravenshadow', '123-456-7818', '1990-03-21'),
('ember_storm', 'ember.storm@example.com', 'James', 'Inferno', '123-456-7819', '1987-12-15'),
('silver_raven', 'silver.raven@example.com', 'Madeline', 'Nocturne', '123-456-7820', '1993-11-27'),
('crystal_flame', 'crystal.flame@example.com', 'Benjamin', 'Glow', '123-456-7821', '1985-09-13'),
('mystic_frost', 'mystic.frost@example.com', 'Zoe', 'Winters', '123-456-7822', '1997-02-10'),
('golden_sun', 'golden.sun@example.com', 'Ryan', 'Solaris', '123-456-7823', '1992-08-31'),
('lunar_shadow', 'lunar.shadow@example.com', 'Isla', 'Eclipse', '123-456-7824', '1990-04-20'),
('sapphire_dream', 'sapphire.dream@example.com', 'Evan', 'Azure', '123-456-7825', '1986-07-08'),
('steel_dragon', 'steel.dragon@example.com', 'Owen', 'Ironhart', '123-456-7826', '1989-10-01'),
('firestorm_rider', 'firestorm.rider@example.com', 'Layla', 'Blaze', '123-456-7827', '1994-06-12'),
('celestial_tide', 'celestial.tide@example.com', 'Carter', 'Oceanus', '123-456-7828', '1995-01-07'),
('onyx_serpent', 'onyx.serpent@example.com', 'Elena', 'Darkfang', '123-456-7829', '1991-11-19'),
('midnight_howl', 'midnight.howl@example.com', 'Dylan', 'Lupus', '123-456-7830', '1988-09-04'),
('radiant_blade', 'radiant.blade@example.com', 'Harper', 'Lumine', '123-456-7831', '1987-05-30'),
('stormy_night', 'stormy.night@example.com', 'Grayson', 'Tempest', '123-456-7832', '1984-08-28'),
('ember_wanderer', 'ember.wanderer@example.com', 'Aurora', 'Nomad', '123-456-7833', '1996-03-17'),
('titan_wraith', 'titan.wraith@example.com', 'Lincoln', 'Specter', '123-456-7834', '1993-12-09'),
('arcane_void', 'arcane.void@example.com', 'Stella', 'Oblivion', '123-456-7835', '1990-06-01'),
('black_phantom', 'black.phantom@example.com', 'Xavier', 'Nightfall', '123-456-7836', '1985-02-27'),
('darkvid', 'darkvid.666@example.com', 'Davdi', 'Pz', '123-456-7836', '2000-12-27'),
('elias', 'hola@meli.com', 'elias', 'meli', '122-222-222', '2001-01-01'),
('Enrique', 'henry.666@example.com', 'Henry', 'Xtz125', '123-456-7836', '2000-12-27');

INSERT INTO Orders (user_id, total_amount, payment_method, order_date, status) VALUES
(5, 125.99, 'Credit Card', '2024-02-01 14:23:45', 'Completed'),
(12, 89.50, 'PayPal', '2024-02-02 09:15:30', 'Pending'),
(23, 240.75, 'Debit Card', '2024-02-03 17:42:10', 'Completed'),
(7, 56.80, 'Cash', '2024-02-04 12:50:25', 'Cancelled'),
(45, 199.99, 'Credit Card', '2024-02-05 15:30:00', 'Completed'),
(8, 75.40, 'Bank Transfer', '2024-02-06 10:45:10', 'Processing'),
(33, 320.60, 'Credit Card', '2024-02-07 18:55:05', 'Completed'),
(22, 150.00, 'PayPal', '2024-02-08 14:20:30', 'Completed'),
(39, 95.20, 'Debit Card', '2024-02-09 09:35:40', 'Pending'),
(17, 134.99, 'Credit Card', '2024-02-10 16:40:50', 'Completed'),
(10, 49.90, 'Cash', '2024-02-11 11:25:15', 'Cancelled'),
(25, 220.30, 'Credit Card', '2024-02-12 19:10:00', 'Completed'),
(2, 87.45, 'Bank Transfer', '2024-02-13 08:05:20', 'Processing'),
(19, 330.80, 'PayPal', '2024-02-14 21:15:55', 'Completed'),
(30, 175.60, 'Debit Card', '2024-02-15 14:05:40', 'Completed'),
(11, 58.20, 'Credit Card', '2024-02-16 07:45:30', 'Cancelled'),
(47, 250.00, 'PayPal', '2024-02-17 15:20:45', 'Completed'),
(4, 120.90, 'Bank Transfer', '2024-02-18 10:10:25', 'Processing'),
(41, 95.00, 'Cash', '2024-02-19 13:55:10', 'Completed'),
(16, 210.75, 'Credit Card', '2024-02-20 18:30:30', 'Pending'),
(9, 76.30, 'Debit Card', '2024-02-21 09:40:50', 'Completed'),
(35, 310.00, 'PayPal', '2024-02-22 16:50:15', 'Completed'),
(28, 130.20, 'Credit Card', '2024-02-23 07:20:35', 'Processing'),
(49, 190.99, 'Cash', '2024-02-24 12:15:45', 'Cancelled'),
(14, 220.75, 'Bank Transfer', '2024-02-25 19:40:55', 'Completed'),
(3, 80.50, 'Credit Card', '2024-02-26 14:10:20', 'Pending'),
(20, 99.90, 'PayPal', '2024-02-27 08:30:45', 'Completed'),
(43, 145.60, 'Debit Card', '2024-02-28 11:55:30', 'Processing'),
(6, 275.40, 'Credit Card', '2024-02-29 17:10:10', 'Completed'),
(32, 180.50, 'Cash', '2024-03-01 09:20:25', 'Completed'),
(21, 125.30, 'Bank Transfer', '2024-03-02 14:45:50', 'Pending'),
(38, 230.90, 'Credit Card', '2024-03-03 18:35:40', 'Completed'),
(27, 100.00, 'PayPal', '2024-03-04 07:55:10', 'Cancelled'),
(50, 320.75, 'Debit Card', '2024-03-05 13:10:00', 'Completed'),
(15, 99.99, 'Credit Card', '2024-03-06 10:05:20', 'Processing'),
(42, 210.80, 'Bank Transfer', '2024-03-07 15:50:30', 'Completed'),
(48, 90.60, 'Cash', '2024-03-08 09:35:45', 'Completed'),
(13, 195.40, 'Credit Card', '2024-03-09 17:20:30', 'Pending'),
(26, 110.75, 'PayPal', '2024-03-10 12:30:50', 'Completed'),
(37, 145.99, 'Debit Card', '2024-03-11 14:40:25', 'Processing'),
(31, 260.20, 'Credit Card', '2024-03-12 08:50:15', 'Completed'),
(1, 75.30, 'Cash', '2024-03-13 10:10:40', 'Completed'),
(44, 199.50, 'Bank Transfer', '2024-03-14 16:30:25', 'Pending'),
(24, 275.80, 'Credit Card', '2024-03-15 07:20:50', 'Completed'),
(29, 110.00, 'PayPal', '2024-03-16 12:40:10', 'Cancelled'),
(36, 340.70, 'Debit Card', '2024-03-17 18:15:30', 'Completed'),
(18, 125.25, 'Bank Transfer', '2024-03-18 14:30:20', 'Processing'),
(46, 190.40, 'Credit Card', '2024-03-19 08:25:50', 'Completed'),
(40, 99.70, 'Cash', '2024-03-20 11:50:30', 'Completed'),
(34, 215.80, 'PayPal', '2024-03-21 17:30:45', 'Pending'),
(15, 120.50, 'Credit Card', '2024-03-22 09:40:10', 'Completed'),
(23, 175.90, 'Bank Transfer', '2024-03-23 14:15:30', 'Processing'),
(11, 220.00, 'Debit Card', '2024-03-24 19:05:40', 'Completed'),
(3, 55.30, 'Cash', '2024-03-25 07:55:25', 'Cancelled'),
(5, 300.00, 'Credit Card', '2024-03-26 12:50:15', 'Completed'),
(50, 135.99, 'PayPal', '2024-03-27 16:40:30', 'Pending'),
(28, 185.20, 'Bank Transfer', '2024-03-28 10:05:45', 'Completed');

INSERT INTO CreditCards (user_id, card_number, expiration_date, cvv, billing_address) VALUES
(5, '4532-6789-1234-5678', '2027-05-01', '123', '123 Elm Street, NY'),
(12, '5276-9087-6543-2109', '2026-08-15', '456', '456 Maple Ave, CA'),
(23, '6011-2345-6789-4321', '2028-02-20', '789', '789 Oak Road, TX'),
(7, '3745-987654-32109', '2029-09-30', '321', '101 Pine Blvd, FL'),
(45, '4539-8765-4321-6789', '2026-12-25', '654', '202 Birch St, WA'),
(8, '5278-3456-7890-1234', '2027-07-10', '987', '303 Cedar Lane, IL'),
(33, '6011-1122-3344-5566', '2025-11-05', '159', '404 Walnut Dr, CO'),
(22, '3742-678901-23456', '2026-06-18', '753', '505 Aspen Ct, NV'),
(39, '4532-9876-5432-1098', '2028-10-08', '852', '606 Redwood Pl, AZ'),
(17, '5274-2345-6789-9876', '2029-03-12', '951', '707 Palm Ave, OR'),
(10, '6011-3456-7890-5678', '2025-04-27', '741', '808 Sequoia Rd, GA'),
(25, '3749-123456-78901', '2027-08-14', '369', '909 Spruce St, MI'),
(2, '4536-7890-1234-5678', '2026-09-23', '258', '110 Chestnut Dr, OH'),
(19, '5271-8765-4321-2345', '2028-01-30', '147', '121 Alder Cir, MN'),
(30, '6011-6789-4321-1234', '2025-12-12', '369', '132 Sycamore Blvd, TN'),
(11, '3743-456789-01234', '2029-05-07', '852', '143 Mahogany Ln, VA'),
(47, '4537-2345-6789-9012', '2027-06-20', '159', '154 Beech St, NC'),
(4, '5272-5678-1234-8765', '2026-11-11', '753', '165 Poplar Ct, MA'),
(41, '6011-3456-7890-0987', '2028-07-15', '852', '176 Elmwood Rd, MO'),
(16, '3748-678901-23457', '2025-03-19', '951', '187 Fir Ave, UT'),
(9, '4535-9876-5432-2109', '2027-02-08', '147', '198 Larch Dr, SC'),
(35, '5273-4567-8901-2345', '2029-10-22', '369', '209 Cedarwood Blvd, IN'),
(28, '6011-7890-1234-5678', '2026-12-29', '258', '220 Hickory Ln, KY'),
(49, '3741-234567-89012', '2028-06-03', '741', '231 Magnolia Ct, WI'),
(14, '4538-8765-4321-6789', '2025-09-15', '159', '242 Mulberry St, PA'),
(3, '5279-3456-7890-0987', '2027-04-09', '852', '253 Palm Cir, NJ'),
(20, '6011-6789-4321-2345', '2029-01-17', '951', '264 Birchwood Ave, LA'),
(43, '3746-456789-01234', '2026-08-30', '753', '275 Dogwood Pl, NV'),
(6, '4531-9876-5432-6789', '2025-11-20', '369', '286 Evergreen Blvd, AR'),
(32, '5275-2345-6789-0123', '2028-05-05', '147', '297 Willow Ln, OK'),
(21, '6011-7890-1234-2109', '2027-10-27', '258', '308 Maplewood Dr, CT'),
(38, '3747-678901-23456', '2026-07-14', '852', '319 Hawthorn St, DE'),
(27, '4534-4567-8901-5678', '2029-12-06', '951', '330 Cedar Hollow Rd, MS'),
(50, '5270-1234-5678-4321', '2025-03-11', '753', '341 Banyan Cir, NH'),
(15, '6011-8765-4321-6789', '2028-09-18', '369', '352 Persimmon Ct, HI');

INSERT INTO Addresses (user_id, street, city, state, postal_code, country) VALUES
(5, '123 Elm Street', 'New York', 'NY', '10001', 'USA'),
(12, '456 Maple Avenue', 'Los Angeles', 'CA', '90001', 'USA'),
(23, '789 Oak Road', 'Toronto', 'Ontario', 'M4B 1B3', 'Canada'),
(7, '101 Pine Boulevard', 'London', 'Greater London', 'W1A 1AA', 'UK'),
(45, '202 Birch Street', 'Sydney', 'New South Wales', '2000', 'Australia'),
(8, '303 Cedar Lane', 'Berlin', 'Berlin', '10115', 'Germany'),
(33, '404 Walnut Drive', 'Paris', 'Île-de-France', '75001', 'France'),
(22, '505 Aspen Court', 'Madrid', 'Madrid', '28001', 'Spain'),
(39, '606 Redwood Place', 'Rome', 'Lazio', '00100', 'Italy'),
(17, '707 Palm Avenue', 'Amsterdam', 'North Holland', '1011AB', 'Netherlands'),
(10, '808 Sequoia Road', 'Oslo', 'Oslo', '0150', 'Norway'),
(25, '909 Spruce Street', 'Stockholm', 'Stockholm County', '11120', 'Sweden'),
(2, '110 Chestnut Drive', 'Zurich', 'Zurich', '8001', 'Switzerland'),
(19, '121 Alder Circle', 'Vienna', 'Vienna', '1010', 'Austria'),
(30, '132 Sycamore Boulevard', 'Brussels', 'Brussels-Capital', '1000', 'Belgium'),
(11, '143 Mahogany Lane', 'Buenos Aires', 'Buenos Aires', 'C1001', 'Argentina'),
(47, '154 Beech Street', 'São Paulo', 'São Paulo', '01000-000', 'Brazil'),
(4, '165 Poplar Court', 'Cape Town', 'Western Cape', '8001', 'South Africa'),
(41, '176 Elmwood Road', 'Tokyo', 'Tokyo', '100-0001', 'Japan'),
(16, '187 Fir Avenue', 'Seoul', 'Seoul', '04500', 'South Korea'),
(9, '198 Larch Drive', 'Beijing', 'Beijing', '100000', 'China'),
(35, '209 Cedarwood Boulevard', 'Bangkok', 'Bangkok', '10100', 'Thailand'),
(28, '220 Hickory Lane', 'Delhi', 'Delhi', '110001', 'India'),
(49, '231 Magnolia Court', 'Jakarta', 'Jakarta', '10110', 'Indonesia'),
(14, '242 Mulberry Street', 'Dubai', 'Dubai', '00000', 'UAE'),
(3, '253 Palm Circle', 'Istanbul', 'Istanbul', '34100', 'Turkey'),
(20, '264 Birchwood Avenue', 'Mexico City', 'Mexico City', '01000', 'Mexico'),
(43, '275 Dogwood Place', 'Moscow', 'Moscow', '101000', 'Russia'),
(6, '286 Evergreen Boulevard', 'Hanoi', 'Hanoi', '100000', 'Vietnam'),
(32, '297 Willow Lane', 'Cairo', 'Cairo', '11511', 'Egypt'),
(21, '308 Maplewood Drive', 'Athens', 'Attica', '10552', 'Greece'),
(38, '319 Hawthorn Street', 'Lisbon', 'Lisbon', '1100-001', 'Portugal'),
(27, '330 Cedar Hollow Road', 'Kuala Lumpur', 'Kuala Lumpur', '50000', 'Malaysia'),
(50, '341 Banyan Circle', 'Singapore', 'Singapore', '018936', 'Singapore'),
(15, '352 Persimmon Court', 'Manila', 'Metro Manila', '1000', 'Philippines');

INSERT INTO Transactions (order_id, amount, payment_method, transaction_date, ip_address) VALUES
(5, 125.99, 'Credit Card', '2024-02-01 14:25:32', '192.168.1.1'),
(12, 89.50, 'PayPal', '2024-02-02 09:20:15', '203.0.113.5'),
(23, 240.75, 'Debit Card', '2024-02-03 17:50:45', '198.51.100.12'),
(7, 56.80, 'Cash', '2024-02-04 12:40:22', '172.16.0.45'),
(18, 199.99, 'Credit Card', '2024-02-05 15:10:33', '192.0.2.18'),
(8, 75.40, 'Bank Transfer', '2024-02-06 10:35:55', '203.0.113.29'),
(14, 320.60, 'Credit Card', '2024-02-07 18:20:40', '198.51.100.47'),
(22, 150.00, 'PayPal', '2024-02-08 14:15:10', '192.168.0.68'),
(19, 95.20, 'Debit Card', '2024-02-09 09:30:50', '172.16.1.92'),
(17, 134.99, 'Credit Card', '2024-02-10 16:15:25', '203.0.113.76'),
(10, 49.90, 'Cash', '2024-02-11 11:50:40', '198.51.100.83'),
(25, 220.30, 'Credit Card', '2024-02-12 19:05:10', '192.168.2.21'),
(2, 87.45, 'Bank Transfer', '2024-02-13 08:45:30', '203.0.113.55'),
(16, 330.80, 'PayPal', '2024-02-14 21:30:20', '198.51.100.77'),
(30, 175.60, 'Debit Card', '2024-02-15 14:00:45', '172.16.3.99'),
(11, 58.20, 'Credit Card', '2024-02-16 07:35:55', '192.168.1.205'),
(26, 250.00, 'PayPal', '2024-02-17 15:50:10', '203.0.113.102'),
(4, 120.90, 'Bank Transfer', '2024-02-18 10:05:25', '198.51.100.108'),
(35, 95.00, 'Cash', '2024-02-19 13:40:55', '192.168.3.77'),
(21, 210.75, 'Credit Card', '2024-02-20 18:20:30', '172.16.4.201'),
(9, 76.30, 'Debit Card', '2024-02-21 09:55:20', '203.0.113.87'),
(32, 310.00, 'PayPal', '2024-02-22 16:45:15', '198.51.100.63'),
(28, 130.20, 'Credit Card', '2024-02-23 07:10:05', '192.168.2.44'),
(36, 190.99, 'Cash', '2024-02-24 12:30:50', '172.16.5.77'),
(14, 220.75, 'Bank Transfer', '2024-02-25 19:55:40', '203.0.113.31'),
(3, 80.50, 'Credit Card', '2024-02-26 14:40:10', '198.51.100.120'),
(20, 99.90, 'PayPal', '2024-02-27 08:25:55', '192.168.4.88'),
(39, 145.60, 'Debit Card', '2024-02-28 11:35:30', '172.16.6.59'),
(6, 275.40, 'Credit Card', '2024-02-29 17:15:45', '203.0.113.67'),
(31, 180.50, 'Cash', '2024-03-01 09:50:20', '198.51.100.203');
