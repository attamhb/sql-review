desc customer;

SELECT c.first_name, c.last_name, a.address FROM customer c
                                                 JOIN address a;
-- JOIN address a ON c.address_id = a.address_id;
-- INNER JOIN address a ON c.address_id = a.address_id;
-- JOIN address a USING (address_id);
-- , address a WHERE c.address_id = a.address_id;
-- , address a WHERE c.address_id = a.address_id AND a.postal_code = 52137;
-- FROM customer c INNER JOIN address a ON c.address_id = a.address_id WHERE a.postal_code = 52137;

desc address;
desc city;

SELECT c.first_name, c.last_name, ct.city FROM customer c 
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN city ct ON a.city_id = ct.city_id;


SELECT c.first_name, c.last_name, ct.city FROM city ct 
INNER JOIN address a ON a.city_id = ct.city_id
INNER JOIN city ct ON a.city_id = ct.city_id;
