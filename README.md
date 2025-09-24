# E_CommerceDB

### Tables 

- Users

- Products
  
- Orders
   
- OrderItems
 
- Payments
 
- Categories

### Relationships

- Users ↔ Orders → One user can place many orders.

- Orders ↔ OrderItems → An order can have many products; a product can appear in many orders.

- Products ↔ Categories → Each product belongs to a category.

- Orders ↔ Payments → Each order can have one payment record.

### ER Diagram

### Labeled entities:

- Users (Orders, Payments)

- Orders (User, OrderItems)

- OrderItems(Order, Product)

- Products (OrderItems, Categories)

- Categories (Products)

- Payments (User, Order)

<img width="1233" height="803" alt="Screenshot 2025-09-24 173802" src="https://github.com/user-attachments/assets/df407737-58aa-44f8-ae2b-408264afbfd3" />
