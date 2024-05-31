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

[beaulieu , Alan. *Reference  Learning SQL*. O'REILLY.](https://www.amazon.com/Learning-SQL-Generate-Manipulate-Retrieve/dp/1492057614)

[DEBAROS, ANTHONY. *Practical SQL*. No Starch Press](https://www.amazon.com/Practical-SQL-Beginners-Guide-Storytelling/dp/1593278276)

