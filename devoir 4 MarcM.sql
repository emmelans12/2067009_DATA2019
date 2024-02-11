-- devoir 4
USE library;

-- exercise 1 (Obtenir la liste des auteurs dont l’éditeur « Harmattan » n’a publié aucun livre)

SELECT au_id, au_fname, au_lname
FROM authors
WHERE au_id NOT IN (
    SELECT DISTINCT au_id
    FROM titleauthor
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN publishers ON titles.pub_id = publishers.pub_id
    WHERE publishers.pub_name = 'Harmattan'
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

