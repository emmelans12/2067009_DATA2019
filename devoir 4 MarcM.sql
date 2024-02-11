-- devoir 4 Marc oblier de push git
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

SELECT DISTINCT au_id, au_fname, au_lname
FROM authors
WHERE au_id IN (
    SELECT DISTINCT au_id
    FROM titleauthor
    INNER JOIN titles ON titleauthor.title_id = titles.title_id
    INNER JOIN publishers ON titles.pub_id = publishers.pub_id
    WHERE publishers.pub_name = 'Eyrolles'
);


-- Exercise 3 (Obtenir la liste des noms d'auteurs ayant touché une avance supérieure à toutes les avances versées par l'éditeur "Harmattan".

SELECT au_fname, au_lname
FROM authors
WHERE (
    SELECT MAX(advance)
    FROM titles
    WHERE pub_id = (SELECT pub_id FROM publishers WHERE pub_name = 'Harmattan')
) < ALL (
    SELECT advance
    FROM titles
    WHERE pub_id = (SELECT pub_id FROM publishers WHERE pub_name = 'Harmattan')
    AND title_id IN (
        SELECT title_id
        FROM titleauthor
        WHERE au_id = authors.au_id
    )
);
