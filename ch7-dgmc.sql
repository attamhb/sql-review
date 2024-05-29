
-- CREATE TABLE  string_tbl
--   (char_fld CHAR(30),
--   vchar_fld VARCHAR(30),
--   text_fld TEXT
--   );


-- INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
-- VALUES ('This is char data', 'This is varchar data', 'THIS is text data');

-- UPDATE string_tbl
-- SET vchar_fld  = 'THIS a piece of extremely long varchar data';

-- SELECT @@session.sql_mode;

-- SET sql_mode='ansi';
-- SELECT @@session.sql_mode;

-- SHOW WARNINGS;
-- SELECT vchar_fld FROM string_tbl;

-- UPDATE string_tbl
-- SET text_fld = 'this string doesn''t work';
----------------------------------------------------------------
----------------------------------------------------------------
-- SELECT 'abcdefg', CHAR(97, 98, 99, 100, 101, 102, 103);
-- SELECT  CHAR(128, 129, 130, 131, 132, 133,134, 135, 136, 137);
-- SELECT  CHAR(138,139,140,141,142,143,144,145,146,147);

-- SELECT CONCAT('dank sch', CHAR(148), 'n')
-- SELECT 'danke sch' || CHR(148) || 'n' FROM dual;
-- SELECT 'danke sch' = CHR(148) + 'n';
-- SELECT ASCHII('i');
----------------------------------------------------------------
---- Sring Manipulation

-- DELETE FROM string_tbl;
-- INSERT INTO string_tbl (char_fld, vchar_fld,text_fld)
-- VALUES('This is 28 character', 'This is 28 character', 'This is 28 character');
-- SELECT * FROM string_tbl;
-- SELECT LENGTH(char_fld) char_lenght, LENGTH(vchar_fld) vchar_length, LENGTH(text_fld) text_lenght FROM string_tbl;
-- SELECT POSITION('characters' IN vchar_fld) FROM string_tbl;
-- SELECT LOCATE('is', vchar_fld, 5)  FROM string_tbl;


-- DELETE FROM string_tbl;
-- INSERT INTO string_tbl(vchar_fld)
-- VALUES('abc'), ('xyz'), ('QRSTUV'),('qrstuv'),('12345');
-- SELECT * FROM string_tbl;

-- SELECT STRCMP('12345', '12345') 12345_12345,
--     STRCMP('abcd', 'xyz') abcd_xyz,
--     STRCMP('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
--     STRCMP('12345', 'xyz') 12345_xyz,
--     STRCMP('xyz', 'qrstuv') xyz_qrstuv;
-- SELECT name, name LIKE '%y' ends_in_y FROM category;
-- SELECT name, name LIKE 'y$' ends_in_y FROM category;

-- DELETE FROM string_tbl;  
-- UPDATE string_tbl
-- SET text_fld = CONCAT(text_fld, ', but now it is longer');
-- SELECT text_fld FROM string_tbl;
-- SELECT CONCAT(first_name, ' ', last_name,
-- ' has been a customer since ', DATE(create_date)) customer_narrative FROM custome;
-- SELECT first_name ||  ' ' || last_name || 
 -- ' has been a customer since ' || DATE(create_date) customer_narrative FROM custome;

-- SELECT INSERT('goodby world', 9, 0, 'cruel ') string;
-- SELECT INSERT('goodby world', 1, 7, 'hello') string;
-- SELECT REPLACE('goodby world', 'ggodby',  'hello') FROM dual;
-- SELECT STUFF('goodby world', 1, 5, 'goodby cruel');
-- SELECT STRING('goodby cruel world', 9, 5);
-- SELECT (37*59)/(78-(8*6));
-- SELECT MOD(10, 6);
-- SELECT MOD(22.75, 5);
-- SELECT POW(2, 8);
-- SELECT POW(2, 8) kilobyte, POW(2,20) megabyte,  POW(2,30) gigabyte, POW(2,40) terabyte;

-- SELECT ceil(72.445);
-- SELECT ceil(72.000001), FLOOR(72.999999);
-- SELECT ceil(72.000001), FLOOR(72.999999), ROUND(72.999999);
-- SELECT ceil(72.000001) ceit_it, FLOOR(72.999999) floor_it, ROUND(72.999999) round_it;

-- SELECT ROUND(17,-1), TRUNCATE(17,-1);
-- SELECT ROUND(170,-2), TRUNCATE(170,-2);
-- SELECT account_id, SIGN(balance), ABS(balance) FROM account;
-- SELECT @@global.time_zone, @@session.time_zone;
-- SET time_zone = 'Europe/Zurich';

-- UPDATE rental SET return_date = '2019-09-17 15:30:00' WHERE rental_id = 9999;
-- SELECT CAST('2019-09-17 15:so:oo' AS DATETIME);
-- SELECT CAST('2019-09-17' AS DATE) data_field, CAST('108:17:57' AS TIME) tiem_field;

-- UPDATE rental
-- SET return_date = STR_TO_DATE('September 17, 2019', '%M %d, %Y')
-- WHERE rental_id = 99999;

-- SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();
-- SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);


-- UPDATE rental
-- SET return_date = DATE_ADD(return_date, INTERVAL '3:27:11' HOUR_SECOND)
-- WHERE rental_id = 9999;


-- SELECT LAST_DAY('2019-09-17');
-- SELECT DAYNAME('2019-09-18');
-- SELECT EXTRACT(YEAR FROM '2019-09-18 22:19:05');
-- SELECT DATEPART(YEAR, GETDATE()w
-- SELECT DATEDIFF('2019-09-03', '2019-06-21');
-- SELECT DATEDIFF('2019-09-03 23:59:59', '2019-06-21 00:00:01');
-- SELECT DATEDIFF('2019-06-21', '2019-09-03');
-- SELECT CAST('1456328' AS SIGNED INTEGER);
-- SELECT CAST('999ABC111' AS UNSIGNED INTEGER);
-- SHOW warnings;

-- TEST your knowledge

-- Exercise 7-1 

-- Exercise 7-2 

-- Exercise 7-3 
