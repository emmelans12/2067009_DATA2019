-- new database
CREATE DATABASE Bookstore;


USE Bookstore;

-- La 'Authors' table
CREATE TABLE Authors (
  au_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  au_name VARCHAR(50),
  phone VARCHAR(20),
  address VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  zip VARCHAR(6),
  contract TEXT,
  email VARCHAR(50)
);

-- La 'Publishers' table
CREATE TABLE Publishers (
  pub_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  email VARCHAR(50)
);

-- La 'Employees' table
CREATE TABLE Employees (
  emp_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  family_name VARCHAR(50),
  name VARCHAR(50),
  pub_id SMALLINT,
  job_id SMALLINT,
  email VARCHAR(50),
  FOREIGN KEY (pub_id) REFERENCES Publishers(pub_id),
  FOREIGN KEY (job_id) REFERENCES Jobs(job_id)
);

-- La 'Jobs' table
CREATE TABLE Jobs (
  job_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  job_desc VARCHAR(50),
  min_lvl ENUM('Stagiaire', 'Junior', 'Intermediaire', 'Senior'),
  max_lvl ENUM('Stagiaire', 'Junior', 'Intermediaire', 'Senior')
);

-- La 'Redactions' table
CREATE TABLE Redactions (
  au_id TINYINT,
  title_id TINYINT,
  au_ord TINYINT,
  royalty FLOAT,
  PRIMARY KEY (au_id, title_id),
  FOREIGN KEY (au_id) REFERENCES Authors(au_id),
  FOREIGN KEY (title_id) REFERENCES Titles(title_id)
);

-- La 'Titles' table
CREATE TABLE Titles (
  title_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  type ENUM('Politique', 'Science', 'Histoire'),
  pub_id SMALLINT,
  price FLOAT,
  advance FLOAT,
  royalties FLOAT,
  pub_date DATE,
  FOREIGN KEY (pub_id) REFERENCES Publishers(pub_id)
);

--  La 'Sales' table
CREATE TABLE Sales (
  store_id TINYINT,
  ord_num VARCHAR(20),
  title_id TINYINT,
  ord_date DATETIME,
  qty INT,
  PRIMARY KEY (store_id, ord_num, title_id),
  FOREIGN KEY (store_id) REFERENCES Stores(store_id),
  FOREIGN KEY (title_id) REFERENCES Titles(title_id)
);

-- La 'Stores' table
CREATE TABLE Stores (
  stor_id TINYINT AUTO_INCREMENT PRIMARY KEY,
  stor_name VARCHAR(50),
  stor_address VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50)
);
