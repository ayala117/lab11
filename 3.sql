
CREATE OR REPLACE PROCEDURE insert_multiple_users(users TEXT[])
LANGUAGE plpgsql
AS $$
DECLARE
    item TEXT;
    name TEXT;
    phone TEXT;
    incorrect_data TEXT[] := '{}';
BEGIN
    FOREACH item IN ARRAY users LOOP
        
        name := trim(both ' ' from split_part(item, ',', 1));
        phone := trim(both ' ' from split_part(item, ',', 2));

       
        IF phone ~ '^\d{10,15}$' THEN
           
            IF EXISTS (SELECT 1 FROM phonebook WHERE first_name = name) THEN
                UPDATE phonebook
                SET phone_number = phone
                WHERE first_name = name;
            ELSE
                INSERT INTO phonebook(first_name, phone_number)
                VALUES (name, phone);
            END IF;
        ELSE
            incorrect_data := array_append(incorrect_data, name || ': ' || phone);
        END IF;
    END LOOP;

   
    RAISE NOTICE 'incorrect_data: %', incorrect_data;
END;
$$;

--phonebook=# CALL insert_multiple_users(ARRAY[
--     'Tom,1234567890',
--     'Ann,9876543210',  
--     'Lara,1234567890', 
--     'Max,87771234567'
-- ]); 
-- NOTICE: incorrect_data: {}
-- CALL
-- phonebook=# SELECT * FROM phonebook;
--  id | first_name | last_name | phone_number 
-- ----+------------+-----------+--------------
--   2 | Jane       | Smith     | 0987654321
--   3 | Alice      |           | 9876543210
--   4 | John       |           | 1234567890
--   5 | Bob        |           | 7777777777
--   6 | Tom        |           | 1234567890
--   8 | Ann        |           | 9876543210
--   9 | Lara       |           | 1234567890
--   7 | Max        |           | 87771234567
