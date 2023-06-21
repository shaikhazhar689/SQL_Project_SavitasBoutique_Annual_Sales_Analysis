# About
## Savita's Boutique Annual Sales Analysis
The stakeholder of Savita's Boutique has requested an annual sales analysis to aid in future decision-making for business growth and development. Using MySQL, the available data has been analyzed, and a set of queries has been created to answer various questions posed by the stakeholders. These queries provide valuable insights and findings that can guide the stakeholders in understanding their sales patterns and trends. The analysis aims to support informed decision-making and suggests a way forward for achieving greater business growth and development. 
To get the insights and examine the findings for Savita's Boutique's annual sales analysis, i have been written following sql query.

Select * From savitasboutique.supplier_sales;

Select Distinct Transaction_id
From savitasboutique.supplier_sales;

Insert Into expenses
Values  (236, '10-06-2023', 'Lata', 16000, 'Cash', 'Salery');

Select Count(*)
From savitasboutique.supplier_sales;

Select count(Distinct Transaction_id), Customer_Name
From savitasboutique.supplier_sales
Where Customer_Name = 'Mandakini Patil';

Select MAX(Cost_Price)
From savitasboutique.supplier_sales;

Select MIN(Cost_Price)
From savitasboutique.supplier_sales;

Select AVG(Profit)
From savitasboutique.supplier_sales;

Select AVG(Profit)
From savitasboutique.supplier_sales
Where Customer_Name='Vaishali R Patil';

Select *
From savitasboutique.supplier_sales
Where Customer_Name = 'Bharti Wagh' And Cost_Price > 25000

Select Distinct Cost_Price, Selling_Price, Supplier, Profit, Profit/Cost_Price*100 As Profit_Percentage
From savitasboutique.supplier_sales
order by Profit_Percentage DESC;

###..Right Join between Two tables supplier and sales..

Select supplier.Transaction_id, sales.Customer_Name, supplier.Date, supplier.Quantity, supplier.Retail_Price, supplier.Cost_Price, supplier.Selling_Price, supplier.Discount, supplier.Profit, supplier.Supplier, supplier.Supplier_Location
From savitasboutique.sales
Right join savitasboutique.supplier 
On sales.Transaction_id = supplier.Transaction_id
Order By supplier.Transaction_id ASC;

### 1..Total Number of Transactions(Shopping) by Each customer..

Select Count(Distinct Transaction_id) As Total_Transaction, Customer_Name
From savitasboutique.supplier_sales
group by Customer_Name
order by Total_Transaction DESC;

### 2..Total Quantity Purchased by each customer..

Select Sum(Quantity) As Total, Customer_Name
From savitasboutique.supplier_sales
Group By Customer_Name
Order By Total DESC;

### 3..Total Quantity Sold Accordingly Supplier..

Select Sum(Quantity) As Total, Supplier
From savitasboutique.supplier_sales
Group By Supplier
Order By Total DESC;

### 4..Customers whose name starts with 'A'..

SELECT Distinct Customer_Name 
FROM savitasboutique.supplier_sales
WHERE Customer_Name LIKE 'a%';

### 5..Number of unique customers visited in a  year..

Select Count(Distinct Customer_Name)
From savitasboutique.supplier_sales;

### 6..Total Gross Profit..
Select Sum(Profit) As Total_Gross_Profit
From savitasboutique.supplier_sales;

### 7..Total Discount..

Select Sum(Discount) Total_Discount
From savitasboutique.supplier_sales;


### 8..Profit by each customer seperately..
Select Sum(Profit) As Total_Profit
From savitasboutique.supplier_sales
Where Customer_Name='Mandakini Patil';

### 9..Total Quantity Sold..
Select Sum(Quantity) As Total_Gross_Profit
From savitasboutique.supplier_sales;

### 10..Total Quanity purchased by each customer in a year..

Select Sum(Quantity) As Total_Quantity
From savitasboutique.supplier_sales
Where Customer_Name='Pranita Patil';

### 11..Top 10 Customers by Profit..

Select Sum(Profit) AS Total_Profit, Customer_Name
From savitasboutique.supplier_sales
Group By Customer_Name
Order By Total_Profit DESC
Limit 10;

### 12..Total Profit earned by Supplier_Location..

Select Sum(Selling_Price) AS Total_Profit, Supplier_Location
From savitasboutique.supplier_sales
Group By Supplier_Location
Order By Total_Profit DESC;

### 13..Total Profit earned and Quantity purchased by every customer of specific supplier..  

Select Sum(Profit) AS Total_Profit, Sum(Quantity) As Total_Quantity, Customer_Name
From savitasboutique.supplier_sales
Where Supplier='Pehnava' or Supplier='ADA'
Group By Customer_Name
Order By Total_Profit DESC;

### 14..Top 10 Customers With heigest avg profit earned..

Select Avg(Profit) As Avg_Profit, Customer_Name
From savitasboutique.supplier_sales
Group By Customer_Name
order by Avg_Profit DESC
Limit 10;

### 15..Detail of individual customer with profit percentage..

Select *, Profit/Cost_Price*100 As Profit_Percentage
From savitasboutique.supplier_Sales
Where Customer_Name='Bharti Wagh'
order by Profit_Percentage DESC;

### 16..Quantity Purchased for specific range of cost price..

Select Sum(Quantity) As Total
From savitasboutique.supplier_sales
Where Cost_Price Between 15000 And 25000;

### 17..Profit_Percentage of specific range of cost price.. 

Select *, Profit/Cost_Price*100 As Profit_Percentage
From savitasboutique.supplier_sales
Where Cost_Price Between 15000 And 25000
Order by Profit_Percentage DESC;

### 18..Using CASE Function..

Select Distinct Transaction_id,
CASE 
 When Customer_Name = 'Dr.Pallavi' then 'Dr.Pallavi Dharmadhikari'
 Else Customer_Name 
 End As cleaned_name
From savitasboutique.supplier_sales;
  
