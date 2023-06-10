-- SQL-команды для создания таблиц
DROP TABLE IF EXISTS employees, customers_data, orders_data;

create table employees
(
	employee_id INT PRIMARY KEY NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	title text,
	birth_date date,
	notes text	
);

CREATE TABLE customers_data (
customer_id varchar(100) NOT NULL,
company_name varchar(100) NOT NULL,
contact_name varchar(100) NOT NULL
);

CREATE TABLE orders_data (
order_id INT REFERENCES employees(employee_id) NOT NULL,
customer_id VARCHAR(100) NOT NULL,
employee_id int NOT NULL,
order_date date,
ship_city VARCHAR(100) NOT NULL
);

