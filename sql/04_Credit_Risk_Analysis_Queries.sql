USE CreditRiskDB;
GO

/*========================================================
  CREDIT RISK ANALYSIS PROJECT
  SQL BUSINESS ANALYSIS QUERIES
  Tables:
  1. Customers
  2. Loans
  3. Payments
========================================================*/


/*========================================================
  1. Total Number of Customers
  Purpose:
  Calculate the total customers available in the system
========================================================*/

SELECT 
    COUNT(*) AS TotalCustomers
FROM Customers;



/*========================================================
  2. Total Number of Loans
  Purpose:
  Count all loans issued to customers
========================================================*/

SELECT
    COUNT(*) AS TotalLoans
FROM Loans;



/*========================================================
  3. Total Loan Amount
  Purpose:
  Calculate total amount of loans issued
========================================================*/

SELECT
    SUM(LoanAmount) AS TotalLoanAmount
FROM Loans;



/*========================================================
  4. Average Annual Income
  Purpose:
  Find the average income of customers
========================================================*/

SELECT
    AVG(AnnualIncome) AS AverageAnnualIncome
FROM Customers;



/*========================================================
  5. Average Credit Score
  Purpose:
  Analyze average customer credit score
========================================================*/

SELECT
    AVG(CreditScore) AS AverageCreditScore
FROM Customers;



/*========================================================
  6. Loan Status Analysis
  Purpose:
  Show number of loans by status
  Example:
  Approved, Rejected, Pending
========================================================*/

SELECT
    LoanStatus,
    COUNT(LoanID) AS TotalLoans
FROM Loans
GROUP BY LoanStatus;



/*========================================================
  7. Loan Type Analysis
  Purpose:
  Show distribution of different loan types
========================================================*/

SELECT
    LoanType,
    COUNT(LoanID) AS TotalLoans
FROM Loans
GROUP BY LoanType;



/*========================================================
  8. Total Loan Amount by Loan Type
  Purpose:
  Identify which loan types have highest value
========================================================*/

SELECT
    LoanType,
    SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY LoanType
ORDER BY TotalLoanAmount DESC;



/*========================================================
  9. Average Loan Amount
  Purpose:
  Calculate average loan size
========================================================*/

SELECT
    AVG(LoanAmount) AS AverageLoanAmount
FROM Loans;



/*========================================================
  10. Total Payment Amount Received
  Purpose:
  Calculate total customer payments
========================================================*/

SELECT
    SUM(AmountPaid) AS TotalPaymentAmount
FROM Payments;



/*========================================================
  11. Payment Status Analysis
  Purpose:
  Analyze payment performance
========================================================*/

SELECT
    PaymentStatus,
    COUNT(PaymentID) AS TotalPayments
FROM Payments
GROUP BY PaymentStatus;



/*========================================================
  12. Average Days Late
  Purpose:
  Measure payment delay risk
========================================================*/

SELECT
    AVG(DaysLate) AS AverageDaysLate
FROM Payments;



/*========================================================
  13. Customer Loan Details
  Purpose:
  Combine customer information with loan details
========================================================*/

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Gender,
    c.City,
    c.AnnualIncome,
    c.CreditScore,
    l.LoanID,
    l.LoanType,
    l.LoanAmount,
    l.LoanStatus
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID;



/*========================================================
  14. Loan Payment Details
  Purpose:
  Show payment information for each loan
========================================================*/

SELECT
    l.LoanID,
    l.LoanType,
    l.LoanAmount,
    p.PaymentDate,
    p.AmountPaid,
    p.PaymentStatus,
    p.DaysLate
FROM Loans l
INNER JOIN Payments p
ON l.LoanID = p.LoanID;



/*========================================================
  15. Top 10 Customers by Loan Amount
  Purpose:
  Identify customers with highest loan exposure
========================================================*/

SELECT TOP 10
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(l.LoanAmount) AS TotalLoanAmount
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
ORDER BY TotalLoanAmount DESC;



/*========================================================
  16. Customer Risk Based on Credit Score
  Purpose:
  Categorize customers into risk groups
========================================================*/

SELECT
    CustomerID,
    FirstName,
    LastName,
    CreditScore,
    CASE
        WHEN CreditScore >= 750 THEN 'Low Risk'
        WHEN CreditScore >= 600 THEN 'Medium Risk'
        ELSE 'High Risk'
    END AS RiskCategory
FROM Customers;



/*========================================================
  17. Loan Approval Analysis
  Purpose:
  Count approved vs rejected loans
========================================================*/

SELECT
    LoanStatus,
    COUNT(*) AS NumberOfLoans
FROM Loans
GROUP BY LoanStatus;



/*========================================================
  18. Late Payment Analysis
  Purpose:
  Find customers with delayed payments
========================================================*/

SELECT
    PaymentID,
    LoanID,
    AmountPaid,
    DaysLate,
    PaymentStatus
FROM Payments
WHERE DaysLate > 0
ORDER BY DaysLate DESC;



/*========================================================
  19. Customer Loan Summary
  Purpose:
  Show total loans taken by each customer
========================================================*/

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(l.LoanID) AS NumberOfLoans,
    SUM(l.LoanAmount) AS TotalBorrowedAmount
FROM Customers c
LEFT JOIN Loans l
ON c.CustomerID = l.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;



/*========================================================
  20. Monthly Payment Trend
  Purpose:
  Analyze payment collection over time
========================================================*/

SELECT
    YEAR(PaymentDate) AS PaymentYear,
    MONTH(PaymentDate) AS PaymentMonth,
    SUM(AmountPaid) AS TotalCollected
FROM Payments
GROUP BY
    YEAR(PaymentDate),
    MONTH(PaymentDate)
ORDER BY
    PaymentYear,
    PaymentMonth;