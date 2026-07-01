-- 1. Create the Listing Table
CREATE TABLE Listing (
    listing_id INT AUTO_INCREMENT PRIMARY KEY,
    supermarket_id INT NOT NULL,
    food_type VARCHAR(255) NOT NULL,
    category ENUM('fruits', 'vegetables') NOT NULL,
    initial_quantity DECIMAL(10,2) NOT NULL,
    available_quantity DECIMAL(10,2) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    expiry_date DATE NOT NULL,
    claim_deadline TIME NOT NULL,
    discount_tier DECIMAL(5,2),
    status ENUM('active', 'reserved', 'sold', 'expired', 'collected') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Create the Listing_Pickup_Slots Table
CREATE TABLE Listing_Pickup_Slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    is_booked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Create the Pickup Table
CREATE TABLE Pickup (
    pickup_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    user_id INT NOT NULL,
    slot_id INT NOT NULL,
    confirmed_at TIMESTAMP NULL,
    confirmed_by INT NULL,
    status ENUM('scheduled', 'completed', 'no_show') DEFAULT 'scheduled',
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id) ON DELETE CASCADE,
    FOREIGN KEY (slot_id) REFERENCES Listing_Pickup_Slots(slot_id) ON DELETE CASCADE
) ENGINE=InnoDB;