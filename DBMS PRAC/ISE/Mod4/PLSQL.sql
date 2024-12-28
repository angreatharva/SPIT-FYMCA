CREATE DATABASE film_production;

USE film_production;

CREATE TABLE producer (
    p_id INT AUTO_INCREMENT PRIMARY KEY,
    p_first_name VARCHAR(50),
    p_last_name VARCHAR(50),
    p_dob DATE,
    p_age INT,              
    p_phno JSON,
    p_email JSON
);

-- Trigger to calculate age based on p_dob
DELIMITER $$
CREATE TRIGGER before_producer_insert
BEFORE INSERT ON producer
FOR EACH ROW
BEGIN
    IF NEW.p_dob IS NOT NULL THEN
        SET NEW.p_age = YEAR(CURDATE()) - YEAR(NEW.p_dob);
        IF MONTH(CURDATE()) < MONTH(NEW.p_dob) OR 
           (MONTH(CURDATE()) = MONTH(NEW.p_dob) AND DAY(CURDATE()) < DAY(NEW.p_dob)) THEN
            SET NEW.p_age = NEW.p_age - 1; -- Adjust if birthday hasn't occurred yet this year
        END IF;
    END IF;
END$$

CREATE TRIGGER before_producer_update
BEFORE UPDATE ON producer
FOR EACH ROW
BEGIN
    IF NEW.p_dob IS NOT NULL THEN
        SET NEW.p_age = YEAR(CURDATE()) - YEAR(NEW.p_dob);
        IF MONTH(CURDATE()) < MONTH(NEW.p_dob) OR 
           (MONTH(CURDATE()) = MONTH(NEW.p_dob) AND DAY(CURDATE()) < DAY(NEW.p_dob)) THEN
            SET NEW.p_age = NEW.p_age - 1; -- Adjust if birthday hasn't occurred yet this year
        END IF;
    END IF;
END$$
DELIMITER ;



