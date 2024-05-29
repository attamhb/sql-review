DESC customer;
DESC city;

SELECT 1 num, 'abs' str  UNION SELECT 9 num, 'xyz' str;
SELECT 'CUST' typ, c.first_name, c.last_name FROM customer c
UNION ALL
SELECT 'ACTOR' typ, a.first_name, a.last_name FROM actor a;


SELECT c.first_name, c.last_name FROM customer c
       WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
       UNION ALL
       -- UNION 
       -- INTERSECT
       -- EXCEPT
       SELECT a.first_name, a.last_name FROM   actor a
       WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';
       -- ORDER BY lname, fname;
       -- ORDER BY last_name, first_name;


-- Set Operations Precedence
SELECT a.first_name fname, a.last_name lname FROM actor a
       WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
       UNION ALL -- UNION
             (
       SELECTa.first_name, a.last_name FROM actor a
       WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
       UNION -- UNION ALL
       SELECT c.first_name, c.last_name FROM customer c
       WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
             )
             ;
-- Exercise 6-2
SELECT a.first_name, a.last_name FROM actor a WHERE a.last_name LIKE 'L%'
       UNION ALL
       SELECT c.first_name, c.last_name FROM customer c WHERE c.last_name LIKE 'L%' ;
-- Exercise 6-3
SELECT a.first_name, a.last_name FROM actor a WHERE a.last_name LIKE 'L%'
       UNION ALL
       SELECT c.first_name, c.last_name FROM customer c WHERE c.last_name LIKE 'L%'
       ORDER BY last_name;
