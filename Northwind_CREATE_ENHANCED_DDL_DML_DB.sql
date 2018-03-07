/*****************************************************************************
   Script: Northwind_CREATE_ENHANCED_DDL_DML_DB.sql
   Description: DBAS 1100 - Project 2 - Data Migration
   DB Server: Oracle 
   Author: Jay Song (W0302272)
********************************************************************************/

/*
DBAS 1100 - Project 2 - Data Migration
"Starting" database
--Full DDL/DML script to create and populate the Northwind database
*/

--BEGIN TABLE DROP STATEMENTS
-- Drop all Northwind tables (13)
  DROP TABLE NWnew.ORDER_DETAILS PURGE;
  DROP TABLE NWnew.ORDERS PURGE;
  DROP TABLE NWnew.PRODUCTS PURGE;
  DROP TABLE NWnew.SUPPLIERS PURGE;
  DROP TABLE NWnew.CATEGORIES PURGE; 
  DROP TABLE NWnew.WAREHOUSE PURGE;
  DROP TABLE NWnew.CUSTOMERS PURGE;
  DROP TABLE NWnew.EMPLOYEETERRITORIES PURGE;
  DROP TABLE NWnew.TERRITORIES PURGE;
  DROP TABLE NWnew.REGION PURGE;
  DROP TABLE NWnew.EMPLOYEES PURGE;
  DROP TABLE NWnew.COUNTRY PURGE;
  DROP TABLE NWnew.SHIPPERS PURGE;
--END TABLE DROP STATEMENTS

--BEGIN TABLE CREATION STATEMENTS
--Create all Northwind tables (13)
  CREATE TABLE NWnew.COUNTRY (
    CountryID number(3) NOT NULL,
    Name varchar (15) NOT NULL
  );
  
  CREATE TABLE NWnew.Employees (
    EmployeeID number(3) NOT NULL ,
    LastName varchar (20) NOT NULL ,
    FirstName varchar (10) NOT NULL ,
    Title varchar (30) NULL ,
    TitleOfCourtesy varchar (25) NULL ,
    FullNameWithTitle varchar (55) NULL,
    BirthDate date NULL ,
    HireDate date NULL ,
    Address varchar (60) NULL ,
    City varchar (15) NULL ,
    Region varchar (15) NULL ,
    PostalCode varchar (10) NULL ,
    CountryID number(3) NULL,    
    HomePhone varchar (24) NULL ,
    Extension varchar (4) NULL ,
    Notes varchar(500) NULL ,
    ReportsTo number NULL
  );
  
  CREATE TABLE NWnew.Categories (
    CategoryID number(2) NOT NULL ,
    CategoryName varchar(15) NOT NULL ,
    Description varchar(255) NULL
  );
    
  CREATE TABLE NWnew.Customers (
    CustomerID number NOT NULL ,
    CustomerAlphaCode varchar(5) NOT NULL,    
    CompanyName varchar (40) NOT NULL ,
    ContactName varchar (30) NULL ,
    ContactTitle varchar (30) NULL ,
    Address varchar (60) NULL ,
    City varchar (15) NULL ,
    Region varchar (15) NULL ,
    PostalCode varchar (10) NULL ,
    CountryID number(3) NULL ,
    Phone varchar (24) NULL ,
    Fax varchar (24) NULL
  );
  
  CREATE TABLE NWnew.Shippers (
    ShipperID number NOT NULL ,
    CompanyName varchar (40) NOT NULL ,
    Phone varchar (24) NULL
  );
  
  CREATE TABLE NWnew.Suppliers (
    SupplierID number NOT NULL ,
    CompanyName varchar (40) NOT NULL ,
    ContactName varchar (30) NULL ,
    ContactTitle varchar (30) NULL ,
    Address varchar (60) NULL ,
    City varchar (15) NULL ,
    Region varchar (15) NULL ,
    PostalCode varchar (10) NULL ,
    CountryID number(3) NULL ,
    Phone varchar (24) NULL ,
    Fax varchar (24) NULL ,
    HomePage varchar(2000) NULL
  );
  
  CREATE TABLE NWnew.Orders (
    OrderID number NOT NULL ,
    CustomerID number NULL ,
    EmployeeID number NULL ,
    OrderDate varchar(15) NULL ,
    RequiredDate varchar(15) NULL ,
    ShippedDate varchar(15) NULL ,
    ShipVia number NULL ,
    Freight number NULL,
    ShipName varchar (40) NULL ,
    ShipAddress varchar (60) NULL ,
    ShipCity varchar (15) NULL ,
    ShipRegion varchar (15) NULL ,
    ShipPostalCode varchar (10) NULL ,
    ShipCountry number(3) NULL
  );
  
  CREATE TABLE NWnew.Warehouse (
    WarehouseID number(1) NOT NULL ,
    WarehouseName varchar(30) NOT NULL ,
    Address varchar(60) NULL
  );
    
  CREATE TABLE NWnew.Products (
    ProductID number  NOT NULL ,
    ProductName varchar (40) NOT NULL ,
    SupplierID number NULL ,
    CategoryID number NULL ,
    QuantityPerUnit varchar (20) NULL ,
    UnitPrice number NULL ,
    UnitsInStock number NULL ,
    UnitsOnOrder number NULL ,
    ReorderLevel number NULL ,    
    Discontinued number NOT NULL,
    WarehouseID number(1) NULL
  );
  
  CREATE TABLE NWnew.Order_Details (
    OrderID number NOT NULL ,
    ProductID number NOT NULL ,
    UnitPrice number NOT NULL ,
    Quantity number NOT NULL ,
    Discount number NOT NULL
  );
    
  CREATE TABLE NWnew.Region 
    ( RegionID number NOT NULL ,
    RegionDescription varchar (50) NOT NULL 
  );
  
  CREATE TABLE NWnew.Territories 
    (TerritoryID varchar (20) NOT NULL ,
    TerritoryDescription varchar (50) NOT NULL ,
    RegionID number NOT NULL
  );
  
  CREATE TABLE NWnew.EmployeeTerritories 
    (EmployeeID number NOT NULL,
    TerritoryID varchar (20) NOT NULL 
  );
