#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import MySQL Connector/Python 
import mysql.connector as connector

# In[2]:


# Establish connection
connection = connector.connect(user="root", password="")

# In[5]:


from mysql.connector.pooling import MySQLConnectionPool

# In[6]:


dbconfig = {"database": "little_lemon_store", "user": "root", "password": ""}
try:
    pool = MySQLConnectionPool(pool_name="pool_b",
                               pool_size=3,
                               **dbconfig)
    print("The connection pool is created with a name: ", pool.pool_name)

except Error as er:
    print("Error code:", er.errno)

# In[7]:


print("Getting a connection from the pool.")
connection2 = pool.get_connection()

# In[8]:


print("Creating a cursor obj")
cursor = connection2.cursor()

# In[9]:


# Stored procedure name >> PeakHours
# Our stored procedure query is
stored_procedure_query = """
CREATE PROCEDURE AddBookings()
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
END
"""

# In[10]:


# Execute the query
cursor.execute(stored_procedure_query)

# In[18]:


# Call the stored procedure with its name
cursor.callproc("AddBookings")

# In[19]:


# Retreve recrods in "dataset"
dataset = results.fetchall()

# In[20]:


# Retrieve column names
cols = cursor.column_names
print(cols)
for result in results:
    print(result)

# In[21]:


# Print column names
print(columns)

# In[ ]:


connection.close()
