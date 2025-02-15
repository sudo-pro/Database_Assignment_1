# SQL Queries Explanation

---

### 1. Table Creation

#### Customer Table

Stores customer details with `customer_id` as the primary key.

#### Product Table

Stores product details, including `product_id` as the primary key, and tracks stock.

#### Order Table

Stores order information, linking each order to a customer via `customer_id` (foreign key).

#### OrderDetail Table

Stores the details of each product in an order, linking to both `Order` and `Product` tables via foreign keys.

---

### 2. Inserting Data

#### Product Table

Inserts 5 products with names, prices, and stock quantities.

#### Customer Table

Inserts 5 customers with their contact details and addresses.

#### Order Table

Inserts 5 orders with total prices, order dates, and shipping addresses.

#### OrderDetail Table

Inserts details of products ordered, linking to specific orders and products.

---

### 3. Retrieve Orders for a Specific Customer

```sql
SELECT c.customer_name, p.product_name, o.order_date, od.quantity
FROM "Order" o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN OrderDetail od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
WHERE c.customer_id = 1;
```

---

### 4. Find the Most Purchased Product

```sql
SELECT p.product_name, SUM(od.quantity) AS total_quantity
FROM OrderDetail od
JOIN Product p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;
```

---

### 5. Trigger to Update Stock

```sql
-- Create a Trigger to Update Stock Quantity after an Order is Placed
CREATE OR REPLACE FUNCTION update_stock_quantity() 
RETURNS TRIGGER AS $$
BEGIN
    -- Update the stock quantity of the product after an order is placed
    UPDATE Product
    SET stocks = stocks - NEW.quantity
    WHERE product_id = NEW.product_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- When a new OrderDetail record is inserted the trigger activates automatically the insertion
INSERT INTO "Order" (customer_id, total_price, order_date, shipping_address)
VALUES (1, 10000, '2025-02-13', '12, MG Road, Bangalore, Karnataka');
INSERT INTO OrderDetail (order_id, product_id, unit_price, quantity)
VALUES (6, 2, 10000, 1);

```

Automatically updates the product stock when an OrderDetail is inserted.

### 6. Delete a Customer's Record

```sql
DELETE FROM Customer WHERE customer_id = 1;

```
