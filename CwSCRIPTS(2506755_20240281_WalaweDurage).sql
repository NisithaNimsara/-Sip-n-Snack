/* Section 4 */
                                                                                -- Database Creation

CREATE DATABASE CafeManagement;


                                                                                -- Table Creation
CREATE TABLE Customer (
    customerID char(4),
    firstName varchar(15) not null,
    lastName varchar(20) not null,
    dateOfBirth date not null,
    houseID varchar(15) not null,
    street varchar(20) not null,
    city varchar(20) not null,
    emailAddress varchar(35) unique,
    registrationDate date not null,
    CONSTRAINT c_cust_pk PRIMARY key (customerID)
);

CREATE TABLE Cust_Tele_Number (
    customerID char(4),
    telephoneNumber char(10),
    CONSTRAINT ct_custtele_fk FOREIGN key (customerID) REFERENCES customer(customerID),
    CONSTRAINT ct_custTele_pk PRIMARY key (customerID , telephoneNumber)
);

CREATE TABLE order_Detail (
    orderID char(4),
    orderDate date not null,
    orderTime time not null,
    preferredDeliveryDate date not null,
    preferredDeliveryTime time not null,
    traceID char(4) UNIQUE not null,
    orderStatus varchar(20) not null,
    customerID char(4) not null,
    CONSTRAINT o_order_pk PRIMARY key (orderID),
    CONSTRAINT o_cust_fk FOREIGN key (customerID) REFERENCES customer(customerID)
);

CREATE TABLE payment (
    paymentID char(4),
    paymentMethod varchar(35) not null,
    paymentStatus varchar(20) not null,
    amountPaid float(8,2) not null,
    paymentDate date not null,
    paymenttime time not null,
    customerID char(4) not null,
    orderID char(4) not null,
    CONSTRAINT p_paym_pk PRIMARY key (paymentID),
    CONSTRAINT p_cust_fk FOREIGN key (customerID) REFERENCES customer(customerID),
    CONSTRAINT p_order_fk FOREIGN key (orderID) REFERENCES order_detail(orderID)
);


CREATE TABLE Employee (
    employeeID char(4),
    designation varchar(25) not null,
    firstName varchar(15) not null,
    lastName varchar(20) not null,
    dateOfBirth date not null,
    houseID varchar(15) not null,
    street varchar(20) not null,
    city varchar(20) not null,
    emailAddress varchar(35) UNIQUE,
    supervisorID char(4),
    CONSTRAINT e_empid_pk PRIMARY key (employeeID),
    CONSTRAINT e_supid_fk FOREIGN key (supervisorID) REFERENCES Employee(employeeID)
);

CREATE TABLE Emp_Tele_Number (
    employeeID char(4),
    telephoneNumber char(10),
    CONSTRAINT et_emptele_fk FOREIGN key (employeeID) REFERENCES employee(employeeID),
    CONSTRAINT et_empTele_pk PRIMARY key (employeeID , telephoneNumber)
);

CREATE TABLE delivery_Staff (
    employeeID char(4),
    drivingLicenseNumber char(10) not null UNIQUE,
    CONSTRAINT dest_empid_fk FOREIGN key (employeeID) REFERENCES employee(employeeID),
    CONSTRAINT dest_destid_pk PRIMARY key (employeeID)
);


CREATE TABLE Vehicle (
    vehicleID char(4),
    vehicleType varchar(15) not null,
    vehicleModel varchar(50) not null,
    licensePlateNumber varchar(12) not null UNIQUE,
    fualType varchar(15) not null,
    cargoCapasity float(9,2) not null,
    vehicleStatus varchar(20) not null,
	driverID char(4) not null,
    CONSTRAINT ve_velid_pk PRIMARY KEY (vehicleID),
	CONSTRAINT ve_drid_fk FOREIGN key (driverID) REFERENCES Employee(employeeID)
);


CREATE TABLE Assignment (
    orderID char(4),
    StewardID char(4),
    vehicleID char(4),
    CONSTRAINT as_ordid_fk FOREIGN key (orderID) REFERENCES order_detail(orderID),
    CONSTRAINT as_empid_fk FOREIGN key (stewardID) REFERENCES employee(employeeID),
    CONSTRAINT as_vehid_fk FOREIGN key (vehicleID) REFERENCES vehicle(vehicleID),
    CONSTRAINT as_asiggid_pk PRIMARY key (orderID ,StewardID, vehicleID)
);


