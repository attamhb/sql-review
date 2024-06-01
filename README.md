# A Review/Cheat-Sheet of Important Commands
This is a review of important SQL commands

## What is SQL 
SQL or Structured Query Language was initially developed to generate, manipulate and retrieve data from relational databases.

## Why SQL?
SQL has stood the test of time, and will continue to do so despite the emergence of new languages/frameworks built for the same purpose. A *database* is an organized collection of accessible data that is (electronically) stored. A *relational database* stores the data into several tables and provides access to data points that are related to one another.
  
## Road Map

1. Set up working environment
2. Create your own database, manipulate the date, update the database and retrieve data from it.
3. Explore the types of data such as, numerical data, strings and temporal data etc.
4. *SELECT* statement.
5. Filtering conditions 
6. Dealing with multiple tables 
7. Generating and manipulating data
8. Grouping and Aggregates
9. Subqueries
10. 
11. 
# SQL Working Environment

# ... 

## Sakila Database
- Download Databas
- Source SQL files
-  

Checking all the table names in the database, 
```sql 
SHOW TABLES;
```

```sql
+----------------------------+
| Tables_in_sakila           |
+----------------------------+
| actor                      |
| actor_info                 |
| address                    |
| category                   |
| city                       |
| country                    |
| customer                   |
| customer_list              |
| film                       |
| film_actor                 |
| film_category              |
| film_list                  |
| film_text                  |
| inventory                  |
| language                   |
| nicer_but_slower_film_list |
| payment                    |
| rental                     |
| sales_by_film_category     |
| sales_by_store             |
| staff                      |
| staff_list                 |
| store                      |
+----------------------------+
23 rows in set (0.000 sec)
```

We have 23 tables, and will see what is stored in each one by one, and we will also find out how they are interlinked.

Lets check the first table with the name actor with DESC command:

```sql
MariaDB [sakila]> DESC actor;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| actor_id    | smallint(5) unsigned | NO   | PRI | NULL                | auto_increment                |
| first_name  | varchar(45)          | NO   |     | NULL                |                               |
| last_name   | varchar(45)          | NO   | MUL | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
4 rows in set (0.000 sec)

```
Notice that actor_id is the primary key with aut_increment and cannot be NULL. 
last_name with MUL key?

```sql
MariaDB [sakila]> DESC actor_info;
+------------+----------------------+------+-----+---------+-------+
| Field      | Type                 | Null | Key | Default | Extra |
+------------+----------------------+------+-----+---------+-------+
| actor_id   | smallint(5) unsigned | NO   |     | 0       |       |
| first_name | varchar(45)          | NO   |     | NULL    |       |
| last_name  | varchar(45)          | NO   |     | NULL    |       |
| film_info  | mediumtext           | YES  |     | NULL    |       |
+------------+----------------------+------+-----+---------+-------+
4 rows in set (0.001 sec)

```

One difference between actor and actor_info tables is that the first one has last_update column while the second one film_info column.  Both have actor_id, first_name, and last_name columns. But the actor_id in actor_info is not the primary key. 


