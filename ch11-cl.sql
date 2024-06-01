-- Conditional Logic
SELECT first_name, last_name,
CASE
WHEN active = 1 THEN 'ACTIVE'
ELSE 'INACTIVE'
END activity_type
FROM customer;


SELECT c.first_name, c.last_name,
CASE
    WHEN active = 0 THEN 0
    ELSE
        (SELECT COUNT(*) FROM rental r
    WHERE r.customer_id = c.customer_id)
END num_rentals
FROM customer c;


-- Simple case Expressions

-- Examples of case Expressions

--- Result Set Translation

SELECT monthname(rental_date) rental_month,
COUNT(*) num_rentals
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01'
GROUP BY monthname(rental_date);



SELECT
SUM(CASE WHEN monthname(rental_date) = 'May' THEN 1 ELSE 0 END) MAy_rentals, 
SUM(CASE WHEN monthname(rental_date) = 'June' THEN 1 ELSE 0 END) June_rentals, 
SUM(CASE WHEN monthname(rental_date) = 'July' THEN 1 ELSE 0 END) July_rentals 
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01';

-- CHECKING for existence

SELECT a.first_name, a.last_name,
CASE
   WHEN EXISTS (SELECT 1 FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
   WHERE fa.actor_id = a.actor_id AND f.rating = 'G') THEN 'Y' ELSE 'N'
END g_actor,
CASE
   WHEN EXISTS (SELECT 1 FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
   WHERE fa.actor_id = a.actor_id AND f.rating = 'PG') THEN 'Y' ELSE 'N'
END pg_actor,
CASE
   WHEN EXISTS (SELECT 1 FROM film_actor fa INNER JOIN film f ON fa.film_id = f.film_id
   WHERE fa.actor_id = a.actor_id AND f.rating = 'NC-17') THEN 'Y' ELSE 'N'
END nc17_actor
FROM actor a
WHERE a.last_name LIKE 'S%' OR a.first_name LIKE 'S%';

SELECT f.title,
CASE (SELECT COUNT(*) FROM inventory i WHERE i.film_id = f.film_id)
WHEN 0 THEN 'Out of Stockh'
WHEN 1 THEN 'Scarce'
WHEN 2 THEN 'Scarce'
WHEN 3 THEN 'Available'
WHEN 4 THEN 'Available'
ELSE 'Common'
END film_availability 
FROM film f;

SELECT 100/0;

SELECT c.first_name, c.last_name, SUM(p.amount) tot_payment_amt, COUNT(p.amount) num_payments,
SUM(p.amount)/ CASE WHEN COUNT(p.amount) = 0 THEN 1 ELSE COUNT(p.amount) END avg_payment
FROM customer c
LEFT OUTER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;


-- Conditional Updates

-- UPDATE customer
-- SET active =
-- CASE
-- WHEN 90 <= (SELECT datediff(now(), MAX(rental_date))
-- FROM rental r WHERE r.customer_id = customer.customer_id) THEN 0 ELSE 1
-- END
-- WHERE active  = 1
-- ;

-- Handling Null Values

SELECT (7*5)/((3+14)*NULL);

