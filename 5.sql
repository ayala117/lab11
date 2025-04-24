
-- delete_user_data.sql
CREATE OR REPLACE PROCEDURE delete_user_data(identifier TEXT)
AS $$
BEGIN
    -- Пайдаланушыны аты бойынша өшіру
    IF EXISTS (SELECT 1 FROM phonebook WHERE first_name = identifier) THEN
        DELETE FROM phonebook WHERE first_name = identifier;
    -- Пайдаланушыны телефон нөмірі бойынша өшіру
    ELSIF EXISTS (SELECT 1 FROM phonebook WHERE phone_number = identifier) THEN
        DELETE FROM phonebook WHERE phone_number = identifier;
    ELSE
        RAISE NOTICE 'Пайдаланушы табылмады';
    END IF;
END;
$$ LANGUAGE plpgsql;



--                                                           ^
-- phonebook=# \i 5.sql
-- CREATE PROCEDURE
-- phonebook=# SELECT * FROM phonebook;
-- CALL delete_user_data('John'); 
-- SELECT * FROM phonebook;
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
-- (8 rows)

-- CALL
--  id | first_name | last_name | phone_number 
-- ----+------------+-----------+--------------
--   2 | Jane       | Smith     | 0987654321
--   3 | Alice      |           | 9876543210
--   5 | Bob        |           | 7777777777
--   6 | Tom        |           | 1234567890
--   8 | Ann        |           | 9876543210
--   9 | Lara       |           | 1234567890
--   7 | Max        |           | 87771234567
-- (7 rows)