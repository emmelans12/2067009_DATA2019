-- devoirs 5 MarcM
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