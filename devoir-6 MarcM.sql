-- Devoir-6 MarcM DATA1029
-- 1. Noms complets des employés de plus haut grade par employeurs.
use library;

SELECT 
    p.pub_name AS Publisher,
    CONCAT(e.fname, ' ', e.lname) AS FullName,
    e.job_lvl AS Grade
FROM employees e
JOIN publishers p ON e.pub_id = p.pub_id
INNER JOIN (
    SELECT pub_id, MAX(job_lvl) AS MaxGrade
    FROM employees
    GROUP BY pub_id
) AS max_grade ON e.pub_id = max_grade.pub_id AND e.job_lvl = max_grade.MaxGrade
ORDER BY p.pub_name, e.lname, e.fname;


-- 2. Noms complets des employés ayant un salaire supérieur à celui de Norbert Zongo.
SELECT 
    CONCAT(fname, ' ', lname) AS Full_Name,
    salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE fname = 'Norbert' AND lname = 'Zongo'
)
ORDER BY salary DESC;


-- 3. Noms complets des employés des éditeurs canadiens.
SELECT 
    CONCAT(e.fname, ' ', e.lname) AS Full_Name,
    p.pub_name AS Publisher,
    p.country AS Country
FROM employees e
JOIN publishers p ON e.pub_id = p.pub_id
WHERE p.country = 'Canada'
ORDER BY p.pub_name, Full_Name;


-- 4. Noms complets des employés qui ont un manager.
SELECT 
    CONCAT(e.fname, ' ', e.lname) AS Full_Name,
    e.job_lvl
FROM employees e
WHERE e.job_lvl <> (
    SELECT MAX(job_lvl) FROM employees
);


-- 5. Noms complets des employés qui ont un salaire au-dessus de la moyenne de
-- salaire chez leur employeur.
SELECT 
    e.fname AS FirstName,
    e.lname AS LastName,
    e.salary AS Salary,
    p.pub_name AS Publisher,
    AVG(e2.salary) OVER(PARTITION BY e.pub_id) AS AvgSalary
FROM employees e
JOIN publishers p ON e.pub_id = p.pub_id
JOIN employees e2 ON e.pub_id = e2.pub_id
GROUP BY e.emp_id, p.pub_name, e.salary
HAVING e.salary > AVG(e2.salary);


-- 6. Noms complets des employés qui ont le salaire minimum de leur grade.
SELECT 
    CONCAT(e.fname, ' ', e.lname) AS Full_Name,
    e.job_lvl AS Job_Level,
    e.salary AS Salary
FROM employees e
INNER JOIN (
    SELECT job_lvl, MIN(salary) AS MinSalary
    FROM employees
    GROUP BY job_lvl
) AS min_salaries ON e.job_lvl = min_salaries.job_lvl AND e.salary = min_salaries.MinSalary
ORDER BY e.job_lvl, Full_Name;


-- 7. De quels types sont les livres les plus vendus?
SELECT 
    t.type AS Book_Type,
    SUM(s.qty) AS Total_Sold
FROM sales s
JOIN titles t ON s.title_id = t.title_id
GROUP BY t.type
ORDER BY Total_Sold DESC;


-- 8. Pour chaque boutique, les 2 livres les plus vendus et leurs prix.
SELECT 
  stores.stor_name,
  titles.title,
  titles.price,
  total_sales.qty_sold
FROM (
    SELECT 
      sales.stor_id, 
      sales.title_id, 
      SUM(sales.qty) AS qty_sold,
      ROW_NUMBER() OVER (PARTITION BY sales.stor_id ORDER BY SUM(sales.qty) DESC) AS rn
    FROM sales
    GROUP BY sales.stor_id, sales.title_id
) AS total_sales
JOIN titles ON total_sales.title_id = titles.title_id
JOIN stores ON total_sales.stor_id = stores.stor_id
WHERE total_sales.rn <= 2
ORDER BY stores.stor_name, total_sales.qty_sold DESC;


-- 9. Les auteurs des 5 livres les plus vendus. 
SELECT 
    t.title, 
    a.au_fname, 
    a.au_lname, 
    SUM(s.qty) AS TotalSales
FROM sales s
JOIN titles t ON s.title_id = t.title_id
JOIN titleauthor ta ON t.title_id = ta.title_id
JOIN authors a ON ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id
ORDER BY TotalSales DESC
LIMIT 5;


-- 10. Prix moyens des livres par maisons d’édition.
SELECT publishers.pub_name, AVG(titles.price) AS avg_price
FROM titles
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY avg_price DESC;


-- 11. . Les 3 auteurs ayant les plus de livres
SELECT a.au_id, a.au_fname, a.au_lname, COUNT(ta.title_id) AS nombre_de_livres
FROM authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_fname, a.au_lname
ORDER BY nombre_de_livres DESC
LIMIT 3;
