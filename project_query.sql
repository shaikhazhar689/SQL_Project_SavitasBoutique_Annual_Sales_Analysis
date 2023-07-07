Select * From savitasboutique.supplier;

Select * From savitasboutique.customer;

Select * From savitasboutique.expenses;

-- Right Join between Two tables supplier and customer

Select A.Transaction_id, A.Date, B.Customer_Name, A.Quantity, A.Tax, 
A.Selling_Price, A.Cost_Price, A.Profit, A.Discount, A.Supplier_Name
From savitasboutique.customer As B
Right join savitasboutique.supplier As A
On A.Transaction_id = B.Transaction_id
Order By A.Transaction_id ASC;

-- Total Sales 

Select sum(A.Selling_Price) As Total_Sales
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id;

-- Total Profit 

Select sum(A.Profit) As Total_Profit
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id;

-- Total Quantity Sold

Select sum(A.Quantity) As Total_Quantity
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id;

-- Total Discount

Select sum(A.Discount) As Total_Discount
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id;

-- Average Discount

Select AVG(A.Discount) As Avg_Discount
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id;

-- Top 10 customers by Profit

Select B.Customer_Name, sum(A.Quantity) As Quantiy, sum(A.Selling_Price) As Total_Sales, 
sum(A.Cost_Price) As Cost_Price, sum(A.Profit) As Total_Profit,
count(Distinct A.Transaction_id) As num_transaction, sum(A.Profit)/sum(A.Cost_Price)*100 As Profit_Percentage
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group By B.Customer_Name
Order By Total_Profit DESC
Limit 10;

-- Profit earned on every supplier products

Select A.Supplier_Name, sum(A.Quantity) As Quantity, sum(A.Selling_Price) As SellingPrice , 
sum(A.Cost_Price) As CostPrice, sum(A.Profit) As Profit, count(Distinct A.transaction_id) As num_orders,
sum(A.Profit)/sum(A.Cost_Price)*100 As Profit_Percentage
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group by A.Supplier_Name
Order by Quantity DESC;

-- Quantity sold to customer of specific supplier

Select A.Supplier_Name As suppliers, sum(A.Quantity) As sold_quantity, B.Customer_Name As customer_name
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group by suppliers, Customer_name
Order by sold_quantity DESC;

-- Customer preference using Having function

SELECT B.Customer_Name, sum(A.Quantity) As Total_Quantity, A.Supplier_Name
FROM savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
GROUP BY B.Customer_Name, A.Supplier_Name
Having Total_Quantity > 25
Order by Total_Quantity DESC; 

-- Indiviidual Customer Preference of different products 

SELECT B.Customer_Name, sum(A.Quantity) As Total_Quantity, A.Supplier_Name
FROM savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Where B.Customer_Name = 'Bharti Wagh'
GROUP BY A.Supplier_Name
Order by Total_Quantity DESC;

-- Max Profit by customer in single transaction

Select B.Customer_Name, A.Supplier_Name, A.Quantity, Max(A.Profit) As Max_Profit
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group by B.Customer_Name, A.Supplier_Name, A.Quantity
Order by Max_Profit DESC
Limit 10;

-- Using CASE Function..

Select Distinct A.Transaction_id,
CASE 
 When B.Customer_Name = 'Dr.Pallavi' then 'Dr.Pallavi Dharmadhikari'
 Else B.Customer_Name 
 End As cleaned_name
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id;

-- Total Profit earned and Quantity purchased from every customer of specific supplier..  

Select  B.Customer_Name, Sum(A.Quantity) As Total_Quantity, Sum(A.Profit) AS Total_Profit 
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Where A.Supplier_Name='Pehnava' or A.Supplier_Name='ADA'
Group By B.Customer_Name
Order By Total_Profit DESC;

-- Quantity Purchased for specific range of cost price..

Select Sum(A.Quantity) As Total_Quantity
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Where A.Cost_Price Between 3000 And 10000;

-- Profit_Percentage of specific range of cost price.. 

Select B.Customer_Name, A.Supplier_Name, A.Selling_Price, A.Cost_Price, A.Discount, A.Profit, 
A.Profit/A.Cost_Price*100 As Profit_Percentage
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Where A.Cost_Price Between 15000 And 25000
Order by Profit_Percentage DESC;

-- Sub Query -- Designate performance level of supplier on the basis of Quantity sold Vs Total Quanity

Select Count(Distinct A.Transaction_id) As Transaction_ID, A.Supplier_Name As Supplier, Sum(A.Quantity) As Quantity,
  (Select
  Sum(A.Quantity) 
 From  savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id) As Total_Quantity,
 Case
   When Sum(A.Quantity)/ (Select Count(*) From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id) <= 0.10
   Then "Poor"
   When Sum(A.Quantity)/ (Select Count(*) From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id) > 0.10
   And Sum(A.Quantity)/ (Select Count(*) From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id) <= 0.50
   Then "Good"
 Else "Very Good"
 End As Performance_Level
From savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group by Supplier
Order by Quantity DESC;

-- IF Function -- Designate purchased quantity status of Customer As More or Less 

SELECT Distinct A.Transaction_id, B.Customer_Name As Customer, A.Quantity, 
IF (A.Quantity >5, "MORE", "LESS") As Status
FROM savitasboutique.supplier As A Left Join Savitasboutique.customer As B 
On A.Transaction_id = B.Transaction_id
Group by A.Transaction_id, Customer, A.Quantity
Order By Quantity DESC;

-- Sum Of Quantity of Sarees sold of different suppliers

Select Sum(A.Quantity) As Quantity, A.Category, A.Supplier_Name
From savitasboutique.customer As B
Right join savitasboutique.supplier As A
On A.Transaction_id = B.Transaction_id
Where Category = 'Saree'
Group by A.Supplier_Name
Having Quantity >= 5
Order by Quantity DESC;

-- Customers who purchased Saree and name of supplier

Select Sum(A.Quantity) As Quantity, A.Category, A.Supplier_Name, B.Customer_Name
From savitasboutique.customer As B
Right join savitasboutique.supplier As A
On A.Transaction_id = B.Transaction_id
Where A.Category = 'Saree'
Group by B.Customer_Name, A.Supplier_Name, A.Category
Order By Quantity DESC;

-- Details of individual customer about purchase of specific Category product

Select A.Quantity, A.Category, A.Supplier_Name, B.Customer_Name
From savitasboutique.customer As B
Right join savitasboutique.supplier As A
On A.Transaction_id = B.Transaction_id
Where A.Category = 'Saree' And B.Customer_Name = "Mandakini Patil";

-- Thank You