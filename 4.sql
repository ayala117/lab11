CREATE OR REPLACE FUNCTION get_contacts_paginated(p_limit INT, p_offset INT)
RETURNS TABLE(id INT, first_name character varying(50), last_name character varying(50), phone_number character varying(50)) AS $$
BEGIN
    RETURN QUERY
    SELECT phonebook.id, phonebook.first_name, phonebook.last_name, phonebook.phone_number
    FROM phonebook
    LIMIT p_limit OFFSET p_offset;
END;
$$ LANGUAGE plpgsql;


-- phonebook=# \i 4.sql
-- CREATE FUNCTION
-- phonebook=# SELECT * FROM get_contacts_paginated(3, 0);
--  id | first_name | last_name | phone_number 
-- ----+------------+-----------+--------------
--   2 | Jane       | Smith     | 0987654321
--   3 | Alice      |           | 9876543210
--   6 | Tom        |           | 1234567890
-- (3 rows)