--END TABLE CREATION STATEMENTS

--BEGIN ALTER TABLE STATEMENTS
--Add all Key and Check Constraints
  ALTER TABLE NWnew.Country
    ADD (
      CONSTRAINT PK_Country PRIMARY KEY (CountryID)
      );
      
  ALTER TABLE NWnew.Employees
    ADD (
      CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID),
      CONSTRAINT FK_Employees_Employees FOREIGN KEY (ReportsTo) 
      REFERENCES Employees (EmployeeID),
      CONSTRAINT FK_Employees_Country FOREIGN KEY (CountryID) 
      REFERENCES Country (CountryID)
      );
  
  ALTER TABLE NWnew.Categories
    ADD (
      CONSTRAINT PK_Categories PRIMARY KEY (CategoryID)
    );
  
  ALTER TABLE NWnew.Customers
    ADD (
      CONSTRAINT PK_Customers PRIMARY KEY (CustomerID),
      CONSTRAINT FK_Customers_Country FOREIGN KEY (CountryID) 
      REFERENCES Country (CountryID)
    );
  
  ALTER TABLE NWnew.Shippers
    ADD (
      CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID)
    );
  
  ALTER TABLE NWnew.Suppliers
    ADD (
      CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID),
      CONSTRAINT FK_Suppliers_Country FOREIGN KEY (CountryID) 
      REFERENCES Country (CountryID)
    );
  
  ALTER TABLE NWnew.Orders
    ADD (
      CONSTRAINT PK_Orders PRIMARY KEY (OrderID),
      CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) 
        REFERENCES Customers (CustomerID),
      CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID),
      CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) 
        REFERENCES Shippers (ShipperID),
      CONSTRAINT FK_Orders_Country FOREIGN KEY (ShipCountry) 
      REFERENCES Country (CountryID)
    );
  
  ALTER TABLE NWnew.Warehouse 
    ADD (
      CONSTRAINT PK_Warehouse PRIMARY KEY (WarehouseID)
      );
      
  ALTER TABLE NWnew.Products
    ADD (
      CONSTRAINT PK_Products PRIMARY KEY (ProductID),
      CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)
        REFERENCES Categories (CategoryID),
      CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID)
        REFERENCES Suppliers (SupplierID),
      CONSTRAINT FK_Products_Warehouse FOREIGN KEY (WarehouseID)
        REFERENCES Warehouse (WarehouseID),        
      CONSTRAINT CK_Products_UnitPrice CHECK (UnitPrice >= 0),
      CONSTRAINT CK_ReorderLevel CHECK (ReorderLevel >= 0),
      CONSTRAINT CK_UnitsInStock CHECK (UnitsInStock >= 0),
      CONSTRAINT CK_UnitsOnOrder CHECK (UnitsOnOrder >= 0),       
      CONSTRAINT CK_Discontinued CHECK (Discontinued IN (0,1))

    );
  
  ALTER TABLE NWnew.Order_Details
    ADD (
      CONSTRAINT PK_Order_Details PRIMARY KEY (OrderID,	ProductID),
      CONSTRAINT FK_Order_Details_Orders FOREIGN KEY (OrderID)
        REFERENCES Orders (OrderID),
      CONSTRAINT FK_Order_Details_Products FOREIGN KEY (ProductID)
        REFERENCES Products (ProductID),
      CONSTRAINT CK_Discount CHECK (Discount >= 0 and (Discount <= 1)),
      CONSTRAINT CK_Quantity CHECK (Quantity > 0),
      CONSTRAINT CK_UnitPrice CHECK (UnitPrice >= 0)
    );
  
  ALTER TABLE NWnew.Region
    ADD CONSTRAINT PK_Region PRIMARY KEY (RegionID);
  
  ALTER TABLE NWnew.Territories
    ADD (
      CONSTRAINT PK_Territories PRIMARY KEY (TerritoryID),
      CONSTRAINT FK_Territories_Region FOREIGN KEY (RegionID)
        REFERENCES Region (RegionID)
        );
  
  ALTER TABLE NWnew.EmployeeTerritories
    ADD (
    CONSTRAINT PK_EmployeeTerritories PRIMARY KEY(EmployeeID,TerritoryID),
    CONSTRAINT FK_EmplTerritories_Employees FOREIGN KEY (EmployeeID)
      REFERENCES Employees (EmployeeID),
    CONSTRAINT FK_EmplTerritories_Territories FOREIGN KEY (TerritoryID)
      REFERENCES Territories (TerritoryID)
      );
