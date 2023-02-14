-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema little_lemon_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `little_lemon_store` ;

-- -----------------------------------------------------
-- Table `little_lemon_store`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NULL DEFAULT NULL,
  `Role` VARCHAR(100) NULL DEFAULT NULL,
  `State` VARCHAR(100) NULL DEFAULT NULL,
  `Contact_Number` INT NULL DEFAULT NULL,
  `Email` VARCHAR(100) NULL DEFAULT NULL,
  `Annual_Salary` VARCHAR(100) NULL DEFAULT NULL,
  `Country` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`menuitems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NULL DEFAULT NULL,
  `Type` VARCHAR(100) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`menus` (
  `MenuID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`MenuID`, `ItemID`),
  INDEX `item_id_fk_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `item_id_fk`
    FOREIGN KEY (`ItemID`)
    REFERENCES `little_lemon_store`.`menuitems` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`orders` (
  `OrderID` INT NOT NULL,
  `TableNo` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  PRIMARY KEY (`OrderID`, `TableNo`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `table_no_fk_idx` (`TableNo` ASC) VISIBLE,
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `item_id_fk_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `little_lemon_store`.`menus` (`MenuID`),
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon_store`.`customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `item_id_fk`
    FOREIGN KEY (`ItemID`)
    REFERENCES `little_lemon_store`.`menuitems` (`ItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NULL DEFAULT NULL,
  `GuestFirstName` VARCHAR(100) NOT NULL,
  `GuestLastName` VARCHAR(100) NOT NULL,
  `BookingDate` TIME NOT NULL,
  `EmployeeID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `table_no_fk_idx` (`TableNo` ASC) VISIBLE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `little_lemon_store`.`employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `table_no_fk`
    FOREIGN KEY (`TableNo`)
    REFERENCES `little_lemon_store`.`orders` (`TableNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `little_lemon_store`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`delivery` (
  `DeliveryID` INT NOT NULL,
  `DeliveryStatus` VARCHAR(45) NOT NULL,
  `DeliveryTime` DATETIME NOT NULL,
  `Comment` VARCHAR(45) NOT NULL,
  `CustomerID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `little_lemon_store`.`customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `little_lemon_store`.`employees` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `little_lemon_store` ;

-- -----------------------------------------------------
-- Placeholder table for view `little_lemon_store`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_store`.`ordersview` (`OrderID` INT, `Quantity` INT, `Cost` INT);

-- -----------------------------------------------------
-- procedure 	CancelOrder
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `	CancelOrder`(inputid INT)
BEGIN
DELETE FROM Orders WHERE OrderID = inputid;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure AddBooking
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `AddBooking`(IN BookingDate DATE, IN TableNo INT)
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

-- -----------------------------------------------------
-- procedure BookingHour
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BookingHour`()
BEGIN
SELECT COUNT(BookingID) AS n_bookings,
HOUR(BookingSlot) AS Hour 
FROM Bookings
GROUP BY Hour
ORDER BY Hour aSC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CheckBookings
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `CheckBookings`()
BEGIN
SELECT 
	CASE 
       WHEN BookingID is  NOT NULL THEN CONCAT('TABLE ', TableNumber,' is already booked')
    END AS Bookingstatus
    
FROM Bookings WHERE BookingDate = bookingtime  AND TableNo = TableNumber;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `GetMaxQuantity`()
BEGIN
SELECT MAX(Quantity) AS Max_Quantity
FROM Orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetOrderDetail
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `GetOrderDetail`()
BEGIN
PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, BillAmount AS Cost FROM Orders
WHERE CustomerID = ?';
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ManageBookings
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `ManageBookings`()
BEGIN
select*FROM bookings;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure SalesReport
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SalesReport`()
BEGIN
SELECT SUM(BillAmount) AS Total_sales,
AVG(BillAmount) AS Average_sale,
MIN(BillAmount) AS Minimum_bill,
MAX(BillAmount) AS Maximum_bill
FROM Orders;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdateBooking
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `UpdateBooking`(IN BookingID INT, IN BookingDate DATE)
BEGIN
UPDATE bookings SET date = BookingDate WHERE booking_id = BookingID; 
SELECT CONCAT("Booking ", BookingID, " updated") AS "Confirmation"; 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function Valid
-- -----------------------------------------------------

DELIMITER $$
USE `little_lemon_store`$$
CREATE DEFINER=`Little_Lemon_user`@`%` FUNCTION `Valid`(RecordsFound INTEGER, message VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    IF RecordsFound IS NOT NULL OR RecordsFound > 0 THEN
        SIGNAL SQLSTATE 'ERR0R' SET MESSAGE_TEXT = message;
    END IF;
    RETURN RecordsFound;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `little_lemon_store`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_store`.`ordersview`;
USE `little_lemon_store`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`Little_Lemon_user`@`%` SQL SECURITY DEFINER VIEW `little_lemon_store`.`ordersview` AS select `little_lemon_store`.`orders`.`OrderID` AS `OrderID`,`little_lemon_store`.`orders`.`Quantity` AS `Quantity`,`little_lemon_store`.`orders`.`BillAmount` AS `Cost` from `little_lemon_store`.`orders`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
