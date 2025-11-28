# Sip'n Snack – Café Management Database

A relational database for managing operations at the **Sip 'n Snack** café.  
This project focuses on **database design, normalization, and SQL querying** to handle customers, employees, orders, payments, deliveries, and inventory in a small café environment.

---

## Features

- Structured schema for core café operations:
  - Customers & contact details
  - Employees & roles (manager, steward, driver, etc.)
  - Orders & ordered products
  - Payments (including card payments)
  - Deliveries & vehicle assignments
  - Inventory, items, and suppliers
- Sample data to demonstrate realistic usage.
- Example SQL queries for:
  - Popular items and order statistics
  - Customer orders and payment methods
  - Delivery time windows and vehicle constraints

---

## Database Schema Overview

Main tables defined in the script:

- `Customer` – Basic customer information and address.
- `Cust_Tele_Number` – One-to-many customer phone numbers.
- `Employee` – Employee details and roles.
- `Emp_Tele_Number` – One-to-many employee phone numbers.
- `delivery_Staff` – Mapping between employees and delivery responsibilities.
- `Vehicle` – Vehicles used for deliveries.
- `Assignment` – Which driver/vehicle delivers which order.
- `Inventory` – Stock levels and reload thresholds.
- `Item` – Café menu items (name, price, category, availability).
- `Ordered_Product` – Items included in each order.
- `order_Detail` – Order metadata (status, delivery time, etc.).
- `Supplier` – Information about suppliers.
- `Sup_Tele_Number` – Supplier phone numbers.
- `source_details` – Links suppliers to inventory.
- `payment` – Payment records and methods.
- `Card_Payment` – Card-specific payment information.

The schema uses **primary keys**, **foreign keys**, and basic **constraints** to maintain referential integrity.

---

