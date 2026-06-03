
-- Retrieve successful credit card orders sorted from newest to oldest


SELECT 
    OrderID, 
    Date, 
    CustomerID, 
    Product, 
    TotalPrice, 
    TrackingNumber
FROM Fact_Sales
WHERE OrderStatus = 'Delivered' 
  AND PaymentMethod = 'Credit Card'
ORDER BY Date DESC;



-- Isolating high-value orders

SELECT 
    OrderID, 
    CustomerID, 
    Product, 
    Quantity, 
    TotalPrice
FROM Fact_Sales
WHERE TotalPrice > 2000
ORDER BY TotalPrice DESC;


-- Financial and operational product performance analysis

SELECT 
    Product,
    COUNT(OrderID) AS TotalOrders,               
    SUM(Quantity) AS TotalUnitsSold,            
    SUM(TotalPrice) AS GrossRevenue,             
    ROUND(AVG(UnitPrice), 2) AS AverageUnitPrice 
FROM Fact_Sales
GROUP BY Product
ORDER BY GrossRevenue DESC;


--Analyzing the efficiency of customer acquisition and marketing channels

SELECT 
    ReferralSource,
    COUNT(OrderID) AS TotalConversions,          
    SUM(Quantity) AS TotalItemsBought,          
    SUM(TotalPrice) AS TotalRevenue,            
    ROUND(AVG(TotalPrice), 2) AS AverageOrderValue 
FROM Fact_Sales
GROUP BY ReferralSource
ORDER BY TotalRevenue DESC;

-- Analysis of order cases and their percentage of total financial volume

SELECT 
    OrderStatus,
    COUNT(OrderID) AS OrderCount,
    round (SUM (TotalPrice),2) AS FinancialValue,
    ROUND(100.0 * COUNT(OrderID) / SUM(COUNT(OrderID)) OVER(), 2) AS PercentageOfTotalOrders
FROM Fact_Sales
GROUP BY OrderStatus
ORDER BY OrderCount DESC;

            

