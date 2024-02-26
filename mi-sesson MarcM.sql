-- 1. La liste des utilisateurs de l’application selon leur rôle. Le résultat doit avoir
-- la structure suivante (15 points) :
USE epharmacy;


SELECT User.full_name, Role.name AS Role
FROM User
JOIN Role ON User.role_id = Role.id
ORDER BY User.full_name;




-- 2. Noms et quantités des produits achetés par Oumar Moussa. Le résultat doit
-- avoir la structure suivante (20points) :

SELECT p.name AS NomProduit, ol.quantity AS Quantite
FROM user u
JOIN invoice i ON u.id = i.customer_id
JOIN orders o ON i.order_id = o.id
JOIN OrderLine ol ON ol.order_id = o.id
JOIN product p ON p.id = ol.product_id
WHERE u.full_name = 'Oumar Moussa';


-- 3.  Quel sont les noms de produits dont le fournisseur est basé à Moncton ? (25points)

SELECT p.name AS NomProduit
FROM product p
JOIN supplier s ON p.supplier_id = s.id
WHERE s.city = 'Moncton';


-- 4. Qui a passé le plus de temps une fois connecté dans l’application (10points) ?


-- 5- Quel est le dernier utilisateur à se déconnecter ? (10 points)
SELECT u.full_name AS NomUtilisateur
FROM user u
JOIN connection_history ch ON u.id = ch.user_id
ORDER BY ch.logout_date DESC
LIMIT 1;


