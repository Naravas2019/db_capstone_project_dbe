USE Little_Lemon_store;
DROP PROCEDURE IF EXISTS AddBooking;
DROP FUNCTION IF EXISTS Valid;

DELIMITER $$

CREATE FUNCTION Valid(RecordsFound INTEGER, message VARCHAR(255)) RETURNS INTEGER DETERMINISTIC
BEGIN
    IF RecordsFound IS NOT NULL OR RecordsFound > 0 THEN
        SIGNAL SQLSTATE 'ERR0R' SET MESSAGE_TEXT = message;
    END IF;
    RETURN RecordsFound;
END$$

CREATE PROCEDURE AddBooking(IN BookingDate DATE, IN TableNo INT)
	BEGIN
		DECLARE `_rollback` BOOL DEFAULT 0;
		DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
		START TRANSACTION;
        
        SELECT Valid(COUNT(*), CONCAT("Table ", TableNo, " is already booked"))
        FROM bookings
        WHERE date = BookingDate AND table_number = TableNo;
        
		INSERT INTO bookings (date, table_number)
		VALUES (BookingDate, TableNo);
		
		IF `_rollback` THEN
			SELECT CONCAT("Table ", TableNo, " is already booked - booking cancelled") AS "Booking status";
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
    END$$
    
DELIMITER ;

CALL AddBooking("2022-12-17", 6);