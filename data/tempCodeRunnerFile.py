import pandas as pd
import random
from datetime import datetime, timedelta

random.seed(42)

# -----------------------------
# Sample Data
# -----------------------------

first_names = [
    "John","Emma","Michael","Sophia","David","Olivia","James","Emily",
    "Daniel","Sarah","Robert","Linda","William","Jessica","Thomas",
    "Anna","Christopher","Laura","Kevin","Lisa"
]

last_names = [
    "Smith","Johnson","Brown","Wilson","Taylor","Anderson","Thomas",
    "Jackson","White","Harris","Martin","Thompson","Garcia","Clark",
    "Lewis","Walker","Hall","Young","Allen","King"
]

cities = [
    "Berlin","Munich","Hamburg","Frankfurt",
    "Cologne","Stuttgart","Leipzig","Dresden"
]

occupations = [
    "Engineer","Teacher","Doctor","Manager","Accountant",
    "Software Developer","Nurse","Consultant",
    "Analyst","Sales Executive"
]

loan_types = [
    "Home Loan",
    "Car Loan",
    "Personal Loan",
    "Education Loan",
    "Business Loan"
]

loan_statuses = ["Active","Closed","Default"]
payment_statuses = ["Paid","Late","Missed"]

# -----------------------------
# Customers
# -----------------------------

customers = []

for customer_id in range(1,1001):

    customers.append({

        "CustomerID": customer_id,

        "FirstName": random.choice(first_names),

        "LastName": random.choice(last_names),

        "Gender": random.choice(["Male","Female"]),

        "Age": random.randint(21,65),

        "Occupation": random.choice(occupations),

        "City": random.choice(cities),

        "AnnualIncome": random.randint(25000,150000),

        "CreditScore": random.randint(300,850)

    })

customers_df = pd.DataFrame(customers)

# -----------------------------
# Loans
# -----------------------------

loans = []

for loan_id in range(1,1001):

    loan_type = random.choice(loan_types)

    if loan_type == "Home Loan":
        amount = random.randint(80000,500000)

    elif loan_type == "Car Loan":
        amount = random.randint(10000,60000)

    elif loan_type == "Business Loan":
        amount = random.randint(50000,300000)

    elif loan_type == "Education Loan":
        amount = random.randint(10000,80000)

    else:
        amount = random.randint(5000,50000)

    loans.append({

        "LoanID": loan_id,

        "CustomerID": loan_id,

        "LoanType": loan_type,

        "LoanAmount": amount,

        "InterestRate": round(random.uniform(3.0,10.0),2),

        "LoanTermMonths": random.choice([12,24,36,60,120,180,240]),

        "LoanStatus": random.choices(
            loan_statuses,
            weights=[70,20,10]
        )[0],

        "ApprovalDate":
        (
            datetime(2022,1,1) +
            timedelta(days=random.randint(0,1000))
        ).strftime("%Y-%m-%d")

    })

loans_df = pd.DataFrame(loans)

# -----------------------------
# Payments
# -----------------------------

payments = []

for payment_id in range(1,1001):

    status = random.choices(
        payment_statuses,
        weights=[80,15,5]
    )[0]

    if status == "Paid":
        days_late = 0

    elif status == "Late":
        days_late = random.randint(1,30)

    else:
        days_late = random.randint(31,90)

    payments.append({

        "PaymentID": payment_id,

        "LoanID": payment_id,

        "PaymentDate":
        (
            datetime(2024,1,1) +
            timedelta(days=random.randint(0,365))
        ).strftime("%Y-%m-%d"),

        "AmountPaid": random.randint(200,5000),

        "PaymentStatus": status,

        "DaysLate": days_late

    })

payments_df = pd.DataFrame(payments)

# -----------------------------
# Save CSV Files
# -----------------------------

customers_df.to_csv("customers.csv",index=False)
loans_df.to_csv("loans.csv",index=False)
payments_df.to_csv("payments.csv",index=False)

print("Files created successfully!")
print("customers.csv")
print("loans.csv")
print("payments.csv")
