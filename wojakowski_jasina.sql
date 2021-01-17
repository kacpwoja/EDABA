-- Drop previous copies
DROP TABLE Order_Products;
DROP TABLE Reviews;
DROP TABLE Deliveries;
DROP TABLE Delivery_Suppliers;
DROP TABLE Orders;
DROP TABLE Customers;
DROP TABLE Products;

-- Create tables
CREATE TABLE Customers (
    email_address VARCHAR(50) NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    password_hash VARCHAR(50) NOT NULL,
    phone_number CHAR(9),
    address VARCHAR(50),
    address_city VARCHAR(50),
    address_zipcode CHAR(6)
);

CREATE TABLE Products (
    product_id INT NOT NULL PRIMARY KEY,
    p_name VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    stock INT NOT NULL,
    p_description VARCHAR(500) NOT NULL,
    p_category VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    order_id INT NOT NULL PRIMARY KEY,
    customer_email VARCHAR(50) NOT NULL,
    date_placed DATE NOT NULL,
    price FLOAT NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT FK_CustomerOrder
        FOREIGN KEY (customer_email)
        REFERENCES Customers(email_address)
);

CREATE TABLE Order_Products (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT FK_OPOrder
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    CONSTRAINT FK_OPProduct
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

CREATE TABLE Delivery_Suppliers (
    supplier_name VARCHAR(50) NOT NULL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    tracking_url VARCHAR(200)
);

CREATE TABLE Deliveries (
    order_id INT NOT NULL PRIMARY KEY,
    customer_email VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    supplier VARCHAR(50) NOT NULL,
    different_address NUMBER(1,0) DEFAULT 0,
    address VARCHAR(50),
    address_city VARCHAR(50),
    address_zipcode CHAR(6),
    date_sent DATE,
    date_delivered DATE,
    tracking_id VARCHAR(50),
    parcel_locker_id VARCHAR(50),
    CONSTRAINT FK_DeliveryOrder
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    CONSTRAINT FK_DeliveryCustomer
        FOREIGN KEY (customer_email)
        REFERENCES Customers(email_address),
    CONSTRAINT FK_DeliverySupplier
        FOREIGN KEY (supplier)
        REFERENCES Delivery_Suppliers(supplier_name)
);

CREATE TABLE Reviews (
    review_id INT NOT NULL PRIMARY KEY,
    product_id INT NOT NULL,
    customer_email VARCHAR(50) NOT NULL,
    score INT NOT NULL,
    text VARCHAR(500),
    CONSTRAINT FK_CustomerReview
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id),
    CONSTRAINT FK_ProductReview
         FOREIGN KEY (customer_email)
         REFERENCES Customers(email_address)
);

-- Inserting values
INSERT INTO Customers VALUES ('kwojtyla@watykan.pl', 'Karol', 'Wojtyla', 'hasbfiadfadjhfbhj1b2413513', '20050204', 'Jana Pawla II 21/37', 'Warszawa', '02-137');
INSERT INTO Customers VALUES ('jkowalski@buziaczek.pl', 'Jan', 'Kowalski', 'uoqeruoiqeior1roi3ui1', '987456321', 'Prosta 1', 'Krakow', '03-997');
INSERT INTO Customers VALUES ('nergal69@behemoth.com', 'Adam', 'Darski', 'jahfoasofnu891n74914', '446512987', 'Bogurodzicy 12', 'Gdansk', '00-666');
INSERT INTO Customers VALUES ('kamikami@mail.com', 'Kamil', 'Kamilowski', 'oadkajnsdkj19238080', '789123456', 'Dziekanska 13', 'Warszawa', '00-123');
INSERT INTO Customers VALUES ('cbroski@gym.edu.com', 'Chad', 'Broski', 'ankjagbkjadbjk124143', '654312789', 'Biceps 200', 'Warszawa', '00-142');
INSERT INTO Customers (email_address, first_name, last_name, password_hash) VALUES ('hackerman12@gmail.com', 'Miguel', 'Pollo', 'ajkdfjkadgkbs1319089');

INSERT INTO Products VALUES (1, 'Premium Membership', 999.99, 100, 'Super fun mega giga great premium membership for this store!!! Buy now!! Not scam!!!!', 'Other');
INSERT INTO Products VALUES (2, 'Gaming Chair', 399.99, 10, 'Very comfortable gaming chair', 'Furniture');
INSERT INTO Products VALUES (3, 'Normal Chair', 99.99, 50, 'Normal char, not as comfortable as a gaming chair', 'Furniture');
INSERT INTO Products VALUES (4, 'Table', 150.00, 25, 'I am the table', 'Furniture');
INSERT INTO Products VALUES (5, 'Shirt', 39.99, 30, 'A shirt with a very funny image', 'Clothing');
INSERT INTO Products VALUES (6, 'MEGA Hat', 15.49, 15, 'Make Elka Great Again', 'Clothing');

INSERT INTO Orders VALUES (1, 'kwojtyla@watykan.pl', '2005-02-04', 999.99, 'DELIVERED');
INSERT INTO Orders VALUES (2, 'cbroski@gym.edu.com', '2020-07-06', 559.99, 'PENDING');
INSERT INTO Orders VALUES (3, 'hackerman12@gmail.com', '2020-06-04', 469.47, 'DELIVERED');
INSERT INTO Orders VALUES (4, 'jkowalski@buziaczek.pl', '2020-11-09', 60.48, 'DELIVERING');

INSERT INTO Order_Products VALUES (1, 1);
INSERT INTO Order_Products VALUES (2, 2);
INSERT INTO Order_Products VALUES (2, 4);
INSERT INTO Order_Products VALUES (3, 2);
INSERT INTO Order_Products VALUES (3, 5);
INSERT INTO Order_Products VALUES (3, 6);
INSERT INTO Order_Products VALUES (4, 5);
INSERT INTO Order_Products VALUES (4, 6);

