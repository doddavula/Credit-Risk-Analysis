/*========================================================
  CREDIT RISK ANALYSIS PROJECT

  DATA IMPORT VALIDATION SCRIPT

  Data Import Method:
  SQL Server Management Studio (SSMS)
  Import Flat File Wizard

  Imported CSV Files:
  1. customers.csv
  2. loans.csv
  3. payments.csv

  Target Tables:
  1. Customers
  2. Loans
  3. Payments

========================================================*/


USE CreditRiskDB;
GO


/*========================================================
  Verify Customers Data Import

  Purpose:
  Check imported customer records
========================================================*/

SELECT TOP 10 *
FROM Customers;



/*========================================================
  Verify Loans Data Import

  Purpose:
  Check imported loan records
========================================================*/

SELECT TOP 10 *
FROM Loans;



/*========================================================
  Verify Payments Data Import

  Purpose:
  Check imported payment records
========================================================*/

SELECT TOP 10 *
FROM Payments;



/*========================================================
  Row Count Validation

  Purpose:
  Confirm number of imported records
========================================================*/

SELECT 
    COUNT(*) AS TotalCustomers
FROM Customers;


SELECT 
    COUNT(*) AS TotalLoans
FROM Loans;


SELECT 
    COUNT(*) AS TotalPayments
FROM Payments;



/*========================================================
  Data Quality Checks

  Check for missing primary keys
========================================================*/

SELECT *
FROM Customers
WHERE CustomerID IS NULL;


SELECT *
FROM Loans
WHERE LoanID IS NULL;


SELECT *
FROM Payments
WHERE PaymentID IS NULL;



/*========================================================
  Relationship Validation

  Check loans without matching customers
========================================================*/

SELECT *
FROM Loans l
LEFT JOIN Customers c
ON l.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;



/*========================================================
  Check payments without matching loans
========================================================*/

SELECT *
FROM Payments p
LEFT JOIN Loans l
ON p.LoanID = l.LoanID
WHERE l.LoanID IS NULL;


GO