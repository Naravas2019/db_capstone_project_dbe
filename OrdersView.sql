CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `Little_Lemon_user`@`%` 
    SQL SECURITY DEFINER
VIEW `ordersview` AS
    SELECT 
        `orders`.`OrderID` AS `OrderID`,
        `orders`.`Quantity` AS `Quantity`,
        `orders`.`BillAmount` AS `Cost`
    FROM
        `orders`