CREATE TABLE Inventory (
    inventoryID char(4),
    stocklevel float(10,2) not null,
    reloadLevel float(8,2) not null,
    managerID char(4) not null,
    CONSTRAINT in_invtid_pk PRIMARY key (inventoryID),
    CONSTRAINT in_manid_fk FOREIGN key (managerID) REFERENCES Employee(employeeID)
);

CREATE TABLE Item (
    itemID char(4),
    name varchar(20) not null,
    price float(8,2) not null,
    category varchar(20) not null,
    discription varchar(150) not null,
    availability varchar(20) not null,
    inventoryID char(4) not null,
    CONSTRAINT it_itmid_pk PRIMARY key (itemID),
    CONSTRAINT it_inventid_fk FOREIGN key (inventoryID) REFERENCES inventory(inventoryID)
);


CREATE TABLE Ordered_Product (
    orderID char(4),
    itemID char(4),
    quantity int(5) NOT null,
    CONSTRAINT op_ordid_fk FOREIGN key (orderID) REFERENCES order_detail(orderID),
    CONSTRAINT op_itmid_fk FOREIGN key (itemID) REFERENCES item(itemID),
    CONSTRAINT op_ordprod_pk PRIMARY key (orderID , itemID)
);



CREATE TABLE Supplier (
    supplierID char(4),
    firstName varchar(15) not null,
    lastName varchar(20) not null,
    CONSTRAINT s_supid_pk PRIMARY key (supplierID)
);



CREATE TABLE Sup_Tele_Number (
    supplierID char(4),
    telephoneNumber char(10),
    CONSTRAINT stn_sypid_fk FOREIGN key (supplierID) REFERENCES supplier(supplierID),
    CONSTRAINT stn_supTele_pk PRIMARY key (supplierID , telephoneNumber)
);


CREATE TABLE source_details (
    itemID char(4),
    supplierID char(4),
    CONSTRAINT sode_itmid_fk FOREIGN key (itemID) REFERENCES item(itemID),
    CONSTRAINT sode_supid_fk FOREIGN key (supplierID) REFERENCES supplier(supplierID),
    CONSTRAINT sode_sordelid_pk PRIMARY key (itemID ,supplierID)
);

CREATE TABLE Card_Payment (
    paymentID char(4),
    cardtype varchar(10) not null,
    ownerName varchar(35) not null,
    cardNumber char(19) not null,
    expireDate varchar(5) not null,
    CONSTRAINT cp_payid_fk FOREIGN key (paymentID) REFERENCES payment(paymentID),
    CONSTRAINT cp_cardpy_pk PRIMARY key (paymentID)
);


                                                                                -- insert PART --

INSERT into customer
VALUES
('C001', 'Bruce', 'Wayne', '1975-02-19', 'H101', 'Gotham St', 'Gotham', 'bruce.wayne@example.com', '2023-01-15'), 
('C002', 'Clark', 'Kent', '1980-06-18', 'H102', 'Metropolis Ave', 'Metropolis', 'clark.kent@example.com', '2023-02-10'),  
('C003', 'Diana', 'Prince', '1985-03-22', 'H103', 'Amazon Rd', 'Themyscira', 'diana.prince@example.com', '2023-03-05'),  
('C004', 'Barry', 'Allen', '1992-07-12', 'H104', 'Central Blvd', 'Central City', 'barry.allen@example.com', '2023-04-20'),  
('C005', 'Hal', 'Jordan', '1983-11-11', 'H105', 'Oa St', 'Coast City', 'hal.jordan@example.com', '2023-05-30'),  
('C006', 'Arthur', 'Curry', '1988-09-05', 'H106', 'Atlantis Ln', 'Atlantis', 'arthur.curry@example.com', '2023-06-25'),  
('C007', 'Victor', 'Stone', '1995-12-02', 'H107', 'Titan Tower', 'Jump City', 'victor.stone@example.com', '2023-07-10'),  
('C008', 'Oliver', 'Queen', '1981-08-29', 'H108', 'Star St', 'Star City', 'oliver.queen@example.com', '2023-08-15'),  
('C009', 'Selina', 'Kyle', '1987-04-17', 'H109', 'Shadow Alley', 'Gotham', 'selina.kyle@example.com', '2023-09-05'),  
('C010', 'Billy', 'Batson', '2005-10-14', 'H110', 'Rock of Eternity', 'Fawcett City', 'billy.batson@example.com', '2023-10-20')  
;

