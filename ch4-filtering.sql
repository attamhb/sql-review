SELECT c.email FROM customer c 
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';
-- WHERE date(r.rental_date) <> '2005-06-14';

--DELETE FROM rental WHERE year(rental_date) = 2004; 
--DELETE FROM rental WHERE year(rental_date) <> 2005 AND year(rental_date) <> 2006; 

SELECT customer_id, rental_date FROM rental
WHERE rental_date < '2005-05-25';
-- WHERE rental_date BETWEEN '2005-06-16' AND '2005-06-14';
-- WHERE rental_date >= '2005-06-16' AND rental_date <= '2005-06-14';

SELECT rental_id, customer_id FROM rental
WHERE rental_date IS NOT NULL;
--WHERE rental_date IS NULL;

SELECT rental_id, customer_id, return_date FROM rental
WHERE return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';
-- WHERE return_date IS NULL OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';


SELECT customer_id, payment_date, amount FROM payment 
WHERE amount BETWEEN 10.0 AND 11.99;


SELECT last_name, first_name  FROM customer
WHERE last_name BETWEEN 'FA' AND 'FR';
-- WHERE left(last_name,  1) = 'Q';
-- WHERE left(last_name,  3) = 'QUI';
-- WHERE last_name REGEXP '^[QY]';
--WHERE last_name LIKE 'Q%' OR last_name LIKE 'Y%';
--HERE last_name LIKE '_A_T%S';

SELECT title, rating FROM film 
WHERE rating = 'G' OR rating = 'PG';
-- WHERE rating IN ('G', 'PG');
-- WHERE rating  IN (SELECT rating FROM film WHERE title LIKE '%PET%'); 
-- WHERE rating  NOT IN ('PG-13', 'R', 'NC-17'); 


-- TEST your knowledge
-- Exercise 4-1
SELECT amount FROM payment ;

-- Exercise 4-2

-- Exercise 4-3

-- Exercise 4-4
