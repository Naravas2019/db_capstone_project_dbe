CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `GetOrderDetail`(IN Customer_ID INT)
BEGIN
SELECT OrderID, Quantity, BillAmount AS COST FROM Orders
WHERE Customer_ID = CustomerID;
END