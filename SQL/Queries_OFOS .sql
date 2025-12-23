USE OnlineFoodOrdering;

-- Problem Statement ---------------------------------------------------------------------------------------------------------------------------------------------
# Identify customers who have placed the highest number of orders. 
-- What does this indicate about their loyalty or engagement?

SELECT c.CustomerID,
CONCAT(c.FirstName," ", c.LastName) AS Customer_Name, 
COUNT(o.OrderID) AS TotalOrders 
FROM Customers c JOIN Orders o
USING(CustomerID)
GROUP BY c.CustomerID, Customer_Name
ORDER BY TotalOrders DESC;
-- strong brand loyalty, this consistent engagement suggests they are satisfied with services & food quality


# Find customers who haven’t placed any orders in the last 3 months. How can the platform re-engage them?
SELECT c.CustomerID,
	CONCAT(FirstName,' ', LastName),
    Email, Phone
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID 
    AND o.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
WHERE o.OrderID IS NULL;
/* can re-enagage them by sending personalized email with coupun code or giving comeback 10/15% discount
can show them top rated MenuItems, or create a flash deal valid for next 48 hours 
*/ 


# Determine the average order value per customer. What does this reveal about spending habits?
SELECT c.CustomerID, 
	CONCAT(FirstName,' ', LastName),
    AVG(o.TotalAmount) as AvgOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY AvgOrderValue DESC;
/* >400 likely order for groups/families or prefer premium restuarants
between 300 to 400 orders meal for two people or complete meal ordered for one person
<300 they ordered single serving meal(snacks) or they are price sensitive customers
*/ 


# Identify the top 5 restaurants with the highest average ratings. 
-- What factors might contribute to their success?
SELECT r.RestaurantName,  
	AVG(rv.Rating) AS AvgRating
FROM Reviews AS rv 
JOIN Restaurants r
ON rv.RestaurantID = r.RestaurantID 
GROUP BY r.RestaurantID, r.RestaurantName, r.CuisineType 
ORDER BY AvgRating DESC 
LIMIT 5;
/* success factor likely include food quality, high quality ingredients, 
delivery speed, reply to customer feedback 
*/ 


# Find restaurants with the lowest number of orders despite being active. 
-- What could be causing low performance? 
SELECT 
    r.RestaurantName, 
    COUNT(o.OrderID) as OrderCount
FROM Restaurants r
LEFT JOIN Orders o 
	ON r.RestaurantID = o.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName
ORDER BY OrderCount ASC;
/* using low quality ingredients, slow service or delivery not effective advertising to attract new customers */


# Determine which cuisine types receive the most and least orders. 
-- How can marketing focus be adjusted accordingly?
SELECT R.CuisineType, 
	COUNT(O.OrderID) AS TotalOrders
FROM Restaurants R 
LEFT JOIN Orders O 
USING(RestaurantID)
GROUP BY R.CuisineType
ORDER BY TotalOrders DESC;
/* top performing cuisinetypes -> can sponsored ads for bestseller dishes, can give discounts for 
loyalty customers, highlight top reviews in the app 
low performing cuisinetypes -> can highlight unique menuitems, introduce Try Me pricing for new users 
create flash deals like 20% off on fast food, Create attractive combo deals 
(e.g., a complete Chinese dinner for two at a fixed price)
*/


# Calculate the total revenue generated in the last quarter. How does it compare to the previous one?
SELECT 
	SUM(CASE 
		WHEN O.OrderDate BETWEEN '2025-10-01' AND '2025-12-31' 
        THEN O.TotalAmount
        ELSE 0
        END) AS LastQuarterRevenue, 
	SUM(CASE
		WHEN O.OrderDate BETWEEN '2025-07-01' AND '2025-09-30' 
        THEN O.TotalAmount
        ELSE 0
        END) AS PreviousQuarterRevenue
FROM Orders O;
/*  There was decrease by 220 in LastQuarterRevenue then PreviousQuarterRevenue 
It indicates a problem and requires investigating factors like seasonality, new competition, or operational changes.
*/ 


# Identify the top 3 most ordered menu items across all restaurants. Should these items be promoted further?
SELECT M.ItemName, 
	SUM(OD.Quantity) AS TotalQuantityOrder
FROM MenuItems M 
JOIN OrderDetails OD 
ON M.MenuItemID = OD.MenuItemID 
GROUP BY M.MenuItemID 
ORDER BY TotalQuantityOrder DESC 
LIMIT 3 ;
-- It indicates strong popularity, so yes this items should be promoted further, 
-- we can reward customers for ordering these popular items repeatedly by offering small discounts 


# Analyze the revenue contribution of each restaurant. Which ones are the most profitable?
SELECT R.RestaurantName, 
	SUM(O.TotalAmount) AS TotalRevenue 
FROM Restaurants R 
JOIN Orders O 
USING(RestaurantID) 
GROUP BY R.RestaurantName, R.RestaurantID
ORDER BY TotalRevenue DESC;



# Determine the average number of items per order. How can order processing be optimized?
SELECT AVG(ItemCount) AS AvgItemPerOrder
FROM
	( SELECT OrderID, 
		SUM(Quantity) AS ItemCount
        FROM OrderDetails 
        GROUP BY OrderID
	)
AS AvgItemOrder;
-- group nearby orders when possible, we can prepare high demanding ingredients in advance
-- we can prioritize order with fewer items so they can be prepared easily and deliver them quickly



# Identify orders where the total amount was less than a certain threshold (e.g., ₹200). 
-- Should minimum order charges be introduced?
SELECT * FROM Orders 
WHERE TotalAmount < 200
ORDER BY TotalAmount DESC;
/* If a minimum order is not met, we can apply a "Small Order Fee"
we set a minimum order amount (e.g., ₹300) required to qualify for free or discounted delivery.
*/ 



