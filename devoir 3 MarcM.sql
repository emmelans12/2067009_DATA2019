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
    publishers p ON a.city = p.city;

    
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
SELECT 
    a.au_fname AS FirstName,
    a.au_lname AS LastName,
    a.city AS City,
    'Author' AS Type,
    p.pub_name AS MatchingEntityName,
    'Publisher' AS MatchingEntityType
FROM
    authors a
        LEFT JOIN
    publishers p ON a.city = p.city 
    
UNION 

SELECT 
    p.pub_name,
    '' AS LastName,
    p.city,
    'Publisher' AS Type,
    a.au_fname AS MatchingEntityFirstName,
    'Author' AS MatchingEntityType
FROM
    publishers p
        LEFT JOIN
    authors a ON p.city = a.city;



-- Exercise 5 Effectif(nombre) d'employes par niveau d'experience
SELECT 
    job_lvl AS ExperienceLevel, 
    COUNT(emp_id) AS NumberOfEmployees
FROM 
    employees
GROUP BY 
    job_lvl;
    
    
-- Exercise 6 Liste des employes par maison d'edition
SELECT
    p.pub_name AS PublishingHouse,
    COUNT(e.emp_id) AS NumberOfEmployees
FROM
    employees e
JOIN
    publishers p ON e.pub_id = p.pub_id
GROUP BY
    p.pub_name;


-- Exercise 7 Salaires horaires moyens des employes par maison d'edition
SELECT 
	p.pub_name AS maison_edition, AVG(e.minit) AS moyenne_minit
FROM 
	employees e
JOIN 
	publishers p ON e.pub_id = p.pub_id
GROUP BY 
	p.pub_name;
    
    
-- Exercise 8 Effectif(nombre) d'employées de niveau SEINIOR par maison d'edition
SELECT 
    p.pub_name AS PublishingHouse,
    COUNT(e.emp_id) AS NumberOfSeniorEmployees
FROM 
    employees e
JOIN 
    publishers p ON e.pub_id = p.pub_id
WHERE 
    e.job_lvl = 'SEINIOR'
GROUP BY 
    p.pub_name

