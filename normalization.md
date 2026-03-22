# Database normalization

## Initial table

The initial table contains the following columns:

- order_number
- product_name_and_quantity
- customer_address
- order_date
- customer_name

Example data shows that one order can contain multiple products in a single field, for example:
- "Laptop: 3, Mouse: 2"

This structure has several problems:
- one column stores multiple values;
- customer data is duplicated across orders;
- product data is mixed with order data;
- the table contains repeating groups and is not normalized.

---

## First Normal Form (1NF)

To convert the table into 1NF, all attributes must contain atomic values only.

The column `product_name_and_quantity` is split into:
- product_name
- qty

After conversion to 1NF, each row represents one product in one order.

Example logical structure in 1NF:
- order_number
- order_date
- customer_name
- customer_address
- product_name
- qty

At this step:
- all values are atomic;
- repeating groups are removed;
- each row describes a single order item.

---

## Second Normal Form (2NF)

To reach 2NF, partial dependencies must be removed.

In the 1NF structure, customer data depends on the customer, not on the whole row.
Product name depends on the product, not on the whole row.
Quantity depends on the combination of order and product.

Therefore, the data is divided into separate entities:

- `customers(id, name, address)`
- `orders(id, order_date, customer_id)`
- `SKU(id, name)`
- `order_SKU(order_id, SKU_id, qty)`

At this step:
- customer data is separated from orders;
- product data is separated from orders;
- the intersection table `order_SKU` stores the quantity of each product in each order.

---

## Third Normal Form (3NF)

To reach 3NF, transitive dependencies must be removed.

In the final schema:
- `orders` stores only order attributes and the reference to the customer;
- `customers` stores customer attributes only;
- `SKU` stores product attributes only;
- `order_SKU` stores only the relationship between orders and products, plus quantity.

Final schema:

- `customers(id, name, address)`
- `orders(id, order_date, customer_id)`
- `SKU(id, name)`
- `order_SKU(order_id, SKU_id, qty)`

Why this schema is in 3NF:
- each table represents one entity;
- each non-key attribute depends only on the key;
- there are no repeating groups;
- there are no partial dependencies;
- there are no transitive dependencies.

---

## ER model summary

Relationships in the final schema:

- one customer can have many orders;
- one order can contain many products;
- one product can appear in many orders.

Therefore:
- `customers` → `orders` is a one-to-many relationship;
- `orders` → `order_SKU` is a one-to-many relationship;
- `SKU` → `order_SKU` is a one-to-many relationship.

The table `order_SKU` resolves the many-to-many relationship between orders and products.