```sql

MariaDB [sakila]> DESC address;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| address_id  | smallint(5) unsigned | NO   | PRI | NULL                | auto_increment                |
| address     | varchar(50)          | NO   |     | NULL                |                               |
| address2    | varchar(50)          | YES  |     | NULL                |                               |
| district    | varchar(20)          | NO   |     | NULL                |                               |
| city_id     | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| postal_code | varchar(10)          | YES  |     | NULL                |                               |
| phone       | varchar(20)          | NO   |     | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
8 rows in set (0.000 sec)

```
address_id is the primary key with auto_increment. Appearantly no connection of address_id with actor and actor_list. This is more likely related with customers.   
```sql
MariaDB [sakila]> DESC category;

+-------------+---------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                | Null | Key | Default             | Extra                         |
+-------------+---------------------+------+-----+---------------------+-------------------------------+
| category_id | tinyint(3) unsigned | NO   | PRI | NULL                | auto_increment                |
| name        | varchar(25)         | NO   |     | NULL                |                               |
| last_update | timestamp           | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+---------------------+------+-----+---------------------+-------------------------------+
3 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC city;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| city_id     | smallint(5) unsigned | NO   | PRI | NULL                | auto_increment                |
| city        | varchar(50)          | NO   |     | NULL                |                               |
| country_id  | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
4 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC country;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| country_id  | smallint(5) unsigned | NO   | PRI | NULL                | auto_increment                |
| country     | varchar(50)          | NO   |     | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
3 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC customer;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| customer_id | smallint(5) unsigned | NO   | PRI | NULL                | auto_increment                |
| store_id    | tinyint(3) unsigned  | NO   | MUL | NULL                |                               |
| first_name  | varchar(45)          | NO   |     | NULL                |                               |
| last_name   | varchar(45)          | NO   | MUL | NULL                |                               |
| email       | varchar(50)          | YES  |     | NULL                |                               |
| address_id  | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| active      | tinyint(1)           | NO   |     | 1                   |                               |
| create_date | datetime             | NO   |     | NULL                |                               |
| last_update | timestamp            | YES  |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
9 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC customer_list;
+----------+----------------------+------+-----+---------+-------+
| Field    | Type                 | Null | Key | Default | Extra |
+----------+----------------------+------+-----+---------+-------+
| ID       | smallint(5) unsigned | NO   |     | 0       |       |
| name     | varchar(91)          | YES  |     | NULL    |       |
| address  | varchar(50)          | NO   |     | NULL    |       |
| zip code | varchar(10)          | YES  |     | NULL    |       |
| phone    | varchar(20)          | NO   |     | NULL    |       |
| city     | varchar(50)          | NO   |     | NULL    |       |
| country  | varchar(50)          | NO   |     | NULL    |       |
| notes    | varchar(6)           | NO   |     |         |       |
| SID      | tinyint(3) unsigned  | NO   |     | NULL    |       |
+----------+----------------------+------+-----+---------+-------+
9 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC film;
+----------------------+---------------------------------------------------------------------+------+-----+---------------------+-------------------------------+
| Field                | Type                                                                | Null | Key | Default             | Extra                         |
+----------------------+---------------------------------------------------------------------+------+-----+---------------------+-------------------------------+
| film_id              | smallint(5) unsigned                                                | NO   | PRI | NULL                | auto_increment                |
| title                | varchar(128)                                                        | NO   | MUL | NULL                |                               |
| description          | text                                                                | YES  |     | NULL                |                               |
| release_year         | year(4)                                                             | YES  |     | NULL                |                               |
| language_id          | tinyint(3) unsigned                                                 | NO   | MUL | NULL                |                               |
| original_language_id | tinyint(3) unsigned                                                 | YES  | MUL | NULL                |                               |
| rental_duration      | tinyint(3) unsigned                                                 | NO   |     | 3                   |                               |
| rental_rate          | decimal(4,2)                                                        | NO   |     | 4.99                |                               |
| length               | smallint(5) unsigned                                                | YES  |     | NULL                |                               |
| replacement_cost     | decimal(5,2)                                                        | NO   |     | 19.99               |                               |
| rating               | enum('G','PG','PG-13','R','NC-17')                                  | YES  |     | G                   |                               |
| special_features     | set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') | YES  |     | NULL                |                               |
| last_update          | timestamp                                                           | NO   |     | current_timestamp() | on update current_timestamp() |
+----------------------+---------------------------------------------------------------------+------+-----+---------------------+-------------------------------+
13 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC film_actor;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| actor_id    | smallint(5) unsigned | NO   | PRI | NULL                |                               |
| film_id     | smallint(5) unsigned | NO   | PRI | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
3 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC film_category;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| film_id     | smallint(5) unsigned | NO   | PRI | NULL                |                               |
| category_id | tinyint(3) unsigned  | NO   | PRI | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
3 rows in set (0.000 sec)

```




