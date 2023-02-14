#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import MySQL Connector/Python 
import mysql.connector as connector


# In[4]:


#Establish connection 
connection=connector.connect(user="root", password = "")


# In[5]:


from mysql.connector.pooling import MySQLConnectionPool


# In[7]:


dbconfig={"database":"little_lemon_store", "user":"root", "password":""}
try:
    pool = MySQLConnectionPool(pool_name = "pool_a",
                               pool_size=3,
                               **dbconfig)
    print("The connection pool is created with a name: ",pool.pool_name)

except Error as er:
    print("Error code:", er.errno)


# In[8]:


print("Getting a connection from the pool.")
connection1 = pool.get_connection()


# In[15]:


print("Creating a cursor obj")
cursor = connection1.cursor()


# In[16]:


# Stored procedure name >> PeakHours
# Our stored procedure query is
stored_procedure_query="""
CREATE PROCEDURE AddBo()
BEGIN
SELECT COUNT(BookingID) AS n_bookings,
HOUR(BookingSlot) AS Hour 
FROM Bookings
GROUP BY Hour
ORDER BY Hour aSC;
END
"""


# In[17]:


# Execute the query
cursor.execute(stored_procedure_query)


# In[18]:


#Call the stored procedure with its name
cursor.callproc("BookingHour")


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


# In[37]:


hhh="""DROP BasicSalesReport; """


# In[38]:


stored_procedure_query="""
CREATE PROCEDURE SalesReport()
BEGIN
SELECT SUM(BillAmount) AS Total_sales,
AVG(BillAmount) AS Average_sale,
MIN(BillAmount) AS Minimum_bill,
MAX(BillAmount) AS Maximum_bill
FROM Orders;
END
"""
# Execute the query
cursor.execute(stored_procedure_query)
# calling the procedure
cursor.callproc("BasicSalesReport")
# Retrieve recrods in "dataset"
results = next( cursor.stored_results() )
dataset = results.fetchall()


# In[ ]:


connection.close()

