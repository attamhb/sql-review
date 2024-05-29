SELECT customer_id, first_name, last_name
  FROM customer
 WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

SELECT MAX(customer_id) FROM customer;

SELECT customer_id, first_name, last_name
  FROM customer
 WHERE customer_id = 599;

-- Subquery Types

SELECT city_id, city
  FROM city
 WHERE country_id <>
       (SELECT country_id FROM country WHERE country = 'India');


SELECT city_id, city
  FROM city
 WHERE country_id <>
       (SELECT country_id FROM country WHERE country <> 'India');

SELECT country_id FROM country WHERE country <> 'India';
SELECT country_id FROM country WHERE country IN ('Canada', 'Mexico');
SELECT country_id FROM country WHERE country = 'Canada' OR country = 'Mexico';

SELECT country_id, city
  FROM city
 WHERE country_id IN
       (SELECT country_id
          FROM country
         WHERE country IN ('Canada', 'Mexico'));


SELECT country_id, city
  FROM city
 WHERE country_id NOT IN
       (SELECT country_id
          FROM country
         WHERE country IN ('Canada', 'Mexico'));



SELECT first_name, last_name
  FROM customer
 WHERE customer_id <> ALL
       (SELECT customer_id
          FROM payment
         WHERE amount = 0);



SELECT first_name, last_name
  FROM customer
 WHERE customer_id NOT IN 
       (SELECT customer_id
          FROM payment
         WHERE amount = 0);


SELECT first_name, last_name
  FROM customer
 WHERE customer_id NOT IN (122, 452, NULL);


SELECT customer_id, COUNT(*)
  FROM rental
 GROUP BY customer_id
HAVING COUNT(*) > ALL
       (SELECT COUNT(*)
          FROM rental r
               INNER JOIN customer c
                   ON r.customer_id = c.customer_id
               INNER JOIN address a
                   ON c.address_id = a.address_id
               INNER JOIN city ct
                   ON a.city_id = ct.city_id
               INNER JOIN country co
                   ON ct.country_id = co.country_id
         WHERE  co.country IN ('United States', 'Mexico', 'Canada')
         GROUP BY r.customer_id
       );




SELECT customer_id, SUM(amount)
  FROM payment
 GROUP BY customer_id
HAVING SUM(amount)> ANY
       (SELECT SUM(p.amount)
          FROM payment p
               INNER JOIN customer c 
                   ON p.customer_id = c.customer_id
               INNER JOIN address a
                   ON c.address_id = a.address_id
               INNER JOIN city ct
                   ON a.city_id = ct.city_id
               INNER JOIN country co
                   ON ct.country_id = co.country_id
         WHERE co.country IN ('Bolivia', 'Paraguay', 'Chile')
         GROUP BY co.country);



