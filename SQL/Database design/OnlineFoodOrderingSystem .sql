CREATE DATABASE OnlineFoodOrdering;
USE OnlineFoodOrdering;

DROP TABLE Customers;
DROP TABLE Restaurants;
DROP TABLE MenuItems;
DROP TABLE Orders;
DROP TABLE OrderDetails;
DROP TABLE Reviews;


-- Table creation ----------------------------------------------------------------------------------------------------------------------------
# Customers table
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL ,
    Phone VARCHAR(20),
    RegistrationDate DATE NOT NULL
);

INSERT INTO Customers (FirstName, LastName, Email, Phone, RegistrationDate) Values
('Aarav', 'Sharma', 'aaravsharma12@gmail.com', 9420657834, '2025-06-12'),
('Nilesh', 'Gund', 'nilesh24gund@outlook.com', 7854120987, '2025-06-20'),
('Abhishek', 'Patil', 'abhishekpatil20@gmail.com', 9876124520 ,'2025-06-29'), 
('Rutvik', 'Shinde', 'rutvikshinde3326@gmail.com', 90671324590, '2025-07-05'),
('Samiksha', 'Shirke', 'samikshashirke47@gmail.com', 8976453102, '2025-07-19'),
('Nikita', 'Jadhav', 'nikajadhav490@gmail.com', 8745349905, '2025-07-25'),
('Rakesh', 'Rokade', 'rakeshrokade34@outlook.com', 7743095678, '2025-08-02'),
('Samrudhi', 'Jain', 'samrudhijain08@gmail.com', 9876542080, '2025-08-10'),
('Neha', 'Sawant', 'neha.sawant@hotmail.com', 9833301122, '2025-08-16'),
('Pooja', 'Kale', 'pooja1011kale@gmail.com', 9822334455, '2025-09-04'),
('Arjun', 'Singh', 'arjun.singh1212@yahoo.com', 8823457605, '2025-09-15'),
('Meera', 'Joshi', 'meerajoshi@hotmail.com', 9897969510, '2025-09-28'),
('Vikram', 'Kumar', 'vikramk143@gmail.com', 7865342982, '2025-10-06'),
('Kavita', 'Nair', 'kavitanair357@gmail.com', 8654385682, '2025-10-17'),
('Aditi', 'Desai', 'aditi726@gmail.com', 9876213420, '2025-10-25');

SELECT * FROM Customers;


# Restaurants table
CREATE TABLE Restaurants (
	RestaurantID INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL ,
    CuisineType VARCHAR(100) NOT NULL
);

INSERT INTO Restaurants (RestaurantName, Address, CuisineType) VALUES
('Spice Garden', 'FC Road, Shivajinagar, Pune', 'North Indian'),
('Royal Biryani House', 'MG Road, Camp, Pune', 'Biryani'),
('Wok & Roll', 'Viman Nagar, Pune', 'Chinese'),
('Tandoori Nights', 'Kothrud, Pune', 'Mughlai'),
('Masala Twist', 'Baner Road, Pune', 'Indian Fusion'),
('Bombay Chaat Corner', 'Koregaon Park, Pune', 'Street Food'),
('Burger Hub', 'Hinjewadi Phase 1, Pune', 'Fast Food'),
('Italiano Café', 'Aundh, Pune', 'Italian'); 

SELECT * FROM Restaurants;


