CREATE OR REPLACE FUNCTION search_contacts(pattern TEXT)
RETURNS TABLE(name TEXT, surname TEXT, phone TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        first_name::TEXT, 
        last_name::TEXT, 
        phone_number::TEXT
    FROM phonebook
    WHERE first_name ILIKE '%' || pattern || '%'
       OR last_name ILIKE '%' || pattern || '%'
       OR phone_number ILIKE '%' || pattern || '%';
END;
$$ LANGUAGE plpgsql;




--psql -h localhost -U kenzhebayaialaicloud.com -d phonebook
--phonebook=# CALL insert_or_update_user('John', '1234567890');
--CALL
--phonebook=# SELECT * FROM search_contacts('John');
-- name | surname |   phone    
------+---------+------------
 --John |         | 1234567890
--(1 row)

--phonebook=# SELECT * FROM phonebook;
 --id | first_name | last_name | phone_number 
----+------------+-----------+--------------
 -- 2 | Jane       | Smith     | 0987654321
  --3 | Alice      |           | 9876543210
  --4 | John       |           | 1234567890
--3 (rows)
