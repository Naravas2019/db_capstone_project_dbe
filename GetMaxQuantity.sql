CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `GetMaxQuantity`()
BEGIN
SELECT MAX(Quantity) AS Max_Quantity
FROM Orders;
END