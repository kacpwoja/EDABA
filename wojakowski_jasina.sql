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

