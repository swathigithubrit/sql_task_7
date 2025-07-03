sql_task_7
This project demonstrates how to create and use SQL views in a library management system. It includes examples of views for data abstraction, security, aggregation, and performance optimization using indexed views in SQL Server.

 Objective

✅ Learn to create, use, and understand views in SQL Server.
✅ Apply views for:
  Data abstraction
  Security
  Reusable query logic
  Performance (indexed views)

⚒️ Tools Used
    Microsoft SQL Server / SSMS
    T-SQL

🗂️ Database Design

We model a small Library Management System with:
📑 Tables
Books
BookID (PK)
Title
Author
Genre
CopiesAvailable

    
Members
-MemberID (PK)
-Name
-Email
-MembershipDate

 Loans
 -LoanID (PK)
 -BookID (FK → Books)
 -MemberID (FK → Members)
 -LoanDate
 -ReturnDate

📥 Sample Data

✅ Books
BookID	Title	Author	Genre	CopiesAvailable
1	The Great Gatsby	F. Scott Fitzgerald	Fiction	3
2	1984	George Orwell	Dystopian	5
3	To Kill a Mockingbird	Harper Lee	Classic	2

✅ Members
MemberID	Name	Email	MembershipDate
1	Alice Johnson	alice@example.com	2024-01-10
2	Bob Smith	bob@example.com	2024-02-15

✅ Loans
LoanID	BookID	MemberID	LoanDate	ReturnDate
101	1	1	2025-06-01	NULL
102	2	2	2025-06-02	2025-06-15