# Find restaurants that receive the most reviews but have average ratings below 3.0. 
-- What corrective actions could be taken?
SELECT 
    r.RestaurantName, 
    COUNT(rev.ReviewID) as ReviewCount, 
    AVG(rev.Rating) as AvgRating
FROM Restaurants r
JOIN Reviews rev ON r.RestaurantID = rev.RestaurantID
GROUP BY r.RestaurantID, r.RestaurantName
HAVING AVG(rev.Rating) < 3.0;
/* Identify most repeated reviews, we can re-create the recipes, 
can offer discount or free replacement for unsatisfied customers, 
can train staff to reduce delays, incorrect orders 
*/



# Analyze the distribution of customer ratings. How many reviews are 4 stars or above?
-- 1. Analyze the Distribution of Ratings
SELECT Rating,
    COUNT(ReviewID) AS TotalReviews
FROM Reviews
GROUP BY Rating
ORDER BY Rating DESC;

-- 2. Count Reviews that are 4 Stars or Above 
SELECT
    COUNT(ReviewID) AS ReviewsAbove4
FROM Reviews
WHERE Rating >= 4.0; -- 10



# Identify customers who frequently leave low ratings. Could this indicate dissatisfaction or unrealistic expectations?
SELECT C.CustomerID, C.FirstName, C.LastName,
    ROUND(AVG(V.Rating), 2) AS AverageRating,
    COUNT(V.ReviewID) AS TotalReviews
FROM Customers C
JOIN Reviews V ON C.CustomerID = V.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
HAVING
    AverageRating < 3.0       
    AND TotalReviews >= 2    
ORDER BY
    TotalReviews DESC, AverageRating ASC ;
-- highly it could be customer dissatisfaction 



# Find patterns in review comments to detect recurring issues (e.g., “cold food,” “late delivery”).
SELECT 
    Issue,
    COUNT(*) AS Occurrences
FROM (
    SELECT 
        CASE 
            WHEN Comments LIKE '%cold%' THEN 'Cold Food'
            WHEN Comments LIKE '%late%' OR Comments LIKE '%slow%' THEN 'Late / Slow Service'
            WHEN Comments LIKE '%overcooked%' THEN 'Overcooked Food'
            WHEN Comments LIKE '%salty%' THEN 'Too Salty'
            WHEN Comments LIKE '%hair%' THEN 'Hygiene Issue (Hair Found)'
            WHEN Comments LIKE '%crowded%' OR Comments LIKE '%noisy%' THEN 'Crowded / Noisy'
            WHEN Comments LIKE '%sour%' THEN 'Food Spoiled or Sour'
            WHEN Comments LIKE '%hygiene%' THEN 'General Hygiene Issues'
            ELSE 'Other'
        END AS Issue
    FROM Reviews
) AS IssueTable
WHERE Issue != 'Other'
GROUP BY Issue
ORDER BY Occurrences DESC;


# Compare total revenue from vegetarian vs non-vegetarian menu items. 
-- Should the company invest more in one category?
SELECT 
    Category,
    SUM(od.Quantity * od.ItemPrice) AS TotalRevenue 
FROM (
    SELECT 
        mi.MenuItemID,
        mi.Description,
        CASE
            -- Vegetarian keywords
            WHEN mi.Description LIKE '%chicken%' 
              OR mi.Description LIKE '%eggs%' 
              OR mi.Description LIKE '%meat%' 
              OR mi.Description LIKE '%Beef%'
              OR mi.Description LIKE '%Manchurian%' 
              THEN 'Non-Vegetarian'
            ELSE 'Vegetarian'
        END AS Category
    FROM MenuItems mi
) AS ItemCategory
JOIN OrderDetails od 
ON ItemCategory.MenuItemID = od.MenuItemID
GROUP BY Category
ORDER BY TotalRevenue DESC;

/* Company should invest in Veg items. expand veg menu items, create veg combo meals 
Invest more in vegetarian items, but continue improving high-value non-vegetarian offerings.
A dual strategy will maximize growth.
*/



# Predict which customers are likely to become inactive based on order frequency and last order date.
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    DATEDIFF(CURRENT_DATE(), MAX(o.OrderDate)) AS DaysSinceLastOrder,
    COUNT(o.OrderID) AS TotalOrdersPlaced,
    CASE 
        WHEN COUNT(o.OrderID) <= 2 
             AND DATEDIFF(CURRENT_DATE(), MAX(o.OrderDate)) >= 45 
            THEN 'High Risk Of Inactivity'
        WHEN COUNT(o.OrderID) BETWEEN 3 AND 5 
             AND DATEDIFF(CURRENT_DATE(), MAX(o.OrderDate)) BETWEEN 25 AND 45
            THEN 'Medium Risk Of Inactivity'
        ELSE 'Low Risk / Active'
    END AS Prediction
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING TotalOrdersPlaced > 0
ORDER BY 
    DaysSinceLastOrder DESC,
    TotalOrdersPlaced ASC ;
  

# Analyze order trends between weekends and weekdays. 
-- Should dynamic pricing or promotions be introduced on low-order days?
SELECT
    CASE 
        WHEN DAYOFWEEK(OrderDate) IN (1, 7) THEN 'Weekend'   
        ELSE 'Weekday'
    END AS DayType,
    COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY DayType
ORDER BY TotalOrders DESC;
/* we can give 10-20% discount on weekends, 
can give free delivery on weekends 
no discounts needed on weekdays as they have more orders,
we can increase prices or can take 10,20 RS extra for delivery fee because of high demand on weekdays