```sql

MariaDB [sakila]> DESC film_list;
+-------------+------------------------------------+------+-----+---------+-------+
| Field       | Type                               | Null | Key | Default | Extra |
+-------------+------------------------------------+------+-----+---------+-------+
| FID         | smallint(5) unsigned               | NO   |     | 0       |       |
| title       | varchar(128)                       | NO   |     | NULL    |       |
| description | text                               | YES  |     | NULL    |       |
| category    | varchar(25)                        | YES  |     | NULL    |       |
| price       | decimal(4,2)                       | NO   |     | 4.99    |       |
| length      | smallint(5) unsigned               | YES  |     | NULL    |       |
| rating      | enum('G','PG','PG-13','R','NC-17') | YES  |     | G       |       |
| actors      | mediumtext                         | YES  |     | NULL    |       |
+-------------+------------------------------------+------+-----+---------+-------+
8 rows in set (0.001 sec)

```




```sql
MariaDB [sakila]> DESC film_text;
+-------------+----------------------+------+-----+---------+-------+
| Field       | Type                 | Null | Key | Default | Extra |
+-------------+----------------------+------+-----+---------+-------+
| film_id     | smallint(5) unsigned | NO   | PRI | NULL    |       |
| title       | varchar(255)         | NO   | MUL | NULL    |       |
| description | text                 | YES  |     | NULL    |       |
+-------------+----------------------+------+-----+---------+-------+
3 rows in set (0.000 sec)


```




```sql
MariaDB [sakila]> DESC inventory;
+--------------+-----------------------+------+-----+---------------------+-------------------------------+
| Field        | Type                  | Null | Key | Default             | Extra                         |
+--------------+-----------------------+------+-----+---------------------+-------------------------------+
| inventory_id | mediumint(8) unsigned | NO   | PRI | NULL                | auto_increment                |
| film_id      | smallint(5) unsigned  | NO   | MUL | NULL                |                               |
| store_id     | tinyint(3) unsigned   | NO   | MUL | NULL                |                               |
| last_update  | timestamp             | NO   |     | current_timestamp() | on update current_timestamp() |
+--------------+-----------------------+------+-----+---------------------+-------------------------------+
4 rows in set (0.000 sec)

```




```sql
MariaDB [sakila]> DESC language;
+-------------+---------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                | Null | Key | Default             | Extra                         |
+-------------+---------------------+------+-----+---------------------+-------------------------------+
| language_id | tinyint(3) unsigned | NO   | PRI | NULL                | auto_increment                |
| name        | char(20)            | NO   |     | NULL                |                               |
| last_update | timestamp           | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+---------------------+------+-----+---------------------+-------------------------------+
3 rows in set (0.000 sec)

```


```sql
MariaDB [sakila]> DESC nicer_but_slower_film_list;
+-------------+------------------------------------+------+-----+---------+-------+
| Field       | Type                               | Null | Key | Default | Extra |
+-------------+------------------------------------+------+-----+---------+-------+
| FID         | smallint(5) unsigned               | NO   |     | 0       |       |
| title       | varchar(128)                       | NO   |     | NULL    |       |
| description | text                               | YES  |     | NULL    |       |
| category    | varchar(25)                        | YES  |     | NULL    |       |
| price       | decimal(4,2)                       | NO   |     | 4.99    |       |
| length      | smallint(5) unsigned               | YES  |     | NULL    |       |
| rating      | enum('G','PG','PG-13','R','NC-17') | YES  |     | G       |       |
| actors      | mediumtext                         | YES  |     | NULL    |       |
+-------------+------------------------------------+------+-----+---------+-------+
8 rows in set (0.001 sec)

```

