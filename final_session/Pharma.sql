-- Question 1
users
id (Clé primaire)
firstname
lastname
designation
adress
city
province
country
postal_code
phone
email
password
actif
image
role_id (Clé étrangère de roles)


roles
id (Clé primaire)
name
description


carts
id (Clé primaire)
user_id (Clé étrangère de users)
actif


cart_product
cart_id (Clé étrangère de carts)
product_id (Clé étrangère de products)
quantity
total
tax
quantity_remainder


products
id (Clé primaire)
name
description
code_product
supplier_id (Clé étrangère de suppliers)
warehouse_id (Clé étrangère de warehouses)
image
min_quantity
price


suppliers
id (Clé primaire)
name
adress
city
province
country
postal_code
phone
email


warehouses
id (Clé primaire)
name
adress
city
province
country


stock_product
stock_id (Clé étrangère de stocks)
product_id (Clé étrangère de products)
quantity


stocks
id (Clé primaire)
name
expire_date


orders
id (Clé primaire)
customer_id (Clé étrangère de users)
order_date
total_amount
status
user_id (Clé étrangère de users)
cart_id (Clé étrangère de carts)


invoices
id (Clé primaire)
montant
tax
users_id (Clé étrangère de users)


invoice_elements
id (Clé primaire)
invoice_id (Clé étrangère de invoices)
stocks_id (Clé étrangère de stocks)


connection_history
id (Clé primaire)
login_date
logout_date
onsite_time
user_id (Clé étrangère de users)
sad adsaa

-- Question 2
Ligne 12 (SET FOREIGN_KEY_CHECKS = 0;):  Désactive la vérification des clés étrangères, permettant des modifications sans contrainte.
Ligne 440 (SET FOREIGN_KEY_CHECKS = 1;):Réactive la vérification des clés étrangères pour assurer lintégrité des données.

-- Question 3
CREATE USER 'pharma'@'localhost' IDENTIFIED BY '1234';

-- Question 4
SELECT CONCAT(firstname, ' ', lastname) AS full_name, SEC_TO_TIME(AVG(TIME_TO_SEC(onsite_time))) AS average_onsite_time
FROM users
JOIN connection_history ON users.id = connection_history.user_id
GROUP BY users.id;

-- Question 5
SELECT roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id
JOIN (
    SELECT user_id, SUM(TIME_TO_SEC(onsite_time)) AS total_onsite_time
    FROM connection_history
    GROUP BY user_id
    ORDER BY total_onsite_time DESC
    LIMIT 1
) AS max_time_user ON users.id = max_time_user.user_id;

-- Question 6 
SELECT s.name AS supplier_name, p.name AS product_name, COUNT(*) AS total_sold
FROM orders o
JOIN carts c ON o.cart_id = c.id
JOIN cart_product cp ON c.id = cp.cart_id
JOIN products p ON cp.product_id = p.id
JOIN suppliers s ON p.supplier_id = s.id
GROUP BY s.name, p.name
ORDER BY total_sold DESC
LIMIT 3;

-- Question 7
SELECT w.name AS warehouse_name, SUM(o.total_amount) AS total_revenue
FROM orders o
JOIN carts c ON o.cart_id = c.id
JOIN cart_product cp ON c.id = cp.cart_id
JOIN products p ON cp.product_id = p.id
JOIN warehouses w ON p.warehouse_id = w.id
GROUP BY w.name;

-- Question 8
UPDATE products
SET image = 'medoc.jpg'
WHERE description LIKE '%médicaux';

-- Question 9
ALTER TABLE users
ADD COLUMN gender ENUM('MALE', 'FEMALE', 'OTHER') DEFAULT 'OTHER';

-- Question 10
DELIMITER //
CREATE PROCEDURE spProfileImage()
BEGIN
    UPDATE users
    SET image = CASE
        WHEN gender = 'MALE' THEN 'male.jpg'
        WHEN gender = 'FEMALE' THEN 'female.jpg'
        ELSE 'other.jpg'
    END
    WHERE image IS NULL;
END//
DELIMITER ;

-- Question 11
ALTER TABLE users
ADD CONSTRAINT unique_email UNIQUE (email);

-- 12. Insertion de données.
use epharmacy;
start transaction;
INSERT INTO users (firstname, lastname, password,adress, city, province, country, postal_code,phone, email,role_id, gender,image) 
VALUES ('Alain', 'Foka', '',"72 McLaughlin Dr", "Moncton", "New-Brunswick", "Canada", "E1A2LP", "7154365275",'AlainFoka@email.com',"3", "MALE", "male.jpg");

INSERT INTO cart_product (cart_id, product_id, quantity, total, tax, quantity_remainder)
VALUES
(1, 1, 4, 40, 4, 4),
(1, 2, 5, 25, 2.5, 5),
(1, 3, 7, 70, 7, 7),
(2, 4, 5, 50, 5, 5),
(2, 5, 3, 30, 3, 3),
(2, 6, 4, 40, 4, 4),
(3, 7, 1, 10, 1, 1),
(3, 8, 2, 20, 2, 2),
(3, 9, 10, 100, 10, 10);

INSERT INTO invoices (montant, tax, users_id)
VALUES
((SELECT SUM(total) FROM cart_product WHERE cart_id = 1), 0.1, 4),
((SELECT SUM(total) FROM cart_product WHERE cart_id = 2), 0.1, 7),
((SELECT SUM(total) FROM cart_product WHERE cart_id = 3), 0.1, 4);

INSERT INTO connection_history (login_date, logout_date, onsite_time, user_id)
VALUES
(NOW(), NOW(), '00:30:00', 4),
(NOW(), NOW(), '00:45:00', 7),
(NOW(), NOW(), '01:00:00', 4);

INSERT INTO carts (user_id, actif)
VALUES
(4, 1),
(7, 1),
(4, 1);

INSERT INTO orders (customer_id, order_date, total_amount, status, user_id, cart_id)
VALUES -- le id de mohammed est 2
(4, NOW(), (SELECT SUM(total) FROM cart_product WHERE cart_id = 1), 1, 2, 1),
(7, NOW(), (SELECT SUM(total) FROM cart_product WHERE cart_id = 2), 1, 2, 2),
(4, NOW(), (SELECT SUM(total) FROM cart_product WHERE cart_id = 3), 1, 2, 3);

commit;

-- 13. modification des donnees
UPDATE users SET
designation = 'RH',
adress = '1750 Rue Crevier',
province = 'QC',
postal_code = 'H4L2X5',
phone = '5665954526',
email = 'Oumar@gmail.com'
WHERE firstname = 'Oumar' AND lastname = 'Moussa';

UPDATE users SET
designation = 'Comptable',
adress = '415 Av. de l’Université',
province = 'NB',
postal_code = 'E1A3E9',
phone = '4065954526',
email = 'Ali@ccnb.ca'
WHERE firstname = 'Ali' AND lastname = 'Sani';

UPDATE users SET
designation = 'Consultant',
adress = '674 Van horne',
province = 'NS',
postal_code = 'B4V4V5',
phone = '7854665265',
email = 'Foka@ccnb.ca'
WHERE firstname = 'Dupont' AND lastname = 'Poupi';