-- SELECT customer_id FROM rental;

-- SELECT customer_id FROM rental GROUP BY customer_id;
-- SELECT DISTINCT customer_id FROM rental;

-- SELECT customer_id, COUNT(*) FROM rental GROUP BY customer_id;
-- SELECT customer_id, COUNT(*) FROM rental GROUP BY customer_id ORDER BY 2 DESC;
-- SELECT customer_id, COUNT(*) FROM rental WHERE  COUNT(*) >=40 GROUP BY customer_id; error 

-- SELECT customer_id, COUNT(*) FROM rental GROUP BY customer_id HAVING  COUNT(*) >=40 ;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
---- Aggregate Functions

-- SELECT MAX(amount) max_amt,
--        MIN(amount) min_amt,
--        AVG(amount) avg_amt,
--        SUM(amount) tot_amt,
--        COUNT(*) num_payments
--          FROM payment;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
---- Implicit Versus Explicit Group

-- SELECT custmer_id,
--        MAX(amount) max_amt,
--        MIN(amount) min_amt,
--        AVG(amount) avg_amt,
--        SUM(amount) tot_amt,
--        COUNT(*) num_payments
--          FROM payment;
-- FROM payaent GROUP BY customer_id

----------------------------------------------------------------------------
-- Counting Distinct Values
-- SELECT COUNT(customer_id) num_rows,
--        COUNT(DISTINCT customer_id) num_customers
--          FROM payment;

----------------------------------------------------------------------------
-- USING Exepressions
-- SELECT MAX(datediff(return_date, rental_date)) FROM rental;

----------------------------------------------------------------------------
-- How Nulls are handeled

-- CREATE TABLE number_tbl (val SMALLINT);

-- INSERT INTO number_tbl VALUES (1);
-- INSERT INTO number_tbl VALUES (3);
-- INSERT INTO number_tbl VALUES (5);

-- SELECT COUNT(*) num_rows,
--        COUNT(val) num_vals,
--        SUM(val) total,
--        MAX(val) max_val,
--        AVG(val) avg_val
--          FROM number_tbl;

-- INSERT INTO number_tbl VALUES (NULL);
-- SELECT COUNT(*) num_rows,
--        COUNT(val) num_vals,
--        SUM(val) total,
--        MAX(val) max_val,
--        AVG(val) avg_val
--          FROM number_tbl;

----------------------------------------------------------------------------
-- Generating Groups

-- SELECT actor_id, COUNT(*)
--   FROM film_actor
--  GROUP BY actor_id;

-- SELECT fa.actor_id, f.rating, COUNT(*)
--   FROM film_actor fa
--        INNER JOIN film f
--            ON fa.film_id = f.film_id
--  GROUP BY fa.actor_id, f.rating
--  ORDER BY 1, 2;

-- SELECT EXTRACT(YEAR FROM rental_date) YEAR,
--        COUNT(*) how_many
--   FROM rental
--  GROUP BY EXTRACT(YEAR FROM rental_date);



SELECT fa.actor_id, f.rating, COUNT(*)
  FROM film_actor fa
       INNER JOIN film f
           ON fa.film_id = f.film_id
 GROUP BY fa.actor_id, f.rating WITH ROLLUP  
 ORDER BY 1, 2;


SELECT fa.actor_id, f.rating, COUNT(*)
  FROM film_actor fa
       INNER JOIN film f
           ON fa.film_id = f.film_id
 WHERE f.rating IN ('G', 'PG')
 GROUP BY fa.actor_id, f.rating
HAVING COUNT(*) > 9;

--- Test your knowledge

-- EX 8.1
-- SELECT * FROM payment;
SELECT COUNT(*) FROM payment;
-- EX 8.2

-- count # of payments by each customer. show customer_id, total amount paid for each customer. 
-- SELECT custmer_id,
--        MAX(amount) total,
--        COUNT(*) num_payments
--        FROM payment;

-- FROM payaent GROUP BY customer_id
-- EX 8.3