```sql
MariaDB [sakila]> DESC payment;
+--------------+----------------------+------+-----+---------------------+-------------------------------+
| Field        | Type                 | Null | Key | Default             | Extra                         |
+--------------+----------------------+------+-----+---------------------+-------------------------------+
| payment_id   | smallint(5) unsigned | NO   | PRI | NULL                | auto_increment                |
| customer_id  | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| staff_id     | tinyint(3) unsigned  | NO   | MUL | NULL                |                               |
| rental_id    | int(11)              | YES  | MUL | NULL                |                               |
| amount       | decimal(5,2)         | NO   |     | NULL                |                               |
| payment_date | datetime             | NO   |     | NULL                |                               |
| last_update  | timestamp            | YES  |     | current_timestamp() | on update current_timestamp() |
+--------------+----------------------+------+-----+---------------------+-------------------------------+
7 rows in set (0.000 sec)


```
```sql
MariaDB [sakila]> DESC rental;
+--------------+-----------------------+------+-----+---------------------+-------------------------------+
| Field        | Type                  | Null | Key | Default             | Extra                         |
+--------------+-----------------------+------+-----+---------------------+-------------------------------+
| rental_id    | int(11)               | NO   | PRI | NULL                | auto_increment                |
| rental_date  | datetime              | NO   | MUL | NULL                |                               |
| inventory_id | mediumint(8) unsigned | NO   | MUL | NULL                |                               |
| customer_id  | smallint(5) unsigned  | NO   | MUL | NULL                |                               |
| return_date  | datetime              | YES  |     | NULL                |                               |
| staff_id     | tinyint(3) unsigned   | NO   | MUL | NULL                |                               |
| last_update  | timestamp             | NO   |     | current_timestamp() | on update current_timestamp() |
+--------------+-----------------------+------+-----+---------------------+-------------------------------+
7 rows in set (0.000 sec)

```
```sql
MariaDB [sakila]> DESC sales_by_film_category;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| category    | varchar(25)   | NO   |     | NULL    |       |
| total_sales | decimal(27,2) | YES  |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+
2 rows in set (0.001 sec)



```
```sql

MariaDB [sakila]> DESC sales_by_store;
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| store       | varchar(101)  | YES  |     | NULL    |       |
| manager     | varchar(91)   | YES  |     | NULL    |       |
| total_sales | decimal(27,2) | YES  |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+
3 rows in set (0.001 sec)




```
```sql
MariaDB [sakila]> DESC staff;
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| Field       | Type                 | Null | Key | Default             | Extra                         |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
| staff_id    | tinyint(3) unsigned  | NO   | PRI | NULL                | auto_increment                |
| first_name  | varchar(45)          | NO   |     | NULL                |                               |
| last_name   | varchar(45)          | NO   |     | NULL                |                               |
| address_id  | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| picture     | blob                 | YES  |     | NULL                |                               |
| email       | varchar(50)          | YES  |     | NULL                |                               |
| store_id    | tinyint(3) unsigned  | NO   | MUL | NULL                |                               |
| active      | tinyint(1)           | NO   |     | 1                   |                               |
| username    | varchar(16)          | NO   |     | NULL                |                               |
| password    | varchar(40)          | YES  |     | NULL                |                               |
| last_update | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+-------------+----------------------+------+-----+---------------------+-------------------------------+
11 rows in set (0.000 sec)




```
```sql



MariaDB [sakila]> DESC staff_list;
+----------+---------------------+------+-----+---------+-------+
| Field    | Type                | Null | Key | Default | Extra |
+----------+---------------------+------+-----+---------+-------+
| ID       | tinyint(3) unsigned | NO   |     | 0       |       |
| name     | varchar(91)         | YES  |     | NULL    |       |
| address  | varchar(50)         | NO   |     | NULL    |       |
| zip code | varchar(10)         | YES  |     | NULL    |       |
| phone    | varchar(20)         | NO   |     | NULL    |       |
| city     | varchar(50)         | NO   |     | NULL    |       |
| country  | varchar(50)         | NO   |     | NULL    |       |
| SID      | tinyint(3) unsigned | NO   |     | NULL    |       |
+----------+---------------------+------+-----+---------+-------+
8 rows in set (0.000 sec)


```
```sql
MariaDB [sakila]> DESC store;
+------------------+----------------------+------+-----+---------------------+-------------------------------+
| Field            | Type                 | Null | Key | Default             | Extra                         |
+------------------+----------------------+------+-----+---------------------+-------------------------------+
| store_id         | tinyint(3) unsigned  | NO   | PRI | NULL                | auto_increment                |
| manager_staff_id | tinyint(3) unsigned  | NO   | UNI | NULL                |                               |
| address_id       | smallint(5) unsigned | NO   | MUL | NULL                |                               |
| last_update      | timestamp            | NO   |     | current_timestamp() | on update current_timestamp() |
+------------------+----------------------+------+-----+---------------------+-------------------------------+
4 rows in set (0.000 sec)



```
```sql



```

