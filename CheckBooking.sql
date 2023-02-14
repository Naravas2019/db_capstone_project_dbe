CREATE DEFINER=`Little_Lemon_user`@`%` PROCEDURE `CheckBooking`(Bookday DATE,Table_No INT)
SELECT CONCAT("Table ", TableNo, " is already booked") AS BOOKING_INFO FROM Bookings
WHERE EXISTS (SELECT * FROM Bookings WHERE BookingDate = Bookday and TableNo = Table_No)