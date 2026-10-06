DROP  DATABASE IF EXISTS RestaurantDB;
CREATE DATABASE RestaurantDB;
USE RestaurantDB;

CREATE TABLE Restaurant (
    restaurantID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    street VARCHAR(100) NOT NULL,
    postalCode VARCHAR(10) NOT NULL,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    openingTime TIME NOT NULL,
    closingTime TIME NOT NULL
);

CREATE TABLE RestaurantTable (
    tableID INT AUTO_INCREMENT PRIMARY KEY,
    restaurantID INT NOT NULL,
    tableNumber INT NOT NULL,
    capacity INT NOT NULL,
    FOREIGN KEY (restaurantID) REFERENCES Restaurant(restaurantID)
);

CREATE TABLE Customer (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Booking (
    bookingID INT AUTO_INCREMENT PRIMARY KEY,
    customerID INT NOT NULL,
    bookingDate DATE NOT NULL,
    bookingTime TIME NOT NULL,
    numberOfGuests INT NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Reserves (
    bookingID INT NOT NULL,
    tableID INT NOT NULL,
    PRIMARY KEY (bookingID, tableID),
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID),
    FOREIGN KEY (tableID) REFERENCES RestaurantTable(tableID)
);

INSERT INTO Restaurant (name, street, postalCode, city, phone, email, openingTime, closingTime)
VALUES ('Ribe Spisehus', 'Sønderportsgade 8', '6760', 'Ribe', '75421128', 'kontakt@ribespisehus.dk', '11:00:00', '22:00:00');

INSERT INTO Customer (firstName, lastName, phone, email)
VALUES
('Mads', 'Jensen', '22114567', 'mads.jensen@email.dk'),
('Freja', 'Nielsen', '30457821', 'freja.nielsen@email.dk'),
('Mikkel', 'Andersen', '51892345', 'mikkel.andersen@email.dk'),
('Ida', 'Christensen', '26783412', 'ida.christensen@email.dk'),
('Emil', 'Larsen', '42315678', 'emil.larsen@email.dk');