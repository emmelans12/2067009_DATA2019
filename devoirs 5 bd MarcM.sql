-- Create a new database
CREATE DATABASE Bookstore;

USE Bookstore;

-- Create the 'Authors' table
CREATE TABLE Authors (
  au_id INT AUTO_INCREMENT PRIMARY KEY,
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

-- Create the 'Publishers' table
CREATE TABLE Publishers (
  pub_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  email VARCHAR(50)
);
