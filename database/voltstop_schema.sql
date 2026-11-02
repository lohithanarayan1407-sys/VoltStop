-- =========================================================
-- VoltStop — EV Charging Slot Booking & Management System
-- Database schema (MySQL 8+)
-- =========================================================

DROP DATABASE IF EXISTS voltstop;
CREATE DATABASE voltstop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE voltstop;

-- ---------------------------------------------------------
-- 1. USERS  (EV User, Station Admin/Operator, System Admin)
-- ---------------------------------------------------------
CREATE TABLE users (
    user_id        INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100)  NOT NULL,
    email           VARCHAR(150)  NOT NULL UNIQUE,
    password_hash   VARCHAR(255)  NOT NULL,
    phone           VARCHAR(20),
    role            ENUM('EV_USER', 'STATION_ADMIN', 'SYSTEM_ADMIN') NOT NULL DEFAULT 'EV_USER',
    status          ENUM('ACTIVE', 'SUSPENDED', 'PENDING_APPROVAL') NOT NULL DEFAULT 'ACTIVE',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- 2. VEHICLES  (belongs to an EV_USER)
-- ---------------------------------------------------------
CREATE TABLE vehicles (
    vehicle_id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id             INT NOT NULL,
    vehicle_name        VARCHAR(100),               -- e.g. "Tata Nexon EV"
    battery_capacity_kwh DECIMAL(6,2) NOT NULL,      -- total battery size, e.g. 40.50
    connector_type      ENUM('TYPE1', 'TYPE2', 'CCS', 'CHADEMO', 'GBT') NOT NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 3. STATIONS  (owned/managed by a STATION_ADMIN)
-- ---------------------------------------------------------
CREATE TABLE stations (
    station_id     INT AUTO_INCREMENT PRIMARY KEY,
    owner_id       INT NOT NULL,
    name           VARCHAR(150) NOT NULL,
    address        VARCHAR(255) NOT NULL,
    city           VARCHAR(100),
    latitude       DECIMAL(10,7),
    longitude      DECIMAL(10,7),
    status         ENUM('PENDING_APPROVAL', 'ACTIVE', 'INACTIVE') NOT NULL DEFAULT 'PENDING_APPROVAL',
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 4. CHARGERS  (each station has multiple chargers)
-- ---------------------------------------------------------
CREATE TABLE chargers (
    charger_id      INT AUTO_INCREMENT PRIMARY KEY,
    station_id      INT NOT NULL,
    charger_code    VARCHAR(50) NOT NULL,             -- e.g. "A1", "Fast-2"
    connector_type  ENUM('TYPE1', 'TYPE2', 'CCS', 'CHADEMO', 'GBT') NOT NULL,
    power_kw        DECIMAL(5,2) NOT NULL,             -- charger power rating, e.g. 50.00
    price_per_kwh   DECIMAL(6,2) NOT NULL DEFAULT 0.00,
    status          ENUM('AVAILABLE', 'MAINTENANCE', 'INACTIVE') NOT NULL DEFAULT 'AVAILABLE',
    FOREIGN KEY (station_id) REFERENCES stations(station_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 5. SLOTS  (bookable time windows per charger)
-- ---------------------------------------------------------
CREATE TABLE slots (
    slot_id       INT AUTO_INCREMENT PRIMARY KEY,
    charger_id    INT NOT NULL,
    slot_date     DATE NOT NULL,
    start_time    TIME NOT NULL,
    end_time      TIME NOT NULL,
    is_booked     BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (charger_id) REFERENCES chargers(charger_id) ON DELETE CASCADE,
    UNIQUE KEY uq_charger_slot (charger_id, slot_date, start_time)
);

-- ---------------------------------------------------------
-- 6. BOOKINGS  (an EV_USER reserving a slot)
-- ---------------------------------------------------------
CREATE TABLE bookings (
    booking_id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id             INT NOT NULL,
    vehicle_id          INT NOT NULL,
    slot_id             INT NOT NULL,
    battery_start_pct   DECIMAL(5,2) NOT NULL,          -- battery % entered at booking time
    battery_target_pct  DECIMAL(5,2) NOT NULL DEFAULT 100.00,
    estimated_time_mins INT,                             -- calculated: charge time estimate
    estimated_cost      DECIMAL(8,2),
    status              ENUM('BOOKED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'BOOKED',
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at         TIMESTAMP NULL,
    FOREIGN KEY (user_id)    REFERENCES users(user_id)    ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
    FOREIGN KEY (slot_id)    REFERENCES slots(slot_id)    ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 7. PAYMENTS  (one payment per booking)
-- ---------------------------------------------------------
CREATE TABLE payments (
    payment_id        INT AUTO_INCREMENT PRIMARY KEY,
    booking_id        INT NOT NULL,
    amount            DECIMAL(8,2) NOT NULL,
    payment_method    ENUM('CARD', 'UPI', 'WALLET', 'NETBANKING') NOT NULL DEFAULT 'CARD',
    status            ENUM('PENDING', 'SUCCESS', 'FAILED', 'REFUNDED') NOT NULL DEFAULT 'PENDING',
    transaction_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 8. NOTIFICATIONS  (booking confirmation, reminders, charge-complete alerts)
-- ---------------------------------------------------------
CREATE TABLE notifications (
    notification_id  INT AUTO_INCREMENT PRIMARY KEY,
    user_id          INT NOT NULL,
    booking_id       INT,
    message          VARCHAR(255) NOT NULL,
    type             ENUM('BOOKING_CONFIRMED', 'REMINDER', 'CHARGE_COMPLETE', 'CANCELLED', 'GENERAL') NOT NULL,
    is_read          BOOLEAN NOT NULL DEFAULT FALSE,
    sent_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(user_id)    ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL
);

-- ---------------------------------------------------------
-- 9. REVIEWS  (EV_USER rates a station after use)
-- ---------------------------------------------------------
CREATE TABLE reviews (
    review_id    INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    station_id   INT NOT NULL,
    booking_id   INT,
    rating       TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment      VARCHAR(500),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)    REFERENCES users(user_id)    ON DELETE CASCADE,
    FOREIGN KEY (station_id) REFERENCES stations(station_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL
);

-- =========================================================
-- Sample seed data (optional — useful for early testing)
-- =========================================================
INSERT INTO users (name, email, password_hash, phone, role) VALUES
('Lohitha Prakashini', 'lohitha@example.com', 'temp_hash_1', '9999999999', 'EV_USER'),
('Station Owner One',  'owner1@example.com',  'temp_hash_2', '8888888888', 'STATION_ADMIN'),
('System Admin',       'admin@example.com',   'temp_hash_3', '7777777777', 'SYSTEM_ADMIN');

INSERT INTO vehicles (user_id, vehicle_name, battery_capacity_kwh, connector_type) VALUES
(1, 'Tata Nexon EV', 40.50, 'CCS');

INSERT INTO stations (owner_id, name, address, city, latitude, longitude, status) VALUES
(2, 'GreenCharge Hub', '123 MG Road', 'Visakhapatnam', 17.6868, 83.2185, 'ACTIVE');

INSERT INTO chargers (station_id, charger_code, connector_type, power_kw, price_per_kwh, status) VALUES
(1, 'A1', 'CCS', 50.00, 12.00, 'AVAILABLE'),
(1, 'A2', 'TYPE2', 22.00, 9.00, 'AVAILABLE');

INSERT INTO slots (charger_id, slot_date, start_time, end_time, is_booked) VALUES
(1, CURDATE(), '10:00:00', '10:30:00', FALSE),
(1, CURDATE(), '10:30:00', '11:00:00', FALSE),
(2, CURDATE(), '11:00:00', '11:30:00', FALSE);
