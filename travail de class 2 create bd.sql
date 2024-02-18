use library2;

CREATE TABLE if not exists jobs (
job_id VARCHAR(100) NOT NULL PRIMARY KEY,
job_desc VARCHAR(100) UNIQUE NOT NULL,
min_lvl VARCHAR(50) NULL,
max_lvl VARCHAR(50) NULL

);

CREATE TABLE IF NOT EXISTS publishers (
pub_id tinyint NOT NULL PRIMARY KEY,
pub_name VARCHAR(100) NOT NULL,
city VARCHAR(30) NOT NULL,
state VARCHAR(30) NULL,
country VARCHAR(30) NULL

);

CREATE TABLE  IF NOT EXISTS  employees (
emp_id int(11) not null primary key,
fname varchar(100) null,
lname varchar(100) null,
job_id int(11) null references publishers (job_id),
job_lvl enum('STAGIAIRE','JUNIOR','INTERMEDIARE','SEINIOR'),
pub_id int(11) null references publishers (pub_id),
hire_date date null,
salary int(2) UNSIGNED null

);

CREATE TABLE IF NOT EXISTS authors (
  au_id int(11),
  au_fname varchar(100),
  au_lname varchar(100),
  phone varchar(20),
  address varchar(100),
  city varchar(100),
  state varchar(100),
  zip varchar(10),
contract int(11) 

);

CREATE TABLE   IF NOT EXISTS  stores (
  stor_id int(11) NOT NULL,
  stor_name varchar(255) NULL,
  stor_address varchar(255) NULL,
  city varchar(255) NULL,
  state varchar(55) NULL,
  zip varchar(8) NULL
  
  );

CREATE TABLE  IF NOT EXISTS  sales (
  stor_id int(11) NOT NULL,
  ord_num int(11) NOT NULL,
  title_id int(11) NOT NULL,
  ord_date date NULL,
  qty int(11) NULL,
  paytemrs varchar(255)NUll
  
  );
  
  CREATE TABLE  IF NOT EXISTS  titleauthor (
  au_id int(11) NOT NULL,
  title_id int(11) NOT NULL,
  au_ord int(2) NULL,
  royaltyper int(11) NULL
  
  );
  
  