--END ALTER TABLE STATEMENTS

--BEGIN DATA INSERT STATEMENTS

  --COUNTRY
INSERT INTO NWnew.Country
SELECT ROW_NUMBER() OVER(ORDER BY "Country"), "Country" FROM (SELECT Employees.Country AS "Country" FROM NWOrig.Employees
UNION
SELECT Orders.ShipCountry AS "Country" FROM NWOrig.Orders
UNION
SELECT Customers.Country AS "Country" FROM NWOrig.Customers
UNION
SELECT Suppliers.Country AS "Country" FROM NWOrig.Suppliers);  

  --SHIPPERS
INSERT INTO NWnew.Shippers
SELECT * FROM NWorig.Shippers;

  --SUPPLIERS
INSERT INTO NWnew.Suppliers
SELECT supplierID,companyName,contactName,contactTitle,address,city,region,postalcode,NWnew.Country.countryID, phone,fax,homepage 
FROM NWorig.Suppliers
  INNER JOIN NWnew.Country ON NWnew.Country.name = NWorig.Suppliers.Country;
  
  --EMPLOYEES
INSERT INTO NWnew.Employees
SELECT employeeID,lastname,firstname,title,titleofcourtesy,titleOfCourtesy || ' ' || firstname || ' ' || lastname As "fullnameWithTitle",birthdate,
        hiredate,address,city,region,postalcode,NWnew.Country.countryID,homephone,extension,notes,reportsTo
