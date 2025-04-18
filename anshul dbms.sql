CREATE TABLE Client (
Client INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Phone VARCHAR(15) UNIQUE
);

CREATE TABLE ServiceProvider (
 Provider_ID INT PRIMARY KEY,
 Name VARCHAR(50) NOT NULL,
 Charges DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Venue (
 Venue_ID INT PRIMARY KEY,
 Location VARCHAR(100) NOT NULL,
 Date DATE NOT NULL,
 Time TIME NOT NULL
);

CREATE TABLE Event (
 Venue_ID INT PRIMARY KEY,
 Type VARCHAR(50) NOT NULL,
 Capacity INT NOT NULL,
 FOREIGN KEY (Venue_ID) REFERENCES Venue(Venue_ID)
);

CREATE TABLE Booking (
 Booking_ID INT PRIMARY KEY,
 Client INT,
 Venue_ID INT,
 Provider_ID INT,
 FOREIGN KEY (Client) REFERENCES Client(Client),
 FOREIGN KEY (Venue_ID) REFERENCES Venue(Venue_ID),
 FOREIGN KEY (Provider_ID) REFERENCES 
ServiceProvider(Provider_ID)
);

CREATE TABLE Payment (
 Payment_ID INT PRIMARY KEY,
 Booking_ID INT,
 Method VARCHAR(30) NOT NULL,
 FOREIGN KEY (Booking_ID) REFERENCES 
Booking(Booking_ID)
);

SELECT * FROM Client;

SELECT * FROM Venue;

SELECT * FROM ServiceProvider WHERE Charges > 
5000;

SELECT B.Booking_ID, C.Name AS Client_Name, V.Location
FROM Booking B
JOIN Client C ON B.Client = C.Client
JOIN Venue V ON B.Venue_ID = V.Venue_ID;

SELECT * FROM Event WHERE Capacity > 200;

SELECT Client, COUNT(*) AS Total_Bookings
FROM Booking
GROUP BY Client;

SELECT B.Booking_ID, P.Method
FROM Booking B
JOIN Payment P ON B.Booking_ID = P.Booking_ID;

SELECT SP.Name, SUM(SP.Charges) AS Total_Revenue
FROM Booking B
JOIN ServiceProvider SP ON B.Provider_ID = SP.Provider_ID
GROUP BY SP.Name;

SELECT DISTINCT C.Name
FROM Client C
JOIN Booking B ON C.Client = B.Client
JOIN Payment P ON B.Booking_ID = P.Booking_ID
WHERE P.Method = 'UPI';

SELECT E.Type, V.Location
FROM Event E
JOIN Venue V ON E.Venue_ID = V.Venue_ID;

SELECT B.Booking_ID, V.Date, C.Name
FROM Booking B
JOIN Venue V ON B.Venue_ID = V.Venue_ID
JOIN Client C ON B.Client = C.Client
WHERE V.Date = '2025-04-15';

SELECT * FROM Event ORDER BY Capacity DESC;

SELECT * FROM ServiceProvider 
WHERE Charges = (SELECT MAX(Charges) FROM 
ServiceProvider);

SELECT Venue_ID, COUNT(*) AS Booking_Count
FROM Booking
GROUP BY Venue_ID;

SELECT C.Name, P.Method
FROM Client C
LEFT JOIN Booking B ON C.Client = B.Client
LEFT JOIN Payment P ON B.Booking_ID = P.Booking_ID;

