/*****************************************************************************
   Script: Northwind_CREATE_ENHANCED_TestPlan_DB.sql
   Description: DBAS 1100 - Project 2 - DB validation 
   DB Server: Oracle
   Author: Jay Song (W0302272)
********************************************************************************/

/*
Validation 1: Get all information from Employees table
Purpose: review all the data entries are showed up properly and migrated data is well placed in the table
Expected Result: 
  - 9 employees should be listed up.
  - Check new entities: Full name with title, countryID instead of country name
*/
SELECT * FROM NWnew.Employees;

/*
Validation 2: Get all information from Customers table
Purpose: review all the data entries are showed up properly and migrated data is well placed in the table
Expected Result: 
  - 91 customers should be listed up in alphabetical order with "Customer Alpha Code"
  - Check new entities: CustomerID, Customer Alpha Code, CountryID
*/
SELECT * FROM NWnew.Customers;

/*
Validation 3: Get all information from Country table
Purpose: review all the data entries are showed up properly and migrated data is well placed in the table
Expected Result: 
  - 25 countries should be listed up in the alphabetical order
  - each country should have its unique ID
*/
SELECT * FROM NWnew.Country;

/*
Validation 4: list of company names which ordered more than 15 times
Purpose: verify record counts between the original and new database
Expected Result: 
  - The new DB should display the same result with the original DB 
*/
-- From New DB
SELECT NWnew.Customers.companyName, COUNT(NWnew.Orders.OrderID) AS "Num of Orders"
FROM NWnew.Customers
  INNER JOIN NWnew.Orders ON NWnew.Customers.customerID = NWnew.Orders.customerID
GROUP BY NWnew.Customers.companyName
HAVING COUNT(NWnew.Orders.OrderID) > 15
ORDER BY "Num of Orders" DESC;

-- FROM Original DB
SELECT NWorig.Customers.companyName, COUNT(NWorig.Orders.OrderID) AS "Num of Orders"
FROM NWorig.Customers
  INNER JOIN NWorig.Orders ON NWorig.Customers.customerID = NWorig.Orders.customerID
GROUP BY NWorig.Customers.companyName
HAVING COUNT(NWorig.Orders.OrderID) > 15
ORDER BY "Num of Orders" DESC;

/*
Validation 5: list of product name, units in stock and units on order that stored at "the dockside warehouse" 
Purpose: verify the integrity of all new primary to foreign key relationships
Expected Result: 
  - list up all product names, number of units in stock and number of orders 
*/
SELECT productname, unitsInStock AS "Num of Units", unitsOnOrder AS "Num of Orders" 
FROM NWnew.Products
WHERE warehouseID = (SELECT warehouseID
                      FROM NWnew.Warehouse
                      WHERE lower(warehouseName) = 'the dockside warehouse')
ORDER BY "Num of Units" DESC;

/*
Validation 6: Insert a new record into orders table with duplicate OrderID
Purpose: verify the database constraints 
Expected Result: 
  - New data record should be failed (Unique constraint violated)
*/
  INSERT INTO NWnew.Orders
  (OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,
    ShippedDate,ShipVia,Freight,ShipName,ShipAddress,
    ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
  VALUES (11077,20,1,'5/6/1998','6/3/1998',NULL,2,8.53,
    'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque',
    'NM','87110',5);

/*
Validation 7: Insert a new record into orders table
Purpose: verify the data record creatation 
Expected Result: 
  - New data record should be inserted
*/
  INSERT INTO NWnew.Orders
  (OrderID,CustomerID,EmployeeID,OrderDate,RequiredDate,
    ShippedDate,ShipVia,Freight,ShipName,ShipAddress,
    ShipCity,ShipRegion,ShipPostalCode,ShipCountry)
  VALUES (11078,20,1,'5/6/1998','6/3/1998',NULL,2,8.53,
    'Rattlesnake Canyon Grocery','2817 Milton Dr.','Albuquerque',
    'NM','87110',5);

/*
Validation 8: Insert a new record into employees table
Purpose: verify the database constraints (invalid foreign key for CountryID)
Expected Result: 
  - New data record should be failed (parent key not found)
*/
Insert into NWnew.EMPLOYEES
  Values(10, 'Song', 'Jay', 'Sales Representative', 'Mr.','Mr. Jay Song', TO_DATE('07/02/1969 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
  TO_DATE('11/15/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '7 Houndstooth Rd.', 'London', NULL, 'WG2 7LT', 35, 
  '(71) 555-4444', '452', 'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5);

/*
Validation 9: Insert a new record into employees table
Purpose: verify the data record creatation
Expected Result: 
  - New data record should be inserted
*/
Insert into NWnew.EMPLOYEES
  Values(10, 'Song', 'Jay', 'Sales Representative', 'Mr.','Mr. Jay Song', TO_DATE('07/02/1969 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
  TO_DATE('11/15/1994 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '7 Houndstooth Rd.', 'London', NULL, 'WG2 7LT', 10, 
  '(71) 555-4444', '452', 'Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.', 5);

/*
Validation 10: Insert a new record into products table
Purpose: verify the database constraints (invalid type for warehouseID)
Expected Result: 
  - New data record should be failed (invalid number)
*/
INSERT INTO NWnew.Products(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,
UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued,warehouseID) 
VALUES(78,'Frankfurter grüne Soße',12,2,'10 boxes',13,32,0,15,0,'The Dockside warehouse');

/*
Validation 11: Insert a new record into product table
Purpose: verify the data record creatation
Expected Result: 
  - New data record should be inserted
*/
INSERT INTO NWnew.Products(ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,
UnitPrice,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued,warehouseID) 
VALUES(78,'Frankfurter grüne Soße',12,2,'10 boxes',13,32,0,15,0,2);

/*
Validation 12: removal of all test records mentioned above
Purpose: verify the data record removal
Expected Result:
  - Test data record should be removed
*/
DELETE FROM NWnew.Orders WHERE OrderID=11078;

DELETE FROM NWnew.EMPLOYEES WHERE EmployeeID=10;

DELETE FROM NWnew.Products WHERE ProductID=78;