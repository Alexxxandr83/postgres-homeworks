-- SQL-команды для создания таблиц
DROP TABLE IF EXISTS employees, customers, orders;

create table employees
(
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	title text,
	birth_date date,
	notes text	
);

CREATE TABLE customers (
customer_id varchar(100) PRIMARY KEY,
company_name varchar(100) NOT NULL,
contact_name varchar(100) NOT NULL
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id VARCHAR(100) REFERENCES customers(customer_id) NOT NULL,
employee_id INT REFERENCES employees(employee_id) NOT NULL,
order_date date,
ship_city VARCHAR(100) NOT NULL
);
