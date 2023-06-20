-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)

ALTER TABLE products ALTER COLUMN unit_price SET NOT NULL,
ADD CONSTRAINT check_positive_unit_price CHECK (unit_price > 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ALTER COLUMN discontinued SET CHECK (discontinued = 0 OR discontinued = 1)

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
CREATE TABLE DiscontinuedProducts AS
SELECT * FROM Products
WHERE discontinued = 1

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.

-- Удаление ограничения foreign_key
ALTER TABLE order_details
DROP constraint FK_order_details_products;

-- Удаление товаров, снятых с продажи
DELETE FROM products
WHERE discontinued = 1;

-- Создание обратного ограничения foreign_key
ALTER TABLE order_details
ADD CONSTRAINT FK_order_details_products
FOREIGN KEY (product_id) REFERENCES products(product_id)
