
SELECT 
    Customers.CustomerID,
    Customers.FullName,
    Orders.OrderID,
    Orders.BillAmount AS 'Cost',
    MenuItems.Name,
    MenuItems.Type
FROM
    Customers
        RIGHT JOIN
    Orders ON Customers.CustomerID = Orders.CustomerID
        LEFT JOIN
    MenuItems ON MenuItems.ItemID = Orders.ItemID
WHERE
    Orders.BillAmount > 0
ORDER BY BillAmount;