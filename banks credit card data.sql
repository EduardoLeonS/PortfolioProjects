#Database obtained at the zenodo.org site and was uploaded by the user "zhyli"
#Cite: zhyli. (2020). Prediction of Churning Credit Card Customers [Data set]. Zenodo. https://doi.org/10.5281/zenodo.4322342

#Look at the database
SELECT COUNT(*) FROM banks;

#Look at the database
SELECT * FROM banks LIMIT 50;

#1.- Defining the Churn: identify how many Attrited Customers are on the database
SELECT Attrition_Flag,
COUNT(*) AS Total_Flags,
(COUNT(*) / total_counts) * 100 AS percentage
FROM
banks,
(SELECT COUNT(*) AS total_counts FROM banks WHERE Attrition_Flag IS NOT NULL) AS total
GROUP BY Attrition_Flag;
#Total Attrited Customers in database of 16%

#2.- Looking at the variables with an Attrited Category
SELECT * FROM banks 
WHERE Attrition_Flag = "Attrited Customer";

#3.- Checking the main Attrited category by Customer Age
SELECT Customer_Age, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY Customer_Age
ORDER BY COUNT(*) DESC
LIMIT 5;
#Main Attrited Age 45 - 49

#4.- Categorized the Customer Age into Generation Group
SELECT 
CASE
WHEN Customer_Age BETWEEN 59 AND 77 THEN "Baby Boomer"
WHEN Customer_Age BETWEEN 43 AND 58 THEN "Generation X"
WHEN Customer_AGE BETWEEN 42 AND 27 THEN "Millenials"
ELSE "Generation Z"
END AS "Generation", COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY Generation
ORDER BY COUNT(*) DESC;
#Most Attrited Customers are the ones belonging in the Generation X
 
 
#5.- Checking the Attrition Group by Gender
SELECT Gender, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 2 DESC;
#Females lead the Attrited Status 

#6.- Checking the Attrition by Dependent_Count 
SELECT Dependent_count, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 2 DESC; 
#Dependent Count of 3 have the more Attrited Status

#7.- Checking by Dependent Count and addying the observed demographics 
SELECT COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer" 
AND Customer_Age BETWEEN 45 AND 49
AND Gender = "F"
AND Dependent_count = 3;

#8.- Checking Attrition Status by Education Level
SELECT Education_Level, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer" 
GROUP BY 1
ORDER BY 2 DESC;
#Graduates lead the Attrited Customers 

#9.- Checking Attrition Status by Education Level
SELECT Education_Level, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer" 
GROUP BY Education_Level
ORDER BY 2 DESC;
#Most Attrited status is the Graduate ones 

#10.-Checking Attrition Status by Marital Status
SELECT Marital_Status, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY Marital_Status
ORDER BY 2 DESC;
#Most Attrited Status are the ones Married and single 

#11.-Checking Attrition Status by Income Category
SELECT Income_Category, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
#Most Attrited Status are customers with an income less than $40K

#12.- Checking by Card Category
SELECT Card_Category, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 2 DESC;
#Mainly are the blue ones the Attrited Customers 

#13.-Combine the observed variables
SELECT CLIENTNUM, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
AND Gender = "F"
AND Dependent_count BETWEEN 2 AND 3
AND Education_Level = "Graduate"
AND Marital_Status = "Married" OR Marital_Status = "Single"
AND Income_Category = "Less than $40K" 
AND Card_Category = "Blue";


#II.- Transaction Activities
SELECT * FROM banks LIMIT 50;

#1.-MOBs by Attrition Status
SELECT Months_on_book, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 2 DESC;
#Most Attrited MOB 36 which are customers with more than 3 years

#2-Average Revolving Balance by customer age in Attrited Status
SELECT DISTINCT Customer_Age, AVG(Total_Revolving_Bal) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
#Average Revolving Balance of Attrited customers is for $1388 

#3.-Most Inactive customers by Month
SELECT Months_Inactive_12_mon, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 5;
#More of the Attrited customers are 3 months inactive using the credit card

#4.-Most Attrited Credit Limit card 
SELECT Credit_Limit, COUNT(*) FROM banks
WHERE Attrition_Flag = "Attrited Customer" AND Card_Category = "Blue"
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
#Credit Limit of 1438 which is the lowest value in the database 

#5.-Average number of Transactions by Gender woth a Credit Limit of 1438	
SELECT Gender, AVG(Total_Trans_Ct), AVG(Total_Trans_Amt) FROM banks
WHERE Attrition_Flag = "Attrited Customer" AND Credit_Limit = 1438
AND Card_Category = "Blue"
GROUP BY 1;
#Females in Attrited Status have 6 more transactions than Males

#6.-Average Transactions and Transaction Amounts by Age and Credit Limit 
SELECT Customer_Age, Credit_Limit, AVG(Total_Trans_Amt), AVG(Total_Trans_Ct) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
HAVING AVG(Total_Trans_Ct) > 64
ORDER BY 3 DESC;
#The 29 years old tend to have more Transactions than the average 

#7.-Average of times contacted by Demographics
SELECT  Customer_Age, AVG(Total_Relationship_Count), Gender, Dependent_count, Education_Level, Marital_Status, Income_Category FROM banks
WHERE Attrition_Flag = "Attrited Customer"
AND Card_Category = "Blue"
GROUP BY 1
ORDER BY 2 DESC;

#8.- Average Open to Buy vs Average Utilization Ratio by Age between 45 and 49
SELECT  Customer_Age, Credit_Limit, Avg_Open_To_Buy, Avg_Utilization_Ratio FROM banks
WHERE Attrition_Flag = "Attrited Customer"
AND Customer_Age BETWEEN 45 AND 49
AND Card_Category = "Blue"
GROUP BY 1
ORDER BY 2 DESC;

#9.- Income Category by Average in Transactions and Open To Buy 
SELECT Income_Category, Credit_Limit, Avg_Open_To_Buy, Avg_Utilization_Ratio, AVG(Total_Trans_Ct), AVG(Total_Trans_Amt) FROM banks
WHERE Attrition_Flag = "Attrited Customer"
GROUP BY 1
ORDER BY 3 ASC;

#10.- Months Inactive by Relationships count by Card Category
SELECT Card_Category, AVG(Credit_Limit) as "Average_Credit_Limit" , Avg_Utilization_Ratio, Avg_Open_To_Buy, Total_Relationship_Count, Months_Inactive_12_mon FROM banks
WHERE Attrition_Flag = "Attrited Customer" 
GROUP BY 1
ORDER BY 5 DESC;