INSERT into cust_tele_number
VALUES
('C001', '0771111111'),
('C002', '0742222222'), 
('C002', '0763333333'), 
('C001', '0701231232'), 
('C005', '0773666663'),
('C006', '0752323236'),
('C007', '0773548979'),
('C008', '0785456453'),
('C009', '0724999876')
;

insert into Employee
VALUES
('E001', 'Manager', 'Tony', 'Stark', '1970-05-29', '201', 'Avengers Tower', 'New York', 'tony.stark@example.com', NULL),
('E002', 'Manager', 'Steve', 'Rogers', '1918-07-04', '202', 'Brooklyn St', 'New York', 'steve.rogers@example.com', Null),  
('E003', 'Steward', 'Nicola', 'Romanoff', '1984-11-22', '203', 'Red Room Blvd', 'Moscow', 'Nicola.romanoff@example.com', 'E001'),  
('E004', 'Driver', 'Peter', 'Parker', '2001-08-10', '204', 'Queens Ave', 'New York', 'peter.parker@example.com', 'E001'),  
('E005', 'Steward', 'Bruce', 'Banner', '1969-12-18', '205', 'Gamma St', 'Dayton', 'bruce.banner@example.com', 'E002'),  
('E006', 'Steward', 'John', 'Odinson', '1500-01-01', '106', 'Asgardian Rd', 'Asgard', 'john.odinson@example.com', 'E002'),  
('E007', 'Steward', 'Peter', 'Barton', '1980-01-07', '107', 'Sharpshooter Ln', 'Iowa', 'peter.barton@example.com', 'E001'),  
('E008', 'Driver', 'Wanda', 'Maximoff', '1989-02-10', '208', 'Hex St', 'Sokovia', 'wanda.maximoff@example.com', 'E002'),  
('E009', 'Driver', 'T’Challa', 'Udaku', '1980-05-21', '209', 'Royal Palace', 'Wakanda', 'tchalla.udaku@example.com', 'E006'),  
('E010', 'Driver', 'Stephen', 'Strange', '1975-11-18', '210', 'Sanctum St', 'New York', 'stephen.strange@example.com', 'E006')
;

insert into Emp_Tele_Number
VALUES
('E001', '0701234567'),
('E002', '0777654321'), 
('E003', '0762334455'), 
('E004', '0746778899'), 
('E005', '0757889900'), 
('E006', '0773445566'), 
('E007', '0754556677'), 
('E008', '0725667788'), 
('E001', '0716778890'), 
('E002', '0747889901'),
('E009', '0768765487'),
('E010', '0712345634') 
;

insert into delivery_Staff
VALUES
('E004', 'DL12345678'),
('E008', 'DL87654321'),
('E009', 'DL11223344'),
('E010', 'DL87656735')
;

insert into Vehicle
VALUES
('V001', 'Bike', 'Honda CB125F', 'ABC123XYZ', 'Petrol', 15.00, 'Active', 'E004'),
('V002', 'Minivan', 'Toyota HiAce', 'DEF456LMN', 'Diesel', 1200.50, 'Active', 'E004'),
('V003', 'Truck', 'Ford Transit', 'GHI789OPQ', 'Diesel', 2500.75, 'Inactive', 'E010'), 
('V004', 'Bike', 'Yamaha YBR125', 'JKL012RST', 'Petrol', 18.00, 'Active', 'E008'),
('V005', 'Minivan', 'Mercedes-Benz Vito', 'MNO345UVW', 'Electric', 1100.00, 'Under Maintenance', 'E008'),
('V006', 'Scooter', 'Vespa Primavera', 'PQR678XYZ', 'Petrol', 12.50, 'Active', 'E009')
;