INSERT INTO Delivery_Suppliers VALUES ('POCZTA_POLSKA', 'COURIER', 5, NULL);
INSERT INTO Delivery_Suppliers VALUES ('SUPERKURIER', 'COURIER', 10, 'superkurier.pl/tracking/');
INSERT INTO Delivery_Suppliers VALUES ('INPOST', 'PARCEL_LOCKER', 8, 'inpost.pl/tracking/');

INSERT INTO Deliveries VALUES (2, 'cbroski@gym.edu.com', 'PENDING', 'SUPERKURIER', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO Deliveries VALUES (3, 'hackerman12@gmail.com', 'DELIVERED', 'SUPERKURIER', 1, 'Grzegorzewska 15/16', 'Warszawa', '02-543', '2020-06-05', '2020-06-09', NULL, NULL);
INSERT INTO Deliveries VALUES (4, 'jkowalski@buziaczek.pl', 'DELIVERING', 'POCZTA_POLSKA', 0, NULL, NULL, NULL, '2020-11-11', NULL, 'ASHB1231591QWE1', NULL);

INSERT INTO Reviews VALUES (1, 6, 'hackerman12@gmail.com', 5, 'GREAT HAT!!! GREAT MESSAGE!!! GOOD!!! 5 STARS!!!');
INSERT INTO Reviews VALUES (2, 1, 'kwojtyla@watykan.pl', 5, 'i am greatly enjoying the premium membership, this premium membership');

-- simple SELECT statements

-- select all customers from Warsaw
SELECT * FROM Customers WHERE address_city='Warszawa';
-- select all delivered packages
SELECT * FROM Deliveries WHERE state='DELIVERED';
-- select all products with stock lower than 20
SELECT product_id, p_name, stock FROM Products WHERE stock<20;
-- select all positive reviews
SELECT review_id, product_id, score, text FROM Reviews WHERE score>4;
-- find all cheapest products
SELECT product_id, p_name FROM Products WHERE price = (SELECT MIN(price) FROM Products);

-- complex SELECT statements

-- show products for each order
SELECT o.order_id, o.customer_email, o.date_placed, p.product_id, p.p_name
FROM Orders o
INNER JOIN Order_Products op ON o.order_id=op.order_id
INNER JOIN Products p ON p.product_id=op.product_id
ORDER BY order_id;

-- count number of orders made by each customer
--SELECT COUNT c.email_address, c.first_name, c.last_name , COUNT(o.order_id) AS number_of_orders
--FROM Customers c
--INNER JOIN Orders o ON c.email_address = o.customer_email
--GROUP BY  c.email_address, c.first_name, c.last_name;

-- count the amount of times each item was ordered
SELECT p.product_id, p.p_name, COUNT(op.product_id) AS times_ordered
FROM Products p
INNER JOIN Order_Products op ON p.product_id=op.product_id
GROUP BY p.product_id, p.p_name;

-- count the amount of deliveries done to each city
SELECT cc.city, COUNT(cc.city) as times_delivered
FROM
(
    SELECT
    CASE
        WHEN d.address_city IS NOT NULL THEN d.address_city
        ELSE c.address_city
    END AS city
    FROM Deliveries d
    INNER JOIN Customers c ON d.customer_email=c.email_address
) cc
GROUP BY cc.city;

-- big select:
-- show the amount of products and their total price delivered to each city
SELECT oo.city,
       COUNT(oo.product_id) total_products,
       SUM(oo.product_price) price_sum
FROM
(
    SELECT o.order_id,
           CASE d.different_address
                WHEN 1 THEN d.address_city
                ELSE c.address_city
           END city,
           op.product_id,
           p.price product_price
    FROM Orders o
    INNER JOIN Order_Products op ON o.order_id = op.order_id
    INNER JOIN Products p ON p.product_id = op.product_id
    INNER JOIN Deliveries d ON o.order_id = d.order_id
    INNER JOIN Customers c ON o.customer_email = c.email_address
) oo
GROUP BY oo.city;

-- TRIGGER
-- drop old
--DROP TRIGGER productorder_added;
--DROP TRIGGER productorder_removed;

-- create new
-- updating the order summary price when a new product is added or removed from the order
CREATE TRIGGER productorder_added
    AFTER INSERT ON Order_Products
    FOR EACH ROW
    BEGIN
        UPDATE Orders SET
            price = price + (SELECT price FROM Products WHERE product_id = :new.product_id)
        WHERE order_id = :new.order_id;
END;
/
CREATE TRIGGER productorder_removed
    AFTER DELETE ON Order_Products
    FOR EACH ROW
    BEGIN
        UPDATE Orders SET
            price = price - (SELECT price FROM Products WHERE product_id = :old.product_id)
        WHERE order_id = :old.order_id;
END;
/
-- testing trigger
SELECT order_id, price FROM Orders where order_id = 2;
SELECT op.order_id, op.product_id, p.price FROM Order_Products op JOIN Products p ON op.product_id = p.product_id WHERE order_id = 2;

INSERT INTO Order_Products VALUES (2, 6);

SELECT order_id, price FROM Orders where order_id = 2;
SELECT op.order_id, op.product_id, p.price FROM Order_Products op JOIN Products p ON op.product_id = p.product_id WHERE order_id = 2;

DELETE FROM Order_Products WHERE order_id = 2 AND product_id = 6;

SELECT order_id, price FROM Orders where order_id = 2;
SELECT op.order_id, op.product_id, p.price FROM Order_Products op JOIN Products p ON op.product_id = p.product_id WHERE order_id = 2;