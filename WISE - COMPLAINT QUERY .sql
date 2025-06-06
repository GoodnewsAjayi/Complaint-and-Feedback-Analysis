select * from [dbo].['Complaints Data$']
select * from [dbo].['Complaints KPIs Summary$']
select * from [dbo].['Vulnerable Customer Cases Data$']

---- Task 1	Question 1
----Top 2 complaint categories by volume

SELECT Complaint_Category, COUNT(*) AS Complaint_Count
FROM [dbo].['Complaints Data$']
GROUP BY Complaint_Category
ORDER BY Complaint_Count DESC
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;

-----Task 1 Question 2
-----Average satisfaction rating by complaint  channel

SELECT Complaint_Channel, AVG(Satisfaction_Rating) AS Avg_Satisfaction
FROM [dbo].['Complaints Data$']
GROUP BY Complaint_Channel;

----Task 1 Question 3 A
--- Are high-priority complaints resolved faster than low-priority ones? ( Average resolution time by day)

SELECT 
    complaint_priority,
    AVG(CAST(DATEDIFF(DAY, complaint_date, resolution_date) AS FLOAT)) AS avg_resolution_time_days
FROM 
   [dbo].['Complaints Data$']
WHERE 
    complaint_status = 'Closed'
    AND complaint_priority IN ('High', 'Low')
    AND complaint_date IS NOT NULL
    AND resolution_date IS NOT NULL
    AND resolution_date >= complaint_date
GROUP BY 
    complaint_priority;


-------Task 2 Question 1 Root Cause Analysis
------Most frequent `ec_primary_root_cause`( Most Frequent Root Cause )

SELECT ec_primary_root_cause, COUNT(*) AS Occurrence
FROM [dbo].['Vulnerable Customer Cases Data$'] 
GROUP BY ec_primary_root_cause
ORDER BY Occurrence DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

------Task 2 Question 2
---Average Handling Time (in Hours)

SELECT 
    AVG(DATEDIFF(MINUTE, ticket_created_timestamp, ticket_solved_timestamp)) / 60.0 AS Avg_Handling_Hours,
    AVG(DATEDIFF(MINUTE, ticket_created_timestamp, ticket_solved_timestamp)) / 1440.0 AS Avg_Handling_Days
FROM 
    [dbo].['Vulnerable Customer Cases Data$']
WHERE 
    ticket_created_timestamp IS NOT NULL
    AND ticket_solved_timestamp IS NOT NULL
    AND ticket_solved_timestamp >= ticket_created_timestamp;


---Task 3 Question 1
---Region with Lowest Median Handling Time

SELECT TOP 1 Region, CAST(Median_Handling_Time_Days AS FLOAT) AS HandlingTime
FROM [dbo].['Complaints KPIs Summary$']
WHERE ISNUMERIC(Median_Handling_Time_Days) = 1
ORDER BY CAST(Median_Handling_Time_Days AS FLOAT) ASC;


---	Task 3 Question 2 
-----  Redress Cost Trend Over Last 3 Months

SELECT TOP 3 Month, SUM(Complaint_Redress_Cost_GBP) AS Total_Redress_Cost
FROM [dbo].['Complaints KPIs Summary$']
GROUP BY Month
ORDER BY Month DESC;


----Task 3 Question 3  
--- Correlation of Headcount_OPS and Handling Time, Pass Rate vs  Redress Cost by Region

	SELECT  
    Region,
    AVG(CAST(Median_Handling_Time_Days AS FLOAT)) AS Avg_Handling_Time,
    AVG(CAST(Complaint_Redress_Cost_GBP AS FLOAT)) AS Avg_Redress_Cost,
    AVG(Stage1_QA_Pass_Rate) AS Avg_QA_Pass_Rate,
    AVG(Headcount_OPS) AS Avg_Headcount_OPS
FROM 
    [dbo].['Complaints KPIs Summary$']
WHERE 
    Region IS NOT NULL
    AND Median_Handling_Time_Days IS NOT NULL 
    AND Headcount_OPS IS NOT NULL
    AND Stage1_QA_Pass_Rate IS NOT NULL
    AND Complaint_Redress_Cost_GBP IS NOT NULL
GROUP BY 
    Region
ORDER BY 
    Region;

-- Question