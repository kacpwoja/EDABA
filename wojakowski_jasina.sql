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
    delivery_id INT,
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