# MenuItems table
CREATE TABLE MenuItems (
	MenuItemID INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantID INT NOT NULL,
    ItemName VARCHAR(100) NOT NULL,
	Price DECIMAL(10,2) NOT NULL,
    Description TEXT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

INSERT INTO MenuItems (RestaurantID, ItemName, Price, Description) VALUES
-- Spice Garden (North Indian, RestaurantID: 1, 5 items)
(1, 'Butter Chicken', 350.00, 'Creamy tomato-based curry with tender chicken pieces.'),
(1, 'Paneer Tikka', 250.00, 'Marinated paneer cubes grilled to perfection.'),
(1, 'Dal Makhani', 200.00, 'Slow-cooked black lentils with butter and cream.'),
(1, 'Aloo Gobi', 180.00, 'Cauliflower and potato stir-fry with spices.'),
(1, 'Naan', 50.00, 'Soft Indian bread baked in a tandoor oven.'),

-- Royal Biryani House (Biryani, RestaurantID: 2, 6 items)
(2, 'Chicken Biryani', 300.00, 'Fragrant basmati rice with spiced chicken and boiled eggs.'),
(2, 'Mutton Biryani', 400.00, 'Aromatic rice dish with tender mutton and saffron.'),
(2, 'Veg Biryani', 250.00, 'Mixed vegetables cooked with basmati rice and spices.'),
(2, 'Paneer Biryani', 280.00, 'Paneer cubes in spiced rice with nuts and raisins.'),
(2, 'Hyderabadi Biryani', 350.00, 'Authentic layered biryani with marinated meat.'),
(2, 'Raita', 80.00, 'Yogurt dip with cucumber and spices.'),

-- Wok & Roll (Chinese, RestaurantID: 3, 4 items)
(3, 'Kung Pao Chicken', 320.00, 'Spicy stir-fried chicken with peanuts and vegetables.'),
(3, 'Veg Manchurian', 250.00, 'Deep-fried vegetable balls in tangy sauce.'),
(3, 'Fried Rice', 200.00, 'Wok-tossed rice with vegetables and soy sauce.'),
(3, 'Spring Rolls', 150.00, 'Crispy rolls filled with cabbage and carrots.'),

-- Tandoori Nights (Mughlai, RestaurantID: 4, 5 items)
(4, 'Tandoori Chicken', 400.00, 'Marinated chicken grilled in a clay oven.'),
(4, 'Seekh Kebab', 350.00, 'Minced meat skewers with spices.'),
(4, 'Malai Kofta', 280.00, 'Creamy dumplings in rich gravy.'),
(4, 'Shahi Paneer', 300.00, 'Paneer in a creamy, nutty sauce.'),
(4, 'Rumali Roti', 60.00, 'Thin, handkerchief-like bread.'),

-- Masala Twist (Indian Fusion, RestaurantID: 5, 3 items)
(5, 'Fusion Pizza', 450.00, 'Indian spices on a pizza base with paneer and veggies.'),
(5, 'Tandoori Wrap', 250.00, 'Grilled chicken wrap with fusion sauces.'),
(5, 'Masala Fries', 180.00, 'Spicy potato fries with Indian twists.'),

-- Bombay Chaat Corner (Street Food, RestaurantID: 6, 6 items)
(6, 'Pani Puri', 100.00, 'Hollow puris filled with spiced water and chutneys.'),
(6, 'Bhel Puri', 120.00, 'Puffed rice mix with veggies and tangy sauce.'),
(6, 'Vada Pav', 80.00, 'Spicy potato fritter in a bun.'),
(6, 'Pav Bhaji', 150.00, 'Mashed veggies with buttered bread.'),
(6, 'Sev Puri', 110.00, 'Crispy puris topped with sev and chutneys.'),
(6, 'Dahi Bhalla', 130.00, 'Lentil dumplings in yogurt.'),

-- Burger Hub (Fast Food, RestaurantID: 7, 4 items)
(7, 'Classic Burger', 250.00, 'Beef patty with lettuce, tomato, and cheese.'),
(7, 'Veggie Burger', 200.00, 'Plant-based patty with fresh veggies.'),
(7, 'Chicken Nuggets', 180.00, 'Crispy fried chicken pieces.'),
(7, 'Fries', 100.00, 'Golden potato fries with salt.'),

-- Italiano Café (Italian, RestaurantID: 8, 5 items)
(8, 'Margherita Pizza', 400.00, 'Tomato, mozzarella, and basil on thin crust.'),
(8, 'Pasta Alfredo', 350.00, 'Creamy fettuccine with parmesan cheese.'),
(8, 'Lasagna', 450.00, 'Layered pasta with meat sauce and cheese.'),
(8, 'Tiramisu', 200.00, 'Coffee-flavored dessert with mascarpone.'),
(8, 'Garlic Bread', 150.00, 'Toasted bread with garlic butter.');

SELECT * FROM MenuItems;


# Orders Table
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    RestaurantID INT NOT NULL,
    OrderDate DATE NOT NULL, 
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

INSERT INTO Orders (CustomerID, RestaurantID, OrderDate, TotalAmount) VALUES 
(1, 1, '2025-06-15', 580.00),
(1, 2, '2025-06-20', 300.00),
(1, 3, '2025-07-02', 450.00),
(1, 6, '2025-07-15', 210.00),
(1, 4, '2025-08-01', 650.00),
(1, 8, '2025-09-10', 400.00),
(1, 5, '2025-10-22', 480.00),
(2, 2, '2025-06-25', 700.00),
(2, 6, '2025-07-06', 120.00),
(2, 1, '2025-08-12', 560.00),
(2, 5, '2025-09-28', 450.00),
(3, 3, '2025-07-01', 350.00),
(3, 1, '2025-07-05', 220.00),
(3, 2, '2025-07-10', 300.00),
(3, 7, '2025-07-25', 250.00),
(3, 6, '2025-08-03', 150.00),
(3, 5, '2025-08-30', 480.00),
(3, 4, '2025-09-18', 700.00),
(3, 8, '2025-10-20', 400.00),
(4, 1, '2025-07-10', 350.00),
(4, 2, '2025-08-05', 400.00),
(4, 7, '2025-09-25', 200.00),
(5, 6, '2025-07-22', 110.00),
(5, 3, '2025-08-01', 250.00),
(5, 5, '2025-08-15', 450.00),
(5, 1, '2025-08-28', 550.00),
(5, 8, '2025-09-30', 350.00),
(5, 4, '2025-10-18', 700.00),
(6, 2, '2025-07-30', 280.00),
(6, 8, '2025-08-12', 450.00),
(6, 6, '2025-09-30', 120.00),
(7, 1, '2025-08-05', 600.00),
(7, 3, '2025-08-12', 200.00),
(7, 7, '2025-08-22', 250.00),
(7, 6, '2025-09-02', 150.00),
(7, 2, '2025-09-15', 350.00),
(7, 4, '2025-09-28', 700.00),
(7, 8, '2025-10-10', 400.00),
(7, 5, '2025-10-25', 450.00),
(8, 6, '2025-08-15', 100.00),
(8, 3, '2025-08-25', 250.00),
(8, 8, '2025-09-18', 350.00),
(8, 1, '2025-10-26', 550.00),
(9, 1, '2025-08-20', 570.00),
(9, 5, '2025-08-30', 450.00),
(9, 7, '2025-09-10', 250.00),
(9, 4, '2025-09-25', 700.00),
(9, 2, '2025-10-05', 300.00),
(9, 6, '2025-10-18', 120.00),
(9, 8, '2025-11-05', 400.00),
(10, 6, '2025-09-10', 150.00),
(10, 2, '2025-09-18', 280.00),
(10, 1, '2025-10-08', 550.00),
(11, 3, '2025-09-18', 220.00),
(11, 7, '2025-09-22', 250.00),
(11, 1, '2025-10-01', 580.00),
(11, 4, '2025-10-08', 700.00),
(11, 2, '2025-10-15', 350.00),
(11, 5, '2025-10-22', 450.00),
(11, 6, '2025-10-30', 110.00),
(11, 8, '2025-11-07', 300.00),
(12, 4, '2025-10-05', 650.00),
(12, 1, '2025-10-12', 550.00),
(12, 5, '2025-10-22', 480.00),
(12, 6, '2025-11-05', 140.00),
(13, 2, '2025-10-10', 350.00),
(13, 3, '2025-10-16', 250.00),
(13, 1, '2025-10-22', 560.00),
(13, 8, '2025-10-28', 400.00),
(13, 7, '2025-11-03', 250.00),
(13, 6, '2025-11-08', 130.00),
(14, 3, '2025-10-25', 250.00),
(14, 7, '2025-11-05', 200.00),
(15, 5, '2025-10-30', 480.00),
(15, 1, '2025-11-01', 560.00),
(15, 4, '2025-11-03', 700.00),
(15, 3, '2025-11-05', 250.00),
(15, 6, '2025-11-06', 120.00),
(15, 2, '2025-11-07', 350.00),
(15, 8, '2025-11-09', 400.00),
(15, 7, '2025-11-10', 200.00);

SELECT * FROM Orders;

UPDATE Orders SET TotalAmount = 430.00 WHERE OrderID IN (7, 17, 64, 74) AND TotalAmount = 480.00;
UPDATE Orders SET TotalAmount = 430.00 WHERE OrderID = 15; 
UPDATE Orders SET TotalAmount = 250.00 WHERE OrderID = 13;
UPDATE Orders SET TotalAmount = 550.00 WHERE OrderID = 44;
UPDATE Orders SET TotalAmount = 200.00 WHERE OrderID = 54;
UPDATE Orders SET TotalAmount = 180.00 WHERE OrderID = 65;



# OrderDetails Table
CREATE TABLE OrderDetails (
	OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    MenuItemID INT NOT NULL,
    Quantity INT NOT NULL, 
    ItemPrice Decimal(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID)
);

INSERT INTO OrderDetails (OrderID, MenuItemID, Quantity, ItemPrice) VALUES
-- Order 1: R1, Total 580 (Butter Chicken 350 + Aloo Gobi 180 + Naan 50)
(1, 1, 1, 350.00), (1, 4, 1, 180.00), (1, 5, 1, 50.00),
-- Order 2: R2, Total 300 (Chicken Biryani)
(2, 6, 1, 300.00),
-- Order 3: R3, Total 450 (Veg Manchurian 250 + Fried Rice 200)
(3, 13, 1, 250.00), (3, 14, 1, 200.00),
-- Order 4: R6, Total 210 (Pani Puri 100 + Sev Puri 110)
(4, 24, 1, 100.00), (4, 28, 1, 110.00),
-- Order 5: R4, Total 650 (Seekh Kebab 350 + Shahi Paneer 300)
(5, 17, 1, 350.00), (5, 19, 1, 300.00),
-- Order 6: R8, Total 400 (Margherita Pizza)
(6, 34, 1, 400.00),
-- Order 7: R5, (Tandoori Wrap 250 + Masala Fries 180)
(7, 22, 1, 250.00), (7, 23, 1, 180.00),
-- Order 8: R2, Total 700 (Hyderabadi Biryani x2)
(8, 10, 2, 350.00),
-- Order 9: R6, Total 120 (Bhel Puri)
(9, 25, 1, 120.00),
-- Order 10: R1, Total 560 (Dal Makhani 200 + Aloo Gobi 180 x2)
(10, 3, 1, 200.00), (10, 4, 2, 180.00),
-- Order 11: R5, Total 450 (Fusion Pizza)
(11, 21, 1, 450.00),
-- Order 12: R3, Total 350 (Fried Rice 200 + Spring Rolls 150)
(12, 14, 1, 200.00), (12, 15, 1, 150.00),
-- Order 13: R1, 250 (Paneer Tikka)
(13, 2, 1, 250.00),
-- Order 14: R2, Total 300 (Chicken Biryani)
(14, 6, 1, 300.00),
-- Order 15: R7, Total 250 (Classic Burger)
(15, 30, 1, 250.00),
-- Order 16: R6, Total 150 (Pav Bhaji)
(16, 27, 1, 150.00),
-- Order 17: R5, Corrected to 430 (Wrap + Fries)
(17, 22, 1, 250.00), (17, 23, 1, 180.00),
-- Order 18: R4, Total 700 (Tandoori Chicken 400 + Shahi Paneer 300)
(18, 16, 1, 400.00), (18, 19, 1, 300.00),
-- Order 19: R8, Total 400 (Margherita Pizza)
(19, 34, 1, 400.00),
-- Order 20: R1, Total 350 (Butter Chicken)
(20, 1, 1, 350.00),
-- Order 21: R2, Total 400 (Mutton Biryani)
(21, 7, 1, 400.00),
-- Order 22: R7, Total 200 (Veggie Burger)
(22, 31, 1, 200.00),
-- Order 23: R6, Total 110 (Sev Puri)
(23, 28, 1, 110.00),
-- Order 24: R3, Total 250 (Veg Manchurian)
(24, 13, 1, 250.00),
-- Order 25: R5, Total 450 (Fusion Pizza)
(25, 21, 1, 450.00),
-- Order 26: R1, Total 550 (Butter Chicken 350 + Dal Makhani 200)
(26, 1, 1, 350.00), (26, 3, 1, 200.00),
-- Order 27: R8, Total 350 (Pasta Alfredo)
(27, 35, 1, 350.00),
-- Order 28: R4, Total 700 (Tandoori Chicken 400 + Shahi Paneer 300)
(28, 16, 1, 400.00), (28, 19, 1, 300.00),
-- Order 29: R2, Total 280 (Paneer Biryani)
(29, 9, 1, 280.00),
-- Order 30: R8, Total 450 (Lasagna)
(30, 36, 1, 450.00),
-- Order 31: R6, Total 120 (Bhel Puri)
(31, 25, 1, 120.00),
-- Order 32: R1, Total 600 (Butter Chicken 350 + Paneer Tikka 250)
(32, 1, 1, 350.00), (32, 2, 1, 250.00),
-- Order 33: R3, Total 200 (Fried Rice)
(33, 14, 1, 200.00),
-- Order 34: R7, Total 250 (Classic Burger)
(34, 30, 1, 250.00),
-- Order 35: R6, Total 150 (Pav Bhaji)
(35, 27, 1, 150.00),
-- Order 36: R2, Total 350 (Hyderabadi Biryani)
(36, 10, 1, 350.00),
-- Order 37: R4, Total 700 (Tandoori Chicken + Shahi Paneer)
(37, 16, 1, 400.00), (37, 19, 1, 300.00),
-- Order 38: R8, Total 400 (Pizza)
(38, 34, 1, 400.00),
-- Order 39: R5, Total 450 (Pizza)
(39, 21, 1, 450.00),
-- Order 40: R6, Total 100 (Pani Puri)
(40, 24, 1, 100.00),
-- Order 41: R3, Total 250 (Veg Manchurian)
(41, 13, 1, 250.00),
-- Order 42: R8, Total 350 (Pasta)
(42, 35, 1, 350.00),
-- Order 43: R1, Total 550 (Butter Chicken + Dal)
(43, 1, 1, 350.00), (43, 3, 1, 200.00),
-- Order 44: R1, Corrected to 550 (Butter Chicken + Dal)
(44, 1, 1, 350.00), (44, 3, 1, 200.00),
-- Order 45: R5, Total 450 (Pizza)
(45, 21, 1, 450.00),
-- Order 46: R7, Total 250 (Burger)
(46, 30, 1, 250.00),
-- Order 47: R4, Total 700 (Chicken + Paneer)
(47, 16, 1, 400.00), (47, 19, 1, 300.00),
-- Order 48: R2, Total 300 (Chicken Biryani)
(48, 6, 1, 300.00),
-- Order 49: R6, Total 120 (Bhel Puri)
(49, 25, 1, 120.00),
-- Order 50: R8, Total 400 (Pizza)
(50, 34, 1, 400.00),
-- Order 51: R6, Total 150 (Pav Bhaji)
(51, 27, 1, 150.00),
-- Order 52: R2, Total 280 (Paneer Biryani)
(52, 9, 1, 280.00),
-- Order 53: R1, Total 550 (Butter Chicken + Dal)
(53, 1, 1, 350.00), (53, 3, 1, 200.00),
-- Order 54: R3, Corrected to 200 (Fried Rice)
(54, 14, 1, 200.00),
-- Order 55: R7, Total 250 (Burger)
(55, 30, 1, 250.00),
-- Order 56: R1, Total 580 (Butter Chicken + Aloo + Naan)
(56, 1, 1, 350.00), (56, 4, 1, 180.00), (56, 5, 1, 50.00),
-- Order 57: R4, Total 700
(57, 16, 1, 400.00), (57, 19, 1, 300.00),
-- Order 58: R2, Total 350
(58, 10, 1, 350.00),
-- Order 59: R5, Total 450
(59, 21, 1, 450.00),
-- Order 60: R6, Total 110
(60, 28, 1, 110.00),
-- Order 61: R8, Total 300 (Garlic Bread x2)
(61, 38, 2, 150.00),
-- Order 62: R4, Total 650 (Seekh Kebab + Shahi Paneer)
(62, 17, 1, 350.00), (62, 19, 1, 300.00),
-- Order 63: R1, Total 550
(63, 1, 1, 350.00), (63, 3, 1, 200.00),
-- Order 64: R5, (Wrap + Fries)
(64, 22, 1, 250.00), (64, 23, 1, 180.00),
-- Order 65: R6, (Pani Puri + Vada Pav)
(65, 24, 1, 100.00), (65, 26, 1, 80.00),
-- Order 66: R2, Total 350
(66, 10, 1, 350.00),
-- Order 67: R3, Total 250
(67, 13, 1, 250.00),
-- Order 68: R1, Total 560 (Dal + Aloo + Aloo)
(68, 3, 1, 200.00), (68, 4, 2, 180.00),
-- Order 69: R8, Total 400
(69, 34, 1, 400.00),
-- Order 70: R7, Total 250
(70, 30, 1, 250.00),
-- Order 71: R6, Total 130 (Dahi Bhalla)
(71, 29, 1, 130.00),
-- Order 72: R3, Total 250
(72, 13, 1, 250.00),
-- Order 73: R7, Total 200
(73, 31, 1, 200.00),
-- Order 74: R5, Total 430
(74, 22, 1, 250.00), (74, 23, 1, 180.00),
-- Order 75: R1, Total 560
(75, 3, 1, 200.00), (75, 4, 2, 180.00),
-- Order 76: R4, Total 700
(76, 16, 1, 400.00), (76, 19, 1, 300.00),
-- Order 77: R3, Total 250
(77, 13, 1, 250.00),
-- Order 78: R6, Total 120
(78, 25, 1, 120.00),
-- Order 79: R2, Total 350
(79, 10, 1, 350.00),
-- Order 80: R8, Total 400
(80, 34, 1, 400.00),
-- Order 81: R7, Total 200
(81, 31, 1, 200.00);

SELECT * FROM OrderDetails;


# Reviews
CREATE TABLE Reviews (
	ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantID INT NOT NULL,
	CustomerID INT NOT NULL, 
    ReviewDate DATE NOT NULL,
    Rating DECIMAL(2,1) NOT NULL CHECK(Rating >= 1.0 AND Rating <= 5.0),
    Comments TEXT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Reviews (RestaurantID, CustomerID, ReviewDate, Rating, Comments) VALUES 
(1, 1, '2025-06-16', 5.0, 'The Butter Chicken was absolutely divine! Best I have had in Pune.'),
(2, 2, '2025-06-26', 4.5, 'Authentic Hyderabadi flavor. The spices were perfect, just a bit oily.'),
(4, 1, '2025-08-02', 5.0, 'Tandoori Nights never disappoints. The Seekh Kebabs were juicy and tender.'),
(8, 6, '2025-08-13', 4.8, 'The Lasagna was cheesy and rich. Great ambiance too!'),
(4, 9, '2025-09-26', 5.0, 'Malai Kofta is a must-try here. Melt in the mouth.'),
(6, 10, '2025-09-11', 4.2, 'Vada Pav was fresh and spicy. Loved the green chutney.'),
(5, 12, '2025-10-23', 4.5, 'The Masala Fries are a unique concept! Really enjoyed the fusion flavors.'),
(8, 9, '2025-11-06', 4.7, 'Tiramisu was the perfect end to the meal. Authentic Italian taste.'),
(8, 11, '2025-11-08', 5.0, 'Garlic Bread and Pasta Alfredo combination is heaven.'),
(4, 15, '2025-11-04', 4.9, 'Perfect place for a family dinner. Great service.'),
(6, 3, '2025-08-04', 3.5, 'Pani Puri was tasty, but the place was too crowded and noisy.'),
(2, 13, '2025-10-11', 3.8, 'Biryani was good, but the rice felt slightly dry this time.'),
(3, 7, '2025-08-13', 3.0, 'Fried rice was okay, but the Manchurian was too salty for my taste.'),
(3, 14, '2025-10-26', 3.5, 'Decent Chinese food at affordable prices, but nothing extraordinary.'),
(1, 8, '2025-10-27', 3.2, 'Food is great, but the service was incredibly slow on the weekend.'),
(5, 5, '2025-08-16', 2.5, 'The Fusion Pizza was weird. Some flavors just do not go together.'),
(7, 11, '2025-09-23', 1.5, 'Very disappointed. The burger was cold and the fries were soggy.'),
(1, 5, '2025-08-29', 2.0, 'Found a hair in my Dal Makhani. Completely ruined my appetite.'),
(7, 4, '2025-09-26', 2.2, 'Chicken nuggets were overcooked and hard as a rock.'),
(6, 9, '2025-10-19', 2.8, 'Hygiene seemed questionable at the counter. Dahi Bhalla was sour.');

SELECT * FROM Reviews;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM OrderDetails WHERE OrderID IN (22, 26, 27, 28, 31);

DELETE FROM Orders WHERE OrderID IN (22, 26, 27, 28, 31);