[beaulieu , Alan. *Reference  Learning SQL*. O'REILLY.](https://www.amazon.com/Learning-SQL-Generate-Manipulate-Retrieve/dp/1492057614)

[DEBAROS, ANTHONY. *Practical SQL*. No Starch Press](https://www.amazon.com/Practical-SQL-Beginners-Guide-Storytelling/dp/1593278276)




## Metadata
E.g. information about the structure, organization, and constraints of the data. 
 
## Schema Information
### Tables
Names, columns, data types, constraints (e.g., primary keys, foreign keys, unique constraints), and relationships between tables.
### Views
Definitions of views including the SQL queries that define them.
### Indexes 
Information about indexes, including which columns are indexed and the type of index (e.g., B-tree, hash).
## Columns

### Column Names 
### Data Types 
INTEGER, VARCHAR, DATE.
### Default Values 
Default values assigned to columns.
### Constraints
Constraints applied to columns, such as NOT NULL, UNIQUE, CHECK constraints.

## Keys and Relationships:

### Primary Keys 
Columns that uniquely identify rows in a table.
### Foreign Keys 
Columns that establish relationships between tables.
### Unique Keys
Columns that must contain unique values across rows.



## Procedures and Functions:

### Stored Procedures 
Definitions and parameters of stored procedures.
### User-Defined Functions 
Definitions and parameters of functions.

## Triggers

### Trigger Information: 
Definitions of triggers, including the timing (BEFORE, AFTER) and the events (INSERT, UPDATE, DELETE) that activate them.

## Security and Permissions:

### Users and Roles: Information about users, roles, and their permissions.
Privileges: Specific privileges granted to users or roles on database objects (e.g., SELECT, INSERT, UPDATE, DELETE privileges).

## Database Properties:

### Database Name: The name of the database.
### Character Set: The character set used in the database.
### Collation: The collation settings used for sorting and comparing textual data.

## Storage Information:

### Tablespaces: Information about tablespaces, which are logical storage units within the database.
### Files: Details about the physical files that store the database data.
In SQL, metadata is typically accessed using system catalog tables or views. Different SQL database management systems (DBMS) have their own specific system tables or views for accessing metadata. Here are examples from 
## some popular DBMS:

### MySQL: Information schema tables such as information_schema.tables, information_schema.columns, and others.
### PostgreSQL: System catalog tables such as pg_tables, pg_class, pg_attribute, and others.
### SQL Server: System views like INFORMATION_SCHEMA.TABLES, INFORMATION_SCHEMA.COLUMNS, and others.


# Analytic Function

## Analytic Functions or Window Functions
Perform calculations across a set of table rows that are somehow related to the current row. 
They allow you to perform complex calculations like moving averages, running totals, and cumulative sums. 

## Common analytic functions include:
### ROW_NUMBER(): Assigns a unique number to each row within a partition.
### RANK(): Assigns a rank to each row within a partition, with gaps in ranking when there are ties.
### DENSE_RANK(): Similar to RANK(), but without gaps in the ranking sequence.
### NTILE(n): Divides the result set into n approximately equal groups.
### LAG(): Accesses data from a previous row in the same result set.
### LEAD(): Accesses data from a subsequent row in the same result set.


## DataWindows
A DataWindow is a powerful data access and presentation component that simplifies retrieving, displaying, and manipulating data from a database.

## Localized Sorting
Localized sorting refers to sorting data according to the rules and conventions of a specific locale or culture. This involves taking into account language-specific rules for character comparison, accents, and case sensitivity. In SQL databases, localized sorting is often controlled by setting the collation of the columns or the database.

## Ranking Functions
Ranking functions assign a rank to each row within a result set based on the values of one or more columns. Common ranking functions include:

## ROW_NUMBER(): Providewa unique number for each row.
### RANK(): Provides a rank with gaps for tied rows.
### DENSE_RANK(): Provides a rank without gaps.
### NTILE(n): Divides rows into n number of approximately equal groups.

## Generating Multi-Blue Ranking Reporting Functions
This term may refer to advanced reporting techniques where multiple ranking functions are used to produce complex ranking reports. These reports might display multiple ranking criteria or visualize rank-based data in a user-friendly way.

## Window Frames
A window frame in SQL defines the subset of rows to be used in a calculation for each row within the window function. This allows for more precise control over the data being analyzed. The window frame is specified using ROWS or RANGE and can be defined in various ways:

### ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
Includes all rows from the start of the partition to the current row.
### ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING 
Includes the previous row, the current row, and the next row.


## LAG and LEAD
### LAG(column, offset, default): Allows access to a value in a previous row without the need for a self-join.

## olumn Value Concatenation
Concatenating column values involves combining the values of multiple columns into a single column. This can be done using the CONCAT() function or the || operator (depending on the SQL dialect).




## Transactions
A sequence of one or more SQL operations treated as a single logical unit of work. 
A transaction must exhibit four key properties known as ACID properties:

1. *Atomicity:* Ensures that all operations within the transaction are completed successfully. If any operation fails, the entire transaction is rolled back.

```sql
-- Create the accounts table
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    balance INTEGER NOT NULL
);

-- Insert some initial data into the accounts table
INSERT INTO accounts (name, balance) VALUES ('Alice', 1000);
INSERT INTO accounts (name, balance) VALUES ('Bob', 500);

-- Begin a transaction
BEGIN TRANSACTION;

-- Try to transfer 200 from Alice's account to Bob's account
-- First, debit Alice's account

UPDATE accounts
SET balance = balance - 200
WHERE name = 'Alice';

-- Next, credit Bob's account
UPDATE accounts
SET balance = balance + 200
WHERE name = 'Bob';

-- Commit the transaction if both updates succeed
COMMIT;

```

2. *Consistency:* Ensures that a transaction transforms the database from one consistent state to another.

```sql
-- Create the accounts table
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    balance INTEGER NOT NULL CHECK (balance >= 0) -- Ensure balance is non-negative
);

-- Create the transactions table
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY,
    from_account INTEGER NOT NULL,
    to_account INTEGER NOT NULL,
    amount INTEGER NOT NULL CHECK (amount > 0), -- Ensure amount is positive
    FOREIGN KEY (from_account) REFERENCES accounts (id),
    FOREIGN KEY (to_account) REFERENCES accounts (id)
);

-- Insert initial data into the accounts table
INSERT INTO accounts (id, name, balance) VALUES (1, 'Alice', 1000);
INSERT INTO accounts (id, name, balance) VALUES (2, 'Bob', 500);
-- Begin a transaction
BEGIN TRANSACTION;

-- Try to transfer 200 from Alice's account (id=1) to Bob's account (id=2)
-- First, check if Alice has sufficient balance
UPDATE accounts
SET balance = balance - 200
WHERE id = 1;

-- Check if the update was successful and if Alice's balance is still non-negative
SELECT CASE
    WHEN (SELECT balance FROM accounts WHERE id = 1) < 0 THEN RAISE(ROLLBACK, 'Insufficient funds')
END;

-- If successful, credit Bob's account
UPDATE accounts
SET balance = balance + 200
WHERE id = 2;

-- Log the transaction in the transactions table
INSERT INTO transactions (from_account, to_account, amount)
VALUES (1, 2, 200);

-- Commit the transaction
COMMIT;

```




3. *Isolation:* Ensures that the intermediate state of a transaction is invisible to other transactions until it is complete.

Isolation Levels in SQL
  * Read Uncommitted: The lowest isolation level, where transactions can see uncommitted changes made by other transactions. This can lead to dirty reads.
  * Read Committed: Ensures that any data read is committed at the moment it is read. This prevents dirty reads but allows non-repeatable reads and phantom reads.
  * Repeatable Read: Ensures that if a transaction reads the same data multiple times, it will see the same values each time. This prevents dirty reads and non-repeatable reads but can still allow phantom reads.
  * Serializable: The highest isolation level, ensuring complete isolation from other transactions. This prevents dirty reads, non-repeatable reads, and phantom reads by ensuring that transactions are serializable (they appear to run sequentially).



```sql
-- Create the accounts table
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    balance INTEGER NOT NULL CHECK (balance >= 0) -- Ensure balance is non-negative
);

-- Insert some initial data into the accounts table
INSERT INTO accounts (id, name, balance) VALUES (1, 'Alice', 1000);
INSERT INTO accounts (id, name, balance) VALUES (2, 'Bob', 500);

BEGIN TRANSACTION;

-- T1: Debit Alice's account by 200
UPDATE accounts
SET balance = balance - 200
WHERE id = 1;

-- Simulate a delay (e.g., WAITFOR in SQL Server or a delay in the application)
-- This is to simulate a long-running transaction.
-- For SQLite, you might just wait in the application layer before committing.

-- Continue the transaction
-- T1: Credit Bob's account by 200
UPDATE accounts
SET balance = balance + 200
WHERE id = 2;

-- Commit the transaction
COMMIT;
BEGIN TRANSACTION;

-- T2: Read Alice's balance
SELECT balance
FROM accounts
WHERE id = 1;

-- Simulate some processing time or delay here

-- Commit or rollback transaction
COMMIT;
-- Set isolation level to Read Committed (default in many databases)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Begin Transaction 2
BEGIN TRANSACTION;

-- T2: Read Alice's balance (will see 1000 if T1 hasn't committed yet)
SELECT balance
FROM accounts
WHERE id = 1;

-- Commit Transaction 2
COMMIT;
-- Set isolation level to Serializable
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Begin Transaction 2
BEGIN TRANSACTION;

-- T2: Read Alice's balance (will wait if T1 is running)
SELECT balance
FROM accounts
WHERE id = 1;

-- Commit Transaction 2
COMMIT;

```

4. *Durability:* Ensures that once a transaction is committed, the changes are permanent, even in the case of a system failure.

```sql

```


## Locking
Locking is a mechanism used to control concurrent access to database resources to prevent conflicts and ensure data integrity. When a transaction accesses a database resource (e.g., a table or a row), it can acquire different types of locks:

### Shared Lock (S)
Allows multiple transactions to read a resource concurrently but not modify it.
### Exclusive Lock (X)
Allows only one transaction to both read and modify a resource.
### Update Lock (U)
Used to avoid deadlock when a transaction intends to update a resource that might later require an exclusive lock.

## Lock Granularities
Lock granularity refers to the size or scope of the data that a lock covers. It can range from coarse to fine:

### Table-level Lock
Locks the entire table. It is less granular and may cause contention in high-concurrency environments.
### Page-level Lock
Locks a page of rows in the database.
### Row-level Lock
Locks individual rows in a table, providing the highest level of concurrency.
### Column-level Lock
Rare and typically not used in most RDBMS. It locks specific columns within a row.
