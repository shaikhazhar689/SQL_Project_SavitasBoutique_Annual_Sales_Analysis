-- AI Generated Query --

SELECT * FROM savitasboutique.customer;

SELECT
    S.Transaction_id,
    S.Date,
    S.Quantity,
    C.Customer_name AS Customer_Name,
    S.Supplier_name AS Supplier_Name,
    S.Selling_Price,
    S.Profit
FROM
    savitasboutique.supplier AS S
RIGHT JOIN
    savitasboutique.customer AS C
ON
    S.Transaction_id = C.Transaction_id;
    
-- Price_Range as per Customer purchases (AI)

SELECT Customer_Name, Sum(A.Cost_Price) As Cost_Price, Sum(A.Selling_Price) As Sales, 
Sum(A.Profit) As Profit, Sum(A.Quantity) As Quantity,
IF (A.Cost_Price < 4000, "Low", IF(A.Cost_Price<10000, "Medium", "High")) As Price_Range, 
Sum(A.Profit)/Sum(A.Selling_Price)*100 As Profit_Margin
FROM savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group by Customer_Name, Price_Range
Order By Profit DESC;

-- 2nd Methd Using CASE Function for seperate price_range column (AI)

SELECT
    Customer_Name,
    SUM(CASE WHEN Price_Range = 'Low' THEN Quantity ELSE 0 END) AS Low_Range,
    SUM(CASE WHEN Price_Range = 'Medium' THEN Quantity ELSE 0 END) AS Medium_Range,
    SUM(CASE WHEN Price_Range = 'High' THEN Quantity ELSE 0 END) AS High_Range,
    SUM(Quantity) AS Total_Quantity,
    SUM(Cost_Price) AS Total_Cost_Price,
    SUM(Selling_Price) AS Total_Selling_Price
FROM (
    SELECT
        B.Customer_name AS Customer_Name,
        A.Cost_Price,
        A.Selling_Price,
        A.Profit,
        A.Quantity,
        CASE
            WHEN A.Cost_Price < 4000 THEN 'Low'
            WHEN A.Cost_Price < 10000 THEN 'Medium'
            ELSE 'High'
        END AS Price_Range
    FROM
        savitasboutique.supplier AS A
    LEFT JOIN
        savitasboutique.customer AS B
    ON
        A.Transaction_id = B.Transaction_id
) AS Subquery
GROUP BY
    Customer_Name
ORDER BY Total_Quantity DESC;

-- 3rd Method Profit Margin On Price_Range (AI)
SELECT
    Customer_Name,
    SUM(CASE WHEN Price_Range = 'Low' THEN Quantity ELSE 0 END) AS Low_Range,
    CASE
        WHEN SUM(Selling_Price) > 0 THEN (SUM(CASE WHEN Price_Range = 'Low' THEN Profit ELSE 0 END) / SUM(CASE WHEN Price_Range = 'Low' THEN Selling_Price ELSE 0 END)) * 100
        ELSE 0
    END AS Profit_Margin_Low,
    
    SUM(CASE WHEN Price_Range = 'Medium' THEN Quantity ELSE 0 END) AS Medium_Range,
    CASE
        WHEN SUM(Selling_Price) > 0 THEN (SUM(CASE WHEN Price_Range = 'Medium' THEN Profit ELSE 0 END) / SUM(CASE WHEN Price_Range = 'Medium' THEN Selling_Price ELSE 0 END)) * 100
        ELSE 0
    END AS Profit_Margin_Medium,
    
    SUM(CASE WHEN Price_Range = 'High' THEN Quantity ELSE 0 END) AS High_Range,
    CASE
        WHEN SUM(Selling_Price) > 0 THEN (SUM(CASE WHEN Price_Range = 'High' THEN Profit ELSE 0 END) / SUM(CASE WHEN Price_Range = 'High' THEN Selling_Price ELSE 0 END)) * 100
        ELSE 0
    END AS Profit_Margin_High,
    
    SUM(Quantity) AS Total_Quantity,
    SUM(Cost_Price) AS Total_Cost_Price,
    SUM(Selling_Price) AS Total_Selling_Price,
    SUM(Profit) AS Total_Profit
FROM (
    SELECT
        B.Customer_name AS Customer_Name,
        A.Cost_Price,
        A.Selling_Price,
        A.Profit,
        A.Quantity,
        CASE
            WHEN A.Cost_Price < 4000 THEN 'Low'
            WHEN A.Cost_Price < 10000 THEN 'Medium'
            ELSE 'High'
        END AS Price_Range
    FROM
        savitasboutique.supplier AS A
    LEFT JOIN
        savitasboutique.customer AS B
    ON
        A.Transaction_id = B.Transaction_id
) AS Subquery
GROUP BY
    Customer_Name
ORDER BY Total_Quantity DESC;


-- Define Customer Category on the basis of total quantity purchased 
-- As Highe Priority, Target and Need more follow-up (AI)

SELECT
    Customer_Name,
    SUM(Selling_Price) AS Selling_Price,
    SUM(Quantity) AS Quantity,
    CASE
        WHEN SUM(Quantity) > 25 THEN 'High Priority'
        WHEN SUM(Quantity) >= 10 AND SUM(Quantity) <= 25 THEN 'Target Customer'
        ELSE 'Need More Follow-up'
    END AS Customer_Category
FROM
    savitasboutique.customer
GROUP BY
    Customer_Name
ORDER BY Quantity DESC;
    
-- Thank You!