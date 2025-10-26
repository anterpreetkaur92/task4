CREATE DATABASE pizza_shop;
USE pizza_shop;
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);



CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(5),
    price DECIMAL(6,2),
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    date TEXT,
    time TEXT
);

SHOW TABLES;

INSERT INTO pizza_types (pizza_type_id, name, category, ingredients)
VALUES
('bbq_ckn', 'Barbecue Chicken Pizza', 'Chicken', 'Barbecued Chicken, Red Peppers, Green Peppers'),
('cali_ckn', 'California Chicken Pizza', 'Chicken', 'Chicken, Artichoke, Spinach, Garlic'),
('five_chs', 'Five Cheese Pizza', 'Veggie', 'Mozzarella, Cheddar, Parmesan, Feta, Goat Cheese');

INSERT INTO pizzas (pizza_id, pizza_type_id, size, price)
VALUES
('bbq_ckn_s', 'bbq_ckn', 'S', 12.75),
('bbq_ckn_m', 'bbq_ckn', 'M', 16.75),
('cali_ckn_l', 'cali_ckn', 'L', 20.75),
('five_chs_s', 'five_chs', 'S', 10.00),
('five_chs_m', 'five_chs', 'M', 14.00);

INSERT INTO orders (order_id, date, time)
VALUES
(1, '2025-10-26', '12:30:00'),
(2, '2025-10-26', '14:45:00'),
(3, '2025-10-27', '11:10:00');

SELECT * FROM pizza_types;
SELECT * FROM pizzas;
SELECT * FROM orders;

SELECT *
FROM pizza_types
ORDER BY category;

SELECT pizza_id, size, price
FROM pizzas
WHERE price < 15
ORDER BY price ASC;

SELECT 
  p.pizza_id,
  p.size,
  p.price,
  pt.name AS pizza_name,
  pt.category
FROM pizzas p
INNER JOIN pizza_types pt 
  ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC;

SELECT pt.name, pt.category, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE p.price = (
  SELECT MAX(p2.price)
  FROM pizzas p2
  WHERE p2.pizza_type_id = p.pizza_type_id
);

CREATE VIEW pizza_price_summary AS
SELECT 
  pt.category,
  COUNT(p.pizza_id) AS total_pizzas,
  ROUND(AVG(p.price), 2) AS avg_price
FROM pizzas p
JOIN pizza_types pt 
  ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

SELECT * FROM pizza_price_summary;

CREATE INDEX idx_pizza_type_id ON pizzas(pizza_type_id);
CREATE INDEX idx_category ON pizza_types(category);

