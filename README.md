# A Review/Cheat-Sheet of Important Commands
This is a review of important SQL commands

##  What is SQL 
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

