/*========================================================
  CREDIT RISK ANALYSIS PROJECT
  DATABASE TABLE CREATION SCRIPT

  Tables:
  1. Customers
  2. Loans
  3. Payments

  Relationship:
  Customers (1) -------- (*) Loans
  Loans     (1) -------- (*) Payments
========================================================*/


USE CreditRiskDB;
GO


/*========================================================
  1. Create Customers Table

  Purpose:
  Stores customer demographic, income and credit details.

  Primary Key:
  CustomerID - Unique identifier for each customer
========================================================*/

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,

    FirstName VARCHAR(50),

    LastName VARCHAR(50),

    Gender VARCHAR(10),

    Age INT,

    Occupation VARCHAR(100),

    City VARCHAR(100),

    AnnualIncome DECIMAL(12,2),

    CreditScore INT
);

GO



/*========================================================
  2. Create Loans Table

  Purpose:
  Stores loan information including loan type,
  amount, interest rate and approval status.

  Primary Key:
  LoanID - Unique identifier for each loan

  Foreign Key:
  CustomerID connects loans with customers
========================================================*/

CREATE TABLE Loans
(
    LoanID INT PRIMARY KEY,

    CustomerID INT,

    LoanType VARCHAR(50),

    LoanAmount DECIMAL(12,2),

    InterestRate DECIMAL(5,2),

    LoanTermMonths INT,

    LoanStatus VARCHAR(30),

    ApprovalDate DATE,


    CONSTRAINT FK_Loans_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

GO



/*========================================================
  3. Create Payments Table

  Purpose:
  Stores loan repayment details including
  payment amount, status and delays.

  Primary Key:
  PaymentID - Unique identifier for each payment

  Foreign Key:
  LoanID connects payments with loans
========================================================*/

CREATE TABLE Payments
(
    PaymentID INT PRIMARY KEY,

    LoanID INT,

    PaymentDate DATE,

    AmountPaid DECIMAL(12,2),

    PaymentStatus VARCHAR(30),

    DaysLate INT,


    CONSTRAINT FK_Payments_Loans
    FOREIGN KEY (LoanID)
    REFERENCES Loans(LoanID)
);

GO



/*========================================================
  Verify Tables Created Successfully
========================================================*/

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

GO