SELECT fa.actor_id, fa.film_id
  FROM film_actor fa
 WHERE fa.actor_id IN
       (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
   AND fa.film_id IN
       (SELECT film_id FROM film WHERE rating ='PG');
                                      
SELECT actor_id, film_id
  FROM film_actor
 WHERE (actor_id, film_id) IN
       (SELECT a.actor_id, f.film_id
          FROM actor a
               CROSS JOIN film f
         WHERE a.last_name = 'MONROE'
           AND f.rating = 'PG');

SELECT c.first_name, c.last_name
  FROM customer c
 WHERE 20 =
       (SELECT COUNT(*) FROM rental r
         WHERE r.customer_id = c.customer_id);




SELECT c.first_name, c.last_name
  FROM customer c
 WHERE 
   (SELECT SUM(p.amount) FROM payment p
     WHERE p.customer_id = c.customer_id)
   BETWEEN 180 AND 240;

SELECT c.first_name, c.last_name
  FROM customer c
 WHERE EXISTS
       (SELECT 1 FROM rental r
         WHERE r.customer_id = c.customer_id
               AND DATE(r.rental_date) < '2005-05-25');


SELECT c.first_name, c.last_name
  FROM customer c
 WHERE EXISTS
       (SELECT r.rental_date, r.customer_id, 'ABCD' str, 2*3/7 nmbr
          FROM rental r
         WHERE r.customer_id = c.customer_id
           AND DATE(r.rental_date) < '2005-05-25');


SELECT a.first_name, a.last_name
  FROM actor  a 
 WHERE NOT EXISTS
       (SELECT 1
          FROM film_actor fa
               INNER JOIN film  f ON f.film_id = fa.film_id
         WHERE fa.actor_id = a.actor_id
           AND f.rating = 'R');


-- UPDATE customer c
--    SET c.last_update =
--        (SELECT MAX(r.ren) FROM rental r
--          WHERE r.customer_id = c.customer_id);

-- UPDATE customer c
--    SET c.last_update =
--        (SELECT MAX(r.ren) FROM rental r
--          WHERE r.customer_id = c.customer_id)
--  WHERE EXISTS
--        (SELECT 1 FROM rental r
--          WHERE r.customer_id = c.customer_id);

-- DELETE FROM customer  ... 
-- DELETE FROM customer  ... 

SELECT c.first_name, c.last_name,
       pymnt.num_rentals, pymnt.tot_payments
  FROM customer c
       INNER JOIN
       (SELECT customer_id,
               COUNT(*) num_rentals, SUM(amount) tot_payments
          FROM payment
         GROUP BY customer_id
       ) pymnt
           ON c.customer_id =pymnt.customer_id;

SELECT customer_id, COUNT(*) num_rentals, SUM(amount) tot_payments
  FROM payment
 GROUP BY customer_id;


SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
         UNION ALL
SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
         UNION ALL
SELECT 'Heavy hitters' name, 150 low_limit, 9999999.99 high_limit;
         

SELECT pymnt_grps.name, COUNT(*) num_customers
  FROM
    (SELECT customer_id,
            COUNT(*) num_rentals, SUM(amount) tot_payments
       FROM payment
      GROUP BY customer_id
    ) pymnt
    INNER JOIN
    (SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
      UNION ALL
     SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
      UNION ALL
     SELECT 'Heavy hitters' name, 150 low_limit, 9999999.99 high_limit
    ) pymnt_grps
        ON pymnt.tot_payments
      BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
      GROUP BY pymnt_grps.name;


SELECT c.first_name, c.last_name, ct.city,
       SUM(p.amount) tot_payments, COUNT(*) tot_rentals
  FROM payment p
       INNER JOIN customer c
           ON p.customer_id = c.customer_id
       INNER JOIN address a
           ON c.address_id = a.address_id
       INNER JOIN city ct 
           ON a.city_id = ct.city_id
 GROUP BY c.first_name, c.last_name, ct.city;

                    
SELECT customer_id, COUNT(*) tot_rentals, SUM(amount) tot_payments
  FROM payment
 GROUP BY customer_id;
                          
         
SELECT c.first_name, c.last_name,
       ct.city,
       pymnt.tot_payments, pymnt.tot_rentals
  FROM
    (SELECT customer_id,
            COUNT(*) tot_rentals, SUM(amount) tot_payments
       FROM payment
              GROUP BY customer_id
    ) pymnt
    INNER JOIN customer c
        ON pymnt.customer_id = c.customer_id
    INNER JOIN address a
        ON c.address_id = a.address_id
    INNER JOIN city ct
        ON a.city_id = ct.city_id;


WITH actors_s AS
    (SELECT actor_id, first_name, last_name
       FROM actor WHERE last_name LIKE 'S%'
    ),
  actors_s_pg AS
    (SELECT s.actor_id, s.first_name, s.last_name,
            f.film_id, f.title
       FROM actors_s s
            INNER JOIN film_actor fa
                ON s.actor_id = fa.actor_id
            INNER JOIN film f
                ON f.film_id = fa.film_id
                         WHERE f.rating = 'PG'
    ),
  actors_s_pg_revenue AS
    (SELECT spg.first_name, spg.last_name, p.amount
       FROM actors_s_pg spg
            INNER JOIN inventory i
                ON i.film_id = spg.film_id
            INNER JOIN rental r
                ON i.inventory_id = r.inventory_id
            INNER JOIN payment p
                         ON r.rental_id = p.rental_id 
    )  
SELECT spg_rev.first_name, spg_rev.last_name,
       SUM(spg_rev.amount) tot_revenue
  FROM actors_s_pg_revenue spg_rev
 GROUP BY spg_rev.first_name, spg_rev.last_name
 ORDER BY 3 DESC;



-- typo,.....
SELECT
  (SELECT c.first_name FROM customer c
    WHERE c.customer_id = p.customer_id
  ) first_name,
  (SELECT c.last_name FROM customer c
    WHERE c.customer_id = p.customer_id
  ) last_name
    (SELECT ct.city
       FROM customer c
            INNER JOIN address a
                ON c.address_id = a.address_id
            INNER JOIN city ct
                ON a.city_id = ct.city_id
      WHERE c.customer_id = p.customer_id
    ) city,
  SUM(p.amount) tot_payments,
  COUNT(*) tot_rentals
  FROM payment p
 GROUP BY p.customer_id;


         
SELECT a.actor_id, a.first_name, a.last_name
  FROM actor a
 ORDER BY
   (SELECT COUNT(*) FROM film_actor fa
     WHERE fa.actor_id = a.actor_id) DESC;
