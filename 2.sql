-- insert_or_update_user.sql
CREATE OR REPLACE PROCEDURE insert_or_update_user(name TEXT, phone TEXT)
AS $$
BEGIN
    -- Пайдаланушының бар екенін тексеру
    IF EXISTS (SELECT 1 FROM phonebook WHERE first_name = name) THEN
        -- Егер бар болса, телефонды жаңарту
        UPDATE phonebook
        SET phone_number = phone
        WHERE first_name = name;
    ELSE
        -- Егер жоқ болса, жаңа пайдаланушы енгізу
        INSERT INTO phonebook (first_name, phone_number)
        VALUES (name, phone);
    END IF;
END;
$$ LANGUAGE plpgsql;


-- phonebook=# \i 2.sql
-- CREATE PROCEDURE
-- phonebook=# CALL insert_or_update_user('Bob', '8888888888');
-- CALL
-- phonebook=# SELECT * FROM phonebook;
--  id | first_name | last_name | phone_number 
-- ----+------------+-----------+--------------
--   2 | Jane       | Smith     | 0987654321
--   3 | Alice      |           | 9876543210
--   6 | Tom        |           | 1234567890
--   8 | Ann        |           | 9876543210
--   9 | Lara       |           | 1234567890
--   7 | Max        |           | 87771234567
--   5 | Bob        |           | 8888888888
-- (7 rows)