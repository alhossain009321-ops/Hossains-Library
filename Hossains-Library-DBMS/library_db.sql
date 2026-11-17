-- ==========================================================
-- Project: Hossains Library Management System (DBMS Lab)
-- Database Schema & Sample Data Script
-- ==========================================================

-- 1. Create Parent Table (Categories) with Primary Key
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Create Child Table (Books) with Primary Key & Foreign Key
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL CHECK (stock >= 0),
    CONSTRAINT fk_book_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 3. Populate Categories
INSERT INTO categories (category_name) VALUES
('Computer Science'),
('Mathematics'),
('Literature'),
('Physics'),
('Engineering'),
('History');

-- 4. Populate 10 Sample Book Records
INSERT INTO books (title, author, category_id, price, stock) VALUES
('Database System Concepts', 'Abraham Silberschatz', 1, 850.00, 12),
('Introduction to Algorithms', 'Thomas H. Cormen', 1, 1200.00, 8),
('Clean Code', 'Robert C. Martin', 1, 950.00, 15),
('Linear Algebra Done Right', 'Sheldon Axler', 2, 700.00, 10),
('Calculus', 'James Stewart', 2, 1100.00, 6),
('To Kill a Mockingbird', 'Harper Lee', 3, 450.00, 20),
('1984', 'George Orwell', 3, 400.00, 25),
('The Great Gatsby', 'F. Scott Fitzgerald', 3, 390.00, 18),
('Concepts of Physics', 'H.C. Verma', 4, 850.00, 14),
('University Physics', 'Hugh D. Young', 4, 900.00, 9);

-- ==========================================================
-- Key Operational Queries Used in the Application
-- ==========================================================

-- Retrieve all books with category names (INNER JOIN)
SELECT b.book_id, b.title, b.author, c.category_name, b.price, b.stock
FROM books b
INNER JOIN categories c ON b.category_id = c.category_id
ORDER BY b.book_id ASC;

-- Search / Filter records (WHERE + LIKE)
SELECT b.book_id, b.title, b.author, c.category_name, b.price, b.stock
FROM books b
INNER JOIN categories c ON b.category_id = c.category_id
WHERE b.title LIKE '%Algorithm%'
   OR b.author LIKE '%Algorithm%'
   OR c.category_name LIKE '%Algorithm%';

-- Update an existing record (UPDATE)
UPDATE books
SET title = 'Database System Concepts (7th Ed.)', price = 900.00, stock = 15
WHERE book_id = 1;

-- Delete a record (DELETE)
DELETE FROM books WHERE book_id = 10;

-- Summary Statistics (Aggregate Functions: COUNT, SUM, AVG)
SELECT
    COUNT(book_id) AS total_titles,
    SUM(stock) AS inventory_stock,
    AVG(price) AS average_price
FROM books;