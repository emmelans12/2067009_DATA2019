-- Question 2
SET FOREIGN_KEY_CHECKS = 0;

-- Question 3 
CREATE USER 'pharma'@'localhost' IDENTIFIED BY '1234';

-- Question 11 
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);

-- Question 12: 
START TRANSACTION;

INSERT INTO users (firstname, lastname, password, adress, city, province, country, postal_code, phone, email, role_id, gender, image) 
VALUES ('Alain', 'Foka', '', "72 McLaughlin Dr", "Moncton", "New-Brunswick", "Canada", "E1A2LP", "7154365275", 'AlainFoka@email.com', "3", "MALE", "male.jpg");

COMMIT;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, total_amount, status, user_id, cart_id)
VALUES
(4, NOW(), (SELECT SUM(total) FROM cart_product WHERE cart_id = 1), 1, 2, 1),
(7, NOW(), (SELECT SUM(total) FROM cart_product WHERE cart_id = 2), 1, 2, 2),
(4, NOW(), (SELECT SUM(total) FROM cart_product WHERE cart_id = 3), 1, 2, 3);

COMMIT;

START TRANSACTION;

INSERT INTO invoices (montant, tax, users_id)
VALUES
((SELECT SUM(total) FROM cart_product WHERE cart_id = 1), 0.1, 4),
((SELECT SUM(total) FROM cart_product WHERE cart_id = 2), 0.1, 7),
((SELECT SUM(total) FROM cart_product WHERE cart_id = 3), 0.1, 4);

COMMIT;


GRANT ALL PRIVILEGES ON epharmacy.* TO 'pharma'@'localhost';

SET FOREIGN_KEY_CHECKS = 1;
