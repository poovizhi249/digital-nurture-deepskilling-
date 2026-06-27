
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance INT,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    Salary INT,
    Department VARCHAR(50),
    HireDate DATE
);


-- SAMPLE DATA

INSERT INTO Accounts VALUES (1, 1, 'Savings', 5000, CURDATE());
INSERT INTO Accounts VALUES (2, 2, 'Checking', 3000, CURDATE());
INSERT INTO Accounts VALUES (3, 3, 'Savings', 8000, CURDATE());

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', '2015-06-15');
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', '2017-03-20');
INSERT INTO Employees VALUES (3, 'Charlie', 'Analyst', 50000, 'IT', '2019-01-10');
INSERT INTO Employees VALUES (4, 'Diana', 'Recruiter', 45000, 'HR', '2020-08-05');


-- SCENARIO 1: Process Monthly Interest


DELIMITER //
CREATE PROCEDURE ProcessMonthlyInterest()
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastModified = CURDATE()
    WHERE AccountType = 'Savings';
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;

-- Call procedure
CALL ProcessMonthlyInterest();

-- Output
SELECT AccountID, AccountType, Balance FROM Accounts;

-- SCENARIO 2: Update Employee Bonus

DELIMITER //
CREATE PROCEDURE UpdateEmployeeBonus(
    IN dept_name VARCHAR(50),
    IN bonus_percentage INT
)
BEGIN
    SET SQL_SAFE_UPDATES = 0;
    UPDATE Employees
    SET Salary = Salary + (Salary * bonus_percentage / 100)
    WHERE Department = dept_name;
    SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;

CALL UpdateEmployeeBonus('IT', 10);

-- Output
SELECT EmployeeID, Name, Department, Salary FROM Employees;


-- SCENARIO 3: Transfer Funds
DELIMITER //
CREATE PROCEDURE TransferFunds(
    IN from_account INT,
    IN to_account INT,
    IN amount INT
)
BEGIN
    DECLARE source_balance INT;

    -- Check source account balance
    SELECT Balance INTO source_balance
    FROM Accounts
    WHERE AccountID = from_account;

    -- If enough balance transfer the funds
    IF source_balance >= amount THEN
        UPDATE Accounts
        SET Balance = Balance - amount
        WHERE AccountID = from_account;

        UPDATE Accounts
        SET Balance = Balance + amount
        WHERE AccountID = to_account;

        SELECT 'Transfer Successful!' AS Message;
    ELSE
        SELECT 'Insufficient Balance!' AS Message;
    END IF;
END //
DELIMITER ;

-- Call procedure (Transfer 1000 from Account 1 to Account 2)
CALL TransferFunds(1, 2, 1000);

-- Output
SELECT AccountID, AccountType, Balance FROM Accounts;
