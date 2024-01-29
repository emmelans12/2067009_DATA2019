-- question 1
SELECT title, price
FROM titles
WHERE title LIKE '%computer%';

-- question 2
SELECT title, price
FROM titles
WHERE title LIKE '%computer%'
AND title NOT LIKE '%computers%';

-- question 3
SELECT title, price
FROM titles
WHERE title LIKE '%SU%' OR title LIKE 'BU%';


-- question 4
SELECT title, price
FROM titles
WHERE title not like 'SU%' and title not like 'BU%';

-- question 5 

SELECT title, price
FROM titles
WHERE (title NOT LIKE 'S%' AND tilte NOT LIKE 'B%') AND title LIKE '_o%';

-- question 6
SELECT title, price
FROM titles
WHERE (title NOT LIKE 'S%' AND title NOT LIKE 'B%') AND title LIKE '_f%' ;

-- question 7
SELECT title, price
FROM titles
WHERE title LIKE 'A%' OR title LIKE 'B%' OR title LIKE 'C%' OR
title LIKE 'D%' OR title LIKE 'E%' OR title LIKE 'F%' OR
title LIKE 'G%' OR title LIKE 'H%' OR title LIKE 'I%' OR
title LIKE 'J%';
