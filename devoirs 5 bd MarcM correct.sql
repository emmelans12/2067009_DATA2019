-- devoirs 5 MarcM*
USE bookstore;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Redactions;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Jobs;
DROP TABLE IF EXISTS Publishers;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Stores;

-- table de Authors
CREATE TABLE Authors (
  au_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  au_name VARCHAR(50),
  phone VARCHAR(20) UNIQUE CHECK (phone REGEXP '^\\+[0-9]{9,14}$'),
  address VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  zip VARCHAR(6) CHECK (zip REGEXP '^[A-Za-z][0-9][A-Za-z][0-9][A-Za-z][0-9]$'),
  contract TEXT,
  email VARCHAR(50) UNIQUE CHECK (email LIKE '%@%')
);

-- table de Publishers
CREATE TABLE Publishers (
  pub_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  email VARCHAR(50) UNIQUE CHECK (email LIKE '%@%')
);

-- table de Stores
CREATE TABLE Stores (
  stor_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  stor_name VARCHAR(50),
  stor_address VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50)
);

-- table de Jobs
CREATE TABLE Jobs (
  job_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  job_desc VARCHAR(50),
  min_lvl ENUM('Stagiaire', 'Junior', 'Intermediaire', 'Senior'),
  max_lvl ENUM('Stagiaire', 'Junior', 'Intermediaire', 'Senior')
);

--  table de Employees 
CREATE TABLE Employees (
  emp_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  family_name VARCHAR(50),
  name VARCHAR(50),
  pub_id TINYINT,
  job_id TINYINT,
  email VARCHAR(50) UNIQUE CHECK (email LIKE '%@%'),
  FOREIGN KEY (pub_id) REFERENCES Publishers(pub_id),
  FOREIGN KEY (job_id) REFERENCES Jobs(job_id)
);

CREATE TABLE Titles (
  title_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  type ENUM('Politique', 'Science', 'Histoire'),
  pub_id TINYINT,
  price FLOAT,
  advance FLOAT,
  royalty FLOAT,
  pub_date DATE,
  FOREIGN KEY (pub_id) REFERENCES Publishers(pub_id)
);

-- Table 'Redactions'
CREATE TABLE Redactions (
  au_id TINYINT,
  title_id TINYINT,
  au_ord TINYINT,
  royalty FLOAT,
  PRIMARY KEY (au_id, title_id),
  FOREIGN KEY (au_id) REFERENCES Authors(au_id),
  FOREIGN KEY (title_id) REFERENCES Titles(title_id)
);

CREATE TABLE Sales (
  store_id TINYINT,
  ord_num VARCHAR(20),
  title_id TINYINT,
  ord_date DATETIME,
  qty INT,
  payterms VARCHAR(12),
  PRIMARY KEY (store_id, ord_num, title_id),
  FOREIGN KEY (store_id) REFERENCES Stores(store_id),
  FOREIGN KEY (title_id) REFERENCES Titles(title_id)
);
