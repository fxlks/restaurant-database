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

INSERT INTO RestaurantTable (restaurantID, tableNumber, capacity)
VALUES
(1, 1, 2),
(1, 2, 4),
(1, 3, 4),
(1, 4, 6),
(1, 5, 8);

INSERT INTO Booking (customerID, bookingDate, bookingTime, numberOfGuests)
VALUES
(1, '2026-10-12', '17:30:00', 4),
(2, '2026-10-13', '18:45:00', 2),
(3, '2026-10-14', '19:30:00', 8),
(4, '2026-10-15', '17:00:00', 3),
(1, '2026-10-16', '20:00:00', 6),
(5, '2026-10-17', '18:30:00', 4);

INSERT INTO Reserves (bookingID, tableID)
VALUES
(1, 2),
(2, 1),
(3, 2),
(3, 3),
(4, 2),
(5, 4),
(6, 3);

/* query 1- List all tables in the restaurant (for a front-end overview). */
SELECT tableID, tableNumber, capacity
FROM RestaurantTable
WHERE restaurantID = 1; 
/* Result: Returns the 5 tables belonging to restaurantID 1, including their table number and capacity. */


/* query 2- List all bookings for a given customer, ordered by date. */
SELECT bookingID, bookingDate, bookingTime, numberOfGuests
FROM Booking
WHERE customerID = 1
ORDER BY bookingDate ASC;
/* Result: Returns the 2 bookings made by customerID 1 (Mads Jensen), ordered by booking date - earliest to latest. */


/* query 3- List all bookings for a given tableID, including the customers, for a specific date. */
SELECT Booking.bookingID, Booking.bookingDate, Booking.bookingTime, Booking.numberOfGuests,
Customer.firstName, Customer.lastName
FROM Booking
JOIN Customer ON Booking.customerID = Customer.customerID
JOIN Reserves ON Booking.bookingID = Reserves.bookingID
WHERE Reserves.tableID = 2
AND Booking.bookingDate = '2026-10-14';
/* Result: Returns Mikkel Andersens booking for tableID 2 on 2026-10-14. */