insert into Inventory
VALUES
('IN01', 150.75, 50.00, 'E001'), 
('IN02', 320.50, 100.00, 'E001'), 
('IN03', 75.25, 30.00, 'E002'),
('IN04', 200.00, 80.00, 'E002'), 
('IN05', 90.60, 40.00, 'E002')
;

insert into Item
VALUES
('I001', 'Espresso', 3.50, 'Beverage', 'Strong and rich coffee shot.', 'Available', 'IN01'),
('I002', 'Cappuccino', 4.20, 'Beverage', 'Espresso with steamed milk and foam.', 'Available', 'IN01'),  
('I003', 'Blueberry Muffin', 2.80, 'Snack', 'Soft muffin with fresh blueberries.', 'Available', 'IN02'),  
('I004', 'Chocolate Cake', 5.50, 'Cake', 'Rich and moist chocolate cake.', 'Available', 'IN03'),  
('I005', 'Tiramisu', 6.75, 'Dessert', 'Classic Italian coffee-flavored dessert.', 'Available', 'IN02'),  
('I006', 'Cheesecake', 6.00, 'Dessert', 'Creamy cheesecake with a biscuit base.', 'Out of Stock', 'IN02'),  
('I007', 'Macarons', 4.50, 'Specialty', 'Colorful and delicate almond meringue cookies.', 'Available', 'IN02'),  
('I008', 'Chai Latte', 4.00, 'Beverage', 'Spiced tea with steamed milk.', 'Available', 'IN03'),  
('I009', 'Americano', 3.00, 'Beverage', 'Espresso diluted with hot water.', 'Available', 'IN04'),  
('I010', 'Croissant', 2.50, 'Snack', 'Flaky and buttery French pastry.', 'Available', 'IN04'),  
('I011', 'Red Velvet Cake', 5.80, 'Cake', 'Moist red velvet cake with cream cheese frosting.', 'Available', 'IN05'),  
('I012', 'Brownie', 3.25, 'Dessert', 'Rich and fudgy chocolate brownie.', 'Available', 'IN04'),  
('I013', 'Matcha Latte', 4.75, 'Beverage', 'Green tea latte with steamed milk.', 'Out of Stock', 'IN05')  
;

insert into supplier
VALUES
('S001', 'Alex', 'Luther'),
('S002', 'Joe', 'Kerr'),
('S003', 'Harley', 'Quinnley'),  
('S004', 'Selina', 'Keller'),  
('S005', 'Ozzie', 'Cobble'),  
('S006', 'Eddie', 'Nash'),  
('S007', 'Sam', 'Wilson'),  
('S008', 'Ray', 'Gould')  
;

insert into Sup_Tele_Number
VALUES
('S001', '0416543210'),  
('S002', '0435432109'), 
('S003', '0914321098'),  
('S004', '0413210987'),  
('S005', '0912109876'),
('S006', '0419878533'),
('S007', '0914534563'),
('S008', '0417878787')
;  

insert into source_details
VALUES
('I001', 'S001'),  
('I002', 'S002'),  
('I003', 'S003'),  
('I004', 'S001'),  
('I005', 'S004'),  
('I006', 'S005'),  
('I007', 'S002'),
('I008', 'S006'),
('I009', 'S004'),
('I010', 'S007'),
('I011', 'S008'),
('I012', 'S008'),
('I013', 'S003')  
;

