---Database Creation

CREATE DATABASE LibraryDB;
GO

USE LibraryDB;
GO

--- Table Creation
---(a) Books Table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title NVARCHAR(100),
    Author NVARCHAR(100),
    Genre NVARCHAR(50),
    CopiesAvailable INT
);

---(b) Members Table
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Email NVARCHAR(100),
    MembershipDate DATE
);

---(c) Loans Table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT FOREIGN KEY REFERENCES Books(BookID),
    MemberID INT FOREIGN KEY REFERENCES Members(MemberID),
    LoanDate DATE,
    ReturnDate DATE
);


---Insert Sample Data

INSERT INTO Books VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 3),
(2, '1984', 'George Orwell', 'Dystopian', 5),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Classic', 2);


--- 
INSERT INTO Members VALUES
(1, 'Alice Johnson', 'alice@example.com', '2024-01-10'),
(2, 'Bob Smith', 'bob@example.com', '2024-02-15');


INSERT INTO Loans VALUES
(101, 1, 1, '2025-06-01', NULL),
(102, 2, 2, '2025-06-02', '2025-06-15');


--- Create Views
---(a) ActiveLoans View

CREATE VIEW ActiveLoans AS
SELECT
    L.LoanID,
    M.Name AS MemberName,
    B.Title AS BookTitle,
    L.LoanDate,
    L.ReturnDate
FROM
    Loans L
    JOIN Members M ON L.MemberID = M.MemberID
    JOIN Books B ON L.BookID = B.BookID
WHERE
    L.ReturnDate IS NULL;


SELECT * FROM ActiveLoans;


---(b) MemberLoanSummary View
CREATE VIEW MemberLoanSummary AS
SELECT
    M.MemberID,
    M.Name,
    COUNT(L.LoanID) AS TotalLoans
FROM
    Members M
    LEFT JOIN Loans L ON M.MemberID = L.MemberID
GROUP BY
    M.MemberID, M.Name;


SELECT * FROM MemberLoanSummary;

---(c) PublicMembers View
CREATE VIEW PublicMembers AS
SELECT
    MemberID,
    Name,
    MembershipDate
FROM
    Members;


SELECT * FROM PublicMembers;


---(d) FictionBooks View with CHECK OPTION
CREATE VIEW FictionBooks AS
SELECT *
FROM Books
WHERE Genre = 'Fiction'
WITH CHECK OPTION;


SELECT * FROM FictionBooks;


-- 1. Schema binding required
CREATE VIEW GenreSummary
WITH SCHEMABINDING
AS
SELECT
    Genre,
    COUNT_BIG(*) AS BookCount,
    SUM(CopiesAvailable) AS TotalCopies
FROM
    dbo.Books
GROUP BY
    Genre;
GO

-- 2. Create clustered index
CREATE UNIQUE CLUSTERED INDEX IDX_GenreSummary_Genre
ON GenreSummary (Genre);


SELECT * FROM GenreSummary;


