-- devoir 4
USE library;

-- exercise 1 (Obtenir la liste des auteurs dont l’éditeur « Harmattan » n’a publié aucun livre)
SELECT DISTINCT a.au_fname, a.au_lname
FROM authors a
WHERE NOT EXISTS (
    SELECT 1
    FROM titleauthor ta
    JOIN titles t ON ta.title_id = t.title_id
    JOIN publishers p ON t.pub_id = p.pub_id
    WHERE p.pub_name = 'Harmattan' AND a.au_id = ta.au_id
);

-- Exercise 2 (Obtenir la liste des auteurs dont l’éditeur «Eyrolles » a publié tous les livres)

SELECT DISTINCT
    a.au_id,
    a.au_fname,
    a.au_lname
FROM
    authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id = t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
WHERE
    p.pub_name = 'Eyrolles';



-- Exercise 3 (Obtenir la liste des noms d'auteurs ayant touché une avance supérieure à toutes les avances versées par l'éditeur "Harmattan".


SELECT au_fname, au_lname
FROM authors
WHERE au_id IN (
    SELECT au_id
    FROM titleauthor AS ta
    JOIN titles as t ON ta.title_id = t.title_id
    WHERE advance > ALL (
        SELECT advance
        FROM titles AS t
        JOIN publishers AS p ON t.pub_id = p.pub_id
        WHERE pub_name = 'Harmattan'
    )
);