INSERT INTO order_detail
VALUES
('O001', '2025-02-20', '14:30:00', '2025-03-22', '10:00:00', 'T001', 'Pending', 'C001'),
('O002', '2025-02-21', '09:15:00', '2025-03-23', '12:30:00', 'T002', 'Completed', 'C003'),  
('O003', '2025-03-22', '18:45:00', '2025-03-24', '14:00:00', 'T003', 'Processing', 'C005'),  
('O004', '2025-03-23', '11:00:00', '2025-03-25', '16:30:00', 'T004', 'Completed', 'C002'),
('O005', '2025-03-24', '20:20:00', '2025-03-26', '09:45:00', 'T005', 'Completed', 'C004'),
('O006', '2025-03-21', '16:45:00', '2025-03-26', '12:30:00', 'T006', 'Processing', 'C006'),  
('O007', '2025-03-22', '10:15:00', '2025-03-27', '09:00:00', 'T007', 'Completed', 'C009'),  
('O008', '2025-03-23', '18:00:00', '2025-03-27', '15:45:00', 'T008', 'Completed', 'C007'),  
('O009', '2025-03-24', '09:30:00', '2025-03-29', '08:15:00', 'T009', 'Processing', 'C008'), 
('O010', '2025-03-25', '13:20:00', '2025-03-29', '11:00:00', 'T010', 'Completed', 'C010'),
('O011', '2025-03-26', '08:45:00', '2025-03-30', '10:30:00', 'T011', 'Pending', 'C002'),  
('O012', '2025-03-27', '15:10:00', '2025-03-31', '12:45:00', 'T012', 'Completed', 'C005'),  
('O013', '2025-03-28', '11:55:00', '2025-04-01', '14:15:00', 'T013', 'Processing', 'C001'),  
('O014', '2025-03-29', '19:30:00', '2025-04-02', '16:00:00', 'T014', 'Completed', 'C004'),  
('O015', '2025-03-30', '07:20:00', '2025-04-03', '09:30:00', 'T015', 'Cancelled', 'C003'),  
('O016', '2025-03-31', '17:40:00', '2025-04-04', '13:00:00', 'T016', 'Completed', 'C006'),  
('O017', '2025-04-01', '14:25:00', '2025-04-05', '08:45:00', 'T017', 'Completed', 'C007'),  
('O018', '2025-04-02', '09:50:00', '2025-04-06', '16:30:00', 'T018', 'Completed', 'C008'),  
('O019', '2025-04-03', '12:10:00', '2025-04-07', '15:20:00', 'T019', 'Pending', 'C009'),  
('O020', '2025-04-04', '18:35:00', '2025-04-08', '11:15:00', 'T020', 'Completed', 'C010')  
;

INSERT INTO ordered_product  
VALUES  
('O001', 'I001', 2),  
('O001', 'I003', 1),  
('O002', 'I005', 3),  
('O002', 'I008', 2),  
('O003', 'I002', 1),  
('O003', 'I006', 2),  
('O004', 'I007', 4),  
('O004', 'I009', 3),  
('O005', 'I004', 2),  
('O005', 'I010', 1),  
('O006', 'I005', 2),  
('O006', 'I011', 3),  
('O007', 'I003', 1),  
('O007', 'I012', 4),  
('O008', 'I002', 2),  
('O008', 'I013', 1),  
('O009', 'I006', 3),  
('O009', 'I007', 2),  
('O010', 'I008', 1),  
('O010', 'I009', 4),  
('O011', 'I010', 2),  
('O011', 'I011', 1),  
('O012', 'I004', 3),  
('O012', 'I005', 2),  
('O013', 'I006', 1),  
('O013', 'I007', 4),  
('O014', 'I008', 2),  
('O014', 'I009', 3),  
('O015', 'I010', 1),  
('O015', 'I011', 2),  
('O016', 'I012', 3),  
('O016', 'I013', 1),  
('O017', 'I002', 4),  
('O017', 'I005', 2),  
('O018', 'I003', 3),  
('O018', 'I007', 1),  
('O019', 'I006', 2),  
('O019', 'I010', 4),  
('O020', 'I008', 1),  
('O020', 'I009', 2)  
;

insert into Assignment
VALUES 
('O001', 'E003', 'V001'),  
('O002', 'E005', 'V002'),  
('O003', 'E006', 'V003'),  
('O004', 'E007', 'V004'),  
('O005', 'E003', 'V005'),  
('O006', 'E006', 'V006'),  
('O007', 'E005', 'V002'),  
('O008', 'E007', 'V003'),  
('O009', 'E003', 'V005'),  
('O010', 'E005', 'V001'),  
('O011', 'E007', 'V004'),  
('O012', 'E006', 'V006'),  
('O013', 'E007', 'V002'),  
('O014', 'E005', 'V003'),  
('O015', 'E003', 'V005'),  
('O016', 'E006', 'V002'),  
('O017', 'E007', 'V004'),  
('O018', 'E005', 'V001'),  
('O019', 'E003', 'V006'),  
('O020', 'E006', 'V003')
;  

