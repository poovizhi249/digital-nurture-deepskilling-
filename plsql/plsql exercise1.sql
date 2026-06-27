CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    DOB DATE,
    Balance INT,
    LastModified DATE
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount INT,
    InterestRate INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers VALUES (1, 'John Old', '1958-01-01', 5000, CURDATE());
INSERT INTO Customers VALUES (2, 'Jane Young', '1990-06-15', 3000, CURDATE());
INSERT INTO Customers VALUES (3, 'Rich Guy', '1985-03-10', 15000, CURDATE());

INSERT INTO Loans VALUES (1, 1, 10000, 8, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 60 MONTH));
INSERT INTO Loans VALUES (2, 2, 5000,  6, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 36 MONTH));
INSERT INTO Loans VALUES (3, 3, 8000,  5, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY));


SET SQL_SAFE_UPDATES = 0;

UPDATE Loans
SET InterestRate = InterestRate - 1
WHERE LoanID IN (
    SELECT LoanID FROM (
        SELECT l.LoanID
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE TIMESTAMPDIFF(YEAR, c.DOB, CURDATE()) > 60
    ) AS temp
);

SET SQL_SAFE_UPDATES = 1;


SELECT 
    c.Name,
    TIMESTAMPDIFF(YEAR, c.DOB, CURDATE()) AS Age,
    l.InterestRate AS RateAfter
FROM Customers c
JOIN Loans l ON c.CustomerID = l.CustomerID;


ALTER TABLE Customers
ADD IsVIP VARCHAR(5) DEFAULT 'FALSE';

SET SQL_SAFE_UPDATES = 0;

UPDATE Customers
SET IsVIP = 'TRUE'
WHERE Balance > 10000;

SET SQL_SAFE_UPDATES = 1;

-- Output
SELECT 
    CustomerID,
    Name,
    Balance,
    IsVIP
FROM Customers;


SELECT 
    c.Name AS CustomerName,
    l.LoanID,
    l.LoanAmount,
    l.EndDate AS DueDate,
    DATEDIFF(l.EndDate, CURDATE()) AS DaysLeft,
    CONCAT('Reminder: Dear ', c.Name, 
           ', your loan of $', l.LoanAmount, 
           ' is due on ', l.EndDate, 
           '. Please ensure timely payment.') AS ReminderMessage
FROM Loans l
JOIN Customers c ON l.CustomerID = c.CustomerID
WHERE l.EndDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY l.EndDate ASC;
