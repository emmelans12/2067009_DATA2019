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
    
-- exercise 2 La liste des paires (auteur, éditeur) demeurant dans la même ville, incluant 
-- aussi les auteurs qui ne répondent pas à ce critère.
SELECT 
    a.au_fname AS AuthorFirstName, 
    a.au_lname AS AuthorLastName, 
    a.city AS City, 
    p.pub_name AS PublisherName
FROM authors a
LEFT JOIN publishers p ON a.city = p.city;


-- exercise 3 les éditeurs qui ne répondent pas à ce critère.
SELECT 
    p.pub_name AS PublisherName, 
    p.city AS City, 
    a.au_fname AS AuthorFirstName, 
    a.au_lname AS AuthorLastName
FROM publishers p
LEFT JOIN authors a ON p.city = a.city;

    
-- Exercise 4 La liste des paires (auteur, éditeur) demeurant dans la même ville, incluant les
-- auteurs et les éditeurs qui ne répondent pas à ce critère.

-- avec union pour auteurs et les éditeurs
SELECT 
    a.au_fname AS FirstName, 
    a.au_lname AS LastName, 
    a.city AS City, 
    'Author' AS Type,
    p.pub_name AS MatchingEntityName,
    'Publisher' AS MatchingEntityType
FROM authors a
LEFT JOIN publishers p ON a.city = p.city

UNION


SELECT 
    p.pub_name, 
    '' AS LastName,
    p.city, 
    'Publisher' AS Type,
    a.au_fname AS MatchingEntityFirstName,
    'Author' AS MatchingEntityType
FROM publishers p
LEFT JOIN authors a ON p.city = a.city

-- Exercise 5