INSERT INTO payment  
VALUES  
('P001', 'Credit Card', 'Completed', 28.25, '2025-03-20', '14:35:00', 'C003', 'O002'),  
('P002', 'Cash on delivery', 'Completed', 27, '2025-03-21', '09:20:00', 'C002', 'O004'),  
('P003', 'Debit Card', 'Completed', 13.5, '2025-03-22', '18:50:00', 'C004', 'O005'),  
('P004', 'Cash on delivery', 'Completed', 15.8, '2025-03-23', '11:05:00', 'C009', 'O007'),  
('P005', 'Credit Card', 'Completed', 13.15, '2025-03-24', '20:25:00', 'C007', 'O008'),  
('P006', 'Debit Card', 'Completed', 16, '2025-03-25', '16:45:00', 'C010', 'O010'),  
('P007', 'Cash on delivery', 'Completed', 30, '2025-03-26', '10:30:00', 'C005', 'O012'),  
('P008', 'Debit Card', 'Completed', 17, '2025-03-27', '18:10:00', 'C004', 'O014'),  
('P009', 'credit Card', 'Refunded', 14.1, '2025-03-28', '09:45:00', 'C003', 'O015'),  
('P010', 'Cash on delivery', 'Completed', 14.5, '2025-03-29', '13:50:00', 'C006', 'O016'),  
('P011', 'Credit Card', 'Completed', 30.3, '2025-03-30', '08:20:00', 'C007', 'O017'),  
('P012', 'Cash on delivery', 'Completed', 12.9, '2025-03-31', '12:15:00', 'C008', 'O018'),
('P013', 'Cash on delivery', 'Completed',10, '2025-04-01', '02:12:34','C010','O020')
;

insert into Card_Payment
VALUES
('P001', 'Visa', 'Diana Prince', '4111 1111 1111 1111', '12/27'),
('P003', 'MasterCard', 'Barry Allen', '5500 0000 0000 0004', '06/26'),
('P005', 'Visa', 'Victor Stone', '3400 0000 0000 0096', '09/28'),
('P006', 'MasterCard', 'Billy Batson', '1234 6543 0988 3345', '12/06'),
('P008', 'MasterCard', 'Barry Allen', '5500 0000 0000 0004', '06/26'),
('P009', 'Visa', 'Diana Prince', '4111 1111 1111 1111', '12/27'),
('P011', 'Visa', 'Victor Stone', '3400 0000 0000 0096', '09/28')
;

/* Section 5*/

-- Question-1)
SELECT item.name as "Item Name", item.category,COUNT(order_detail.orderID) As "Total Number of Orders"
FROM order_detail JOIN ordered_product
ON order_detail.orderID = ordered_product.orderID
JOIN item
ON item.itemID = ordered_product.itemID
WHERE order_detail.orderDate BETWEEN '2025-03-00' and '2025-04-00'
GROUP by item.itemID
ORDER by COUNT(order_detail.orderID) DESC
LIMIT 10;

-- Question-2)
SELECT employee.employeeID, concat(employee.firstName," ",employee.lastName) as "Full Name",sum(payment.amountPaid) as "total revenue"
FROM employee join assignment
on employee.employeeID = assignment.StewardID
JOIN order_detail
on order_detail.orderID = assignment.orderID
JOIN payment
ON order_detail.orderID = payment.orderID
WHERE employee.firstName IN ('John','Peter','Nicola') and order_detail.orderStatus = "Completed" and order_detail.preferredDeliveryDate BETWEEN '2025-03-23' and '2025-04-06'
GROUP BY employeeID
HAVING COUNT(order_detail.orderID) > 5;

-- Question-3)
SELECT order_detail.orderID, order_detail.orderStatus, order_detail.preferredDeliveryDate as
"expected delivery date", order_detail.preferredDeliveryTime as "expected delivery time"
FROM order_detail join payment
on order_detail.orderID = payment.orderID
JOIN assignment
ON order_detail.orderID = assignment.orderID
JOIN vehicle
on vehicle.vehicleID = assignment.vehicleID
WHERE payment.paymentMethod = "Cash on delivery" and vehicle.vehicleType <> "Minivan" and
concat(order_detail.preferredDeliveryDate,' ', order_detail.preferredDeliveryTime) BETWEEN
concat("2025-04-06"," ",'12:23:00') and concat("2025-04-06"," ",'22:23:00');