FROM NWorig.Employees
  INNER JOIN NWnew.Country ON NWnew.Country.name = NWorig.Employees.Country
ORDER BY employeeID;
  
  --REGIONS
INSERT INTO NWnew.Region
SELECT * FROM NWorig.Region;

  --TERRITORIES
INSERT INTO NWnew.Territories
SELECT * FROM NWorig.Territories;

  --EMPLOYEETERRITORIES
INSERT INTO NWnew.Employeeterritories
SELECT * FROM NWorig.Employeeterritories;

  --CUSTOMERS
INSERT INTO NWnew.Customers
SELECT ROW_NUMBER() OVER(ORDER BY customerID),customerID,companyName,contactName,contactTitle,address,city,region,postalcode,NWnew.Country.countryID,phone,fax
FROM NWorig.Customers
  INNER JOIN NWnew.Country ON NWnew.Country.name = NWorig.Customers.Country; 
  
  --CATEGORIES
INSERT INTO NWnew.Categories
SELECT * FROM NWorig.Categories;

  --WAREHOUSE
CREATE SEQUENCE Warehouse_warehouseID_seq
START WITH 1
INCREMENT BY 1;

INSERT INTO NWnew.Warehouse (warehouseID, warehouseName, address) VALUES(Warehouse_warehouseID_seq.nextval,'the Dockside warehouse',
                              '123 Dockside St.');
INSERT INTO NWnew.Warehouse (warehouseID, warehouseName, address) VALUES(Warehouse_warehouseID_seq.nextval,'the Airport warehouse',
                              '456 Airport Ave.');
INSERT INTO NWnew.Warehouse (warehouseID, warehouseName, address) VALUES(Warehouse_warehouseID_seq.nextval,'the Central warehouse',
                              '789 Central Rd.');
                              
DROP SEQUENCE Warehouse_warehouseID_seq;

  --PRODUCTS
INSERT INTO NWnew.Products (productID, productName,supplierID,categoryID,quantityPerUnit,unitPrice,unitsInStock,unitsOnOrder,reorderLevel,discontinued)
SELECT * FROM NWorig.Products;

UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 1;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 2;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 3;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 4;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 5;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 6;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 7;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 8;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 9;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 10;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 11;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 12;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 13;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 14;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 15;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 16;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 17;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 18;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 19;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 20;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 21;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 22;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 23;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 24;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 25;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 26;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 27;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 28;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 29;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 30;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 31;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 32;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 33;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 34;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 35;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 36;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 37;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 38;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 39;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 40;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 41;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 42;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 43;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 44;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 45;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 46;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 47;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 48;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 49;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 50;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 51;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 52;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 53;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 54;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 55;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 56;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 57;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 58;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 59;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 60;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 61;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 62;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 63;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 64;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 65;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 66;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 67;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 68;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 69;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 70;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 71;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 72;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 73;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 74;
UPDATE NWnew.Products SET WareHouseID = 1 WHERE ProductID = 75;
UPDATE NWnew.Products SET WareHouseID = 3 WHERE ProductID = 76;
UPDATE NWnew.Products SET WareHouseID = 2 WHERE ProductID = 77;

  --ORDERS
INSERT INTO NWnew.Orders
SELECT orderID,NWnew.customers.customerID,employeeID,orderdate,requiredDate,shippedDate,shipvia,freight,shipName,shipAddress,shipCity,
        shipRegion,shipPostalCode,NWnew.Country.countryID
FROM NWorig.Orders
  INNER JOIN NWnew.Customers ON NWnew.Customers.customerAlphaCode = NWorig.Orders.customerID
  INNER JOIN NWnew.Country ON NWnew.Country.name = NWorig.Orders.shipCountry;
  
  --ORDER DETAILS
INSERT INTO NWnew.Order_details
SELECT * FROM NWorig.Order_details;

--END DATA INSERT STATEMENTS