-- devoir 3 Marc
USE library;

-- exercise 1 La liste des paires (auteur, éditeur) demeurant dans la même ville.
SELECT 
    a.au_fname AS AuthorFirstName, 
    a.au_lname AS AuthorLastName, 
    p.pub_name AS PublisherName, 
    a.city AS City
FROM 
    authors a
JOIN 
    publishers p ON a.city = p.city
ORDER BY 
    a.city;

